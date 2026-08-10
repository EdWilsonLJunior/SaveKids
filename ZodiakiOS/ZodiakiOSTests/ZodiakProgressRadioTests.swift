import Testing
@testable import ZodiakiOS

// MARK: - ZodiakProgressKind Tests

@Suite("ZodiakProgressKind")
struct ZodiakProgressKindTests {
    @Test("linear kind creates ZodiakProgressIndicator with linear kind")
    func linearKind() {
        let indicator = ZodiakProgressIndicator(value: 0.5, kind: .linear)
        if case .linear = indicator.kind {
            #expect(true)
        } else {
            Issue.record("Expected .linear kind")
        }
    }

    @Test("circular kind creates ZodiakProgressIndicator with circular kind")
    func circularKind() {
        let indicator = ZodiakProgressIndicator(value: 0.5, kind: .circular)
        if case .circular = indicator.kind {
            #expect(true)
        } else {
            Issue.record("Expected .circular kind")
        }
    }
}

// MARK: - ZodiakProgressIndicator Tests

@Suite("ZodiakProgressIndicator")
struct ZodiakProgressIndicatorTests {
    @Test("value is clamped to 0-1 range (above 1)")
    func valueClampedAbove() {
        let indicator = ZodiakProgressIndicator(value: 1.5)
        #expect(indicator.value == 1.0)
    }

    @Test("value is clamped to 0-1 range (below 0)")
    func valueClampedBelow() {
        let indicator = ZodiakProgressIndicator(value: -0.5)
        #expect(indicator.value == 0.0)
    }

    @Test("nil value represents indeterminate state")
    func nilValueIsIndeterminate() {
        let indicator = ZodiakProgressIndicator(value: nil)
        #expect(indicator.value == nil)
    }

    @Test("default kind is linear")
    func defaultKindIsLinear() {
        let indicator = ZodiakProgressIndicator(value: 0.5)
        if case .linear = indicator.kind {
            #expect(true)
        } else {
            Issue.record("Expected .linear default kind")
        }
    }
}

// MARK: - ZodiakRadioState Tests

@Suite("ZodiakRadioState")
struct ZodiakRadioStateTests {
    @Test("normal state allows selection")
    func normalStateAllowsSelection() {
        var tapped = false
        let button = ZodiakRadioButton(
            label: "Test",
            isSelected: false,
            state: .normal
        ) { tapped = true }
        #expect(button.effectiveIsDisabled == false)
        _ = tapped // suppress warning
    }

    @Test("disabled state prevents selection")
    func disabledStatePreventsSelection() {
        let button = ZodiakRadioButton(
            label: "Test",
            isSelected: false,
            state: .disabled
        ) {}
        #expect(button.effectiveIsDisabled == true)
    }

    @Test("nil state falls back to isDisabled default (false)")
    func nilStateFallsBackToDefault() {
        let button = ZodiakRadioButton(
            label: "Test",
            isSelected: false
        ) {}
        #expect(button.effectiveIsDisabled == false)
    }
}

// MARK: - ZodiakRadioSize Tests

@Suite("ZodiakRadioSize")
struct ZodiakRadioSizeTests {
    @Test("small outer diameter = 18pt")
    func smallOuterDiameter() {
        #expect(ZodiakRadioSize.small.outerDiameter == 18)
    }

    @Test("large outer diameter = 24pt")
    func largeOuterDiameter() {
        #expect(ZodiakRadioSize.large.outerDiameter == 24)
    }
}
