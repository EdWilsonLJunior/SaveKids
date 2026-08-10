//
//  ZodiakIconSnapshotTests.swift
//  ZodiakiOSTests
//
//  Snapshot smoke tests for ZodiakIconView.
//  Covers the DoD requirement: "Snapshot da icon sheet por tamanho × tint × tema".
//
//  These are smoke-level tests — they verify the rendering pipeline produces
//  non-empty PNG output for every size/color-scheme/tint combination.
//  RTL tests additionally assert that directional icons produce a DIFFERENT
//  pixel hash when rendered in a right-to-left environment, and that
//  non-directional icons produce an IDENTICAL hash.
//
//  To promote to regression baselines: replace `data.count > 0` assertions
//  with `ZodiakSnapshot.sha256Hex(data) == "<recorded hash>"`.
//

import SwiftUI
import Testing
@testable import ZodiakiOS

@Suite("ZodiakIconView Snapshots")
@MainActor
struct ZodiakIconSnapshotTests {
    // MARK: - Size × Color Scheme (8 renders)

    @Test("small · light")
    func smallLight() {
        #expect(render(.check, size: .small, scheme: .light) != nil)
    }

    @Test("small · dark")
    func smallDark() {
        #expect(render(.check, size: .small, scheme: .dark) != nil)
    }

    @Test("medium · light")
    func mediumLight() {
        let data = render(.check, size: .medium, scheme: .light)
        #expect(data != nil)
        #expect((data?.count ?? 0) > 0)
    }

    @Test("medium · dark")
    func mediumDark() {
        #expect(render(.check, size: .medium, scheme: .dark) != nil)
    }

    @Test("large · light")
    func largeLight() {
        #expect(render(.check, size: .large, scheme: .light) != nil)
    }

    @Test("large · dark")
    func largeDark() {
        #expect(render(.check, size: .large, scheme: .dark) != nil)
    }

    @Test("xLarge · light")
    func xLargeLight() {
        #expect(render(.check, size: .xLarge, scheme: .light) != nil)
    }

    @Test("xLarge · dark")
    func xLargeDark() {
        #expect(render(.check, size: .xLarge, scheme: .dark) != nil)
    }

    // MARK: - Color variants (4)

    @Test("tint: textPrimary")
    func tintTextPrimary() {
        #expect(render(.user, color: ZodiakColors.textPrimary) != nil)
    }

    @Test("tint: actionPrimary")
    func tintActionPrimary() {
        #expect(render(.user, color: ZodiakColors.actionPrimary) != nil)
    }

    @Test("tint: brand")
    func tintBrand() {
        #expect(render(.user, color: ZodiakColors.brand) != nil)
    }

    @Test("tint: textDisabled")
    func tintTextDisabled() {
        #expect(render(.user, color: ZodiakColors.textDisabled) != nil)
    }

    // MARK: - RTL mirroring

    @Test("directional icon (arrowRight) produces different pixels in RTL vs LTR")
    func rtlDirectionalIconMirrors() {
        let ltr = render(.arrowRight, size: .medium, layoutDir: .leftToRight)
        let rtl = render(.arrowRight, size: .medium, layoutDir: .rightToLeft)
        guard let ltr, let rtl else {
            Issue.record("ImageRenderer returned nil for arrowRight")
            return
        }
        #expect(ZodiakSnapshot.sha256Hex(ltr) != ZodiakSnapshot.sha256Hex(rtl),
                "arrowRight should be mirrored in RTL — hashes must differ")
    }

    @Test("non-directional icon (star) produces identical pixels in RTL vs LTR")
    func rtlNonDirectionalIconUnchanged() {
        let ltr = render(.star, size: .medium, layoutDir: .leftToRight)
        let rtl = render(.star, size: .medium, layoutDir: .rightToLeft)
        guard let ltr, let rtl else {
            Issue.record("ImageRenderer returned nil for star")
            return
        }
        #expect(ZodiakSnapshot.sha256Hex(ltr) == ZodiakSnapshot.sha256Hex(rtl),
                "star should NOT be mirrored in RTL — hashes must be equal")
    }

    // MARK: - Hash stability

    @Test("render is deterministic across two calls")
    func deterministicHash() {
        let dataA = render(.settings, size: .medium, scheme: .light)
        let dataB = render(.settings, size: .medium, scheme: .light)
        guard let dataA, let dataB else {
            Issue.record("ImageRenderer returned nil")
            return
        }
        #expect(ZodiakSnapshot.sha256Hex(dataA) == ZodiakSnapshot.sha256Hex(dataB))
    }

    @Test("dark and light renders of same icon differ in pixel content")
    func lightAndDarkDiffer() {
        let light = render(.bell, size: .medium, scheme: .light)
        let dark = render(.bell, size: .medium, scheme: .dark)
        guard let light, let dark else {
            Issue.record("ImageRenderer returned nil")
            return
        }
        // Background fills differ between schemes — hashes must not match.
        #expect(ZodiakSnapshot.sha256Hex(light) != ZodiakSnapshot.sha256Hex(dark))
    }

    // MARK: - Helper

    private func render(
        _ icon: ZodiakIcon,
        size: ZodiakIconSize = .medium,
        color: Color = .primary,
        scheme: ColorScheme = .light,
        layoutDir: LayoutDirection = .leftToRight
    ) -> Data? {
        let dim = size.dimension + 16
        let view = ZodiakIconView(icon, size: size, color: color)
            .padding(8)
            .background(scheme == .light ? Color.white : Color.black)
            .environment(\.layoutDirection, layoutDir)
        return ZodiakSnapshot.renderPNG(
            view,
            size: CGSize(width: dim, height: dim),
            colorScheme: scheme
        )
    }
}
