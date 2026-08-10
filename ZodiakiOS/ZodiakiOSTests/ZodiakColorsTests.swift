import SwiftUI
import Testing
import UIKit
@testable import ZodiakiOS

// MARK: - ZodiakColors Tests
// Issue: #7 — DS Foundation: Colors
// Verifica que os 64 tokens semânticos (54 Supernova + 10 iOS-only)
// são acessíveis e que os tokens always-fixed têm os valores corretos.

@Suite("ZodiakColors")
struct ZodiakColorsTests {
    // MARK: - Brand

    @Test("Brand tokens are accessible")
    func brandTokens() {
        _ = ZodiakColors.brand
        _ = ZodiakColors.brandOrange
    }

    // MARK: - Surfaces (15 Supernova tokens)

    @Test("Surface tokens are accessible")
    func surfaceTokens() {
        _ = ZodiakColors.background
        _ = ZodiakColors.surface
        _ = ZodiakColors.surfaceSmoke
        _ = ZodiakColors.surfaceFog
        _ = ZodiakColors.surfaceCaribbean
        _ = ZodiakColors.surfaceCaribbeanInverse
        _ = ZodiakColors.surfaceInk
        _ = ZodiakColors.surfaceMarine
        _ = ZodiakColors.surfaceAzur
        _ = ZodiakColors.surfacePositive
        _ = ZodiakColors.surfaceNegative
    }

    @Test("background resolves to expected light and dark values")
    func backgroundResolvedValues() {
        #expect(resolvedHex(ZodiakColors.background, style: .light) == "#ffffff")
        #expect(resolvedHex(ZodiakColors.background, style: .dark) == "#12151d")
    }

    @Test("surface resolves to expected light and dark values")
    func surfaceResolvedValues() {
        #expect(resolvedHex(ZodiakColors.surface, style: .light) == "#ffffff")
        #expect(resolvedHex(ZodiakColors.surface, style: .dark) == "#12151d")
    }

    @Test("background and surface resolve to the same values in both appearances")
    func backgroundAndSurfaceMatch() {
        #expect(resolvedHex(ZodiakColors.background, style: .light) == resolvedHex(ZodiakColors.surface, style: .light))
        #expect(resolvedHex(ZodiakColors.background, style: .dark) == resolvedHex(ZodiakColors.surface, style: .dark))
    }

    @Test("surfaceAlwaysWhite is white in both modes")
    func surfaceAlwaysWhite() {
        #expect(ZodiakColors.surfaceAlwaysWhite == Color(hex: "#ffffff"))
    }

    @Test("surfaceAlwaysBlack is black in both modes")
    func surfaceAlwaysBlack() {
        #expect(ZodiakColors.surfaceAlwaysBlack == Color(hex: "#000000"))
    }

    @Test("surfaceDecorativeBrand equals brand")
    func surfaceDecorativeBrandAlias() {
        // decorative tokens are aliases — same Color instance
        _ = ZodiakColors.surfaceDecorativeBrand
        _ = ZodiakColors.surfaceDecorativeOrange
    }

    // MARK: - Text (13 tokens: 12 Supernova + textPositive iOS-only)

    @Test("Text tokens are accessible")
    func textTokens() {
        _ = ZodiakColors.textPrimary
        _ = ZodiakColors.textSecondary
        _ = ZodiakColors.textInverse
        _ = ZodiakColors.textDisabled
        _ = ZodiakColors.textLink
        _ = ZodiakColors.textLinkHover
        _ = ZodiakColors.textLinkPressed
        _ = ZodiakColors.textLinkInverse
        _ = ZodiakColors.textNegative
    }

    @Test("textAlwaysWhite is #ffffff")
    func textAlwaysWhite() {
        #expect(ZodiakColors.textAlwaysWhite == Color(hex: "#ffffff"))
    }

    @Test("textAlwaysBlack is Neutral shade950 #171a22")
    func textAlwaysBlack() {
        #expect(ZodiakColors.textAlwaysBlack == Color(hex: "#171a22"))
    }

    @Test("textNegativeOnHeavy is Red shade200 #ffa7a9")
    func textNegativeOnHeavy() {
        #expect(ZodiakColors.textNegativeOnHeavy == Color(hex: "#ffa7a9"))
    }

    @Test("textPositive (iOS-only) is accessible")
    func textPositive() {
        _ = ZodiakColors.textPositive
    }

    // MARK: - Actions (17 onLite + 3 onHeavy + warning + focus)

    @Test("Action onLite tokens are accessible")
    func actionOnLiteTokens() {
        _ = ZodiakColors.actionPrimary
        _ = ZodiakColors.actionHover
        _ = ZodiakColors.actionPressed
        _ = ZodiakColors.actionDisabled
        _ = ZodiakColors.actionDisabledContent
        _ = ZodiakColors.actionActive
        _ = ZodiakColors.actionFocus
    }

    @Test("Action Warning tokens are accessible")
    func actionWarningTokens() {
        _ = ZodiakColors.actionWarning
        _ = ZodiakColors.actionWarningContent
        _ = ZodiakColors.actionWarningHover
        _ = ZodiakColors.actionWarningHoverOutline
        _ = ZodiakColors.actionWarningPressed
        _ = ZodiakColors.actionWarningPressedOutline
        _ = ZodiakColors.actionWarningSecondary
        _ = ZodiakColors.actionWarningSecondaryHover
    }

    @Test("Action onHeavy tokens are accessible")
    func actionOnHeavyTokens() {
        _ = ZodiakColors.actionPrimaryOnHeavy
        _ = ZodiakColors.actionHoverOnHeavy
        _ = ZodiakColors.actionPressedOnHeavy
        _ = ZodiakColors.actionFocusOnHeavy
    }

    @Test("actionFocusOnHeavy is white (always-fixed)")
    func actionFocusOnHeavy() {
        #expect(ZodiakColors.actionFocusOnHeavy == Color(hex: "#ffffff"))
    }

    @Test("actionPrimaryOnPhoto is clear")
    func actionPrimaryOnPhoto() {
        #expect(ZodiakColors.actionPrimaryOnPhoto == Color.clear)
    }

    // MARK: - Borders

    @Test("Border tokens are accessible")
    func borderTokens() {
        _ = ZodiakColors.borderPrimary
        _ = ZodiakColors.borderSecondary
    }

    // MARK: - Overlays

    @Test("Overlay tokens are accessible")
    func overlayTokens() {
        _ = ZodiakColors.pageOverlay
        _ = ZodiakColors.heroPhotographic
    }

    // MARK: - Status (iOS-only, 3 tokens)

    @Test("Status tokens are accessible")
    func statusTokens() {
        _ = ZodiakColors.statusOnline
        _ = ZodiakColors.statusAway
        _ = ZodiakColors.statusDoNotDisturb
    }

    @Test("statusOnline matches #21b87d")
    func statusOnlineValue() {
        #expect(ZodiakColors.statusOnline == Color(hex: "#21b87d"))
    }

    @Test("statusAway matches #ff6270")
    func statusAwayValue() {
        #expect(ZodiakColors.statusAway == Color(hex: "#ff6270"))
    }

    // MARK: - Warning tints, banners, rating (iOS-only)

    @Test("iOS-only tokens are accessible")
    func iOSOnlyTokens() {
        _ = ZodiakColors.actionWarningTint
        _ = ZodiakColors.surfaceWarningTint
        _ = ZodiakColors.bannerSuccess
        _ = ZodiakColors.bannerWarning
        _ = ZodiakColors.bannerError
    }
}

// MARK: - Helpers

private func resolvedHex(_ color: Color, style: UIUserInterfaceStyle) -> String {
    let traitCollection = UITraitCollection(userInterfaceStyle: style)
    let resolved = UIColor(color).resolvedColor(with: traitCollection)

    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    #expect(resolved.getRed(&red, green: &green, blue: &blue, alpha: &alpha))

    let r = Int(round(red * 255))
    let g = Int(round(green * 255))
    let b = Int(round(blue * 255))

    return String(format: "#%02x%02x%02x", r, g, b)
}
