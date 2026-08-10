import Foundation
import Testing
@testable import ZodiakiOS

// MARK: - SolutionsCatalogViewModelTests

@Suite("SolutionsCatalogViewModel")
@MainActor
struct SolutionsCatalogViewModelTests {
    @Test("Estado inicial carrega soluções do JSON")
    func initialStateLoadsSolutions() async throws {
        let vm = SolutionsCatalogViewModel()
        try await Task.sleep(nanoseconds: 600_000_000)
        #expect(!vm.filteredSolutions.isEmpty)
    }

    @Test("Filtro por categoria retorna apenas soluções da categoria")
    func filterByCategory() async throws {
        let vm = SolutionsCatalogViewModel()
        vm.filter.categories = [.frontend]
        try await Task.sleep(nanoseconds: 600_000_000)
        #expect(vm.filteredSolutions.allSatisfy { $0.category == .frontend })
    }

    @Test("Filtro por texto de busca retorna soluções relevantes")
    func filterBySearchText() async throws {
        let vm = SolutionsCatalogViewModel()
        vm.filter.searchText = "Angular"
        try await Task.sleep(nanoseconds: 600_000_000)
        #expect(!vm.filteredSolutions.isEmpty)
        #expect(vm.filteredSolutions.allSatisfy {
            $0.stack.localizedCaseInsensitiveContains("Angular")
                || $0.title.localizedCaseInsensitiveContains("Angular")
                || $0.description.localizedCaseInsensitiveContains("Angular")
        })
    }

    @Test("Limpar filtro restaura todas as soluções")
    func clearFilterRestoresAll() async throws {
        let vm = SolutionsCatalogViewModel()
        try await Task.sleep(nanoseconds: 600_000_000)
        let total = vm.filteredSolutions.count
        vm.filter.categories = [.migracao]
        try await Task.sleep(nanoseconds: 600_000_000)
        vm.clearFilter()
        try await Task.sleep(nanoseconds: 600_000_000)
        #expect(vm.filteredSolutions.count == total)
    }

    @Test("Selecionar solução define selectedSolution")
    func selectSolution() async throws {
        let vm = SolutionsCatalogViewModel()
        try await Task.sleep(nanoseconds: 600_000_000)
        let first = try #require(vm.filteredSolutions.first)
        vm.select(first)
        #expect(vm.selectedSolution?.id == first.id)
    }

    @Test("isShowingFilter inicia como false")
    func initialIsShowingFilterIsFalse() throws {
        let vm = SolutionsCatalogViewModel()
        #expect(!vm.isShowingFilter)
    }

    @Test("clearFilter define isShowingFilter como false")
    func clearFilterDismissesSheet() throws {
        let vm = SolutionsCatalogViewModel()
        vm.isShowingFilter = true
        vm.clearFilter()
        #expect(!vm.isShowingFilter)
        #expect(vm.filter == SolutionFilter())
    }
}
