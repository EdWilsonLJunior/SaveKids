import SwiftUI

// MARK: - Zodiak Grid Tokens
// Zodiak Design System — "Layout grid"
//
// Adaptive grid resolved from device/size-class context.
// Breakpoints map iOS traits to canonical columns/gutter/margin:
//
//  ┌──────────────────┬─────────┬────────┬────────┐
//  │ Context          │ Columns │ Gutter │ Margin │
//  ├──────────────────┼─────────┼────────┼────────┤
//  │ iPhone Portrait  │    4    │  16pt  │  16pt  │
//  │ iPhone Landscape │    6    │  16pt  │  16pt  │
//  │ iPad Portrait    │    8    │  24pt  │  32pt  │
//  │ iPad Landscape   │   12    │  24pt  │  32pt  │
//  └──────────────────┴─────────┴────────┴────────┘
//
// Usage:
//   let grid = ZodiakGrid.from(size: geometry.size)
//   LazyVGrid(columns: Array(repeating: .flexible(), count: grid.columns), spacing: grid.gutter)

// MARK: - ZodiakGrid

/// Resolved grid configuration for the current layout context.
struct ZodiakGrid {
    let columns: Int
    let gutter: CGFloat
    let margin: CGFloat

    // MARK: Grid presets

    /// iPhone portrait / compact context — 4 cols, 16pt gutter/margin.
    static let compact = Self(
        columns: ZodiakGridTokens.Columns.iPhonePortrait,
        gutter: ZodiakGridTokens.Gutter.iPhone,
        margin: ZodiakGridTokens.Margin.iPhone
    )

    /// iPhone landscape — 6 cols, 16pt gutter/margin.
    static let compactWide = Self(
        columns: ZodiakGridTokens.Columns.iPhoneLandscape,
        gutter: ZodiakGridTokens.Gutter.iPhone,
        margin: ZodiakGridTokens.Margin.iPhone
    )

    /// iPad portrait — 8 cols, 24pt gutter, 32pt margin.
    static let medium = Self(
        columns: ZodiakGridTokens.Columns.iPadPortrait,
        gutter: ZodiakGridTokens.Gutter.iPad,
        margin: ZodiakGridTokens.Margin.iPad
    )

    /// iPad landscape — 12 cols, 24pt gutter, 32pt margin.
    static let expanded = Self(
        columns: ZodiakGridTokens.Columns.iPadLandscape,
        gutter: ZodiakGridTokens.Gutter.iPad,
        margin: ZodiakGridTokens.Margin.iPad
    )

    // MARK: Dynamic resolution

    /// Resolves the grid configuration from a container size.
    ///
    /// - Parameter size: The available container width, e.g. from `GeometryProxy.size`.
    static func from(size: CGSize) -> Self {
        switch size.width {
        case ..<600: return size.height > size.width ? .compact : .compactWide
        case 600..<900: return .medium
        default: return .expanded
        }
    }
}

// MARK: - ZodiakGridTokens (raw token constants)

enum ZodiakGridTokens {
    // MARK: - Column Count

    enum Columns {
        /// iPhone Portrait — 4 columns
        static let iPhonePortrait: Int = 4
        /// iPhone Landscape — 6 columns
        static let iPhoneLandscape: Int = 6
        /// iPad Portrait — 8 columns
        static let iPadPortrait: Int = 8
        /// iPad Landscape / Expanded — 12 columns
        static let iPadLandscape: Int = 12
    }

    // MARK: - Gutter

    enum Gutter {
        /// iPhone — 16pt
        static let iPhone: CGFloat = 16
        /// iPad — 24pt
        static let iPad: CGFloat = 24
    }

    // MARK: - Margin

    enum Margin {
        /// iPhone — 16pt
        static let iPhone: CGFloat = 16
        /// iPad — 32pt
        static let iPad: CGFloat = 32
    }
}
