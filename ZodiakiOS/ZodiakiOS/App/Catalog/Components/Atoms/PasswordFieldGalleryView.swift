import SwiftUI

// MARK: - Password Field Gallery View
// Figma: ZodiakTextField + "Show hide icon"

struct PasswordFieldGalleryView: View {
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var selectedHelper: ZodiakTextFieldHelperType = .informational
    @State private var helperText = ""
    @State private var isDisabled = false

    private var confirmHelper: (String, ZodiakTextFieldHelperType)? {
        guard !confirmPassword.isEmpty else { return nil }
        if confirmPassword == password { return ("Senhas coincidem", .success) }
        return ("catalog.passfield.error.mismatch", .error)
    }

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.password_field",
                subtitle: "catalog.password_field.subtitle",
                figmaRef: "Show hide icon"
            )

            // MARK: Live playground
            gallerySectionCard(title: "catalog.section.playground") {
                    ZodiakPasswordField(
                        label: "Senha",
                        placeholder: "shared.placeholder.min_password_chars",
                        text: $password,
                        isRequired: true,
                        helperText: helperText.isEmpty ? nil : helperText,
                        helperType: selectedHelper,
                        isDisabled: isDisabled
                    )

                    ZodiakPasswordField(
                        label: "Confirmar senha",
                        placeholder: "shared.placeholder.repeat_password",
                        text: $confirmPassword,
                        isRequired: true,
                        helperText: confirmHelper?.0,
                        helperType: confirmHelper?.1 ?? .informational,
                        isDisabled: isDisabled
                    )

                    Picker("catalog.spec.helper_state", selection: $selectedHelper) {
                        Text("catalog.spec.label_info").tag(ZodiakTextFieldHelperType.informational)
                        Text("catalog.spec.label_warning").tag(ZodiakTextFieldHelperType.warning)
                        Text("catalog.spec.label_error").tag(ZodiakTextFieldHelperType.error)
                        Text("catalog.spec.label_success").tag(ZodiakTextFieldHelperType.success)
                    }.pickerStyle(.segmented)

                    TextField("catalog.spec.helper_optional", text: $helperText)
                        .font(ZodiakTypography.bodySmall)
                        .padding(ZodiakSpacing.s4)
                        .background(ZodiakColors.surfaceSmoke)
                        .cornerRadius(ZodiakRadii.xs)

                    Toggle("catalog.section.disabled", isOn: $isDisabled)
                        .tint(ZodiakColors.actionPrimary)
                        .font(ZodiakTypography.bodySmall)
            }

            // MARK: All states
            gallerySectionCard(title: "catalog.section.todos_os_estados") {
                    ZodiakPasswordField(
                        label: "catalog.section.default",
                        placeholder: "catalog.section.without_helper",
                        text: .constant(""))
                    ZodiakPasswordField(label: "Com valor", placeholder: "—", text: .constant("senha123"))
                    ZodiakPasswordField(
                        label: "Informacional",
                        placeholder: "—",
                        text: .constant(""),
                        helperText: "catalog.passfield.hint.strong",
                        helperType: .informational
                    )
                    ZodiakPasswordField(
                        label: "shared.state.warning_label",
                        placeholder: "—",
                        text: .constant("abc"),
                        helperText: "catalog.passfield.hint.weak",
                        helperType: .warning
                    )
                    ZodiakPasswordField(
                        label: "shared.state.error_label",
                        placeholder: "—",
                        text: .constant("abc"),
                        helperText: "Senha muito curta",
                        helperType: .error
                    )
                    ZodiakPasswordField(
                        label: "shared.state.success_label",
                        placeholder: "—",
                        text: .constant("Senha@2024"),
                        helperText: "Senha forte!",
                        helperType: .success
                    )
                    ZodiakPasswordField(
                        label: "catalog.section.disabled",
                        placeholder: "—",
                        text: .constant(""),
                        isDisabled: true)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.base",
                        value: "catalog.spec.val.zodiaktextfield_securefield",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.toggle_icon",
                        value: "catalog.spec.val.eye_eyeslash_sf_symbols",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.altura",
                        value: "catalog.spec.val.48pt_textfieldheight",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.helper_states",
                        value: "catalog.spec.val.informational_warning_error_success",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component.password_field")
    }
}

#Preview { NavigationStack { PasswordFieldGalleryView() } }
