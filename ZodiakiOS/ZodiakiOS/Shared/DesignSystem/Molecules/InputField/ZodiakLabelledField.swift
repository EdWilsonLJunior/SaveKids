import SwiftUI

// MARK: - ZodiakLabelledField

/// Campo de texto com label, suporte a `ZodiakFieldState`, loading e mensagem de helper.
///
/// ## Usage
/// ```swift
/// ZodiakLabelledField(
///     label: "Email",
///     placeholder: "email@example.com",
///     text: $email,
///     state: .error,
///     helperText: "E-mail inválido"
/// )
/// ```
struct ZodiakLabelledField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isRequired: Bool = false

    /// Preferred way to set field state. When provided, `errorMessage` is ignored.
    var state: ZodiakFieldState?

    /// Helper/error text displayed below the field.
    var helperText: LocalizedStringKey?

    /// Shows loading state in the underlying text field.
    var isLoading: Bool = false

    /// Deprecated: use `state: .error` + `helperText` instead.
    @available(*, deprecated, message: "Use state: .error + helperText instead.")
    var errorMessage: LocalizedStringKey?

    var onSubmit: (() -> Void)?

    // MARK: - Resolved helpers

    private var effectiveState: ZodiakFieldState? {
        if let state {
            return state
        }

        if errorMessage != nil {
            return .error
        }

        return nil
    }

    private var effectiveHelperText: LocalizedStringKey? {
        helperText ?? errorMessage
    }

    var body: some View {
        ZodiakTextField(
            label: label,
            placeholder: placeholder,
            text: $text,
            keyboardType: keyboardType,
            isRequired: isRequired,
            isLoading: isLoading,
            onSubmit: onSubmit
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(LocalizedStringKey(label)))
        .accessibilityValue(text.isEmpty ? Text("shared.accessibility.empty") : Text(verbatim: text))
    }
}

// MARK: - ZodiakLabelledPasswordField

/// Campo de senha com label e suporte a `ZodiakFieldState`.
struct ZodiakLabelledPasswordField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var state: ZodiakFieldState?
    var helperText: LocalizedStringKey?
    var onSubmit: (() -> Void)?

    var body: some View {
        ZodiakPasswordField(
            label: label,
            placeholder: placeholder,
            text: $text,
            isRequired: isRequired,
            state: state
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(LocalizedStringKey(label)))
        .accessibilityValue(text.isEmpty ? Text("shared.accessibility.empty") : Text(verbatim: String(repeating: "•", count: text.count)))
    }
}

// MARK: - ZodiakLabelledNumericField

/// Campo numérico com label e suporte a erro.
struct ZodiakLabelledNumericField: View {
    let label: String
    let placeholder: String
    @Binding var value: Double?
    var minimum: Double = 0
    var maximum: Double?
    var isRequired: Bool = false
    var state: ZodiakFieldState?
    var helperText: LocalizedStringKey?

    /// Deprecated: use `state: .error` + `helperText` instead.
    @available(*, deprecated, message: "Use state: .error + helperText instead.")
    var errorMessage: LocalizedStringKey?

    var onSubmit: (() -> Void)?

    // MARK: - Resolved helpers

    private var effectiveState: ZodiakFieldState? {
        if let state {
            return state
        }

        if errorMessage != nil {
            return .error
        }

        return nil
    }

    private var effectiveHelperText: LocalizedStringKey? {
        helperText ?? errorMessage
    }

    var body: some View {
        ZodiakNumericField(
            label: label,
            placeholder: placeholder,
            value: $value,
            minimum: minimum,
            maximum: maximum,
            isRequired: isRequired,
            helperText: effectiveHelperText,
            helperType: effectiveState == .error ? .error : .informational,
            onSubmit: onSubmit
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(LocalizedStringKey(label)))
        .accessibilityValue(
            value.map { Text(verbatim: String(format: "%.1f", $0)) }
                ?? Text("shared.accessibility.empty")
        )
    }
}

// MARK: - ZodiakLabelledCheckbox

/// Checkbox com label.
struct ZodiakLabelledCheckbox: View {
    let label: String
    @Binding var isChecked: Bool

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakIconView(
                isChecked ? .checkboxCheck : .checkboxUnchecked,
                size: .medium,
                color: isChecked ? ZodiakColors.actionPrimary : ZodiakColors.borderPrimary
            )

            ZodiakText(label, style: .body())
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isChecked.toggle()
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text(LocalizedStringKey(label)))
        .accessibilityValue(isChecked ? Text("shared.accessibility.checked") : Text("shared.accessibility.unchecked"))
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        ZodiakLabelledField(
            label: "shared.label.name",
            placeholder: "shared.placeholder.name",
            text: .constant(""),
            state: .normal
        )

        ZodiakLabelledField(
            label: "E-mail",
            placeholder: "email@example.com",
            text: .constant("bad-email"),
            state: .error,
            helperText: "E-mail inválido"
        )

        ZodiakLabelledField(
            label: "Carregando",
            placeholder: "Aguarde",
            text: .constant(""),
            isLoading: true
        )

        ZodiakLabelledPasswordField(
            label: "Senha",
            placeholder: "Digite sua senha",
            text: .constant("")
        )

        ZodiakLabelledNumericField(
            label: "Nota",
            placeholder: "0 – 10",
            value: .constant(nil),
            state: .error,
            helperText: "catalog.text_field.required_state"
        )

        ZodiakLabelledCheckbox(
            label: "shared.label.accept_terms",
            isChecked: .constant(true)
        )
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
