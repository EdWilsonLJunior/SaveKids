import SwiftUI

// MARK: - US-30.05 Statement Screen
struct LPStatementScreen: View {
    @StateObject private var viewModel = LPStatementViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: String(localized: "lp.statement.title"),
            eyebrow: String(localized: "lp.statement.eyebrow"),
            intro: String(localized: "lp.statement.intro")
        ) {
            contentView
        } edgeToEdgeContent: {
            ZodiakTabs(tabs: viewModel.tabTitles, selectedIndex: $viewModel.selectedTab)
        }
        .navigationTitle(String(localized: "lp.statement.title"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP statement screen appeared", metadata: ["feature": "LoyaltyProgram"])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPStatement")
        }
        .onChange(of: viewModel.selectedTab) { _, _ in
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }

    // MARK: - Content

    @ViewBuilder
    private var contentView: some View {
        if viewModel.filteredTransactions.isEmpty {
            ZodiakEmptyState(
                icon: "list.bullet.rectangle",
                title: String(localized: "lp.statement.empty_title"),
                description: String(localized: "lp.statement.empty_description")
            )
            .transition(.opacity.combined(with: .scale(scale: 0.92)))
        } else {
            ZodiakShowMore(
                items: viewModel.filteredTransactions,
                initialCount: LPConstants.Pagination.statementPageSize
            ) { tx in
                transactionRowView(for: tx)
            }
            .id(viewModel.selectedTab)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.2), value: viewModel.selectedTab)
        }
    }

    // MARK: - Row

    @ViewBuilder
    private func pointsBadge(for tx: LPPointTransaction) -> some View {
        if tx.points > 0 {
            ZodiakSuccessBadge(verbatim: viewModel.formattedPoints(tx.points))
                .contentTransition(.numericText())
        } else {
            ZodiakErrorBadge(verbatim: viewModel.formattedPoints(tx.points))
                .contentTransition(.numericText())
        }
    }

    @ViewBuilder
    private func transactionRowView(for tx: LPPointTransaction) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        ZodiakText(verbatim: viewModel.typeLabel(for: tx), style: .body(bold: true))
                        ZodiakText(verbatim: tx.description, style: .caption())
                    }
                    Spacer()
                    pointsBadge(for: tx)
                }
                ZodiakText(verbatim: viewModel.formattedDate(tx.date), style: .caption())
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))

            ZodiakDivider(hierarchy: .secondary)
                .padding(.top, ZodiakSpacing.s8)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel([
            viewModel.typeLabel(for: tx),
            tx.description,
            viewModel.formattedDate(tx.date),
            viewModel.formattedPoints(tx.points)
        ].joined(separator: ", "))
        .contextMenu {
            Button {
                UIPasteboard.general.string = tx.id
            } label: {
                Label(String(localized: "lp.statement.copy_id"), systemImage: "doc.on.doc")
            }
        }
    }
}
