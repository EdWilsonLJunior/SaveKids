import Combine
import SwiftUI

// MARK: - Catalog State

enum LPCatalogState: Equatable {
    case loading
    case success([LPReward])
    case error
}

// MARK: - US-30.08 Catalog ViewModel
final class LPCatalogViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.points) var points: Int = LPConstants.Defaults.initialPoints

    @Published var catalogState: LPCatalogState = .loading
    @Published var selectedCategories: Set<LPRewardCategory> = []

    private let fetchRewards: LPRewardsFetcher

    init(fetchRewards: @escaping LPRewardsFetcher = LPAPIService.fetchRewards) {
        self.fetchRewards = fetchRewards
    }

    // MARK: - Computed

    var filteredRewards: [LPReward] {
        guard case .success(let rewards) = catalogState else { return [] }
        guard !selectedCategories.isEmpty else { return rewards }
        return rewards.filter { selectedCategories.contains($0.category) }
    }

    var activeFilterCount: Int {
        selectedCategories.count
    }

    var formattedPoints: String {
        NumberFormatter.lpPoints.string(from: NSNumber(value: points)) ?? "\(points)"
    }

    // MARK: - Actions

    func loadRewards() async {
        let span = ZodiakSpan(name: "lp_load_catalog", category: .network)
        catalogState = .loading
        let rewards = await fetchRewards()
        await MainActor.run {
            catalogState = rewards.isEmpty ? .error : .success(rewards)
            span.end(
                status: rewards.isEmpty ? "error" : "ok",
                metadata: ["feature": "LoyaltyProgram"],
                extraMetrics: ["rewards_count": Double(rewards.count)]
            )
        }
    }

    func retry() {
        catalogState = .loading
        Task { await loadRewards() }
    }

    func reset() {
        selectedCategories = []
        catalogState = .loading
    }
}
