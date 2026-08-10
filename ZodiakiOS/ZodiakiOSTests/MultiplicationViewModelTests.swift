import Testing
@testable import ZodiakiOS

// MARK: - MultiplicationTableViewModel Tests

@Suite("MultiplicationTableViewModel")
struct MultiplicationTableViewModelTests {
    @Test("generateTable gera tabuada correta para número 5")
    func generatesCorrectTableFor5() {
        let vm = MultiplicationTableViewModel()
        vm.number = 5.0
        vm.generateTable()
        #expect(vm.table != nil)
        #expect(vm.table?.count == 10)
        #expect(vm.table?.first?.result == 5)
        #expect(vm.table?.last?.result == 50)
    }

    @Test("número nil gera errorMessage")
    func nilNumberGeneratesError() {
        let vm = MultiplicationTableViewModel()
        vm.number = nil
        vm.generateTable()
        #expect(vm.table == nil)
        #expect(vm.errorMessage != nil)
    }

    @Test("número negativo gera errorMessage")
    func negativeNumberGeneratesError() {
        let vm = MultiplicationTableViewModel()
        vm.number = -3.0
        vm.generateTable()
        #expect(vm.table == nil)
        #expect(vm.errorMessage != nil)
    }

    @Test("reset limpa tabela e erro")
    func resetClearsState() {
        let vm = MultiplicationTableViewModel()
        vm.number = 3.0
        vm.generateTable()
        vm.reset()
        #expect(vm.number == nil)
        #expect(vm.table == nil)
        #expect(vm.errorMessage == nil)
    }
}
