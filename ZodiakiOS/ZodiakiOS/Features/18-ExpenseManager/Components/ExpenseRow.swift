import SwiftUI

// MARK: - ExpenseRow

struct ExpenseRow: View {
    let expense: ExpenseEntry
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            categoryIcon
            expenseInfo
            Spacer()
            amountLabel
            deleteButton
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Private

    private var categoryIcon: some View {
        Image(systemName: expense.category.icon)
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(ZodiakColors.actionPrimary)
            .frame(width: 40, height: 40)
            .background(ZodiakColors.actionPrimary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var expenseInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            ZodiakText(
                verbatim: NSLocalizedString(expense.category.localizedKey, comment: ""),
                style: .body(bold: true)
            )
            if !expense.notes.isEmpty {
                ZodiakText(verbatim: expense.notes, style: .caption())
            }
        }
    }

    private var amountLabel: some View {
        ZodiakText(
            verbatim: expense.amount.formatted(.currency(code: "BRL")),
            style: .body(bold: true)
        )
    }

    private var deleteButton: some View {
        Button(action: onDelete) {
            Image(systemName: ExpenseManagerConstants.deleteIcon)
                .foregroundStyle(ZodiakColors.textNegative)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("shared.action.delete"))
    }
}
