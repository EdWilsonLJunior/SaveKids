import Testing
@testable import ZodiakiOS

// MARK: - LPLoginViewModel Tests
@Suite("LPLoginViewModel")
struct LPLoginViewModelTests {
    // MARK: Initial State

    @Test("Estado inicial é vazio e idle")
    func initialState() {
        let viewModel = LPLoginViewModel()
        #expect(viewModel.state == .idle)
        #expect(!viewModel.isLoading)
        #expect(viewModel.errorMessage == nil)
    }

    // MARK: Validation — CPF

    @Test("Login com CPF inválido define estado cpfError")
    func loginWithInvalidCPF() {
        let viewModel = LPLoginViewModel()
        viewModel.login(identifier: "123", password: "1234")
        #expect(viewModel.state == .cpfError)
        #expect(viewModel.errorMessage == "lp.login.error_cpf")
    }

    // MARK: Validation — Password

    @Test("Login com senha curta define estado passwordError")
    func loginWithShortPassword() {
        let viewModel = LPLoginViewModel()
        viewModel.login(identifier: "12345678909", password: "12")
        #expect(viewModel.state == .passwordError)
        #expect(viewModel.errorMessage == "lp.login.error_password")
    }

    // MARK: Loading State

    @Test("Login com dados válidos define estado loading")
    func loginWithValidInputStartsLoading() {
        let viewModel = LPLoginViewModel()
        viewModel.login(identifier: "12345678909", password: "1234")
        #expect(viewModel.state == .loading)
        #expect(viewModel.isLoading)
    }

    // MARK: Reset

    @Test("Reset limpa todos os campos e estado")
    func resetClearsAllState() {
        let viewModel = LPLoginViewModel()
        viewModel.state = .cpfError
        viewModel.reset()
        #expect(viewModel.state == .idle)
        #expect(viewModel.errorMessage == nil)
    }
}
