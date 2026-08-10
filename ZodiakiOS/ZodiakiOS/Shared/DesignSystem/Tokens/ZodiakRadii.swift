import SwiftUI

// MARK: - Zodiak Radius Tokens
// Supernova: "Radius" — Zodiak Design System
//
// Four radius tokens cover all official Zodiak components:
//
//   ┌──────────┬────────┬──────────────────────────────────────────────────┐
//   │ Token    │ Value  │ Typical use                                      │
//   ├──────────┼────────┼──────────────────────────────────────────────────┤
//   │ none     │  0pt   │ Fully square corners                             │
//   │ xs       │  4pt   │ Inputs, badges, small chips                      │
//   │ s        │ 16pt   │ Cards, modals, containers                        │
//   │ m        │ 32pt   │ Larger surfaces, feature framing                 │
//   │ l / full │ 999pt  │ Pill / fully-rounded (avatars, pill buttons)     │
//   └──────────┴────────┴──────────────────────────────────────────────────┘
//
// Usage:
//   .cornerRadius(ZodiakRadii.xs)
//   .clipShape(ZodiakRadii.shape(.s))   // continuous squircle via helper

/// Canonical corner-radius tokens. All values are CGFloat points.
enum ZodiakRadii {
    /// None — 0pt. Square corners.
    static let none: CGFloat = 0

    /// XS — 4pt. Inputs, badges, small chips.
    static let xs: CGFloat = 4

    /// S — 16pt. Cards, containers, modals.
    static let s: CGFloat = 16

    /// M — 32pt. Larger surfaces or feature framing.
    static let m: CGFloat = 32

    /// L (full / pill) — 999pt. Avatars, pill buttons, any fully-rounded shape.
    static let l: CGFloat = 999

    /// Full — canonical alias for `l` (pill / fully-rounded).
    static let full: CGFloat = l

    // MARK: - Shape helpers

    /// Returns a `RoundedRectangle` with `.continuous` corner style for the given radius.
    ///
    /// Use `.continuous` (squircle) for all Zodiak surfaces to match Apple HIG.
    static func shape(_ radius: CGFloat) -> RoundedRectangle {
        RoundedRectangle(cornerRadius: radius, style: .continuous)
    }
}
