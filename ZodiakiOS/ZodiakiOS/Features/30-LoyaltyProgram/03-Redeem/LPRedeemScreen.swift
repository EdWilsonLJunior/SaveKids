import SwiftUI

// MARK: - US-30.03 Redeem Screen
struct LPRedeemScreen: View {
    @Binding var path: [LPRoute]
    @StateObject private var viewModel: LPRedeemViewModel

    init(path: Binding<[LPRoute]>) {
        self._path = path
        self._viewModel = StateObject(wrappedValue: LPRedeemViewModel())
    }

    @State private var showFilterSheet = false

    // MARK: - Category binding bridge (Set<LPRewardCategory> ↔ Set<String>)

    private var categorySelectionBinding: Binding<Set<String>> {
        LPRewardCategory.selectionBinding(for: $viewModel.selectedCategories)
    }

    // MARK: - Body

    var body: some View {
        ZodiakActivityTemplate(title: String(localized: "lp.redeem.title")) {
            balanceSection
            categoryFilterSection
            contentSection
        }
        .task { await viewModel.loadRewards() }
        .navigationTitle(String(localized: "lp.redeem.title"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP redeem screen appeared", metadata: ["feature": "LoyaltyProgram"])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPRedeem")
        }
    }

    // MARK: - Balance section

    @ViewBuilder
    private var balanceSection: some View {
        ZodiakTooltip("lp.redeem.balance_tooltip", placement: .trailing) {
            ZodiakKeyFigures(
                items: [
                    ZodiakKeyFigureItem(
                        value: viewModel.formattedPoints,
                        label: "lp.redeem.balance_label"
                    )
                ],
                columns: 1
            )
        }
    }

    // MARK: - Category filter

    @ViewBuilder
    private var categoryFilterSection: some View {
        ZodiakFilterButton(
            action: { showFilterSheet = true },
            activeFilterCount: viewModel.activeFilterCount
        )
        .sheet(isPresented: $showFilterSheet) {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                        ZodiakMultiselect(
                            label: "lp.redeem.filter_label",
                            options: viewModel.categoryOptions,
                            selections: categorySelectionBinding
                        )
                    }
                    .padding(ZodiakSpacing.s16)
                }
                .navigationTitle(String(localized: "lp.redeem.filter_sheet_title"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(String(localized: "shared.action.done")) {
                            showFilterSheet = false
                        }
                        .foregroundStyle(ZodiakColors.actionPrimary)
                    }
                }
            }
            .presentationDetents([.medium])
        }
    }

    // MARK: - State-driven content

    @ViewBuilder
    private var contentSection: some View {
        switch viewModel.state {
        case .loading:
            skeletonContent

        case .error:
            ZodiakEmptyState(
                icon: "exclamationmark.triangle",
                title: String(localized: "lp.redeem.error_title"),
                action: (label: String(localized: "lp.redeem.retry"), handler: viewModel.retry)
            )

        case .success:
            if viewModel.filteredRewards.isEmpty {
                ZodiakEmptyState(
                    icon: "line.3.horizontal.decrease.circle",
                    title: String(localized: "lp.redeem.filter_empty_title"),
                    action: (label: String(localized: "lp.redeem.filter_empty_action"), handler: viewModel.reset)
                )
            } else {
                rewardGrid
            }
        }
    }

    @ViewBuilder
    private var skeletonContent: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            ZodiakSkeletonRect(height: 160, cornerRadius: ZodiakRadii.s)
            ZodiakSkeletonRect(height: 160, cornerRadius: ZodiakRadii.s)
            ZodiakSkeletonRect(height: 160, cornerRadius: ZodiakRadii.s)
        }
    }

    @ViewBuilder
    private var rewardGrid: some View {
        ZodiakCardGrid(items: cardItems(from: viewModel.filteredRewards), columns: 1)
    }

    // MARK: - Card item mapping

    private func cardItems(from rewards: [LPReward]) -> [ZodiakCardItem] {
        rewards.map { reward in
            let affordable = viewModel.isAffordable(reward)
            let tag = affordable
                ? "\(reward.pointsCost) pts"
                : String(localized: "lp.redeem.status_insufficient")
            return ZodiakCardItem(
                title: reward.name,
                subtitle: reward.category.localizedName,
                description: reward.description,
                imageURL: reward.deterministicImageURL,
                imageName: reward.imageSystemName,
                tag: tag,
                onTap: {
                    UISelectionFeedbackGenerator().selectionChanged()
                    path.append(.rewardDetail(reward))
                }
            )
        }
    }
}
