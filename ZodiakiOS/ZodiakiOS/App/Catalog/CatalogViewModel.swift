import Combine
import SwiftUI

// MARK: - Catalog ViewModel

final class CatalogViewModel: ObservableObject {
    @Published var selectedItem: CatalogDestination? {
        didSet {
            guard let destination = selectedItem else { return }
            let name: String
            switch destination {
            case .home:         name = "home"
            case .examples:     name = "examples"
            case .item(let item): name = item.rawValue
            }
            ZodiakLog.info(.navigation, "Feature selected name=\(name)",
                           metadata: ["feature": name])
            ZodiakSessionMetrics.shared.trackScreenOpen(name)
        }
    }
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @Published var searchQuery: String = ""

    // MARK: - Section Items

    func items(for section: CatalogSection) -> [CatalogItem] {
        section.items
    }

    var atomItems: [CatalogItem] {
        CatalogSection.components.items.filter { $0.subsection == "catalog.section_name.atoms" }
    }

    var moleculeItems: [CatalogItem] {
        CatalogSection.components.items.filter { $0.subsection == "catalog.section_name.molecules" }
    }

    var organismItems: [CatalogItem] {
        CatalogSection.components.items.filter { $0.subsection == "catalog.section_name.organisms" }
    }

    var utilityItems: [CatalogItem] {
        CatalogSection.components.items.filter {
            $0.subsection == "catalog.section_name.templates" ||
            $0.subsection == "catalog.section_name.utilities"
        }
    }

    var compositionItems: [CatalogItem] {
        CatalogSection.compositions.items
    }

    // MARK: - Search

    var searchResults: [CatalogItem] {
        let query = searchQuery.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return [] }
        let lowered = query.lowercased()
        return CatalogItem.allCases.filter { item in
            item.rawValue.localizedCaseInsensitiveContains(lowered) ||
            String(localized: String.LocalizationValue(item.rawValue))
                .localizedCaseInsensitiveContains(lowered)
        }
    }

    var groupedSearchResults: [(subsection: String, items: [CatalogItem])] {
        let results = searchResults
        let order: [String] = [
            "catalog.home.tab_tokens",
            "catalog.section_name.atoms",
            "catalog.section_name.molecules",
            "catalog.section_name.organisms",
            "catalog.section_name.templates",
            "catalog.section_name.utilities",
            "catalog.section.compositions",
            "catalog.section.visual_assets"
        ]
        func subsectionKey(_ item: CatalogItem) -> String {
            if let sub = item.subsection { return sub }
            switch item.section {
            case .tokens:      return "catalog.home.tab_tokens"
            case .compositions: return "catalog.section.compositions"
            case .visualAssets: return "catalog.section.visual_assets"
            default:            return "catalog.section_name.utilities"
            }
        }
        return order.compactMap { key in
            let filtered = results.filter { subsectionKey($0) == key }
            return filtered.isEmpty ? nil : (subsection: key, items: filtered)
        }
    }
}
