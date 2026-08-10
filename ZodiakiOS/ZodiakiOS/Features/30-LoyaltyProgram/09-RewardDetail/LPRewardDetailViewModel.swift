import Combine
import SwiftUI

// MARK: - US-30.09 Reward Detail ViewModel
final class LPRewardDetailViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.points) var points: Int = LPConstants.Defaults.initialPoints
    @AppStorage(LPConstants.Storage.statement) var statementData: Data = Data()

    @Published var showSuccessModal: Bool = false

    let reward: LPReward
    private var redeemTask: Task<Void, Never>?

    init(reward: LPReward) {
        self.reward = reward
    }

    var isAffordable: Bool {
        reward.pointsCost <= points
    }

    var missingPoints: Int {
        max(0, reward.pointsCost - points)
    }

    var formattedPoints: String {
        NumberFormatter.lpPoints.string(from: NSNumber(value: points)) ?? "\(points)"
    }

    var formattedCost: String {
        NumberFormatter.lpPoints.string(from: NSNumber(value: reward.pointsCost)) ?? "\(reward.pointsCost)"
    }

    var remainingAfterRedeem: String {
        let remaining = points - reward.pointsCost
        return NumberFormatter.lpPoints.string(from: NSNumber(value: remaining)) ?? "\(remaining)"
    }

    func redeem() {
        guard isAffordable else { return }
        let cost = reward.pointsCost
        let tx = LPPointTransaction(
            id: UUID().uuidString,
            type: .redeemed,
            description: reward.name,
            date: Date(),
            points: -cost
        )
        redeemTask?.cancel()
        redeemTask = Task { @MainActor in
            let span = ZodiakSpan(name: "lp_reward_detail_redeem", category: .service)
            let balanceBefore = self.points
            do {
                // Delay de processamento: reforça percepção de transação real
                try await Task.sleep(for: .milliseconds(800))
                self.points -= cost
                LPStatementService.appendTransaction(tx, to: &self.statementData)
                self.showSuccessModal = true
                span.end(status: "ok", metadata: ["feature": "LoyaltyProgram", "reward_id": self.reward.id])
                let auditEvent = LPAuditEvent.redeemPoints(
                    rewardId: self.reward.id,
                    pointsCost: cost,
                    balanceBefore: balanceBefore,
                    balanceAfter: self.points
                )
                auditEvent.emit()
            } catch {
                ZodiakLog.debug(.viewModel, "LP reward detail redeem task cancelled",
                                metadata: ["feature": "LoyaltyProgram"])
                span.end(status: "cancelled", metadata: ["feature": "LoyaltyProgram"])
            }
        }
    }

    deinit { redeemTask?.cancel() }
}
