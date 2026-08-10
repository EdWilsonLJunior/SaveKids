import Testing
@testable import ZodiakiOS

@Suite("LPHomeViewModel")
struct LPHomeViewModelTests {
    @Test("estado inicial é loading")
    func initialStateIsLoading() {
        let vm = LPHomeViewModel(fetchPromotions: { [] })
        #expect(vm.promoState == .loading)
    }

    @Test("loadPromotions com lista vazia → estado error")
    func loadWithEmptyResultSetsError() async {
        let vm = LPHomeViewModel(fetchPromotions: { [] })
        await vm.loadPromotions()
        #expect(vm.promoState == .error)
    }

    @Test("loadPromotions com dados → estado ready")
    func loadWithDataSetsReady() async {
        let promo = LPPromotion(
            id: "p1",
            title: "Test",
            description: "Desc",
            imageSystemName: "star",
            pointsCost: 100,
            expiresAt: nil
        )
        let vm = LPHomeViewModel(fetchPromotions: { [promo] })
        await vm.loadPromotions()
        if case .ready(let promotions) = vm.promoState {
            #expect(promotions.count == 1)
        } else {
            #expect(Bool(false), "Expected .ready state")
        }
    }

    @Test("formattedPoints formata 1250 com separador de milhar")
    func formattedPointsFormat() {
        let vm = LPHomeViewModel(fetchPromotions: { [] })
        // Default points é LPConstants.Defaults.initialPoints (1250)
        // Deve conter "1" e "250" mas com separador de milhar (locale-dependente)
        let result = vm.formattedPoints
        #expect(!result.isEmpty)
        #expect(result.contains("250"))
        // Não deve ser apenas o número sem formatação
        #expect(result != "1250")
    }
}
