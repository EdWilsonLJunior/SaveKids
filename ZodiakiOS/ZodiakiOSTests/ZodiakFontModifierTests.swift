import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakFontModifier Tests
// Issue: #120 — DS Utils: FontModifier
// Verifica ZodiakTextStyle enum, valores de tracking/lineSpacing,
// isHeading flag e que o modifier é aplicável sem crash.

@Suite("ZodiakTextStyle")
struct ZodiakFontModifierTests {
    // MARK: - CaseIterable coverage

    @Test("ZodiakTextStyle has 17 cases")
    func caseCount() {
        #expect(ZodiakTextStyle.allCases.count == 17)
    }

    // MARK: - font property

    @Test("All styles return a non-nil font value")
    func allStylesHaveFont() {
        for style in ZodiakTextStyle.allCases {
            _ = style.font  // must not crash
        }
    }

    // MARK: - tracking

    @Test("Display styles have negative tracking (large headings compress)")
    func displayStylesHaveNegativeTracking() {
        #expect(ZodiakTextStyle.displayLarge.tracking < 0)
        #expect(ZodiakTextStyle.displayMedium.tracking < 0)
        #expect(ZodiakTextStyle.displaySmall.tracking < 0)
    }

    @Test("Body and label styles have positive tracking")
    func bodyLabelStylesHavePositiveTracking() {
        #expect(ZodiakTextStyle.bodyMedium.tracking > 0)
        #expect(ZodiakTextStyle.bodySmall.tracking > 0)
        #expect(ZodiakTextStyle.captionLarge.tracking > 0)
        #expect(ZodiakTextStyle.labelMedium.tracking > 0)
    }

    // MARK: - lineSpacing

    @Test("All styles have non-negative lineSpacing")
    func allStylesNonNegativeLineSpacing() {
        for style in ZodiakTextStyle.allCases {
            #expect(style.lineSpacing >= 0, "lineSpacing should be >= 0 for \(style)")
        }
    }

    @Test("titleLarge lineSpacing is 40-32 = 8")
    func titleLargeLineSpacing() {
        #expect(ZodiakTextStyle.titleLarge.lineSpacing == 8)
    }

    @Test("bodyMedium lineSpacing is 26-16 = 10")
    func bodyMediumLineSpacing() {
        #expect(ZodiakTextStyle.bodyMedium.lineSpacing == 10)
    }

    // MARK: - isHeading

    @Test("Display and Headline styles are headings")
    func displayAndHeadlineAreHeadings() {
        #expect(ZodiakTextStyle.displayLarge.isHeading)
        #expect(ZodiakTextStyle.displayMedium.isHeading)
        #expect(ZodiakTextStyle.displaySmall.isHeading)
        #expect(ZodiakTextStyle.headlineLarge.isHeading)
        #expect(ZodiakTextStyle.headlineMedium.isHeading)
        #expect(ZodiakTextStyle.headlineSmall.isHeading)
    }

    @Test("Title, body, label, caption styles are NOT headings")
    func nonHeadingStyles() {
        #expect(!ZodiakTextStyle.titleLarge.isHeading)
        #expect(!ZodiakTextStyle.bodyMedium.isHeading)
        #expect(!ZodiakTextStyle.labelLarge.isHeading)
        #expect(!ZodiakTextStyle.captionLarge.isHeading)
    }

    // MARK: - View modifier smoke tests

    @Test("zodiakStyle modifier can be applied to Text")
    func zodiakStyleModifierApplies() {
        // Constructing the modified view must not crash
        let view = Text("Hello").zodiakStyle(.bodyMedium)
        _ = view  // existence check
    }

    @Test("zodiakColor modifier can be chained after zodiakStyle")
    func zodiakColorChainable() {
        let view = Text("Hello")
            .zodiakStyle(.labelLarge)
            .zodiakColor(ZodiakColors.textPrimary)
        _ = view  // existence check
    }
}
