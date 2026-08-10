import Combine
import SwiftUI

// MARK: - Home Promo State
enum LPHomePromoState: Equatable {
    case loading
    case ready([LPPromotion])
    case error
}

// MARK: - US-30.02 Home ViewModel
final class LPHomeViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.isAuthenticated) var isAuthenticated: Bool = false
    @AppStorage(LPConstants.Storage.points) var points: Int = LPConstants.Defaults.initialPoints

    @Published var promoState: LPHomePromoState = .loading
    @Published var selectedPromotion: LPPromotion?

    // MARK: - Membership Tier
    var membershipTier: LPMembershipTier {
        if points >= LPConstants.Membership.pointsToSilver {
            return LPMembershipTier(
                name: String(localized: "lp.home.tier_silver"),
                currentPoints: points,
                pointsToNextTier: LPConstants.Membership.pointsToSilver,
                nextTierName: nil
            )
        }
        return LPMembershipTier(
            name: String(localized: "lp.home.tier_bronze"),
            currentPoints: points,
            pointsToNextTier: LPConstants.Membership.pointsToSilver,
            nextTierName: String(localized: "lp.home.tier_silver")
        )
    }

    private let fetchPromotions: LPPromotionsFetcher

    init(fetchPromotions: @escaping LPPromotionsFetcher = LPAPIService.fetchPromotions) {
        self.fetchPromotions = fetchPromotions
    }

    func loadPromotions() async {
        let span = ZodiakSpan(name: "lp_load_promotions", category: .network)
        promoState = .loading
        let promotions = await fetchPromotions()
        await MainActor.run {
            promoState = promotions.isEmpty ? .error : .ready(promotions)
            span.end(
                status: promotions.isEmpty ? "error" : "ok",
                metadata: ["feature": "LoyaltyProgram"],
                extraMetrics: ["promo_count": Double(promotions.count)]
            )
        }
    }

    func retryPromotions() {
        Task { await loadPromotions() }
    }

    var formattedPoints: String {
        NumberFormatter.lpPoints.string(from: NSNumber(value: points)) ?? "\(points)"
    }

    // MARK: - Banner helpers

    func expiringPromotion(from promotions: [LPPromotion]) -> LPPromotion? {
        promotions.first { promo in
            guard let expiresAt = promo.expiresAt else { return false }
            let days = Calendar.current.dateComponents([.day], from: Date(), to: expiresAt).day ?? Int.max
            return days >= 0 && days <= 7
        }
    }
}
