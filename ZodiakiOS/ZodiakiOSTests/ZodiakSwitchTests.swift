import Testing
@testable import ZodiakiOS

// MARK: - ZodiakSwitch Tests

@Suite("ZodiakSwitch")
struct ZodiakSwitchTests {
    @Test("state defaults to nil")
    func defaultStateNil() {
        let view = ZodiakSwitch(label: "Toggle", isOn: .constant(false))
        #expect(view.state == nil)
    }

    @Test("effectiveIsEnabled true when state is normal")
    func enabledWhenNormal() {
        let view = ZodiakSwitch(label: "Toggle", isOn: .constant(false), state: .normal)
        #expect(view.effectiveIsEnabled == true)
    }

    @Test("effectiveIsEnabled false when state is disabled")
    func disabledWhenDisabled() {
        let view = ZodiakSwitch(label: "Toggle", isOn: .constant(false), state: .disabled)
        #expect(view.effectiveIsEnabled == false)
    }

    @Test("effectiveIsEnabled falls back to isEnabled when state is nil — true")
    func fallbackEnabledTrue() {
        var view = ZodiakSwitch(label: "Toggle", isOn: .constant(false))
        view.isEnabled = true
        #expect(view.effectiveIsEnabled == true)
    }

    @Test("effectiveIsEnabled falls back to isEnabled when state is nil — false")
    func fallbackEnabledFalse() {
        var view = ZodiakSwitch(label: "Toggle", isOn: .constant(false))
        view.isEnabled = false
        #expect(view.effectiveIsEnabled == false)
    }

    @Test("state param takes precedence over isEnabled")
    func statePrecedence() {
        var view = ZodiakSwitch(label: "Toggle", isOn: .constant(false), state: .normal)
        view.isEnabled = false
        // state: .normal wins → enabled
        #expect(view.effectiveIsEnabled == true)
    }

    @Test("labelPlacement defaults to leading")
    func defaultPlacement() {
        let view = ZodiakSwitch(label: "Toggle", isOn: .constant(true))
        #expect(view.labelPlacement == .leading)
    }

    @Test("ZodiakSwitchState values are normal and disabled")
    func stateValues() {
        let normal = ZodiakSwitchState.normal
        let disabled = ZodiakSwitchState.disabled
        #expect(normal != disabled)
    }
}
