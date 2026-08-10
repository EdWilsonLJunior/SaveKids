import SwiftUI

// MARK: - ZodiakColorScheme
// Struct that mirrors all ZodiakColors static tokens as instance properties.
// Inject via the `\.zodiakColors` EnvironmentKey to override colors in previews or tests.
//
// Usage (override in preview):
//   MyView()
//       .zodiakColors(ZodiakColorScheme(brand: .red))
//
// Usage (read in view):
//   @Environment(\.zodiakColors) private var colors
//   Text("Hello").foregroundStyle(colors.textPrimary)

struct ZodiakColorScheme {
    // MARK: - Brand
    var brand: Color = ZodiakColors.brand
    var brandOrange: Color = ZodiakColors.brandOrange

    // MARK: - Surfaces
    var background: Color = ZodiakColors.background
    var surface: Color = ZodiakColors.surface
    var surfaceSmoke: Color = ZodiakColors.surfaceSmoke
    var surfaceFog: Color = ZodiakColors.surfaceFog
    var surfaceCaribbean: Color = ZodiakColors.surfaceCaribbean
    var surfaceCaribbeanInverse: Color = ZodiakColors.surfaceCaribbeanInverse
    var surfaceInk: Color = ZodiakColors.surfaceInk
    var surfaceMarine: Color = ZodiakColors.surfaceMarine
    var surfaceAzur: Color = ZodiakColors.surfaceAzur
    var surfaceAlwaysWhite: Color = ZodiakColors.surfaceAlwaysWhite
    var surfaceAlwaysBlack: Color = ZodiakColors.surfaceAlwaysBlack
    var surfacePositive: Color = ZodiakColors.surfacePositive
    var surfaceNegative: Color = ZodiakColors.surfaceNegative
    var surfaceDecorativeBrand: Color = ZodiakColors.surfaceDecorativeBrand
    var surfaceDecorativeOrange: Color = ZodiakColors.surfaceDecorativeOrange
    var surfaceWarningTint: Color = ZodiakColors.surfaceWarningTint

    // MARK: - Text / Content
    var textPrimary: Color = ZodiakColors.textPrimary
    var textSecondary: Color = ZodiakColors.textSecondary
    var textInverse: Color = ZodiakColors.textInverse
    var textDisabled: Color = ZodiakColors.textDisabled
    var textAlwaysWhite: Color = ZodiakColors.textAlwaysWhite
    var textAlwaysBlack: Color = ZodiakColors.textAlwaysBlack
    var textLink: Color = ZodiakColors.textLink
    var textLinkHover: Color = ZodiakColors.textLinkHover
    var textLinkPressed: Color = ZodiakColors.textLinkPressed
    var textLinkInverse: Color = ZodiakColors.textLinkInverse
    var textNegative: Color = ZodiakColors.textNegative
    var textNegativeOnHeavy: Color = ZodiakColors.textNegativeOnHeavy
    var textPositive: Color = ZodiakColors.textPositive

    // MARK: - Status
    var statusOnline: Color = ZodiakColors.statusOnline
    var statusAway: Color = ZodiakColors.statusAway
    var statusDoNotDisturb: Color = ZodiakColors.statusDoNotDisturb

    // MARK: - Warning / Banner
    var actionWarningTint: Color = ZodiakColors.actionWarningTint
    var bannerSuccess: Color = ZodiakColors.bannerSuccess
    var bannerWarning: Color = ZodiakColors.bannerWarning
    var bannerError: Color = ZodiakColors.bannerError

    // MARK: - Actions (onLite)
    var actionPrimary: Color = ZodiakColors.actionPrimary
    var actionHover: Color = ZodiakColors.actionHover
    var actionPressed: Color = ZodiakColors.actionPressed
    var actionDisabled: Color = ZodiakColors.actionDisabled
    var actionDisabledContent: Color = ZodiakColors.actionDisabledContent
    var actionActive: Color = ZodiakColors.actionActive
    var actionFocus: Color = ZodiakColors.actionFocus
    var actionFocusOnHeavy: Color = ZodiakColors.actionFocusOnHeavy
    var actionPrimaryOnPhoto: Color = ZodiakColors.actionPrimaryOnPhoto
    var actionWarning: Color = ZodiakColors.actionWarning
    var actionWarningContent: Color = ZodiakColors.actionWarningContent
    var actionWarningHover: Color = ZodiakColors.actionWarningHover
    var actionWarningHoverOutline: Color = ZodiakColors.actionWarningHoverOutline
    var actionWarningPressed: Color = ZodiakColors.actionWarningPressed
    var actionWarningPressedOutline: Color = ZodiakColors.actionWarningPressedOutline
    var actionWarningSecondary: Color = ZodiakColors.actionWarningSecondary
    var actionWarningSecondaryHover: Color = ZodiakColors.actionWarningSecondaryHover

    // MARK: - Actions (onHeavy)
    var actionPrimaryOnHeavy: Color = ZodiakColors.actionPrimaryOnHeavy
    var actionHoverOnHeavy: Color = ZodiakColors.actionHoverOnHeavy
    var actionPressedOnHeavy: Color = ZodiakColors.actionPressedOnHeavy

    // MARK: - Borders
    var borderPrimary: Color = ZodiakColors.borderPrimary
    var borderSecondary: Color = ZodiakColors.borderSecondary

    // MARK: - Overlays
    var pageOverlay: Color = ZodiakColors.pageOverlay
    var heroPhotographic: Color = ZodiakColors.heroPhotographic
}

// MARK: - EnvironmentKey

private struct ZodiakColorSchemeKey: EnvironmentKey {
    static let defaultValue = ZodiakColorScheme()
}

extension EnvironmentValues {
    /// The active Zodiak color scheme. Override in previews and tests via `.zodiakColors(_:)`.
    var zodiakColors: ZodiakColorScheme {
        get { self[ZodiakColorSchemeKey.self] }
        set { self[ZodiakColorSchemeKey.self] = newValue }
    }
}

// MARK: - View Helper

extension View {
    /// Injects a custom [ZodiakColorScheme] into the environment.
    /// Use in previews and tests to override specific color tokens without modifying production code.
    func zodiakColors(_ colors: ZodiakColorScheme) -> some View {
        environment(\.zodiakColors, colors)
    }
}
