import Foundation

// MARK: - Constants
enum SolutionsCatalogConstants {
    static let durationRanges: [String] = [
        String(localized: "feature.solutions_catalog.duration_short"),
        String(localized: "feature.solutions_catalog.duration_medium"),
        String(localized: "feature.solutions_catalog.duration_long")
    ]

    static func durationRange(for duration: String) -> String {
        if duration == "+8h" { return String(localized: "feature.solutions_catalog.duration_long") }
        let hours = Int(duration.replacingOccurrences(of: "h", with: "")) ?? 0
        if hours <= 2 { return String(localized: "feature.solutions_catalog.duration_short") }
        return String(localized: "feature.solutions_catalog.duration_medium")
    }
}
