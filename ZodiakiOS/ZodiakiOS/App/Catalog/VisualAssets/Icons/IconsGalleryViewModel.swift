import Combine
import SwiftUI

// MARK: - IconsGalleryViewModel

final class IconsGalleryViewModel: ObservableObject {
    // MARK: - Inputs

    @Published var searchText: String = ""
    @Published var selectedSize: ZodiakIconSize = .medium
    @Published var selectedColorIndex: Int = 0
    @Published var selectedCategoryIndex: Int = 0
    @Published var selectedIcon: ZodiakIcon?

    // MARK: - Output (read-only from View)

    @Published private(set) var filteredIcons: [ZodiakIcon] = ZodiakIcon.allCases

    // MARK: - Static data

    static let allSizes: [ZodiakIconSize] = [.small, .medium, .large, .xLarge]

    static let colorVariants: [(color: Color, label: String)] = [
        (ZodiakColors.actionPrimary, "actionPrimary"),
        (ZodiakColors.brand, "brand"),
        (ZodiakColors.brandOrange, "brandOrange"),
        (ZodiakColors.textSecondary, "textSecondary")
    ]

    // Pre-computed once — avoids iterating all icons on every re-render.
    static let categoryCounts: [IconCategory: Int] = {
        var counts = [IconCategory: Int]()
        for icon in ZodiakIcon.allCases {
            counts[IconCategoryMap.map[icon] ?? .actions, default: 0] += 1
        }
        return counts
    }()

    // MARK: - Derived

    var selectedCategory: IconCategory {
        IconCategory(rawValue: selectedCategoryIndex) ?? .all
    }

    var previewColor: Color {
        Self.colorVariants.indices.contains(selectedColorIndex)
            ? Self.colorVariants[selectedColorIndex].color
            : ZodiakColors.actionPrimary
    }

    var previewColorLabel: String {
        Self.colorVariants.indices.contains(selectedColorIndex)
            ? Self.colorVariants[selectedColorIndex].label
            : "actionPrimary"
    }

    // MARK: - Init

    init() {
        bindFilteredIcons()
    }

    // MARK: - Combine pipeline

    private func bindFilteredIcons() {
        Publishers.CombineLatest($searchText, $selectedCategoryIndex)
            .map { search, categoryIdx -> [ZodiakIcon] in
                let base = ZodiakIcon.allCases
                if !search.isEmpty {
                    return base.filter {
                        $0.accessibilityLabel.localizedCaseInsensitiveContains(search)
                        || (iconCommonUsesMapPT[$0] ?? []).contains {
                            $0.localizedCaseInsensitiveContains(search)
                        }
                        || (iconCommonUsesMapEN[$0] ?? []).contains {
                            $0.localizedCaseInsensitiveContains(search)
                        }
                    }
                }
                let category = IconCategory(rawValue: categoryIdx) ?? .all
                guard category != .all else { return base }
                return base.filter { (IconCategoryMap.map[$0] ?? .actions) == category }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredIcons)
    }
}
