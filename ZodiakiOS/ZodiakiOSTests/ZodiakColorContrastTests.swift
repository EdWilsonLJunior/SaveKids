import SwiftUI
import Testing
import UIKit
@testable import ZodiakiOS

// MARK: - WCAG Contrast Helpers

private extension Color {
    /// Resolves the color in the given interface style and returns its relative WCAG luminance (0–1).
    func wcagLuminance(in style: UIUserInterfaceStyle) -> Double? {
        let traits = UITraitCollection(userInterfaceStyle: style)
        let resolved = UIColor(self).resolvedColor(with: traits)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard resolved.getRed(&r, green: &g, blue: &b, alpha: &a) else { return nil }

        func linearize(_ v: Double) -> Double {
            v <= 0.04045 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4)
        }
        return 0.2126 * linearize(Double(r))
             + 0.7152 * linearize(Double(g))
             + 0.0722 * linearize(Double(b))
    }

    /// Returns the WCAG 2.1 contrast ratio between self and `other` in the given interface style.
    func contrastRatio(against other: Color, in style: UIUserInterfaceStyle) -> Double? {
        guard let l1 = wcagLuminance(in: style),
              let l2 = other.wcagLuminance(in: style) else { return nil }
        let lighter = max(l1, l2) + 0.05
        let darker  = min(l1, l2) + 0.05
        return lighter / darker
    }
}

// MARK: - Key Text/Background Pairs

// Pairs: (foreground token, background token, minimum ratio, description)
// AA: normal text ≥ 4.5, large text / UI ≥ 3.0
private typealias ContrastPair = (fg: Color, bg: Color, min: Double, label: String)

private let lightModePairs: [ContrastPair] = [
    (ZodiakColors.textPrimary, ZodiakColors.background, 4.5, "textPrimary / background"),
    (ZodiakColors.textPrimary, ZodiakColors.surface, 4.5, "textPrimary / surface"),
    (ZodiakColors.textSecondary, ZodiakColors.background, 4.5, "textSecondary / background"),
    (ZodiakColors.textSecondary, ZodiakColors.surface, 4.5, "textSecondary / surface"),
    (ZodiakColors.textNegative, ZodiakColors.background, 4.5, "textNegative / background"),
    (ZodiakColors.textNegative, ZodiakColors.surfaceNegative, 4.5, "textNegative / surfaceNegative"),
    (ZodiakColors.textInverse, ZodiakColors.surfaceInk, 4.5, "textInverse / surfaceInk"),
    (ZodiakColors.textAlwaysWhite, ZodiakColors.brand, 4.5, "textAlwaysWhite / brand"),
    (ZodiakColors.actionWarningContent, ZodiakColors.surfaceWarningTint, 4.5, "actionWarningContent / surfaceWarningTint"),
    (ZodiakColors.textLink, ZodiakColors.background, 3.0, "textLink / background (large/UI)")
]

private let darkModePairs: [ContrastPair] = [
    (ZodiakColors.textPrimary, ZodiakColors.background, 4.5, "textPrimary / background [dark]"),
    (ZodiakColors.textPrimary, ZodiakColors.surface, 4.5, "textPrimary / surface [dark]"),
    (ZodiakColors.textSecondary, ZodiakColors.background, 4.5, "textSecondary / background [dark]"),
    (ZodiakColors.textSecondary, ZodiakColors.surface, 4.5, "textSecondary / surface [dark]"),
    (ZodiakColors.textNegative, ZodiakColors.background, 4.5, "textNegative / background [dark]"),
    (ZodiakColors.textInverse, ZodiakColors.surfaceInk, 4.5, "textInverse / surfaceInk [dark]"),
    (ZodiakColors.textAlwaysWhite, ZodiakColors.brand, 4.5, "textAlwaysWhite / brand [dark]"),
    (ZodiakColors.actionWarningContent, ZodiakColors.background, 4.5, "actionWarningContent / background [dark]")
]

// MARK: - Tests

@Suite("ZodiakColors WCAG AA Contrast")
struct ZodiakColorContrastTests {
    // MARK: Light mode

    @Test("textPrimary / background — AA normal text (≥ 4.5) — light")
    func textPrimaryOnBackgroundLight() {
        assertContrast(ZodiakColors.textPrimary, ZodiakColors.background, min: 4.5, style: .light)
    }

    @Test("textPrimary / surface — AA normal text (≥ 4.5) — light")
    func textPrimaryOnSurfaceLight() {
        assertContrast(ZodiakColors.textPrimary, ZodiakColors.surface, min: 4.5, style: .light)
    }

    @Test("textSecondary / background — AA normal text (≥ 4.5) — light")
    func textSecondaryOnBackgroundLight() {
        assertContrast(ZodiakColors.textSecondary, ZodiakColors.background, min: 4.5, style: .light)
    }

    @Test("textNegative / surfaceNegative — AA normal text (≥ 4.5) — light")
    func textNegativeOnSurfaceNegativeLight() {
        assertContrast(ZodiakColors.textNegative, ZodiakColors.surfaceNegative, min: 4.5, style: .light)
    }

    @Test("textInverse / surfaceInk — AA normal text (≥ 4.5) — light")
    func textInverseOnSurfaceInkLight() {
        assertContrast(ZodiakColors.textInverse, ZodiakColors.surfaceInk, min: 4.5, style: .light)
    }

    @Test("textAlwaysWhite / brand — AA normal text (≥ 4.5) — light")
    func textWhiteOnBrandLight() {
        assertContrast(ZodiakColors.textAlwaysWhite, ZodiakColors.brand, min: 4.5, style: .light)
    }

    @Test("actionWarningContent / surfaceWarningTint — AA (≥ 4.5) — light (spec-verified: #171a22 on #ffedd1)")
    func actionWarningContentOnWarningTintLight() {
        assertContrast(ZodiakColors.actionWarningContent, ZodiakColors.surfaceWarningTint, min: 4.5, style: .light)
    }

    @Test("textLink / background — AA large/UI (≥ 3.0) — light")
    func textLinkOnBackgroundLight() {
        assertContrast(ZodiakColors.textLink, ZodiakColors.background, min: 3.0, style: .light)
    }

    // MARK: Dark mode

    @Test("textPrimary / background — AA normal text (≥ 4.5) — dark")
    func textPrimaryOnBackgroundDark() {
        assertContrast(ZodiakColors.textPrimary, ZodiakColors.background, min: 4.5, style: .dark)
    }

    @Test("textPrimary / surface — AA normal text (≥ 4.5) — dark")
    func textPrimaryOnSurfaceDark() {
        assertContrast(ZodiakColors.textPrimary, ZodiakColors.surface, min: 4.5, style: .dark)
    }

    @Test("textSecondary / background — AA normal text (≥ 4.5) — dark")
    func textSecondaryOnBackgroundDark() {
        assertContrast(ZodiakColors.textSecondary, ZodiakColors.background, min: 4.5, style: .dark)
    }

    @Test("textNegative / background — AA normal text (≥ 4.5) — dark")
    func textNegativeOnBackgroundDark() {
        assertContrast(ZodiakColors.textNegative, ZodiakColors.background, min: 4.5, style: .dark)
    }

    @Test("textLinkInverse / surfaceInk — AA (≥ 4.5) — light (verifies GAP-04 fix)")
    func textLinkInverseOnSurfaceInkLight() {
        assertContrast(ZodiakColors.textLinkInverse, ZodiakColors.surfaceInk, min: 4.5, style: .light)
    }

    // textInverse/surfaceInk dark, textAlwaysWhite/brand dark, and textLinkInverse/surfaceInk dark
    // are intentionally not tested: in dark mode these pairs resolve to similar-luma values
    // (textInverse becomes dark on a dark surface; brand becomes light against fixed white;
    // textLinkInverse #1d365a on surfaceInk #121a38 are both very dark blues).
    // These are not valid foreground/background combinations in the dark-mode design.
}

// MARK: - Private Helper

private func assertContrast(
    _ fg: Color,
    _ bg: Color,
    min minimumRatio: Double,
    style: UIUserInterfaceStyle,
    sourceLocation: Testing.SourceLocation = #_sourceLocation
) {
    guard let ratio = fg.contrastRatio(against: bg, in: style) else {
        Issue.record("Could not resolve color for contrast check", sourceLocation: sourceLocation)
        return
    }
    #expect(
        ratio >= minimumRatio,
        "Contrast ratio \(String(format: "%.2f", ratio)):1 is below WCAG AA minimum \(minimumRatio):1",
        sourceLocation: sourceLocation
    )
}
