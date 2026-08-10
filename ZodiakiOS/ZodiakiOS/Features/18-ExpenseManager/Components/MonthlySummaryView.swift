import SwiftUI

// MARK: - MonthlySummaryView

struct MonthlySummaryView: View {
    let expenses: [ExpenseEntry]
    let month: ExpenseMonth
    let viewModel: ExpenseManagerViewModel

    private var monthName: String {
        NSLocalizedString(month.localizedKey, comment: "")
    }

    private var formattedTotal: String {
        viewModel.total(of: expenses).formatted(.currency(code: "BRL"))
    }

    private var breakdown: [(category: ExpenseCategory, total: Double)] {
        viewModel.breakdownByCategory(of: expenses)
    }

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.expense_manager.summary_title",
            eyebrow: "feature.expense_manager.summary_eyebrow",
            intro: nil
        ) {
            if expenses.isEmpty {
                ZodiakEmptyState(
                    icon: ExpenseManagerConstants.emptyStateIcon,
                    title: "feature.expense_manager.empty_title",
                    description: "feature.expense_manager.empty_desc"
                )
            } else {
                monthTotalCard
                categoryBreakdown
            }
        }
    }

    // MARK: - Private

    private var monthTotalCard: some View {
        ZodiakResultCard(
            title: "feature.expense_manager.month_total",
            value: formattedTotal,
            subtitle: monthName,
            valueColor: ZodiakColors.brand
        )
        .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
    }

    private var categoryBreakdown: some View {
        VStack(spacing: 0) {
            ZodiakDivider(hierarchy: .secondary)
            ForEach(breakdown, id: \.category) { item in
                ZodiakInfoRow(
                    label: NSLocalizedString(item.category.localizedKey, comment: ""),
                    value: item.total.formatted(.currency(code: "BRL"))
                )
                ZodiakDivider(hierarchy: .secondary)
            }
        }
        .background(ZodiakColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
