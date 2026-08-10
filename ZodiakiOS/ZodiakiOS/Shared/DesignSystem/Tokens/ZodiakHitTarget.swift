import SwiftUI

// MARK: - ZodiakHitTarget
// WCAG 2.5.5 (AAA — 44×44pt) and HIG minimum touch-target guidelines.
// All interactive Zodiak components must meet `ZodiakHitTarget.minimum`.
//
// Usage:
//   .frame(minWidth: ZodiakHitTarget.minimum, minHeight: ZodiakHitTarget.minimum)
//   // or the modifier:
//   .zodiakHitTarget()

/// Canonical hit-target size tokens.
enum ZodiakHitTarget {
    /// Minimum — 44pt. WCAG 2.5.5 AAA + HIG standard for all interactive elements.
    static let minimum: CGFloat = 44

    /// Comfortable — 48pt. Material 3 / Android baseline; optional larger target.
    static let comfortable: CGFloat = 48
}

// MARK: - View Modifier

extension View {
    /// Ensures the view meets the Zodiak minimum hit-target (44×44pt).
    ///
    /// Applies `.frame(minWidth:minHeight:)` and `.contentShape(.rect)` so the
    /// entire padding region participates in hit-testing.
    func zodiakHitTarget(_ size: CGFloat = ZodiakHitTarget.minimum) -> some View {
        frame(minWidth: size, minHeight: size)
            .contentShape(Rectangle())
    }
}
