import Testing
@testable import ZodiakiOS

// MARK: - ZodiakLabelledField Tests

@Suite("ZodiakLabelledField")
struct ZodiakLabelledFieldTests {
    @Test("default state is nil")
    func defaultStateNil() {
        let field = ZodiakLabelledField(
            label: "Name",
            placeholder: "Enter name",
            text: .constant("")
        )
        #expect(field.state == nil)
    }

    @Test("error state is resolved from state param")
    func errorStateFromParam() {
        let field = ZodiakLabelledField(
            label: "Email",
            placeholder: "email",
            text: .constant("bad"),
            state: .error
        )
        #expect(field.effectiveState == .error)
    }

    @Test("normal state resolves to non-error")
    func normalStateNotError() {
        let field = ZodiakLabelledField(
            label: "Name",
            placeholder: "",
            text: .constant(""),
            state: .normal
        )
        #expect(field.effectiveState != .error)
    }

    @Test("nil state with no errorMessage = nil effectiveState")
    func nilStateNoErrorMessage() {
        let field = ZodiakLabelledField(
            label: "Name",
            placeholder: "",
            text: .constant("")
        )
        #expect(field.effectiveState == nil)
    }
}

// MARK: - ZodiakLabelledPasswordField Tests

@Suite("ZodiakLabelledPasswordField")
struct ZodiakLabelledPasswordFieldTests {
    @Test("default state is nil")
    func defaultStateNil() {
        let field = ZodiakLabelledPasswordField(
            label: "Password",
            placeholder: "Enter password",
            text: .constant("")
        )
        #expect(field.state == nil)
    }

    @Test("error state is stored")
    func errorStateStored() {
        let field = ZodiakLabelledPasswordField(
            label: "Password",
            placeholder: "",
            text: .constant(""),
            state: .error
        )
        #expect(field.state == .error)
    }
}

// MARK: - ZodiakLabelledNumericField Tests

@Suite("ZodiakLabelledNumericField")
struct ZodiakLabelledNumericFieldTests {
    @Test("error state resolves from state param")
    func errorStateFromParam() {
        let field = ZodiakLabelledNumericField(
            label: "Value",
            placeholder: "0",
            value: .constant(nil),
            state: .error
        )
        #expect(field.effectiveState == .error)
    }

    @Test("nil state with no errorMessage = nil effectiveState")
    func nilState() {
        let field = ZodiakLabelledNumericField(
            label: "Value",
            placeholder: "0",
            value: .constant(nil)
        )
        #expect(field.effectiveState == nil)
    }
}
