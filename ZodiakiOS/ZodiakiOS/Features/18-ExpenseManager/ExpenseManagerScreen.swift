import SwiftData
import SwiftUI

// MARK: - ExpenseManagerScreen

struct ExpenseManagerScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ExpenseEntry.createdAt, order: .reverse) private var allExpenses: [ExpenseEntry]
    @StateObject private var viewModel = ExpenseManagerViewModel()

    private var filteredExpenses: [ExpenseEntry] {
        viewModel.filtered(allExpenses)
    }

    private var monthTabs: [String] {
        ExpenseMonth.allCases.map { NSLocalizedString($0.localizedKey, comment: "") }
    }

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.expense_manager.title",
            eyebrow: "feature.expense_manager.eyebrow",
            intro: "feature.expense_manager.intro"
        ) {
            monthTotalCard
            expensesList
        } edgeToEdgeContent: {
            ZodiakTabs(tabs: monthTabs, selectedIndex: $viewModel.selectedMonthIndex)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarButtons
            }
        }
        .sheet(isPresented: $viewModel.isAddingExpense) {
            AddExpenseSheet(viewModel: viewModel, onConfirm: addExpense)
        }
        .navigationDestination(isPresented: $viewModel.isShowingSummary) {
            MonthlySummaryView(
                expenses: filteredExpenses,
                month: viewModel.selectedMonth,
                viewModel: viewModel
            )
        }
        .accessibilityIdentifier("screen.18.expense_manager")
    }

    // MARK: - Private Views

    private var toolbarButtons: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Button {
                viewModel.isShowingSummary = true
            } label: {
                Image(systemName: ExpenseManagerConstants.summaryIcon)
            }
            .accessibilityLabel(Text("feature.expense_manager.action.view_summary"))

            Button {
                viewModel.resetForm()
                viewModel.isAddingExpense = true
            } label: {
                Image(systemName: ExpenseManagerConstants.addIcon)
            }
            .accessibilityLabel(Text("shared.action.add"))
        }
    }

    @ViewBuilder
    private var monthTotalCard: some View {
        if !filteredExpenses.isEmpty {
            ZodiakResultCard(
                title: "feature.expense_manager.month_total",
                value: viewModel.total(of: filteredExpenses).formatted(.currency(code: "BRL")),
                subtitle: nil,
                valueColor: ZodiakColors.brand
            )
            .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
            .animation(
                .spring(response: 0.4, dampingFraction: 0.8),
                value: viewModel.selectedMonthIndex
            )
        }
    }

    @ViewBuilder
    private var expensesList: some View {
        if filteredExpenses.isEmpty {
            ZodiakEmptyState(
                icon: ExpenseManagerConstants.emptyStateIcon,
                title: "feature.expense_manager.empty_title",
                description: "feature.expense_manager.empty_desc"
            )
        } else {
            VStack(spacing: ZodiakSpacing.s4) {
                ForEach(filteredExpenses) { expense in
                    ExpenseRow(expense: expense) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            removeExpense(expense)
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.2), value: filteredExpenses.count)
        }
    }

    // MARK: - Actions

    private func addExpense() {
        guard viewModel.isFormValid(),
              let amount = viewModel.amountValue,
              let category = viewModel.selectedCategory else {
            viewModel.formError = "feature.expense_manager.error.invalid_amount"
            return
        }
        let year = Calendar.current.component(.year, from: Date())
        let entry = ExpenseEntry(
            category: category,
            amount: amount,
            month: viewModel.selectedMonth,
            year: year,
            notes: viewModel.notesInput
        )
        modelContext.insert(entry)
        viewModel.resetForm()
        viewModel.isAddingExpense = false
    }

    private func removeExpense(_ expense: ExpenseEntry) {
        modelContext.delete(expense)
    }
}

#Preview {
    NavigationStack {
        ExpenseManagerScreen()
    }
    .modelContainer(for: ExpenseEntry.self, inMemory: true)
}
