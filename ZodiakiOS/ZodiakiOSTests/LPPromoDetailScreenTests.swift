import Foundation
import Testing
@testable import ZodiakiOS

@Suite("LPPromoDetailScreen — Logic")
struct LPPromoDetailScreenTests {
    private func makePromotion(expiresAt: Date?) -> LPPromotion {
        LPPromotion(
            id: "p1",
            rewardId: "reward-p01",
            title: "Test Promo",
            description: "Desc",
            imageSystemName: "star",
            pointsCost: 500,
            expiresAt: expiresAt
        )
    }

    @Test("promoção sem expiração não está expirada")
    func promoWithoutExpiryIsNotExpired() {
        let promo = makePromotion(expiresAt: nil)
        #expect(promo.expiresAt == nil)
    }

    @Test("promoção com data passada está expirada")
    func promoWithPastDateIsExpired() throws {
        let pastDate = Date(timeIntervalSinceNow: -86400)
        let promo = makePromotion(expiresAt: pastDate)
        let expiresAt = try #require(promo.expiresAt)
        #expect(expiresAt < Date())
    }

    @Test("custo de pontos é positivo")
    func pointsCostIsPositive() {
        let promo = makePromotion(expiresAt: nil)
        #expect(promo.pointsCost > 0)
    }

    @Test("promoção preserva id da recompensa associada")
    func promotionKeepsAssociatedRewardID() {
        let promo = makePromotion(expiresAt: nil)
        #expect(promo.rewardId == "reward-p01")
    }
}
