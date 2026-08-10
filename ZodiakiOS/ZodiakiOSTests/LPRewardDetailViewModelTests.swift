import Testing
@testable import ZodiakiOS

@Suite("LPRewardDetailViewModel Tests")
struct LPRewardDetailViewModelTests {
    private func makeReward(cost: Int = 800) -> LPReward {
        LPReward(
            id: "reward-1",
            name: "Reward",
            description: "Description",
            imageSystemName: "gift",
            pointsCost: cost,
            category: .products,
            type: .product
        )
    }

    @Test("reward é affordável quando pontos são suficientes")
    func affordableWhenEnoughPoints() {
        let vm = LPRewardDetailViewModel(reward: makeReward(cost: 600))
        vm.points = 1_000

        #expect(vm.isAffordable)
        #expect(vm.missingPoints == 0)
    }

    @Test("reward não é affordável e missingPoints é calculado")
    func unaffordableCalculatesMissingPoints() {
        let vm = LPRewardDetailViewModel(reward: makeReward(cost: 1_500))
        vm.points = 1_000

        #expect(vm.isAffordable == false)
        #expect(vm.missingPoints == 500)
    }

    @Test("formatadores de pontos retornam valor não vazio")
    func formattersReturnNonEmptyValues() {
        let vm = LPRewardDetailViewModel(reward: makeReward(cost: 1_200))
        vm.points = 3_000

        #expect(vm.formattedPoints.isEmpty == false)
        #expect(vm.formattedCost.isEmpty == false)
    }
}
