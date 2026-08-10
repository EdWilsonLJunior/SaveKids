import SwiftUI

// MARK: - US-30.08 Catalog Screen
struct LPCatalogScreen: View {
    @Binding var path: [LPRoute]
    @StateObject private var viewModel = LPCatalogViewModel()
    @State private var isFilterSheetPresented = false

    var body: some View {
        ZodiakActivityTemplate(
            title: String(localized: "lp.catalog.title"),
            eyebrow: String(localized: "lp.catalog.eyebrow")
        ) {
            // MARK: Balance bar
            ZodiakKeyFigures(items: [
                ZodiakKeyFigureItem(
                    value: viewModel.formattedPoints,
                    label: String(localized: "lp.catalog.balance_label")
                )
            ])
            .contentTransition(.numericText())
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: viewModel.points)

            // MARK: Filter toolbar
            HStack {
                ZodiakFilterButton(
                    action: { isFilterSheetPresented = true },
                    activeFilterCount: viewModel.activeFilterCount
                )
                Spacer()
            }
            .padding(.vertical, ZodiakSpacing.s8)

            // MARK: Content switcher
            contentSection
        }
        .navigationTitle(String(localized: "lp.catalog.title"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            ZodiakSessionMetrics.shared.trackScreenOpen("LPCatalog")
        }
        .task { await viewModel.loadRewards() }
        .sheet(isPresented: $isFilterSheetPresented) {
            filterSheet
        }
    }

    // MARK: - Content switcher

    @ViewBuilder
    private var contentSection: some View {
        switch viewModel.catalogState {
        case .loading:
            catalogSkeleton

        case .success:
            if viewModel.filteredRewards.isEmpty {
                // Empty state when filters are active but no results
                ZodiakEmptyState(
                    icon: "line.3.horizontal.decrease.circle",
                    title: String(localized: "lp.catalog.empty_filter_title"),
                    description: String(localized: "lp.catalog.empty_filter_subtitle"),
                    action: (
                        label: String(localized: "lp.catalog.filter_empty_action"),
                        handler: { viewModel.selectedCategories = [] }
                    )
                )
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.2), value: viewModel.activeFilterCount)
            } else {
                ZodiakCardGrid(
                    items: viewModel.filteredRewards.map { reward in
                        ZodiakCardItem(
                            title: reward.name,
                            subtitle: reward.category.localizedName,
                            description: reward.description,
                            imageURL: reward.deterministicImageURL,
                            imageName: reward.imageSystemName,
                            tag: "\(NumberFormatter.lpPoints.string(from: NSNumber(value: reward.pointsCost)) ?? "\(reward.pointsCost)") pts",
                            actionLabel: String(localized: "lp.reward_detail.eyebrow"),
                            onTap: {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                path.append(.rewardDetail(reward))
                            }
                        )
                    },
                    columns: 2,
                    initialCount: LPConstants.Pagination.catalogPageSize
                )
                .transition(.opacity.combined(with: .scale(scale: 0.97, anchor: .top)))
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.filteredRewards.count)
            }

        case .error:
            ZodiakEmptyState(
                icon: "exclamationmark.triangle",
                title: String(localized: "lp.catalog.error_title"),
                description: String(localized: "lp.catalog.error_subtitle"),
                action: (
                    label: String(localized: "lp.catalog.retry_action"),
                    handler: viewModel.retry
                )
            )
        }
    }

    // MARK: - Skeleton

    private var catalogSkeleton: some View {
        ZodiakLayoutGrid(
            columns: 2,
            horizontalSpacing: ZodiakSpacing.s8,
            verticalSpacing: ZodiakSpacing.s8,
            applyScreenPadding: false
        ) {
            ForEach(0..<6, id: \.self) { _ in
                ZodiakSkeletonRect(height: 180, cornerRadius: ZodiakRadii.s)
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    // MARK: - Filter Sheet

    private var filterSheet: some View {
        ZodiakMultiselect(
            label: String(localized: "lp.catalog.filter_sheet_title"),
            options: LPRewardCategory.allCases.map(\.localizedName),
            selections: LPRewardCategory.selectionBinding(for: $viewModel.selectedCategories)
        )
        .padding(ZodiakSpacing.s16)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
