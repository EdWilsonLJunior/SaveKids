import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakShadows Tests
// Issue: #18 — DS Foundation: Shadows
// Verifica tokens de sombra (ZodiakShadow struct) e as propriedades
// do namespace legado ZodiakShadows.

@Suite("ZodiakShadows")
struct ZodiakShadowsTests {
    // MARK: - ZodiakShadow struct

    @Test("ZodiakShadow.none has zero radius and clear color")
    func shadowNone() {
        #expect(ZodiakShadow.none.radius == 0)
        #expect(ZodiakShadow.none.x == 0)
        #expect(ZodiakShadow.none.y == 0)
    }

    @Test("ZodiakShadow.capgemini matches Figma spec: x=4, y=0, blur=35")
    func shadowCapgemini() {
        #expect(ZodiakShadow.capgemini.x == 4)
        #expect(ZodiakShadow.capgemini.y == 0)
        #expect(ZodiakShadow.capgemini.radius == 35)
    }

    @Test("ZodiakShadow.default equals .capgemini")
    func shadowDefault() {
        #expect(ZodiakShadow.default == ZodiakShadow.capgemini)
    }

    // MARK: - ZodiakShadows namespace (backward-compat)

    @Test("ZodiakShadows.radius equals capgemini radius")
    func namespacedRadius() {
        #expect(ZodiakShadows.radius == ZodiakShadow.capgemini.radius)
    }

    @Test("ZodiakShadows.x equals capgemini x")
    func namespacedX() {
        #expect(ZodiakShadows.x == ZodiakShadow.capgemini.x)
    }

    @Test("ZodiakShadows.y equals capgemini y")
    func namespacedY() {
        #expect(ZodiakShadows.y == ZodiakShadow.capgemini.y)
    }

    @Test("ZodiakShadows.spread equals Figma documented spread")
    func namespacedSpread() {
        #expect(ZodiakShadows.spread == 3)
    }

    @Test("ZodiakShadows.standard is the capgemini token")
    func namespacedStandard() {
        #expect(ZodiakShadows.standard == ZodiakShadow.capgemini)
    }
}
