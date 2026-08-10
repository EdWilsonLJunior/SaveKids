import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakIconButtonShape Tests

@Suite("ZodiakIconButtonShape")
struct ZodiakIconButtonShapeTests {
    @Test("todos os casos existem")
    func allCasesExist() {
        let shapes: [ZodiakIconButtonShape] = [.circle, .roundedSquare]
        #expect(shapes.count == 2)
    }

    @Test("padrão em ZodiakIconButtonPrimary é circle")
    func defaultShapeIsCircle() {
        let btn = ZodiakIconButtonPrimary(icon: "heart.fill", action: {}, accessibilityLabel: "Curtir")
        #expect(btn.shape == .circle)
    }
}

// MARK: - ZodiakIconButtonStyle Tests

@Suite("ZodiakIconButtonStyle")
struct ZodiakIconButtonStyleTests {
    @Test("4 casos existem (primary secondary tertiary ghost)")
    func allCasesExist() {
        let styles: [ZodiakIconButtonStyle] = [.primary, .secondary, .tertiary, .ghost]
        #expect(styles.count == 4)
    }
}

// MARK: - ZodiakIconButtonPrimary Tests

@Suite("ZodiakIconButtonPrimary")
struct ZodiakIconButtonPrimaryTests {
    @Test("size padrão é medium")
    func defaultSizeMedium() {
        let btn = ZodiakIconButtonPrimary(icon: "plus", action: {}, accessibilityLabel: "Adicionar")
        #expect(btn.size == .medium)
    }

    @Test("isLoading padrão é false")
    func defaultLoadingFalse() {
        let btn = ZodiakIconButtonPrimary(icon: "plus", action: {}, accessibilityLabel: "Adicionar")
        #expect(btn.isLoading == false)
    }

    @Test("isEnabled padrão é true")
    func defaultEnabledTrue() {
        let btn = ZodiakIconButtonPrimary(icon: "plus", action: {}, accessibilityLabel: "Adicionar")
        #expect(btn.isEnabled == true)
    }

    @Test("context padrão é onLite")
    func defaultContextOnLite() {
        let btn = ZodiakIconButtonPrimary(icon: "plus", action: {}, accessibilityLabel: "Adicionar")
        #expect(btn.context == .onLite)
    }

    @Test("isLoading true persiste")
    func loadingStatePersists() {
        let btn = ZodiakIconButtonPrimary(icon: "plus", action: {}, isLoading: true, accessibilityLabel: "Adicionar")
        #expect(btn.isLoading == true)
    }
}

// MARK: - ZodiakIconButtonSecondary Tests

@Suite("ZodiakIconButtonSecondary")
struct ZodiakIconButtonSecondaryTests {
    @Test("size padrão é medium")
    func defaultSizeMedium() {
        let btn = ZodiakIconButtonSecondary(icon: "heart", action: {}, accessibilityLabel: "Favoritar")
        #expect(btn.size == .medium)
    }
}

// MARK: - ZodiakIconButtonTertiary Tests

@Suite("ZodiakIconButtonTertiary")
struct ZodiakIconButtonTertiaryTests {
    @Test("isLoading padrão é false")
    func defaultLoadingFalse() {
        let btn = ZodiakIconButtonTertiary(icon: "xmark", action: {}, accessibilityLabel: "Fechar")
        #expect(btn.isLoading == false)
    }
}

// MARK: - ZodiakIconButtonGhost Tests

@Suite("ZodiakIconButtonGhost")
struct ZodiakIconButtonGhostTests {
    @Test("size padrão é medium")
    func defaultSizeMedium() {
        let btn = ZodiakIconButtonGhost(icon: "ellipsis", action: {}, accessibilityLabel: "Mais opções")
        #expect(btn.size == .medium)
    }

    @Test("shape roundedSquare persiste")
    func roundedSquarePersists() {
        let btn = ZodiakIconButtonGhost(
            icon: "ellipsis", action: {},
            shape: .roundedSquare,
            accessibilityLabel: "Mais opções"
        )
        #expect(btn.shape == .roundedSquare)
    }
}

// MARK: - ZodiakIconButtonSize Tests

@Suite("ZodiakIconButtonSize")
struct ZodiakIconButtonSizeTests {
    @Test("small diameter é buttonHeightSmall")
    func smallDiameter() {
        #expect(ZodiakIconButtonSize.small.diameter == ZodiakSizing.buttonHeightSmall)
    }

    @Test("medium diameter é buttonHeightMedium")
    func mediumDiameter() {
        #expect(ZodiakIconButtonSize.medium.diameter == ZodiakSizing.buttonHeightMedium)
    }

    @Test("large diameter é buttonHeightLarge")
    func largeDiameter() {
        #expect(ZodiakIconButtonSize.large.diameter == ZodiakSizing.buttonHeightLarge)
    }
}
