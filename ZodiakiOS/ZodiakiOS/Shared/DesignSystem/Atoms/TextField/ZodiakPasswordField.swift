import SwiftUI

// MARK: - Zodiak Password Field
// Figma: ZodiakTextField + "Show hide icon" component
// Wraps ZodiakTextFieldImpl with isSecure + eye-toggle trailingContent.
// Reuses ZodiakTextFieldHelperType from ZodiakTextField.swift.

struct ZodiakPasswordField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var helperText: String?
    var helperType: ZodiakTextFieldHelperType = .informational
    var isDisabled: Bool = false
    // New in #45: explicit state override (supersedes isDisabled when set)
    var state: ZodiakFieldState?

    @State private var isVisible: Bool = false

    private var resolvedState: ZodiakFieldState {
        if let state { return state }
        if isDisabled { return .disabled }
        if helperType == .error && helperText != nil { return .error }
        return .normal
    }

    private var effectiveDisabled: Bool {
        resolvedState == .disabled || resolvedState == .readonly
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            // Label
            HStack(spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(label))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(
                        resolvedState == .disabled
                            ? ZodiakColors.textDisabled
                            : ZodiakColors.textPrimary
                    )

                if isRequired {
                    Text("shared.label.required_marker")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textNegative)
                }
            }

            // Input: ZodiakTextFieldImpl with eye-toggle as trailing content
            ZodiakTextFieldImpl(
                text: $text,
                placeholder: placeholder,
                fieldState: resolvedState,
                isSecure: !isVisible,
                autocapitalization: .never,
                trailingContent: AnyView(
                    Button {
                        isVisible.toggle()
                    } label: {
                        ZodiakIconView(
                            isVisible ? .hide : .show,
                            size: .small,
                            color: effectiveDisabled
                                ? ZodiakColors.textDisabled
                                : ZodiakColors.textSecondary
                        )
                        .frame(width: 44, height: ZodiakSizing.textFieldHeight)
                        .contentShape(Rectangle())
                    }
                    .disabled(effectiveDisabled)
                    .accessibilityLabel(
                        isVisible
                            ? Text("shared.action.hide_password")
                            : Text("shared.action.show_password")
                    )
                )
            )
            .accessibilityLabel(Text(LocalizedStringKey(label)))
            .accessibilityHint(
                helperText.map { Text(LocalizedStringKey($0)) }
                    ?? Text(LocalizedStringKey(placeholder))
            )
            .accessibilityAddTraits(resolvedState == .error ? .isStaticText : [])
            .zodiakA11yID("textfield", role: "password")

            // Helper text
            if let helperText {
                HStack(spacing: ZodiakSpacing.s4) {
                    Image(systemName: helperType.icon)
                        .font(.caption2)

                    Text(LocalizedStringKey(helperText))
                        .font(ZodiakTypography.captionLarge)
                }
                .foregroundColor(helperType.color)
                .accessibilityLabel(Text(LocalizedStringKey(helperText)))
            }
        }
        .accessibilityElement(children: .contain)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        ZodiakPasswordField(
            label: "Senha",
            placeholder: "shared.placeholder.password",
            text: .constant("")
        )

        ZodiakPasswordField(
            label: "Confirmar senha",
            placeholder: "Repita a senha",
            text: .constant("senha123"),
            isRequired: true,
            helperText: "Senhas não coincidem",
            helperType: .error,
            state: .error
        )

        ZodiakPasswordField(
            label: "Senha (desabilitada)",
            placeholder: "—",
            text: .constant(""),
            state: .disabled
        )
    }
    .padding()
    .background(ZodiakColors.background)
}
