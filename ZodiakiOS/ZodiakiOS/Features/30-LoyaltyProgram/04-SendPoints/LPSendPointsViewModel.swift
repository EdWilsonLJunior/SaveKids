import Combine
import SwiftUI

// MARK: - Send State
enum LPSendState: Equatable {
    case idle
    case cpfError
    case selfCPFError
    case pointsError
    case multipleError
    case minimumError
    case processing
    case success
    case cancelled
}

// MARK: - US-30.04 Send Points ViewModel
final class LPSendPointsViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.points) var points: Int = LPConstants.Defaults.initialPoints
    @AppStorage(LPConstants.Storage.statement) var statementData: Data = Data()

    @Published var currentStep: Int = 0
    @Published var recipientCPF: String = ""
    @Published var amount: Int = LPConstants.Validation.minTransferPoints
    @Published var state: LPSendState = .idle
    @Published var showCancelModal: Bool = false
    @Published var showSuccessModal: Bool = false

    // Mock: own CPF for self-send validation (hardcoded for the mock auth)
    private let ownCPF = LPConstants.Validation.mockOwnCPF
    private let processingDelay: Duration
    private var confirmTask: Task<Void, Never>?

    init(processingDelay: Duration = .milliseconds(800)) {
        self.processingDelay = processingDelay
    }

    var recipientCPFDigits: String { recipientCPF.filter(\.isNumber) }

    var stepTitles: [String] {
        [
            String(localized: "lp.send.step1_label"),
            String(localized: "lp.send.step2_label"),
            String(localized: "lp.send.step3_label")
        ]
    }

    var formattedPoints: String {
        NumberFormatter.lpPoints.string(from: NSNumber(value: points)) ?? "\(points)"
    }

    var maskedRecipient: String {
        let digits = recipientCPFDigits
        guard digits.count == LPConstants.Validation.cpfLength else { return recipientCPF }
        let suffix = String(digits.suffix(3))
        return String(format: String(localized: "lp.send.recipient_masked"), suffix)
    }

    var remainingBalance: Int {
        points - amount
    }

    var formattedRemainingBalance: String {
        let value = NSNumber(value: remainingBalance)
        let remaining = NumberFormatter.lpPoints.string(from: value) ?? "\(remainingBalance)"
        return remaining + " pts"
    }

    // MARK: - Reactive validation (used by ZodiakInputWizard canProceed)

    var isStep0Valid: Bool {
        recipientCPFDigits.count == LPConstants.Validation.cpfLength &&
        recipientCPFDigits != ownCPF
    }

    var isStep1Valid: Bool {
        amount >= LPConstants.Validation.minTransferPoints &&
        amount.isMultiple(of: LPConstants.Validation.transferPointsMultiple) &&
        amount <= points
    }

    // MARK: - Step Validation

    func validateStep1() -> Bool {
        if recipientCPFDigits.count != LPConstants.Validation.cpfLength {
            state = .cpfError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "send_points", errorKey: "cpfError").emit()
            return false
        }
        if recipientCPFDigits == ownCPF {
            state = .selfCPFError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "send_points", errorKey: "selfCPFError").emit()
            return false
        }
        state = .idle
        return true
    }

    func validateStep2() -> Bool {
        if amount < LPConstants.Validation.minTransferPoints {
            state = .minimumError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "send_points", errorKey: "minimumError").emit()
            return false
        }
        if !amount.isMultiple(of: LPConstants.Validation.transferPointsMultiple) {
            state = .multipleError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "send_points", errorKey: "multipleError").emit()
            return false
        }
        if amount > points {
            state = .pointsError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "send_points", errorKey: "pointsError").emit()
            return false
        }
        state = .idle
        return true
    }

    func advance() {
        switch currentStep {
        case 0:
            if validateStep1() {
                currentStep = 1
                state = .idle
            }

        case 1:
            if validateStep2() {
                currentStep = 2
                state = .idle
            }

        default:
            break
        }
    }

    func back() {
        if currentStep > 0 {
            currentStep -= 1
            state = .idle
        }
    }

    func confirm() {
        guard validateStep2() else { return }
        state = .processing
        let balanceBefore = points
        let transferAmount = amount
        let recipient = maskedRecipient
        let tx = LPPointTransaction(
            id: UUID().uuidString,
            type: .sent,
            description: String(localized: "lp.send.title") + " → " + maskedRecipient,
            date: Date(),
            points: -amount
        )
        confirmTask?.cancel()
        confirmTask = Task { @MainActor in
            let span = ZodiakSpan(name: "lp_send_points", category: .service)
            do {
                // Delay de processamento: reforça percepção de transação real
                try await Task.sleep(for: self.processingDelay)
                self.points -= self.amount
                LPStatementService.appendTransaction(tx, to: &self.statementData)
                self.state = .success
                self.showSuccessModal = true
                span.end(status: "ok", metadata: ["feature": "LoyaltyProgram"])
                let auditEvent = LPAuditEvent.sendPoints(
                    recipientMasked: recipient,
                    amount: transferAmount,
                    balanceBefore: balanceBefore,
                    balanceAfter: self.points
                )
                auditEvent.emit()
            } catch {
                ZodiakLog.debug(.viewModel, "LP send points task cancelled",
                                metadata: ["feature": "LoyaltyProgram"])
                self.state = .idle
                span.end(status: "cancelled", metadata: ["feature": "LoyaltyProgram"])
            }
        }
    }

    /// Processa a transferência de forma síncrona — usado pelo ZodiakInputWizard
    /// cujo `onComplete` é chamado após a animação de sucesso embutida.
    func commitTransfer() {
        guard isStep1Valid else { return }
        let span = ZodiakSpan(name: "lp_send_points", category: .service)
        let balanceBefore = points
        let transferAmount = amount
        let recipient = maskedRecipient
        let tx = LPPointTransaction(
            id: UUID().uuidString,
            type: .sent,
            description: String(localized: "lp.send.title") + " → " + maskedRecipient,
            date: Date(),
            points: -amount
        )
        points -= amount
        LPStatementService.appendTransaction(tx, to: &statementData)
        state = .success
        span.end(status: "ok", metadata: ["feature": "LoyaltyProgram"])
        let auditEvent = LPAuditEvent.sendPoints(
            recipientMasked: recipient,
            amount: transferAmount,
            balanceBefore: balanceBefore,
            balanceAfter: points
        )
        auditEvent.emit()
    }

    func requestCancel() {
        showCancelModal = true
    }

    func confirmCancel() {
        showCancelModal = false
    }

    func reset() {
        currentStep = 0
        recipientCPF = ""
        amount = LPConstants.Validation.minTransferPoints
        state = .idle
        showCancelModal = false
        showSuccessModal = false
    }

    deinit { confirmTask?.cancel() }
}
