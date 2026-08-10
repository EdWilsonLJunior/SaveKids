import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakFieldState Tests

@Suite("ZodiakFieldState")
struct ZodiakFieldStateTests {
    @Test("4 casos existem (normal disabled error readonly)")
    func allCasesExist() {
        let states: [ZodiakFieldState] = [.normal, .disabled, .error, .readonly]
        #expect(states.count == 4)
    }
}

// MARK: - ZodiakTextFieldHelperType Tests

@Suite("ZodiakTextFieldHelperType")
struct ZodiakTextFieldHelperTypeTests {
    @Test("4 casos existem")
    func allCasesExist() {
        let types: [ZodiakTextFieldHelperType] = [.informational, .warning, .error, .success]
        #expect(types.count == 4)
    }

    @Test("informational usa info.circle")
    func informationalIcon() {
        #expect(ZodiakTextFieldHelperType.informational.icon == "info.circle")
    }

    @Test("error usa xmark.circle")
    func errorIcon() {
        #expect(ZodiakTextFieldHelperType.error.icon == "xmark.circle")
    }

    @Test("warning usa exclamationmark.triangle")
    func warningIcon() {
        #expect(ZodiakTextFieldHelperType.warning.icon == "exclamationmark.triangle")
    }

    @Test("success usa checkmark.circle")
    func successIcon() {
        #expect(ZodiakTextFieldHelperType.success.icon == "checkmark.circle")
    }
}

// MARK: - ZodiakTextFieldImpl Tests

@Suite("ZodiakTextFieldImpl")
struct ZodiakTextFieldImplTests {
    @Test("fieldState padrão é normal")
    func defaultFieldStateIsNormal() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "Placeholder")
        #expect(impl.fieldState == .normal)
    }

    @Test("isSecure padrão é false")
    func defaultIsSecureFalse() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "Placeholder")
        #expect(impl.isSecure == false)
    }

    @Test("maxLength padrão é nil")
    func defaultMaxLengthIsNil() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "Placeholder")
        #expect(impl.maxLength == nil)
    }

    @Test("leadingIcon padrão é nil")
    func defaultLeadingIconIsNil() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "Placeholder")
        #expect(impl.leadingIcon == nil)
    }

    @Test("isSecure true persiste")
    func isSecurePersists() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "Placeholder", isSecure: true)
        #expect(impl.isSecure == true)
    }

    @Test("maxLength persiste")
    func maxLengthPersists() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "Placeholder", maxLength: 50)
        #expect(impl.maxLength == 50)
    }

    @Test("leadingIcon persiste")
    func leadingIconPersists() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "Placeholder", leadingIcon: "envelope")
        #expect(impl.leadingIcon == "envelope")
    }

    @Test("estado disabled persiste")
    func disabledStatePersists() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "P", fieldState: .disabled)
        #expect(impl.fieldState == .disabled)
    }

    @Test("estado error persiste")
    func errorStatePersists() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "P", fieldState: .error)
        #expect(impl.fieldState == .error)
    }

    @Test("estado readonly persiste")
    func readonlyStatePersists() {
        let impl = ZodiakTextFieldImpl(text: .constant(""), placeholder: "P", fieldState: .readonly)
        #expect(impl.fieldState == .readonly)
    }
}

// MARK: - ZodiakTextField Tests

@Suite("ZodiakTextField")
struct ZodiakTextFieldTests {
    @Test("isDisabled padrão é false")
    func defaultIsDisabledFalse() {
        let field = ZodiakTextField(label: "Nome", placeholder: "Digite", text: .constant(""))
        #expect(field.isDisabled == false)
    }

    @Test("isRequired padrão é false")
    func defaultIsRequiredFalse() {
        let field = ZodiakTextField(label: "Nome", placeholder: "Digite", text: .constant(""))
        #expect(field.isRequired == false)
    }

    @Test("state padrão é nil (resolve via isDisabled)")
    func defaultStateIsNil() {
        let field = ZodiakTextField(label: "Nome", placeholder: "Digite", text: .constant(""))
        #expect(field.state == nil)
    }

    @Test("maxLength padrão é nil")
    func defaultMaxLengthNil() {
        let field = ZodiakTextField(label: "Nome", placeholder: "Digite", text: .constant(""))
        #expect(field.maxLength == nil)
    }

    @Test("isSecure padrão é false")
    func defaultIsSecureFalse() {
        let field = ZodiakTextField(label: "Senha", placeholder: "Digite", text: .constant(""))
        #expect(field.isSecure == false)
    }

    @Test("helperType padrão é informational")
    func defaultHelperType() {
        let field = ZodiakTextField(label: "Nome", placeholder: "Digite", text: .constant(""))
        #expect(field.helperType == .informational)
    }

    @Test("state .error persiste")
    func stateErrorPersists() {
        let field = ZodiakTextField(
            label: "E-mail", placeholder: "Digite", text: .constant(""), state: .error
        )
        #expect(field.state == .error)
    }

    @Test("leadingIcon persiste")
    func leadingIconPersists() {
        let field = ZodiakTextField(
            label: "E-mail", placeholder: "Digite", text: .constant(""),
            leadingIcon: "envelope"
        )
        #expect(field.leadingIcon == "envelope")
    }
}
