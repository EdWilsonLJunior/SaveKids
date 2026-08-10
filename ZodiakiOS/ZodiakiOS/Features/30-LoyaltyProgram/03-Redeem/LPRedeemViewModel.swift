import Combine
import SwiftUI

// MARK: - Redeem State
enum LPRedeemState: Equatable {
    case loading
    case success([LPReward])
    case error
}

// MARK: - US-30.03 Redeem ViewModel
final class LPRedeemViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.points) var points: Int = LPConstants.Defaults.initialPoints

    @Published var state: LPRedeemState = .loading
    @Published var selectedCategories: Set<LPRewardCategory> = Set(LPRewardCategory.allCases)

    private let fetchRewards: LPRewardsFetcher

    init(fetchRewards: @escaping LPRewardsFetcher = LPAPIService.fetchRewards) {
        self.fetchRewards = fetchRewards
    }

    func loadRewards() async {
        let span = ZodiakSpan(name: "lp_load_rewards", category: .network)
        state = .loading
        let rewards = await fetchRewards()
        await MainActor.run {
            state = rewards.isEmpty ? .error : .success(rewards)
            span.end(
                status: rewards.isEmpty ? "error" : "ok",
                metadata: ["feature": "LoyaltyProgram"],
                extraMetrics: ["reward_count": Double(rewards.count)]
            )
        }
    }

    func retry() {
        Task { await loadRewards() }
    }

    var allRewards: [LPReward] {
        if case .success(let rewards) = state { return rewards }
        return []
    }

    var categoryOptions: [String] {
        LPRewardCategory.allCases.map(\.localizedName)
    }

    var activeFilterCount: Int {
        let allSelected = selectedCategories == Set(LPRewardCategory.allCases)
        return allSelected ? 0 : LPRewardCategory.allCases.count - selectedCategories.count
    }

    var filteredRewards: [LPReward] {
        if selectedCategories.isEmpty { return [] }
        if selectedCategories == Set(LPRewardCategory.allCases) { return allRewards }
        return allRewards.filter { selectedCategories.contains($0.category) }
    }

    func isAffordable(_ reward: LPReward) -> Bool {
        reward.pointsCost <= points
    }

    func reset() {
        selectedCategories = Set(LPRewardCategory.allCases)
    }

    var formattedPoints: String {
        NumberFormatter.lpPoints.string(from: NSNumber(value: points)) ?? "\(points)"
    }
}
