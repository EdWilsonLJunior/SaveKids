import SwiftUI

// MARK: - SolutionsCatalogScreen

struct SolutionsCatalogScreen: View {
    @StateObject private var viewModel = SolutionsCatalogViewModel()
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var selectedCategory: Set<String> = []
    @State private var isGridMode: Bool = true

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.solutions_catalog.title",
            eyebrow: "feature.solutions_catalog.eyebrow",
            intro: "feature.solutions_catalog.intro"
        ) {
            catalogContent
        } edgeToEdgeContent: {
            categoryChipGroup
        }
        .searchable(
            text: $viewModel.filter.searchText,
            prompt: String(localized: "feature.solutions_catalog.search_placeholder")
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) { isGridMode.toggle() }
                } label: {
                    Image(systemName: isGridMode ? "list.bullet" : "square.grid.2x2")
                        .foregroundStyle(ZodiakColors.textPrimary)
                }
                .accessibilityLabel(
                    isGridMode
                        ? String(localized: "feature.solutions_catalog.view_list")
                        : String(localized: "feature.solutions_catalog.view_grid")
                )
            }
            ToolbarItem(placement: .topBarTrailing) {
                filterButton
            }
        }
        .sheet(isPresented: $viewModel.isShowingFilter) {
            SolutionFilterSheet(
                filter: $viewModel.filter,
                authors: viewModel.uniqueAuthors(),
                onApply: { viewModel.isShowingFilter = false }
            )
        }
        .navigationDestination(item: $viewModel.selectedSolution) { solution in
            SolutionDetailScreen(solution: solution, viewModel: viewModel)
        }
        .onChange(of: selectedCategory) { _, newValue in
            viewModel.filter.categories = Set(newValue.compactMap { SolutionCategory(rawValue: $0) })
        }
        .onChange(of: viewModel.filter.categories) { _, newValue in
            selectedCategory = Set(newValue.map(\.rawValue))
        }
        .accessibilityIdentifier("screen.28.solutions_catalog")
    }

    // MARK: - Subviews

    @ViewBuilder
    private var catalogContent: some View {
        if viewModel.filteredSolutions.isEmpty {
            ZodiakEmptyState(
                icon: "magnifyingglass",
                title: String(localized: "feature.solutions_catalog.empty_title"),
                description: String(localized: "feature.solutions_catalog.empty_subtitle")
            )
            .frame(maxWidth: .infinity)
        } else if isGridMode {
            ZodiakTypographicCardGrid(items: typographicItems, columns: sizeClass == .regular ? 3 : 2)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.96, anchor: .top)),
                    removal: .opacity.combined(with: .scale(scale: 1.04, anchor: .top))
                ))
        } else {
            ZodiakHorizontalCardList(items: horizontalItems)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.96, anchor: .top)),
                    removal: .opacity.combined(with: .scale(scale: 1.04, anchor: .top))
                ))
        }
    }

    private var allCategoryLabel: String {
        String(localized: "feature.solutions_catalog.all_categories")
    }

    private var categoryChipGroup: some View {
        let allLabel = allCategoryLabel
        let options = [allLabel] + SolutionCategory.allCases.map(\.rawValue)
        let binding = Binding<Set<String>>(
            get: { selectedCategory.isEmpty ? [allLabel] : selectedCategory },
            set: { newValue in
                if newValue.contains(allLabel) || newValue.isEmpty {
                    selectedCategory = []
                } else {
                    selectedCategory = newValue
                }
            }
        )
        return ZodiakChipGroup(
            options: options,
            selectedOptions: binding,
            allowsMultipleSelection: false,
            label: nil as String?
        )
        .padding(.horizontal, ZodiakSpacing.screenPad)
        .padding(.vertical, ZodiakSpacing.s8)
    }

    private var filterButton: some View {
        Button {
            viewModel.isShowingFilter = true
        } label: {
            Image(
                systemName: viewModel.filter.isActive
                    ? "line.3.horizontal.decrease.circle.fill"
                    : "line.3.horizontal.decrease.circle"
            )
            .foregroundStyle(
                viewModel.filter.isActive ? ZodiakColors.actionPrimary : ZodiakColors.textPrimary
            )
        }
        .accessibilityLabel(String(localized: "feature.solutions_catalog.filter_button_label"))
    }

    // MARK: - Card Items

    private var horizontalItems: [ZodiakHorizontalCardItem] {
        viewModel.filteredSolutions.map { solution in
            ZodiakHorizontalCardItem(
                id: solution.id,
                title: solution.title,
                subtitleTags: solution.stack.components(separatedBy: " + "),
                description: solution.description,
                tag: solution.category.rawValue,
                author: solution.author,
                icon: solution.category.icon,
                onTap: { viewModel.select(solution) }
            )
        }
    }

    private var typographicItems: [ZodiakTypographicCardItem] {
        viewModel.filteredSolutions.map { solution in
            ZodiakTypographicCardItem(
                id: solution.id,
                category: solution.category.rawValue,
                title: solution.title,
                body: solution.description,
                meta: solution.author,
                metaRole: solution.duration,
                leading: .icon(solution.category.icon),
                size: .medium,
                cardBackground: solution.category.typographicBackground,
                onTap: { viewModel.select(solution) }
            )
        }
    }
}
