import Testing
@testable import ZodiakiOS

// MARK: - CardManagerViewModel Tests

@Suite("CardManagerViewModel")
struct CardManagerViewModelTests {
    @Test("estado inicial tem selectedCard nil")
    func initialStateSelectedCardIsNil() {
        let vm = CardManagerViewModel()
        #expect(vm.selectedCard == nil)
    }

    @Test("estado inicial carrega cartões de amostra")
    func initialStateHasSampleCards() {
        let vm = CardManagerViewModel()
        #expect(!vm.cards.isEmpty)
        #expect(vm.cards.count == CardManagerConstants.sampleCards.count)
    }

    @Test("select define selectedCard corretamente")
    func selectSetsSelectedCard() {
        let vm = CardManagerViewModel()
        let card = vm.cards[0]
        vm.select(card)
        #expect(vm.selectedCard?.id == card.id)
    }

    @Test("dismiss limpa selectedCard")
    func dismissClearsSelectedCard() {
        let vm = CardManagerViewModel()
        vm.select(vm.cards[0])
        vm.dismiss()
        #expect(vm.selectedCard == nil)
    }

    @Test("select de cartão diferente substitui o anterior")
    func selectReplacesExistingSelection() {
        let vm = CardManagerViewModel()
        vm.select(vm.cards[0])
        vm.select(vm.cards[1])
        #expect(vm.selectedCard?.id == vm.cards[1].id)
    }
}
