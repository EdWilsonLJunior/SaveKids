import Testing
@testable import ZodiakiOS

// MARK: - ThemeSwitchViewModel Tests

@Suite("ThemeSwitchViewModel")
struct ThemeSwitchViewModelTests {
    @Test("estado inicial segue ThemeSwitchConstants.darkModeDefault")
    func initialStateMatchesDefault() {
        let vm = ThemeSwitchViewModel()
        #expect(vm.isDarkMode == ThemeSwitchConstants.darkModeDefault)
    }

    @Test("toggle alterna isDarkMode")
    func toggleSwitchesDarkMode() {
        let vm = ThemeSwitchViewModel()
        let initial = vm.isDarkMode
        vm.isDarkMode.toggle()
        #expect(vm.isDarkMode == !initial)
        vm.isDarkMode.toggle()
        #expect(vm.isDarkMode == initial)
    }
}
