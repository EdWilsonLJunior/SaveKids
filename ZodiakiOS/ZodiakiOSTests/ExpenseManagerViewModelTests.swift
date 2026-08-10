import SwiftData
import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ExpenseManagerViewModel Tests

@Suite("ExpenseManagerViewModel")
struct ExpenseManagerViewModelTests {
    // MARK: - Helpers

    private static func makeContainer() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try ModelContainer(for: ExpenseEntry.self, configurations: config)
    }

    private static func makeEntry(
        category: ExpenseCategory = .mercado,
        amount: Double = 100,
        month: ExpenseMonth = .janeiro,
        year: Int = 2026,
        context: ModelContext
    ) -> ExpenseEntry {
        let entry = ExpenseEntry(category: category, amount: amount, month: month, year: year)
        context.insert(entry)
        return entry
    }

    // MARK: - Month Selection

    @Test("selectedMonth retorna o mês correto pelo índice")
    func selectedMonthMatchesIndex() {
        let vm = ExpenseManagerViewModel()
        vm.selectedMonthIndex = 0
        #expect(vm.selectedMonth == .janeiro)
        vm.selectedMonthIndex = 4
        #expect(vm.selectedMonth == .maio)
    }

    // MARK: - Filtering

    @Test("filtered retorna apenas entradas do mês selecionado")
    func filtersBySelectedMonth() throws {
        let container = try Self.makeContainer()
        let context = ModelContext(container)
        let vm = ExpenseManagerViewModel()
        vm.selectedMonthIndex = 0 // janeiro

        let janEntry = Self.makeEntry(month: .janeiro, year: 2026, context: context)
        let fevEntry = Self.makeEntry(month: .fevereiro, year: 2026, context: context)

        let result = vm.filtered([janEntry, fevEntry], currentYear: 2026)
        #expect(result.count == 1)
        #expect(result.first?.monthRaw == ExpenseMonth.janeiro.rawValue)
    }

    @Test("filtered exclui entradas de anos diferentes")
    func filtersByCurrentYear() throws {
        let container = try Self.makeContainer()
        let context = ModelContext(container)
        let vm = ExpenseManagerViewModel()
        vm.selectedMonthIndex = 0

        let current = Self.makeEntry(month: .janeiro, year: 2026, context: context)
        let old = Self.makeEntry(month: .janeiro, year: 2025, context: context)

        let result = vm.filtered([current, old], currentYear: 2026)
        #expect(result.count == 1)
        #expect(result.first?.year == 2026)
    }

    // MARK: - Totals

    @Test("total soma corretamente os valores das entradas")
    func totalSumsAmounts() throws {
        let container = try Self.makeContainer()
        let context = ModelContext(container)
        let vm = ExpenseManagerViewModel()

        let entries = [
            Self.makeEntry(amount: 150, context: context),
            Self.makeEntry(amount: 300, context: context),
            Self.makeEntry(amount: 50.50, context: context)
        ]

        #expect(vm.total(of: entries) == 500.50)
    }

    @Test("total retorna zero para lista vazia")
    func totalZeroForEmptyList() {
        let vm = ExpenseManagerViewModel()
        #expect(vm.total(of: []) == 0)
    }

    // MARK: - Category Breakdown

    @Test("breakdownByCategory agrupa e ordena por valor decrescente")
    func breakdownGroupsAndSortsByDescendingTotal() throws {
        let container = try Self.makeContainer()
        let context = ModelContext(container)
        let vm = ExpenseManagerViewModel()

        let entries = [
            Self.makeEntry(category: .aluguel, amount: 1500, context: context),
            Self.makeEntry(category: .mercado, amount: 300, context: context),
            Self.makeEntry(category: .mercado, amount: 200, context: context)
        ]

        let breakdown = vm.breakdownByCategory(of: entries)
        #expect(breakdown.count == 2)
        #expect(breakdown[0].category == .aluguel)
        #expect(breakdown[0].total == 1500)
        #expect(breakdown[1].category == .mercado)
        #expect(breakdown[1].total == 500)
    }

    @Test("breakdownByCategory exclui categorias sem despesas")
    func breakdownExcludesEmptyCategories() throws {
        let container = try Self.makeContainer()
        let context = ModelContext(container)
        let vm = ExpenseManagerViewModel()

        let entries = [Self.makeEntry(category: .energia, amount: 200, context: context)]
        let breakdown = vm.breakdownByCategory(of: entries)
        #expect(breakdown.count == 1)
        #expect(breakdown.first?.category == .energia)
    }

    // MARK: - Form Validation

    @Test("isFormValid retorna false quando amount é nil")
    func formInvalidWithNilAmount() {
        let vm = ExpenseManagerViewModel()
        vm.amountValue = nil
        vm.selectedCategory = .mercado
        #expect(vm.isFormValid() == false)
    }

    @Test("isFormValid retorna false quando amount é zero")
    func formInvalidWithZeroAmount() {
        let vm = ExpenseManagerViewModel()
        vm.amountValue = 0
        vm.selectedCategory = .mercado
        #expect(vm.isFormValid() == false)
    }

    @Test("isFormValid retorna false quando category é nil")
    func formInvalidWithNilCategory() {
        let vm = ExpenseManagerViewModel()
        vm.amountValue = 100
        vm.selectedCategory = nil
        #expect(vm.isFormValid() == false)
    }

    @Test("isFormValid retorna true com dados válidos")
    func formValidWithCorrectData() {
        let vm = ExpenseManagerViewModel()
        vm.amountValue = 99.99
        vm.selectedCategory = .lazer
        #expect(vm.isFormValid() == true)
    }

    // MARK: - Reset Form

    @Test("resetForm limpa todos os campos do formulário")
    func resetFormClearsFields() {
        let vm = ExpenseManagerViewModel()
        vm.amountValue = 500
        vm.selectedCategory = .cursos
        vm.notesInput = "test note"
        vm.formError = "some error"

        vm.resetForm()

        #expect(vm.amountValue == nil)
        #expect(vm.selectedCategory == .mercado)
        #expect(vm.notesInput.isEmpty)
        #expect(vm.formError == nil)
    }
}
