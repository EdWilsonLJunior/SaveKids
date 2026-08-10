import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakTypography Tests
// Issue: #21 — DS Foundation: Typography
// Verifica presença dos tokens canônicos Supernova e paridade entre
// aliases deprecados e nomes canônicos.

@Suite("ZodiakTypography")
struct ZodiakTypographyTests {
    // MARK: - Canonical display tokens

    @Test("displayLarge is accessible")
    func displayLarge() { _ = ZodiakTypography.displayLarge }

    @Test("displayMedium is accessible")
    func displayMedium() { _ = ZodiakTypography.displayMedium }

    @Test("displaySmall is accessible")
    func displaySmall() { _ = ZodiakTypography.displaySmall }

    // MARK: - Canonical headline tokens

    @Test("headlineLarge is accessible")
    func headlineLarge() { _ = ZodiakTypography.headlineLarge }

    @Test("headlineMedium is accessible")
    func headlineMedium() { _ = ZodiakTypography.headlineMedium }

    @Test("headlineSmall is accessible")
    func headlineSmall() { _ = ZodiakTypography.headlineSmall }

    // MARK: - Canonical title tokens

    @Test("titleLarge is accessible")
    func titleLarge() { _ = ZodiakTypography.titleLarge }

    @Test("titleMedium is accessible")
    func titleMedium() { _ = ZodiakTypography.titleMedium }

    @Test("titleSmall is accessible")
    func titleSmall() { _ = ZodiakTypography.titleSmall }

    // MARK: - Canonical label tokens

    @Test("labelLarge is accessible")
    func labelLarge() { _ = ZodiakTypography.labelLarge }

    @Test("labelMedium is accessible")
    func labelMedium() { _ = ZodiakTypography.labelMedium }

    @Test("labelSmall is accessible")
    func labelSmall() { _ = ZodiakTypography.labelSmall }

    // MARK: - Canonical body tokens

    @Test("bodyLarge is accessible")
    func bodyLarge() { _ = ZodiakTypography.bodyLarge }

    @Test("bodyMedium is accessible")
    func bodyMedium() { _ = ZodiakTypography.bodyMedium }

    @Test("bodySmall is accessible")
    func bodySmall() { _ = ZodiakTypography.bodySmall }

    // MARK: - Canonical caption tokens

    @Test("captionLarge is accessible")
    func captionLarge() { _ = ZodiakTypography.captionLarge }

    @Test("captionSmall is accessible")
    func captionSmall() { _ = ZodiakTypography.captionSmall }

    // MARK: - Deprecated alias parity

    @Test("Deprecated headline6XL equals displayLarge")
    func headline6XLParity() {
        #expect(ZodiakTypography.headline6XL == ZodiakTypography.displayLarge)
    }

    @Test("Deprecated title1 equals titleMedium")
    func title1Parity() {
        #expect(ZodiakTypography.title1 == ZodiakTypography.titleMedium)
    }

    @Test("Deprecated title2 equals titleSmall")
    func title2Parity() {
        #expect(ZodiakTypography.title2 == ZodiakTypography.titleSmall)
    }

    @Test("Deprecated body equals bodyMedium")
    func bodyParity() {
        #expect(ZodiakTypography.body == ZodiakTypography.bodyMedium)
    }

    @Test("Deprecated caption equals captionLarge")
    func captionParity() {
        #expect(ZodiakTypography.caption == ZodiakTypography.captionLarge)
    }

    // MARK: - Semantic alias

    @Test("button equals bodyMedium")
    func buttonAlias() {
        #expect(ZodiakTypography.button == ZodiakTypography.bodyMedium)
    }

    // MARK: - Italic variants

    @Test("Italic variants are accessible")
    func italicVariants() {
        _ = ZodiakTypography.bodyXLItalic
        _ = ZodiakTypography.bodyLargeItalic
        _ = ZodiakTypography.bodyItalic
        _ = ZodiakTypography.bodySmallItalic
        _ = ZodiakTypography.captionItalic
    }

    // MARK: - HeadingSize enum

    @Test("HeadingSize.large has pointSize 32")
    func headingSizeLargePointSize() {
        #expect(ZodiakTypography.HeadingSize.large.pointSize == 32)
    }

    @Test("HeadingSize.sixXLarge has pointSize 128")
    func headingSizeSixXLargePointSize() {
        #expect(ZodiakTypography.HeadingSize.sixXLarge.pointSize == 128)
    }

    @Test("HeadingSize line-height values are larger than point sizes")
    func headingSizeLineHeightsAreTaller() {
        for size in [ZodiakTypography.HeadingSize.twoXSmall, .xSmall, .small, .medium, .large] {
            #expect(size.lineHeight >= size.pointSize)
        }
    }

    // MARK: - BodySize enum

    @Test("BodySize.m has pointSize 16")
    func bodySizeMPointSize() {
        #expect(ZodiakTypography.BodySize.m.pointSize == 16)
    }

    @Test("BodySize.xs has pointSize 12")
    func bodySizeXsPointSize() {
        #expect(ZodiakTypography.BodySize.xs.pointSize == 12)
    }

    // MARK: - allMainStyles inventory

    @Test("allMainStyles inventory is non-empty")
    func allMainStylesNonEmpty() {
        #expect(!ZodiakTypography.allMainStyles.isEmpty)
    }

    @Test("allMainStyles contains canonical names")
    func allMainStylesUsesCanonicalNames() {
        let names = Set(ZodiakTypography.allMainStyles.map(\.name))
        #expect(names.contains("Title Large"))
        #expect(names.contains("Body Medium"))
        #expect(names.contains("Caption Large"))
    }
}
