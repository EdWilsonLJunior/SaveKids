import SwiftUI

// MARK: - AddExpenseSheet

struct AddExpenseSheet: View {
    @ObservedObject var viewModel: ExpenseManagerViewModel
    let onConfirm: () -> Void

    private var categoryOptions: [(value: ExpenseCategory, label: String)] {
        ExpenseCategory.allCases.map {
            (value: $0, label: NSLocalizedString($0.localizedKey, comment: ""))
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZodiakColors.background.ignoresSafeArea()
                VStack(spacing: ZodiakSpacing.s16) {
                    ZodiakFormWrapper {
                        ZodiakDropdown(
                            label: "feature.expense_manager.label.category",
                            selection: $viewModel.selectedCategory,
                            options: categoryOptions
                        )
                        ZodiakLabelledNumericField(
                            label: "feature.expense_manager.label.amount",
                            placeholder: "feature.expense_manager.placeholder.amount",
                            value: $viewModel.amountValue,
                            minimum: 0.01
                        )
                        ZodiakLabelledField(
                            label: "feature.expense_manager.label.notes",
                            placeholder: "feature.expense_manager.placeholder.notes",
                            text: $viewModel.notesInput
                        )
                    }

                    if let error = viewModel.formError {
                        ZodiakAlert(title: error, variant: .error, isDismissible: true)
                    }

                    ZodiakButtonPrimary(
                        title: "feature.expense_manager.action.confirm",
                        action: onConfirm
                    )
                }
                .padding(ZodiakSpacing.s16)
            }
            .navigationTitle(String(localized: "feature.expense_manager.sheet_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "shared.action.cancel")) {
                        viewModel.isAddingExpense = false
                    }
                }
            }
        }
    }
}
