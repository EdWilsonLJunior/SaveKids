import Testing
@testable import ZodiakiOS

@Suite("LPSendPointsViewModel")
struct LPSendPointsViewModelTests {
    @Test("estado inicial é step 0 idle")
    func initialState() {
        let vm = LPSendPointsViewModel()
        #expect(vm.currentStep == 0)
        #expect(vm.state == .idle)
    }

    @Test("CPF inválido (curto) → cpfError")
    func shortCPFSetsCPFError() {
        let vm = LPSendPointsViewModel()
        vm.recipientCPF = "123456789"
        let valid = vm.validateStep1()
        #expect(!valid)
        #expect(vm.state == .cpfError)
    }

    @Test("CPF com 11 dígitos → válido (avanço para step 1)")
    func validCPFAdvancesToStep1() {
        let vm = LPSendPointsViewModel()
        vm.recipientCPF = "12345678901"
        vm.advance()
        #expect(vm.currentStep == 1)
    }

    @Test("valor menor que mínimo → minimumError")
    func belowMinimumSetsMinimumError() {
        let vm = LPSendPointsViewModel()
        vm.amount = 5
        let valid = vm.validateStep2()
        #expect(!valid)
        #expect(vm.state == .minimumError)
    }

    @Test("valor não múltiplo de 10 → multipleError")
    func nonMultipleSetsMultipleError() {
        let vm = LPSendPointsViewModel()
        vm.amount = 15
        let valid = vm.validateStep2()
        #expect(!valid)
        #expect(vm.state == .multipleError)
    }

    @Test("valor acima do saldo → pointsError")
    func aboveBalanceSetsPointsError() {
        let vm = LPSendPointsViewModel()
        vm.points = 100
        vm.amount = 200
        let valid = vm.validateStep2()
        #expect(!valid)
        #expect(vm.state == .pointsError)
    }

    @Test("confirm decrementa pontos")
    func confirmDecrementsPoints() async {
        let vm = LPSendPointsViewModel(processingDelay: .zero)
        vm.points = 1250
        vm.recipientCPF = "12345678901"
        vm.amount = 100
        vm.currentStep = 2
        vm.confirm()
        await Task.yield()
        await Task.yield()
        #expect(vm.points == 1150)
        #expect(vm.showSuccessModal == true)
    }

    @Test("reset limpa todos os campos")
    func resetClearsAllState() {
        let vm = LPSendPointsViewModel()
        vm.currentStep = 2
        vm.recipientCPF = "12345678901"
        vm.amount = 100
        vm.reset()
        #expect(vm.currentStep == 0)
        #expect(vm.recipientCPF.isEmpty)
        #expect(vm.amount == LPConstants.Validation.minTransferPoints)
    }
}
