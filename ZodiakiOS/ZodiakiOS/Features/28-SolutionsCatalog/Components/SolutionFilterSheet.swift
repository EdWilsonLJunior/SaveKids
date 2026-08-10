import SwiftUI

// MARK: - SolutionFilterSheet

struct SolutionFilterSheet: View {
    @Binding var filter: SolutionFilter
    let authors: [String]
    let onApply: () -> Void

    @State private var localFilter: SolutionFilter

    init(filter: Binding<SolutionFilter>, authors: [String], onApply: @escaping () -> Void) {
        self._filter = filter
        self.authors = authors
        self.onApply = onApply
        self._localFilter = State(initialValue: filter.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZodiakColors.background.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
                        ZodiakChipGroup(
                            options: SolutionsCatalogConstants.durationRanges,
                            selectedOptions: $localFilter.durations,
                            allowsMultipleSelection: true,
                            label: LocalizedStringKey("feature.solutions_catalog.filter_duration")
                        )

                        ZodiakChipGroup(
                            options: authors,
                            selectedOptions: $localFilter.authors,
                            allowsMultipleSelection: true,
                            label: LocalizedStringKey("feature.solutions_catalog.filter_author")
                        )

                        ZodiakButtonPrimary(
                            title: "feature.solutions_catalog.apply_filter",
                            action: apply
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .padding(ZodiakSpacing.s16)
                }
            }
            .navigationTitle(String(localized: "feature.solutions_catalog.filter_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "shared.action.clear")) {
                        clear()
                    }
                }
            }
        }
    }

    private func apply() {
        filter = localFilter
        onApply()
    }

    private func clear() {
        localFilter = SolutionFilter()
        filter = SolutionFilter()
        onApply()
    }
}
