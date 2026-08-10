import Testing
@testable import ZodiakiOS

@Suite("LPPromoDetailViewModel Tests")
struct LPPromoDetailViewModelTests {
    private func makePromotion(rewardId: String? = "reward-p01") -> LPPromotion {
        LPPromotion(
            id: "promo-1",
            rewardId: rewardId,
            title: "Promo",
            description: "Description",
            imageSystemName: "star",
            pointsCost: 500,
            expiresAt: nil
        )
    }

    private func makeReward(id: String = "reward-p01") -> LPReward {
        LPReward(
            id: id,
            name: "Reward",
            description: "Description",
            imageSystemName: "gift",
            pointsCost: 500,
            category: .products,
            type: .product
        )
    }

    @Test("initial state has no associated reward")
    func initialStateHasNoAssociatedReward() {
        let vm = LPPromoDetailViewModel(fetchReward: { _ in nil })

        #expect(vm.associatedReward == nil)
    }

    @Test("load associated reward finds matching reward")
    func loadAssociatedRewardFindsReward() async {
        let reward = makeReward()
        let vm = LPPromoDetailViewModel(fetchReward: { id in
            id == "reward-p01" ? reward : nil
        })

        await vm.loadAssociatedReward(for: makePromotion())

        #expect(vm.associatedReward == reward)
    }

    @Test("load associated reward without id clears reward")
    func loadAssociatedRewardWithoutIDClearsReward() async {
        let vm = LPPromoDetailViewModel(fetchReward: { _ in makeReward() })
        await vm.loadAssociatedReward(for: makePromotion())

        await vm.loadAssociatedReward(for: makePromotion(rewardId: nil))

        #expect(vm.associatedReward == nil)
    }

    @Test("reset clears associated reward")
    func resetClearsAssociatedReward() async {
        let vm = LPPromoDetailViewModel(fetchReward: { _ in makeReward() })
        await vm.loadAssociatedReward(for: makePromotion())

        vm.reset()

        #expect(vm.associatedReward == nil)
    }
}
