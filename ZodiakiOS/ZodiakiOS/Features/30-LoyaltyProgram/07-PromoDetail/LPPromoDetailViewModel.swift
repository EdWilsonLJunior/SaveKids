import Combine
import Foundation

// MARK: - US-30.07 Promo Detail ViewModel
final class LPPromoDetailViewModel: ObservableObject {
    @Published var associatedReward: LPReward?

    private let fetchReward: (String?) async -> LPReward?

    init(fetchReward: @escaping (String?) async -> LPReward? = LPAPIService.fetchReward) {
        self.fetchReward = fetchReward
    }

    func loadAssociatedReward(for promotion: LPPromotion) async {
        guard promotion.rewardId != nil else {
            await MainActor.run { associatedReward = nil }
            ZodiakLog.debug(.viewModel, "LP promo detail has no reward ID",
                            metadata: ["feature": "LoyaltyProgram", "promo_id": promotion.id])
            return
        }

        let span = ZodiakSpan(name: "lp_promo_detail_load_reward", category: .network)
        let reward = await fetchReward(promotion.rewardId)
        await MainActor.run { associatedReward = reward }
        span.end(
            status: reward == nil ? "error" : "ok",
            metadata: ["feature": "LoyaltyProgram", "promo_id": promotion.id]
        )
        ZodiakLog.debug(
            .viewModel,
            "LP promo detail associated reward loaded",
            metadata: ["feature": "LoyaltyProgram", "promo_id": promotion.id, "reward_id": reward?.id ?? "nil"]
        )
    }

    func reset() {
        associatedReward = nil
    }
}
