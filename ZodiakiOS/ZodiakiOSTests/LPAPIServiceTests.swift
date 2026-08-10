import Testing
@testable import ZodiakiOS

// MARK: - LPAPIService Tests

@Suite("LPAPIService")
struct LPAPIServiceTests {
    @Test("fetchPromotions retorna itens do bundle mock")
    func fetchPromotionsFromBundle() async {
        // A URL real falha em testes (placeholder). Fallback deve retornar bundle JSON.
        let result = await LPAPIService.fetchPromotions()
        #expect(!result.isEmpty)
        #expect(result.allSatisfy { !$0.id.isEmpty })
        #expect(result.allSatisfy { !$0.title.isEmpty })
    }

    @Test("fetchRewards retorna itens do bundle mock")
    func fetchRewardsFromBundle() async {
        let result = await LPAPIService.fetchRewards()
        #expect(!result.isEmpty)
        #expect(result.allSatisfy { !$0.id.isEmpty })
        #expect(result.allSatisfy { !$0.name.isEmpty })
    }

    @Test("fetchRewards cobre todas as categorias")
    func fetchRewardsCoversAllCategories() async {
        let result = await LPAPIService.fetchRewards()
        let categories = Set(result.map(\.category))
        #expect(categories.count == LPRewardCategory.allCases.count)
    }

    @Test("fetchPromotions retorna promoções associadas a recompensas existentes")
    func fetchPromotionsResolveExistingRewards() async {
        let promotions = await LPAPIService.fetchPromotions()
        let rewards = await LPAPIService.fetchRewards()
        let rewardIds = Set(rewards.map(\.id))

        #expect(promotions.allSatisfy { promotion in
            guard let rewardId = promotion.rewardId else { return false }
            return rewardIds.contains(rewardId)
        })
    }

    @Test("fetchReward retorna recompensa pelo id")
    func fetchRewardByID() async {
        let reward = await LPAPIService.fetchReward(id: "reward-p01")
        #expect(reward?.id == "reward-p01")
    }
}
