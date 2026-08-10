import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - Zodiak Design System Token Tests
// Phase 5.1 — unit tests para validar invariantes dos tokens.

// MARK: ZodiakSpacing

@Suite("ZodiakSpacingLegacy")
struct ZodiakSpacingLegacyTests {
    @Test("Escala segue progressão Zodiak (4/8/16/24/32/40/48/56/...)")
    func scaleProgression() {
        // 4-pt grid: cada token deve ser múltiplo de 4 (exceto hairline=2pt sentinel).
        #expect(ZodiakSpacing.s4 == 4)
        #expect(ZodiakSpacing.s8 == 8)
        #expect(ZodiakSpacing.s16 == 16)
        #expect(ZodiakSpacing.s24 == 24)
        #expect(ZodiakSpacing.s32 == 32)
        #expect(ZodiakSpacing.s40 == 40)
        #expect(ZodiakSpacing.s48 == 48)
        #expect(ZodiakSpacing.s56 == 56)
    }

    @Test("Tokens de tela (screenPad / screenPadLarge) são positivos")
    func screenPadding() {
        #expect(ZodiakSpacing.screenPad > 0)
        #expect(ZodiakSpacing.screenPadLarge > ZodiakSpacing.screenPad)
    }
}

// MARK: ZodiakRadii

@Suite("ZodiakRadii")
struct ZodiakRadiiTests {
    @Test("Radii formam progressão monotônica xs < s < m < l (excluindo l=pill)")
    func progression() {
        #expect(ZodiakRadii.xs < ZodiakRadii.s)
        #expect(ZodiakRadii.s < ZodiakRadii.m)
        // l = 999 (pill); m < pill por definição
        #expect(ZodiakRadii.m < ZodiakRadii.l)
    }

    @Test("Pill radius é 999pt (per spec)")
    func pillRadius() {
        #expect(ZodiakRadii.l == 999)
    }
}

// MARK: ZodiakSizing

@Suite("ZodiakSizing")
struct ZodiakSizingTests {
    @Test("Button heights: small=38, medium=48, large=56 (per Zodiak PDF)")
    func buttonHeights() {
        #expect(ZodiakSizing.buttonHeightSmall == 38)
        #expect(ZodiakSizing.buttonHeightMedium == 48)
        #expect(ZodiakSizing.buttonHeightLarge == 56)
    }

    @Test("Content max widths (cardMaxWidth ≤ contentMaxWidth)")
    func maxWidths() {
        #expect(ZodiakSizing.cardMaxWidth > 0)
        #expect(ZodiakSizing.contentMaxWidth >= ZodiakSizing.cardMaxWidth)
    }
}

// MARK: ZodiakTypography

@Suite("ZodiakTypographyLegacy")
struct ZodiakTypographyLegacyTests {
    @Test("HeadingSize.pointSize segue spec PDF (32→128)")
    func headingPointSizes() {
        #expect(ZodiakTypography.HeadingSize.large.pointSize == 32)
        #expect(ZodiakTypography.HeadingSize.xLarge.pointSize == 40)
        #expect(ZodiakTypography.HeadingSize.twoXLarge.pointSize == 48)
        #expect(ZodiakTypography.HeadingSize.threeXLarge.pointSize == 56)
        #expect(ZodiakTypography.HeadingSize.fourXLarge.pointSize == 72)
        #expect(ZodiakTypography.HeadingSize.fiveXLarge.pointSize == 96)
        #expect(ZodiakTypography.HeadingSize.sixXLarge.pointSize == 128)
    }

    @Test("HeadingSize.lineHeight é sempre ≥ pointSize")
    func headingLineHeightSane() {
        for size in [
            ZodiakTypography.HeadingSize.twoXSmall,
            .xSmall, .small, .medium, .large,
            .xLarge, .twoXLarge, .threeXLarge,
            .fourXLarge, .fiveXLarge, .sixXLarge
        ] {
            #expect(size.lineHeight >= size.pointSize)
        }
    }

    @Test("BodySize.pointSize: xs=12, s=14, m=16, l=18, xl=24")
    func bodyPointSizes() {
        #expect(ZodiakTypography.BodySize.xs.pointSize == 12)
        #expect(ZodiakTypography.BodySize.s.pointSize == 14)
        #expect(ZodiakTypography.BodySize.m.pointSize == 16)
        #expect(ZodiakTypography.BodySize.l.pointSize == 18)
        #expect(ZodiakTypography.BodySize.xl.pointSize == 24)
    }

    @Test("BodySize.lineHeight é sempre ≥ pointSize")
    func bodyLineHeightSane() {
        for size in [ZodiakTypography.BodySize.xs, .s, .m, .l, .xl] {
            #expect(size.lineHeight >= size.pointSize)
        }
    }

    @Test("Heading factory retorna Font não-nil para todas combinações size×weight")
    func headingFactory() {
        for size in [
            ZodiakTypography.HeadingSize.twoXSmall,
            .small, .medium, .large, .xLarge, .threeXLarge, .sixXLarge
        ] {
            for weight in [ZodiakTypography.HeadingWeight.light, .regular] {
                let font = ZodiakTypography.heading(size, weight: weight)
                #expect(String(describing: font).isEmpty == false)
            }
        }
    }
}

// MARK: ZodiakViewport

@Suite("ZodiakViewport")
struct ZodiakViewportTests {
    @Test("Resolução por largura segue 5 viewports do PDF")
    func resolutionByWidth() {
        #expect(ZodiakViewport.current(for: 320) == .mobile)
        #expect(ZodiakViewport.current(for: 767) == .mobile)
        #expect(ZodiakViewport.current(for: 768) == .tablet)
        #expect(ZodiakViewport.current(for: 991) == .tablet)
        #expect(ZodiakViewport.current(for: 992) == .tabletLarge)
        #expect(ZodiakViewport.current(for: 1279) == .tabletLarge)
        #expect(ZodiakViewport.current(for: 1280) == .desktopSmall)
        #expect(ZodiakViewport.current(for: 1919) == .desktopSmall)
        #expect(ZodiakViewport.current(for: 1920) == .desktopLarge)
        #expect(ZodiakViewport.current(for: 2400) == .desktopLarge)
    }

    @Test("Column counts: mobile=4, tablet*=6, desktop*=12")
    func columnCounts() {
        #expect(ZodiakViewport.mobile.columnCount == 4)
        #expect(ZodiakViewport.tablet.columnCount == 6)
        #expect(ZodiakViewport.tabletLarge.columnCount == 6)
        #expect(ZodiakViewport.desktopSmall.columnCount == 12)
        #expect(ZodiakViewport.desktopLarge.columnCount == 12)
    }

    @Test("Margens crescem monotonicamente do mobile ao desktopLarge")
    func marginsMonotonic() {
        #expect(ZodiakViewport.mobile.margin < ZodiakViewport.tablet.margin)
        #expect(ZodiakViewport.tablet.margin < ZodiakViewport.tabletLarge.margin)
        #expect(ZodiakViewport.tabletLarge.margin < ZodiakViewport.desktopSmall.margin)
        #expect(ZodiakViewport.desktopSmall.margin < ZodiakViewport.desktopLarge.margin)
    }

    @Test("Gutters: mobile=16, tablet/desktopSmall=24, desktopLarge=32")
    func gutters() {
        #expect(ZodiakViewport.mobile.gutter == 16)
        #expect(ZodiakViewport.tablet.gutter == 24)
        #expect(ZodiakViewport.tabletLarge.gutter == 24)
        #expect(ZodiakViewport.desktopSmall.gutter == 24)
        #expect(ZodiakViewport.desktopLarge.gutter == 32)
    }
}

// MARK: ZodiakMediaAction

@Suite("ZodiakMediaAction")
struct ZodiakMediaActionTests {
    @Test("Cobertura mínima das 15 ações Zodiak (play/pause/stop primary, 12 secondary)")
    func coverage() {
        let actions: [ZodiakMediaAction] = [
            .play, .pause, .stop,
            .skipBack, .skipForward,
            .rewind, .forward,
            .forward15s, .back15s,
            .muteOff, .maxVolume, .minVolume,
            .shuffle, .speed("1×"), .close
        ]
        #expect(actions.count == 15)
    }

    @Test("Apenas play/pause/stop são primary (filled hierarchy)")
    func primaryActions() {
        #expect(ZodiakMediaAction.play.isPrimary)
        #expect(ZodiakMediaAction.pause.isPrimary)
        #expect(ZodiakMediaAction.stop.isPrimary)
        #expect(!ZodiakMediaAction.shuffle.isPrimary)
        #expect(!ZodiakMediaAction.close.isPrimary)
    }
}
