import Foundation
import Testing
@testable import ZodiakiOS

// MARK: - LPModels Tests

@Suite("LPModels")
struct LPModelsTests {
    @Test("LPProfile.empty tem defaults corretos")
    func profileEmptyDefaults() {
        let profile = LPProfile.empty
        #expect(profile.name.isEmpty)
        #expect(profile.email.isEmpty)
        #expect(profile.emailNotifications == true)
        #expect(profile.pushNotifications == true)
    }

    @Test("LPPointTransaction com pontos negativos é débito")
    func transactionNegativePointsIsDebit() {
        let tx = LPPointTransaction(
            id: "tx-001",
            type: .redeemed,
            description: "Resgate de recompensa",
            date: .now,
            points: -500
        )
        #expect(tx.points < 0)
    }

    @Test("LPRewardCategory tem 4 cases")
    func rewardCategoryCount() {
        #expect(LPRewardCategory.allCases.count == 4)
    }

    @Test("LPRewardCategory IDs são os rawValues")
    func rewardCategoryID() {
        #expect(LPRewardCategory.products.id == "products")
        #expect(LPRewardCategory.discounts.id == "discounts")
        #expect(LPRewardCategory.services.id == "services")
        #expect(LPRewardCategory.donations.id == "donations")
    }

    @Test("LPConstants.Validation tem valores corretos")
    func validationConstants() {
        #expect(LPConstants.Validation.cpfLength == 11)
        #expect(LPConstants.Validation.minPasswordLength == 4)
        #expect(LPConstants.Validation.minTransferPoints == 10)
        #expect(LPConstants.Validation.transferPointsMultiple == 10)
    }
}
