import Testing
@testable import ZodiakiOS

@Suite("LPRedeemViewModel")
struct LPRedeemViewModelTests {
    private func makeReward(id: String = "r1", cost: Int = 500) -> LPReward {
        LPReward(
            id: id,
            name: "Test Reward",
            description: "Desc",
            imageSystemName: "star",
            pointsCost: cost,
            category: .products,
            type: .product
        )
    }

    @Test("estado inicial é loading")
    func initialStateIsLoading() {
        let vm = LPRedeemViewModel(fetchRewards: { [] })
        #expect(vm.state == .loading)
    }

    @Test("loadRewards com lista vazia → error")
    func loadEmptyResultSetsError() async {
        let vm = LPRedeemViewModel(fetchRewards: { [] })
        await vm.loadRewards()
        #expect(vm.state == .error)
    }

    @Test("loadRewards com dados → success")
    func loadWithDataSetsSuccess() async {
        let reward = makeReward()
        let vm = LPRedeemViewModel(fetchRewards: { [reward] })
        await vm.loadRewards()
        if case .success(let rewards) = vm.state {
            #expect(rewards.count == 1)
        } else {
            #expect(Bool(false), "Expected .success state")
        }
    }

    @Test("isAffordable retorna true quando pontos suficientes")
    func isAffordableReturnsTrueWhenEnoughPoints() {
        let vm = LPRedeemViewModel(fetchRewards: { [] })
        vm.points = 1000
        let reward = makeReward(cost: 500)
        #expect(vm.isAffordable(reward) == true)
    }

    @Test("isAffordable retorna false quando pontos insuficientes")
    func isAffordableReturnsFalseWhenInsufficientPoints() {
        let vm = LPRedeemViewModel(fetchRewards: { [] })
        vm.points = 100
        let reward = makeReward(cost: 500)
        #expect(vm.isAffordable(reward) == false)
    }

    @Test("reset restaura todas as categorias selecionadas")
    func resetRestoresAllCategories() {
        let vm = LPRedeemViewModel(fetchRewards: { [] })
        vm.selectedCategories = [.products]
        vm.reset()
        #expect(vm.selectedCategories == Set(LPRewardCategory.allCases))
    }
}
