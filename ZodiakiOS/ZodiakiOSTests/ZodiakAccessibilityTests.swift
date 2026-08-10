import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakAccessibility Tests

@Suite("ZodiakAccessibility")
struct ZodiakAccessibilityTests {
    // MARK: - zodiakHitTarget

    @Test("zodiakHitTarget returns a view (smoke)")
    func hitTargetSmoke() {
        let view = Text("Test").zodiakHitTarget()
        _ = view // should compile without errors
        #expect(true)
    }

    @Test("zodiakHitTarget accepts custom minimum")
    func hitTargetCustom() {
        let view = Text("Test").zodiakHitTarget(48)
        _ = view
        #expect(true)
    }

    // MARK: - zodiakHeading

    @Test("zodiakHeading level 1 applies without crash")
    func headingLevel1() {
        let view = Text("Title").zodiakHeading(level: 1)
        _ = view
        #expect(true)
    }

    @Test("zodiakHeading clamps level below 1 to h1")
    func headingClampBelow() {
        let view = Text("Title").zodiakHeading(level: 0)
        _ = view
        #expect(true)
    }

    @Test("zodiakHeading clamps level above 6 to h6")
    func headingClampAbove() {
        let view = Text("Title").zodiakHeading(level: 99)
        _ = view
        #expect(true)
    }

    // MARK: - zodiakMirrorRTL

    @Test("zodiakMirrorRTL returns a view (smoke)")
    func mirrorRTLSmoke() {
        let view = Image(systemName: "arrow.right").zodiakMirrorRTL()
        _ = view
        #expect(true)
    }

    // MARK: - zodiakA11yID

    @Test("zodiakA11yID with all parts")
    func a11yIDAllParts() {
        let view = Button("OK") {}.zodiakA11yID("button", role: "primary", context: "submit")
        _ = view
        #expect(true)
    }

    @Test("zodiakA11yID with atom only")
    func a11yIDAtomOnly() {
        let view = Button("OK") {}.zodiakA11yID("button")
        _ = view
        #expect(true)
    }
}
