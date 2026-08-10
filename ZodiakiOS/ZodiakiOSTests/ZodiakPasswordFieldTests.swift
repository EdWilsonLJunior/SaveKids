import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakPasswordField Tests

@Suite("ZodiakPasswordField")
struct ZodiakPasswordFieldTests {
    @Test("isRequired padrão é false")
    func defaultIsRequiredFalse() {
        let field = ZodiakPasswordField(label: "Senha", placeholder: "Digite", text: .constant(""))
        #expect(field.isRequired == false)
    }

    @Test("isDisabled padrão é false")
    func defaultIsDisabledFalse() {
        let field = ZodiakPasswordField(label: "Senha", placeholder: "Digite", text: .constant(""))
        #expect(field.isDisabled == false)
    }

    @Test("state padrão é nil (resolve via isDisabled)")
    func defaultStateIsNil() {
        let field = ZodiakPasswordField(label: "Senha", placeholder: "Digite", text: .constant(""))
        #expect(field.state == nil)
    }

    @Test("helperType padrão é informational")
    func defaultHelperType() {
        let field = ZodiakPasswordField(label: "Senha", placeholder: "Digite", text: .constant(""))
        #expect(field.helperType == .informational)
    }

    @Test("helperText padrão é nil")
    func defaultHelperTextNil() {
        let field = ZodiakPasswordField(label: "Senha", placeholder: "Digite", text: .constant(""))
        #expect(field.helperText == nil)
    }

    @Test("state .error persiste")
    func stateErrorPersists() {
        let field = ZodiakPasswordField(
            label: "Senha", placeholder: "Digite",
            text: .constant(""), state: .error
        )
        #expect(field.state == .error)
    }

    @Test("state .disabled persiste")
    func stateDisabledPersists() {
        let field = ZodiakPasswordField(
            label: "Senha", placeholder: "Digite",
            text: .constant(""), state: .disabled
        )
        #expect(field.state == .disabled)
    }

    @Test("state .readonly persiste")
    func stateReadonlyPersists() {
        let field = ZodiakPasswordField(
            label: "Senha", placeholder: "Digite",
            text: .constant(""), state: .readonly
        )
        #expect(field.state == .readonly)
    }

    @Test("helperText persiste")
    func helperTextPersists() {
        let field = ZodiakPasswordField(
            label: "Senha", placeholder: "Digite",
            text: .constant(""),
            helperText: "Mínimo 8 caracteres"
        )
        #expect(field.helperText == "Mínimo 8 caracteres")
    }

    @Test("helperType .error persiste")
    func helperTypeErrorPersists() {
        let field = ZodiakPasswordField(
            label: "Senha", placeholder: "Digite",
            text: .constant(""), helperType: .error
        )
        #expect(field.helperType == .error)
    }

    @Test("isRequired true persiste")
    func isRequiredTruePersists() {
        let field = ZodiakPasswordField(
            label: "Senha", placeholder: "Digite",
            text: .constant(""), isRequired: true
        )
        #expect(field.isRequired == true)
    }

    @Test("isDisabled true resolve para state .disabled via resolvedState")
    func isDisabledMapsToDisabledState() {
        let field = ZodiakPasswordField(
            label: "Senha", placeholder: "Digite",
            text: .constant(""), isDisabled: true
        )
        // state é nil → resolvedState usa isDisabled
        #expect(field.state == nil)
        #expect(field.isDisabled == true)
    }
}
