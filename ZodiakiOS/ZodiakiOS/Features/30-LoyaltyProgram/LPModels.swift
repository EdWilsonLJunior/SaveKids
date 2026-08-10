import Foundation
import SwiftUI

// MARK: - LP Domain Models — Épico 30: Programa Fidelidade

struct LPPromotion: Codable, Identifiable, Hashable {
    let id: String
    let rewardId: String?
    let title: String
    let description: String
    let imageSystemName: String
    let pointsCost: Int
    let expiresAt: Date?
    var benefits: [String]

    init(
        id: String,
        rewardId: String? = nil,
        title: String,
        description: String,
        imageSystemName: String,
        pointsCost: Int,
        expiresAt: Date?,
        benefits: [String] = []
    ) {
        self.id = id
        self.rewardId = rewardId
        self.title = title
        self.description = description
        self.imageSystemName = imageSystemName
        self.pointsCost = pointsCost
        self.expiresAt = expiresAt
        self.benefits = benefits
    }

    // Custom decoder: benefits is optional in JSON (older API responses may omit it)
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        rewardId = try c.decodeIfPresent(String.self, forKey: .rewardId)
        title = try c.decode(String.self, forKey: .title)
        description = try c.decode(String.self, forKey: .description)
        imageSystemName = try c.decode(String.self, forKey: .imageSystemName)
        pointsCost = try c.decode(Int.self, forKey: .pointsCost)
        expiresAt = try c.decodeIfPresent(Date.self, forKey: .expiresAt)
        benefits = (try? c.decode([String].self, forKey: .benefits)) ?? []
    }
}

// MARK: - Membership Tier

struct LPMembershipTier: Codable {
    let name: String
    let currentPoints: Int
    let pointsToNextTier: Int
    let nextTierName: String?

    var progress: Double {
        guard pointsToNextTier > 0 else { return 1.0 }
        return min(1.0, Double(currentPoints) / Double(pointsToNextTier))
    }
}

struct LPReward: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let imageSystemName: String
    let pointsCost: Int
    let category: LPRewardCategory
    let type: LPRewardType

    var deterministicImageURL: URL? {
        URL(string: "https://picsum.photos/seed/\(id)/640/360")
    }
}

enum LPRewardCategory: String, CaseIterable, Codable, Identifiable {
    case products
    case discounts
    case services
    case donations

    var id: String { rawValue }

    var localizedName: String {
        switch self {
        case .products:  return String(localized: "lp.category.products")
        case .discounts: return String(localized: "lp.category.discounts")
        case .services:  return String(localized: "lp.category.services")
        case .donations: return String(localized: "lp.category.donations")
        }
    }
}

enum LPRewardType: String, Codable {
    case product
    case service
    case discount
}

struct LPPointTransaction: Codable, Identifiable {
    let id: String
    let type: LPTransactionType
    let description: String
    let date: Date
    let points: Int // negative = debit
}

enum LPTransactionType: String, Codable {
    case earned
    case redeemed
    case sent
    case received
}

struct LPProfile: Codable {
    var name: String
    var email: String
    var emailNotifications: Bool
    var pushNotifications: Bool

    static let empty = Self(name: "", email: "", emailNotifications: true, pushNotifications: true)
}

// MARK: - LPRewardCategory selection bridge (ZodiakMultiselect compatibility)

extension LPRewardCategory {
    /// Returns a `Binding<Set<String>>` suitable for `ZodiakMultiselect`,
    /// bridging `Set<LPRewardCategory>` via `localizedName` — which must match the options array.
    static func selectionBinding(for selection: Binding<Set<LPRewardCategory>>) -> Binding<Set<String>> {
        Binding(
            get: { Set(selection.wrappedValue.map(\.localizedName)) },
            set: { newNames in
                selection.wrappedValue = Set(allCases.filter { newNames.contains($0.localizedName) })
            }
        )
    }
}

// MARK: - Earn Opportunity

struct LPEarnOpportunity: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let subtitle: String
    let points: Int
    let imageSystemName: String
}

// MARK: - Shared NumberFormatter for LP points display

extension NumberFormatter {
    /// Shared locale-aware decimal formatter used across all LP ViewModels.
    static let lpPoints: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.locale = Locale.current
        return fmt
    }()
}
