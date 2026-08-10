import Foundation
import Testing
@testable import ZodiakiOS

// MARK: - Test Sink

/// Captures `ZodiakLogEntry` values emitted to `ZodiakLogBus` for assertion.
private final class MockAuditSink: ZodiakLogSink, @unchecked Sendable {
    private(set) var captured: [ZodiakLogEntry] = []
    private let lock = NSLock()

    func emit(_ entry: ZodiakLogEntry) {
        lock.withLock { captured.append(entry) }
    }

    /// Returns entries filtered to a specific category.
    func entries(for category: ZodiakLogCategory) -> [ZodiakLogEntry] {
        lock.withLock { captured.filter { $0.category == category } }
    }
}

// MARK: - LP Audit Event Tests

@Suite("LPAuditEvent")
struct LPAuditEventTests {
    private let sink = MockAuditSink()

    init() {
        ZodiakLogBus.shared.removeAllSinks()
        ZodiakLogBus.shared.register(sink)
    }

    // MARK: - loginAttempt

    @Test("loginAttempt success emite categoria .audit com status=success")
    func loginAttemptSuccessEmitsAuditEntry() throws {
        LPAuditEvent.loginAttempt(success: true).emit()

        // O bus despacha de forma assíncrona — aguarda breve intervalo
        Thread.sleep(forTimeInterval: 0.05)

        let auditEntries = sink.entries(for: .audit)
        #expect(!auditEntries.isEmpty)
        let entry = try #require(auditEntries.first)
        #expect(entry.level == .info)
        #expect(entry.metadata["status"] == "success")
        #expect(entry.metadata["action"] == "login")
        #expect(entry.metadata["feature"] == "LoyaltyProgram")
    }

    @Test("loginAttempt failure emite status=failure")
    func loginAttemptFailureEmitsCorrectStatus() throws {
        LPAuditEvent.loginAttempt(success: false).emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        #expect(entry.metadata["status"] == "failure")
    }

    // MARK: - redeemPoints

    @Test("redeemPoints emite métricas de saldo e custo")
    func redeemPointsEmitsBalanceMetrics() throws {
        let event = LPAuditEvent.redeemPoints(
            rewardId: "reward-42",
            pointsCost: 500,
            balanceBefore: 1000,
            balanceAfter: 500
        )
        event.emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        #expect(entry.metadata["reward_id"] == "reward-42")
        #expect(entry.metadata["action"] == "redeem")
        #expect(entry.metrics["points_cost"] == 500)
        #expect(entry.metrics["balance_before"] == 1000)
        #expect(entry.metrics["balance_after"] == 500)
        #expect(entry.metrics["delta"] == -500)
    }

    // MARK: - sendPoints — PII safety

    @Test("sendPoints contém CPF mascarado, não CPF real")
    func sendPointsDoesNotExposeRealCPF() throws {
        let maskedCPF = "***824"
        let sendEvent = LPAuditEvent.sendPoints(
            recipientMasked: maskedCPF,
            amount: 100,
            balanceBefore: 800,
            balanceAfter: 700
        )
        sendEvent.emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        // Verifica que o CPF mascarado está presente
        #expect(entry.metadata["recipient_masked"] == maskedCPF)
        // Verifica que nenhum campo contém um CPF completo (11 dígitos numéricos)
        let containsRealCPF = entry.metadata.values.contains { value in
            value.filter(\.isNumber).count == 11
        }
        #expect(!containsRealCPF)
    }

    @Test("sendPoints emite métricas de saldo e valor transferido")
    func sendPointsEmitsBalanceMetrics() throws {
        let event = LPAuditEvent.sendPoints(
            recipientMasked: "***001",
            amount: 200,
            balanceBefore: 1000,
            balanceAfter: 800
        )
        event.emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        #expect(entry.metrics["amount"] == 200)
        #expect(entry.metrics["balance_before"] == 1000)
        #expect(entry.metrics["balance_after"] == 800)
    }

    // MARK: - earnPoints

    @Test("earnPoints balanceAfter é maior que balanceBefore")
    func earnPointsBalanceAfterGreaterThanBefore() throws {
        let event = LPAuditEvent.earnPoints(
            opportunityId: "daily-checkin",
            delta: 50,
            balanceBefore: 400,
            balanceAfter: 450
        )
        event.emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        let before = try #require(entry.metrics["balance_before"])
        let after = try #require(entry.metrics["balance_after"])
        #expect(after > before)
        #expect(entry.metadata["opportunity_id"] == "daily-checkin")
    }

    // MARK: - profileSaved — PII safety

    @Test("profileSaved não loga valores PII — somente nomes de campos")
    func profileSavedDoesNotLogPIIValues() throws {
        let sensitiveEmail = "usuario@example.com"
        let sensitiveName = "João da Silva"
        LPAuditEvent.profileSaved(fieldsChanged: ["name", "email"]).emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        // Verifica que os valores PII não aparecem em nenhum campo da entrada
        let allValues = (entry.metadata.values + [entry.message]).joined(separator: " ")
        #expect(!allValues.contains(sensitiveEmail))
        #expect(!allValues.contains(sensitiveName))
        // Verifica que os nomes dos campos estão presentes
        #expect(entry.metadata["fields_changed"]?.contains("name") == true)
        #expect(entry.metadata["fields_changed"]?.contains("email") == true)
    }

    // MARK: - sessionEnded

    @Test("sessionEnded emite nível .notice com action=logout")
    func logoutEmitsSessionEnded() throws {
        LPAuditEvent.sessionEnded.emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        #expect(entry.level == .notice)
        #expect(entry.metadata["action"] == "logout")
        #expect(entry.metadata["feature"] == "LoyaltyProgram")
    }

    // MARK: - validationFailed

    @Test("validationFailed emite nível .warning com action e error_key")
    func validationFailedEmitsWarningWithDetails() throws {
        LPAuditEvent.validationFailed(action: "login", errorKey: "cpfError").emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        #expect(entry.level == .warning)
        #expect(entry.metadata["action"] == "login")
        #expect(entry.metadata["error_key"] == "cpfError")
        #expect(entry.metadata["feature"] == "LoyaltyProgram")
    }

    @Test("validationFailed não emite categoria .audit como .info")
    func validationFailedIsNotInfoLevel() throws {
        LPAuditEvent.validationFailed(action: "send_points", errorKey: "pointsError").emit()
        Thread.sleep(forTimeInterval: 0.05)

        let entry = try #require(sink.entries(for: .audit).first)
        #expect(entry.level != .info)
    }
}

// MARK: - LPLoginViewModel Audit Integration

@Suite("LPLoginViewModel — audit integration")
struct LPLoginViewModelAuditTests {
    private let sink = MockAuditSink()

    init() {
        ZodiakLogBus.shared.removeAllSinks()
        ZodiakLogBus.shared.register(sink)
    }

    @Test("CPF inválido dispara validationFailed no bus de audit")
    func invalidCPFTriggersAuditValidationFailed() {
        let vm = LPLoginViewModel()
        vm.login(identifier: "123", password: "senha123")

        Thread.sleep(forTimeInterval: 0.05)

        let auditEntries = sink.entries(for: .audit)
        #expect(!auditEntries.isEmpty)
        #expect(auditEntries.first?.metadata["error_key"] == "cpfError")
    }

    @Test("Senha inválida dispara validationFailed com passwordError")
    func invalidPasswordTriggersAuditValidationFailed() {
        let vm = LPLoginViewModel()
        vm.login(identifier: "12345678901", password: "ab")

        Thread.sleep(forTimeInterval: 0.05)

        let auditEntries = sink.entries(for: .audit)
        #expect(auditEntries.first?.metadata["error_key"] == "passwordError")
    }
}

// MARK: - LPEarnPointsViewModel Audit Integration

@Suite("LPEarnPointsViewModel — audit integration")
struct LPEarnPointsViewModelAuditTests {
    private let sink = MockAuditSink()

    init() {
        ZodiakLogBus.shared.removeAllSinks()
        ZodiakLogBus.shared.register(sink)
    }

    @Test("submit sem oportunidade selecionada dispara validationFailed")
    func submitWithoutOpportunityTriggersValidationFailed() {
        let vm = LPEarnPointsViewModel()
        vm.selectedOpportunity = nil
        vm.submit()

        Thread.sleep(forTimeInterval: 0.05)

        let auditEntries = sink.entries(for: .audit)
        #expect(auditEntries.first?.metadata["error_key"] == "no_opportunity_selected")
    }

    @Test("submit com oportunidade emite earnPoints audit com balance correto")
    func submitWithOpportunityEmitsEarnPointsAudit() {
        let vm = LPEarnPointsViewModel()
        let opportunity = LPEarnOpportunity(
            id: "test-daily",
            title: "Test Daily",
            subtitle: "Test",
            points: 50,
            imageSystemName: "star"
        )
        vm.selectedOpportunity = opportunity
        let initialPoints = vm.points
        vm.submit()

        Thread.sleep(forTimeInterval: 0.05)

        let auditEntries = sink.entries(for: .audit)
        let earnEntry = auditEntries.first { $0.metadata["action"] == "earn_points" }
        #expect(earnEntry != nil)
        #expect(earnEntry?.metadata["opportunity_id"] == "test-daily")
        #expect(earnEntry?.metrics["delta"] == 50)
        #expect(earnEntry?.metrics["balance_before"] == Double(initialPoints))
        #expect(earnEntry?.metrics["balance_after"] == Double(initialPoints + 50))
    }
}
