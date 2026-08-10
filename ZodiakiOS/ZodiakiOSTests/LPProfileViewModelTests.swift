import Testing
@testable import ZodiakiOS

@Suite("LPProfileViewModel")
struct LPProfileViewModelTests {
    @Test("estado inicial é idle")
    func initialStateIsIdle() {
        let vm = LPProfileViewModel()
        #expect(vm.state == .idle)
    }

    @Test("nome com 1 caractere → nameError")
    func shortNameSetsNameError() async {
        let vm = LPProfileViewModel(processingDelay: .zero)
        vm.name = "A"
        vm.email = "test@example.com"
        await vm.save()
        #expect(vm.state == .nameError)
    }

    @Test("email sem @ → emailError")
    func invalidEmailSetsEmailError() async {
        let vm = LPProfileViewModel(processingDelay: .zero)
        vm.name = "João Silva"
        vm.email = "emailinvalido"
        await vm.save()
        #expect(vm.state == .emailError)
    }

    @Test("nome e email válidos → success")
    func validDataSetsSuccess() async {
        let vm = LPProfileViewModel(processingDelay: .zero)
        vm.name = "João Silva"
        vm.email = "joao@example.com"
        await vm.save()
        #expect(vm.state == .success)
    }

    @Test("confirmDiscard restaura valores salvos")
    func confirmDiscardRestoresSavedValues() async {
        let vm = LPProfileViewModel(processingDelay: .zero)
        vm.name = "João Silva"
        vm.email = "joao@example.com"
        await vm.save()
        vm.name = "Alterado"
        vm.email = "alterado@example.com"
        vm.confirmDiscard()
        #expect(vm.name == "João Silva")
        #expect(vm.email == "joao@example.com")
    }

    @Test("hasChanges é true quando campos diferem dos salvos")
    func hasChangesDetectsDirtyState() async {
        let vm = LPProfileViewModel(processingDelay: .zero)
        vm.name = "João Silva"
        vm.email = "joao@example.com"
        await vm.save()
        vm.name = "Novo Nome"
        #expect(vm.hasChanges == true)
    }
}
