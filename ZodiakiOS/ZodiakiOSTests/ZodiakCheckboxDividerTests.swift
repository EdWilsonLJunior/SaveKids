import Testing
@testable import ZodiakiOS

// MARK: - ZodiakCheckboxState Tests

@Suite("ZodiakCheckboxState")
struct ZodiakCheckboxStateTests {
    @Test("normal state allows toggle")
    func normalStateAllowsToggle() {
        var checked = false
        let checkbox = ZodiakCheckbox(
            label: "Test",
            isChecked: .init(get: { checked }, set: { checked = $0 }),
            state: .normal
        )
        #expect(checkbox.effectiveIsEnabled == true)
        #expect(checkbox.effectiveIsError == false)
    }

    @Test("disabled state prevents toggle")
    func disabledStatePreventsToggle() {
        var checked = false
        let checkbox = ZodiakCheckbox(
            label: "Test",
            isChecked: .init(get: { checked }, set: { checked = $0 }),
            state: .disabled
        )
        #expect(checkbox.effectiveIsEnabled == false)
    }

    @Test("error state shows error")
    func errorStateShowsError() {
        var checked = false
        let checkbox = ZodiakCheckbox(
            label: "Test",
            isChecked: .init(get: { checked }, set: { checked = $0 }),
            state: .error
        )
        #expect(checkbox.effectiveIsError == true)
        #expect(checkbox.effectiveIsEnabled == true)
    }

    @Test("nil state falls back to isEnabled/isError defaults")
    func nilStateFallsBackToDefaults() {
        var checked = false
        let checkbox = ZodiakCheckbox(
            label: "Test",
            isChecked: .init(get: { checked }, set: { checked = $0 })
        )
        #expect(checkbox.effectiveIsEnabled == true)
        #expect(checkbox.effectiveIsError == false)
    }
}

// MARK: - ZodiakCheckboxSize Tests

@Suite("ZodiakCheckboxSize")
struct ZodiakCheckboxSizeTests {
    @Test("small box = 18pt")
    func smallBox() {
        #expect(ZodiakCheckboxSize.small.boxSize == 18)
    }

    @Test("large box = 24pt")
    func largeBox() {
        #expect(ZodiakCheckboxSize.large.boxSize == 24)
    }
}

// MARK: - ZodiakDividerOrientation Tests

@Suite("ZodiakDividerOrientation")
struct ZodiakDividerOrientationTests {
    @Test("default orientation is horizontal")
    func defaultIsHorizontal() {
        let divider = ZodiakDivider()
        if case .horizontal = divider.orientation {
            #expect(true)
        } else {
            Issue.record("Expected horizontal orientation")
        }
    }
}

// MARK: - ZodiakDividerStyle Tests

@Suite("ZodiakDividerStyle")
struct ZodiakDividerStyleTests {
    @Test("thin lineWidth = 1")
    func thinLine() {
        #expect(ZodiakDividerStyle.thin.lineWidth == 1)
    }

    @Test("thick lineWidth = 2")
    func thickLine() {
        #expect(ZodiakDividerStyle.thick.lineWidth == 2)
    }
}

// MARK: - ZodiakDividerInset Tests

@Suite("ZodiakDividerInset")
struct ZodiakDividerInsetTests {
    @Test("default inset is none")
    func defaultIsNone() {
        let divider = ZodiakDivider()
        if case .none = divider.inset {
            #expect(true)
        } else {
            Issue.record("Expected .none inset")
        }
    }
}
