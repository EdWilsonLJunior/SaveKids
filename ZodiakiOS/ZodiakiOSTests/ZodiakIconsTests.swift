import Foundation
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakIconSize Tests

@Suite("ZodiakIconSize")
struct ZodiakIconSizeTests {
    @Test("small = 16pt")
    func smallDimension() {
        #expect(ZodiakIconSize.small.dimension == 16)
    }

    @Test("medium = 24pt")
    func mediumDimension() {
        #expect(ZodiakIconSize.medium.dimension == 24)
    }

    @Test("large = 32pt")
    func largeDimension() {
        #expect(ZodiakIconSize.large.dimension == 32)
    }

    @Test("xLarge = 56pt")
    func xLargeDimension() {
        #expect(ZodiakIconSize.xLarge.dimension == 56)
    }

    @Test("small stroke = 1.0pt")
    func smallStroke() {
        #expect(ZodiakIconSize.small.strokeWidth == 1.0)
    }

    @Test("medium stroke = 1.4pt")
    func mediumStroke() {
        #expect(ZodiakIconSize.medium.strokeWidth == 1.4)
    }
}

// MARK: - ZodiakIcon Tests

@Suite("ZodiakIcon")
struct ZodiakIconTests {
    // MARK: imageName

    @Test("imageName maps rawValue to kebab-case with prefix")
    func imageNameKebab() {
        #expect(ZodiakIcon.addPlus.imageName == "zodiak-icon-add-plus")
    }

    @Test("accessibilityLabel converts underscores to spaces")
    func accessibilityLabelFormat() {
        #expect(ZodiakIcon.arrowLeft.accessibilityLabel == "Arrow Left")
    }

    // MARK: shouldMirrorForRTL — directional icons

    @Test("arrowLeft mirrors for RTL")
    func arrowLeftMirrors() {
        #expect(ZodiakIcon.arrowLeft.shouldMirrorForRTL)
    }

    @Test("arrowRight mirrors for RTL")
    func arrowRightMirrors() {
        #expect(ZodiakIcon.arrowRight.shouldMirrorForRTL)
    }

    @Test("chevronLeft mirrors for RTL")
    func chevronLeftMirrors() {
        #expect(ZodiakIcon.chevronLeft.shouldMirrorForRTL)
    }

    @Test("chevronRight mirrors for RTL")
    func chevronRightMirrors() {
        #expect(ZodiakIcon.chevronRight.shouldMirrorForRTL)
    }

    @Test("chevronFirstPage mirrors for RTL")
    func chevronFirstPageMirrors() {
        #expect(ZodiakIcon.chevronFirstPage.shouldMirrorForRTL)
    }

    @Test("skipBack mirrors for RTL")
    func skipBackMirrors() {
        #expect(ZodiakIcon.skipBack.shouldMirrorForRTL)
    }

    @Test("undo mirrors for RTL")
    func undoMirrors() {
        #expect(ZodiakIcon.undo.shouldMirrorForRTL)
    }

    @Test("redo mirrors for RTL")
    func redoMirrors() {
        #expect(ZodiakIcon.redo.shouldMirrorForRTL)
    }

    // MARK: shouldMirrorForRTL — non-directional icons

    @Test("play does NOT mirror for RTL")
    func playDoesNotMirror() {
        #expect(!ZodiakIcon.play.shouldMirrorForRTL)
    }

    @Test("star does NOT mirror for RTL")
    func starDoesNotMirror() {
        #expect(!ZodiakIcon.star.shouldMirrorForRTL)
    }

    @Test("check does NOT mirror for RTL")
    func checkDoesNotMirror() {
        #expect(!ZodiakIcon.check.shouldMirrorForRTL)
    }

    @Test("user does NOT mirror for RTL")
    func userDoesNotMirror() {
        #expect(!ZodiakIcon.user.shouldMirrorForRTL)
    }

    // MARK: CaseIterable

    @Test("CaseIterable has exactly 281 cases")
    func allCasesCount() {
        #expect(ZodiakIcon.allCases.count == 281)
    }
}
