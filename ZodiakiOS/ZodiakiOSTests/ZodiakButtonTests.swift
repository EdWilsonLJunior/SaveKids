import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakSurface Tests

@Suite("ZodiakSurface")
struct ZodiakSurfaceTests {
    @Test("todos os casos existem")
    func allCasesExist() {
        let surfaces: [ZodiakSurface] = [.onLite, .onHeavy, .onPhoto]
        #expect(surfaces.count == 3)
    }

    @Test("onLite é o padrão em ZodiakButtonPrimary")
    func primaryDefaultSurface() {
        let btn = ZodiakButtonPrimary(title: "Test", action: {})
        #expect(btn.surface == .onLite)
    }

    @Test("onLite é o padrão em ZodiakButtonSecondary")
    func secondaryDefaultSurface() {
        let btn = ZodiakButtonSecondary(title: "Test", action: {})
        #expect(btn.surface == .onLite)
    }
}

// MARK: - ZodiakButtonVariant Tests

@Suite("ZodiakButtonVariant")
struct ZodiakButtonVariantTests {
    @Test("todos os variantes existem")
    func allVariantsExist() {
        let variants: [ZodiakButtonVariant] = [.primary, .secondary, .tertiary, .ghost]
        #expect(variants.count == 4)
    }
}

// MARK: - ZodiakButtonPrimary Tests

@Suite("ZodiakButtonPrimary")
struct ZodiakButtonPrimaryTests {
    @Test("tamanho padrão é medium")
    func defaultSizeMedium() {
        let btn = ZodiakButtonPrimary(title: "Test", action: {})
        #expect(btn.size == .medium)
    }

    @Test("isLoading padrão é false")
    func defaultLoadingFalse() {
        let btn = ZodiakButtonPrimary(title: "Test", action: {})
        #expect(btn.isLoading == false)
    }

    @Test("isEnabled padrão é true")
    func defaultEnabledTrue() {
        let btn = ZodiakButtonPrimary(title: "Test", action: {})
        #expect(btn.isEnabled == true)
    }

    @Test("surface onHeavy persiste")
    func heavySurfacePersists() {
        let btn = ZodiakButtonPrimary(title: "Test", action: {}, surface: .onHeavy)
        #expect(btn.surface == .onHeavy)
    }

    @Test("isLoading true persiste")
    func loadingStatePersists() {
        let btn = ZodiakButtonPrimary(title: "Test", action: {}, isLoading: true)
        #expect(btn.isLoading == true)
    }
}

// MARK: - ZodiakButtonSecondary Tests

@Suite("ZodiakButtonSecondary")
struct ZodiakButtonSecondaryTests {
    @Test("tamanho padrão é medium")
    func defaultSizeMedium() {
        let btn = ZodiakButtonSecondary(title: "Test", action: {})
        #expect(btn.size == .medium)
    }

    @Test("isLoading padrão é false")
    func defaultLoadingFalse() {
        let btn = ZodiakButtonSecondary(title: "Test", action: {})
        #expect(btn.isLoading == false)
    }
}

// MARK: - ZodiakButtonGhost Tests

@Suite("ZodiakButtonGhost")
struct ZodiakButtonGhostTests {
    @Test("tamanho padrão é medium")
    func defaultSizeMedium() {
        let btn = ZodiakButtonGhost(title: "Test", action: {})
        #expect(btn.size == .medium)
    }

    @Test("isEnabled padrão é true")
    func defaultEnabledTrue() {
        let btn = ZodiakButtonGhost(title: "Test", action: {})
        #expect(btn.isEnabled == true)
    }

    @Test("isLoading padrão é false")
    func defaultLoadingFalse() {
        let btn = ZodiakButtonGhost(title: "Test", action: {})
        #expect(btn.isLoading == false)
    }
}

// MARK: - ZodiakButtonSize Tests

@Suite("ZodiakButtonSize")
struct ZodiakButtonSizeTests {
    @Test("small height é buttonHeightSmall")
    func smallHeight() {
        #expect(ZodiakButtonSize.small.height == ZodiakSizing.buttonHeightSmall)
    }

    @Test("medium height é buttonHeightMedium")
    func mediumHeight() {
        #expect(ZodiakButtonSize.medium.height == ZodiakSizing.buttonHeightMedium)
    }

    @Test("large height é buttonHeightLarge")
    func largeHeight() {
        #expect(ZodiakButtonSize.large.height == ZodiakSizing.buttonHeightLarge)
    }
}
