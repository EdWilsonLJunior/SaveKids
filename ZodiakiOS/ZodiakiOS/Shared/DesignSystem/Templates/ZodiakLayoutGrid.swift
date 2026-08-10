import SwiftUI

// MARK: - ZodiakLayoutGrid
/// Zero-configuration adaptive column grid.
/// Automatically selects column count based on device type and orientation.
/// Margins are the caller's responsibility — use `ZodiakSpacing.screenPad` (iPhone)
/// or `ZodiakSpacing.screenPadLarge` (iPad) for standard Zodiak margins.
///
/// Spacing defaults to Zodiak tokens per device (`xs` on iPhone, `s` on iPad),
/// but both axes can be overridden independently:
///
/// > **Terminology note:** The Zodiak Design System (platform-agnostic) calls these
/// > spaces **gutter** (between columns) and **margin** (screen edge to content).
/// > The parameter names `horizontalSpacing` / `verticalSpacing` follow SwiftUI's
/// > own `Grid` API convention. Zodiak is the single source of truth for values.
///
/// ```swift
/// ZodiakLayoutGrid { ... }
/// // → horizontalSpacing = xs/s, verticalSpacing = xs/s (auto by device)
///
/// ZodiakLayoutGrid(horizontalSpacing: ZodiakSpacing.s8) { ... }
/// // → colunas mais juntas, linhas no padrão
///
/// ZodiakLayoutGrid(horizontalSpacing: ZodiakSpacing.s8,
///                  verticalSpacing: ZodiakSpacing.s16) { ... }
/// // → ambos customizados
/// ```
///
/// Column counts (with standard Zodiak horizontal padding applied):
///
/// | Device              | Portrait  | Landscape |
/// |---------------------|-----------|-----------|
/// | iPhone SE           | 3 col     | 4 col     |
/// | iPhone (normal)     | 4 col     | 6 col     |
/// | iPhone Pro Max      | 4 col     | 6 col     |
/// | iPad mini           | 4 col     | 7 col     |
/// | iPad Air 11"        | 5 col     | 7 col     |
/// | iPad Pro 13"        | 6 col     | 8 col     |

struct ZodiakLayoutGrid<Content: View>: View {
    // MARK: - Configuration

    var columns: Int?
    var horizontalSpacing: CGFloat?
    var verticalSpacing: CGFloat?
    var applyScreenPadding: Bool
    let content: Content

    // MARK: - Environment
    // verticalSizeClass is .compact on iPhone landscape and .regular on portrait.
    // Using this instead of NotificationCenter avoids a timing bug where
    // orientationDidChangeNotification fires before interfaceOrientation updates,
    // causing the grid to read the stale value and lock to the wrong column count.

    @Environment(\.verticalSizeClass) private var vSizeClass

    // MARK: - Init

    init(
        columns: Int? = nil,
        horizontalSpacing: CGFloat? = nil,
        verticalSpacing: CGFloat? = nil,
        applyScreenPadding: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.columns = columns
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.applyScreenPadding = applyScreenPadding
        self.content = content()
    }

    // MARK: - Private

    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var isLandscape: Bool { vSizeClass == .compact }
    private var defaultSpacing: CGFloat { isIPad ? ZodiakSpacing.s24 : ZodiakSpacing.s16 }
    private var resolvedHorizontalSpacing: CGFloat { horizontalSpacing ?? defaultSpacing }
    private var resolvedVerticalSpacing: CGFloat { verticalSpacing ?? defaultSpacing }

    /// Minimum column width drives the adaptive column count:
    /// - iPad: floored at 130pt to avoid 10+ columns on wide screens
    /// - iPhone landscape: scaled 1.4× to compensate for Dynamic Island safe-area
    ///   insets (~59pt each side on iPhone 17) while still reaching 6 columns.
    ///   Formula (iPhone 17): floor((702 + gutter) / (105 + gutter)) = 6 ✓
    private var minimumColumnWidth: CGFloat {
        let base: CGFloat = 75
        if isIPad { return max(base, 130) }
        return isLandscape ? base * 1.4 : base
    }

    /// Logical screen width for the current orientation.
    /// Uses `UIWindowScene.screen` (iOS 16+) to avoid the `UIScreen.main` deprecation in iOS 26.
    /// Falls back to a standard iPhone 16 logical size (393×852) when no active scene is found.
    private var currentScreenWidth: CGFloat {
        let scene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
        let bounds = scene?.screen.bounds ?? CGRect(x: 0, y: 0, width: 393, height: 852)
        return isLandscape
            ? max(bounds.width, bounds.height)
            : min(bounds.width, bounds.height)
    }

    /// Maximum allowed columns derived from the Zodiak column-width heuristic
    /// applied to the current device and orientation.
    private var maxColumns: Int {
        let sidePad = applyScreenPadding
            ? (isIPad ? ZodiakSpacing.screenPadLarge : ZodiakSpacing.screenPad)
            : 0
        let available = currentScreenWidth - 2 * sidePad
        let gutter = resolvedHorizontalSpacing
        return max(1, Int((available + gutter) / (minimumColumnWidth + gutter)))
    }

    private var gridItems: [GridItem] {
        guard let requested = columns else {
            return [GridItem(.adaptive(minimum: minimumColumnWidth), spacing: resolvedHorizontalSpacing)]
        }
        let clamped = min(max(1, requested), maxColumns)
        return Array(
            repeating: GridItem(.flexible(), spacing: resolvedHorizontalSpacing),
            count: clamped
        )
    }

    private var screenPadding: CGFloat {
        guard applyScreenPadding else { return 0 }
        return isIPad ? ZodiakSpacing.screenPadLarge : ZodiakSpacing.screenPad
    }

    // MARK: - Body

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: resolvedVerticalSpacing) {
            content
        }
        .padding(.horizontal, screenPadding)
    }
}

// MARK: - Previews

#Preview("Adaptive — iPhone SE (3 col)") {
    let items = (1...9).map { "Item \($0)" }
    ScrollView {
        ZodiakLayoutGrid {
            ForEach(items, id: \.self) { label in
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .fill(ZodiakColors.actionPrimary.opacity(0.15))
                    .frame(height: 60)
                    .overlay(Text(verbatim: label).font(ZodiakTypography.captionLarge))
            }
        }
        .padding(.top, ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

#Preview("Adaptive — iPhone 16 (4 col)") {
    let items = (1...12).map { "Item \($0)" }
    ScrollView {
        ZodiakLayoutGrid {
            ForEach(items, id: \.self) { label in
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .fill(ZodiakColors.actionPrimary.opacity(0.15))
                    .frame(height: 60)
                    .overlay(Text(verbatim: label).font(ZodiakTypography.captionLarge))
            }
        }
        .padding(.top, ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

#Preview("Fixed 2-col — iPhone") {
    let items = (1...8).map { "Item \($0)" }
    ScrollView {
        ZodiakLayoutGrid(columns: 2) {
            ForEach(items, id: \.self) { label in
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .fill(ZodiakColors.brand.opacity(0.15))
                    .frame(height: 80)
                    .overlay(Text(verbatim: label).font(ZodiakTypography.captionLarge))
            }
        }
        .padding(.top, ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

#Preview("Fixed 3-col — clampado (iPad Pro 13\" = 6 max)") {
    let items = (1...12).map { "Item \($0)" }
    ScrollView {
        ZodiakLayoutGrid(columns: 3) {
            ForEach(items, id: \.self) { label in
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .fill(ZodiakColors.actionPrimary.opacity(0.15))
                    .frame(height: 60)
                    .overlay(Text(verbatim: label).font(ZodiakTypography.captionLarge))
            }
        }
        .padding(.top, ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
    .environment(\.horizontalSizeClass, .regular)
}

#Preview("Adaptive — iPad Pro 13\" (6 col)") {
    let items = (1...18).map { "Item \($0)" }
    ScrollView {
        ZodiakLayoutGrid {
            ForEach(items, id: \.self) { label in
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .fill(ZodiakColors.actionPrimary.opacity(0.15))
                    .frame(height: 60)
                    .overlay(Text(verbatim: label).font(ZodiakTypography.captionLarge))
            }
        }
        .padding(.top, ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
    .environment(\.horizontalSizeClass, .regular)
}
