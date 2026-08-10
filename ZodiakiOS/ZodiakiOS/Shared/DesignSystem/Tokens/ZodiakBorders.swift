import SwiftUI

// MARK: - Zodiak Border Tokens
// Supernova: "Borders" — Zodiak Design System
//
// Three official Supernova weights + a hairline utility for iOS Retina:
//
//   ┌──────────┬────────┬─────────────────────────────────────────────────┐
//   │ Token    │ Value  │ Typical use                                     │
//   ├──────────┼────────┼─────────────────────────────────────────────────┤
//   │ hairline │ 0.5pt  │ Subtle separators (1 physical pixel on 2×/3×)   │
//   │ thin     │ 1pt    │ Default border for most components              │
//   │ medium   │ 2pt    │ Focus rings, selected / active states           │
//   │ thick    │ 4pt    │ Strong emphasis, feature framing                │
//   └──────────┴────────┴─────────────────────────────────────────────────┘
//
// Colors live in ZodiakColors: borderPrimary / borderSecondary / borderSubtle.
//
// Usage:
//   .overlay(
//       RoundedRectangle(cornerRadius: ZodiakRadii.xs)
//           .stroke(ZodiakColors.borderPrimary, lineWidth: ZodiakBorders.thin)
//   )
//   // or the helper:
//   .zodiakBorder(.medium, color: ZodiakColors.actionPrimary, radius: ZodiakRadii.xs)

/// Canonical border-width tokens. All values are CGFloat points.
enum ZodiakBorders {
    /// Hairline — 0.5pt. Renders as 1 physical pixel on 2× and 3× Retina.
    static let hairline: CGFloat = 0.5

    /// Thin — 1pt. Default border for cards, inputs, chips.
    static let thin: CGFloat = 1

    /// Medium — 2pt. Mid-emphasis: focus rings, active selection.
    static let medium: CGFloat = 2

    /// Thick — 4pt. Strong emphasis or feature framing.
    static let thick: CGFloat = 4

    // MARK: - Deprecated aliases (use Supernova canonical names above)

    /// Deprecated: renamed to `thin`.
    @available(*, deprecated, renamed: "thin")
    static let `default`: CGFloat = thin

    /// Deprecated: renamed to `medium`.
    @available(*, deprecated, renamed: "medium")
    static let strong: CGFloat = medium
}

// MARK: - View Modifier

extension View {
    /// Applies a Zodiak border with canonical width token and semantic color.
    ///
    /// - Parameters:
    ///   - width: A `ZodiakBorders` width constant (e.g. `.thin`, `.medium`).
    ///   - color: Border color. Defaults to `ZodiakColors.borderPrimary`.
    ///   - radius: Corner radius. Defaults to `ZodiakRadii.xs`.
    func zodiakBorder(
        _ width: CGFloat,
        color: Color = ZodiakColors.borderPrimary,
        radius: CGFloat = ZodiakRadii.xs
    ) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(color, lineWidth: width)
        )
    }
}
