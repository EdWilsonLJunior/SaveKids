import Combine
import SwiftUI

// MARK: - ExpenseManagerViewModel

final class ExpenseManagerViewModel: ObservableObject {
    // MARK: - Navigation State

    @Published var isAddingExpense: Bool = false
    @Published var isShowingSummary: Bool = false

    // MARK: - Month Selection

    /// Índice 0-based mapeado para `ExpenseMonth.allCases`.
    @Published var selectedMonthIndex: Int = 0

    var selectedMonth: ExpenseMonth {
        ExpenseMonth.allCases[selectedMonthIndex]
    }

    // MARK: - Form State

    @Published var selectedCategory: ExpenseCategory? = .mercado
    @Published var amountValue: Double?
    @Published var notesInput: String = ""
    @Published var formError: LocalizedStringKey?

    // MARK: - Business Logic

    /// Filtra entradas pelo mês selecionado e ano fornecido.
    func filtered(_ expenses: [ExpenseEntry], currentYear: Int? = nil) -> [ExpenseEntry] {
        let year = currentYear ?? Calendar.current.component(.year, from: Date())
        return expenses.filter { $0.monthRaw == selectedMonth.rawValue && $0.year == year }
    }

    /// Soma os valores de uma lista de entradas.
    func total(of expenses: [ExpenseEntry]) -> Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    /// Retorna o total por categoria, ordenado pelo maior valor. Exclui categorias sem despesas.
    func breakdownByCategory(of expenses: [ExpenseEntry]) -> [(category: ExpenseCategory, total: Double)] {
        ExpenseCategory.allCases
            .compactMap { category -> (ExpenseCategory, Double)? in
                let subtotal = expenses
                    .filter { $0.categoryRaw == category.rawValue }
                    .reduce(0) { $0 + $1.amount }
                return subtotal > 0 ? (category, subtotal) : nil
            }
            .sorted { $0.1 > $1.1 }
    }

    // MARK: - Form Helpers

    /// Reseta os campos do formulário de adição.
    func resetForm() {
        ZodiakLog.info(.viewModel, "ExpenseManagerViewModel.resetForm() [trace=\(ZodiakTrace.short)]")
        selectedCategory = .mercado
        amountValue = nil
        notesInput = ""
        formError = nil
    }

    /// `true` se o formulário está válido para submissão.
    func isFormValid() -> Bool {
        guard let amount = amountValue, amount > 0 else { return false }
        guard selectedCategory != nil else { return false }
        return true
    }
}
