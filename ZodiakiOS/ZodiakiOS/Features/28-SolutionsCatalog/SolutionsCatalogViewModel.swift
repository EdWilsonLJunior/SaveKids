import Combine
import Foundation

// MARK: - SolutionFilter

struct SolutionFilter: Equatable {
    var categories: Set<SolutionCategory> = []
    var durations: Set<String> = []
    var authors: Set<String> = []
    var searchText: String = ""

    var isActive: Bool {
        !categories.isEmpty || !durations.isEmpty || !authors.isEmpty || !searchText.isEmpty
    }
}

// MARK: - SolutionsCatalogViewModel

final class SolutionsCatalogViewModel: ObservableObject {
    @Published var filter = SolutionFilter()
    @Published private(set) var filteredSolutions: [Solution] = []
    @Published var selectedSolution: Solution?
    @Published var isShowingFilter: Bool = false

    private let allSolutions: [Solution]
    private var cancellables = Set<AnyCancellable>()

    init() {
        allSolutions = Self.loadSolutions()
        filteredSolutions = allSolutions
        bindFiltering()
    }

    // MARK: - Public

    func select(_ solution: Solution) {
        selectedSolution = solution
    }

    func applyFilter(_ newFilter: SolutionFilter) {
        filter = newFilter
        isShowingFilter = false
    }

    func clearFilter() {
        filter = SolutionFilter()
        isShowingFilter = false
    }

    func relatedSolutions(for solution: Solution) -> [Solution] {
        allSolutions.filter { solution.relatedIds.contains($0.id.uuidString.lowercased()) }
    }

    func uniqueAuthors() -> [String] {
        Array(Set(allSolutions.map(\.author))).sorted()
    }

    // MARK: - Private

    private func bindFiltering() {
        $filter
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { [weak self] filter -> [Solution] in
                guard let self else { return [] }
                return self.allSolutions.filter { solution in
                    let matchCategory = filter.categories.isEmpty
                        || filter.categories.contains(solution.category)
                    let matchDuration = filter.durations.isEmpty
                        || filter.durations.contains(
                            SolutionsCatalogConstants.durationRange(for: solution.duration)
                        )
                    let matchAuthor = filter.authors.isEmpty
                        || filter.authors.contains(solution.author)
                    let matchSearch = filter.searchText.isEmpty
                        || solution.title.localizedCaseInsensitiveContains(filter.searchText)
                        || solution.description.localizedCaseInsensitiveContains(filter.searchText)
                        || solution.stack.localizedCaseInsensitiveContains(filter.searchText)
                    return matchCategory && matchDuration && matchAuthor && matchSearch
                }
            }
            .assign(to: &$filteredSolutions)
    }

    private static func loadSolutions() -> [Solution] {
        let langCode = Locale.current.language.languageCode?.identifier ?? "en"
        let filename = langCode == "pt" ? "solutions.pt-BR" : "solutions.en"
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        return (try? JSONDecoder().decode([Solution].self, from: data)) ?? []
    }
}
