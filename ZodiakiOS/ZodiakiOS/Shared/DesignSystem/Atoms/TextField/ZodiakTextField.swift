import SwiftUI

// MARK: - ZodiakFieldState
// External state override. Focus is tracked internally by ZodiakTextFieldImpl.

enum ZodiakFieldState {
    case normal
    case disabled
    case error
    case readonly
}

// MARK: - ZodiakTextFieldHelperType
// Unchanged — types the helper text for semantic coloring

enum ZodiakTextFieldHelperType {
    case informational, warning, error, success

    var icon: String {
        switch self {
        case .informational: return "info.circle"
        case .warning:       return "exclamationmark.triangle"
        case .error:         return "xmark.circle"
        case .success:       return "checkmark.circle"
        }
    }

    var color: Color {
        switch self {
        case .informational: return ZodiakColors.textSecondary
        case .warning:       return ZodiakColors.actionWarning
        case .error:         return ZodiakColors.textNegative
        case .success:       return ZodiakColors.textPositive
        }
    }
}

// MARK: - ZodiakTextFieldImpl
// Figma: "Text input" inner container — border + background + icons + field
// Building block consumed by ZodiakTextField, ZodiakPasswordField, ZodiakSearchField, ZodiakPhoneInput.
// Does NOT include label or helper text — those belong to the parent wrapper.

struct ZodiakTextFieldImpl: View {
    @Binding var text: String
    let placeholder: String
    var fieldState: ZodiakFieldState = .normal
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    var submitLabel: SubmitLabel = .done
    var maxLength: Int?
    var leadingIcon: String?
    var trailingContent: AnyView?
    var onSubmit: (() -> Void)?

    @FocusState private var isFocused: Bool

    private var effectiveDisabled: Bool {
        fieldState == .disabled || fieldState == .readonly
    }

    private var borderColor: Color {
        switch fieldState {
        case .disabled:
            return ZodiakColors.actionDisabled
        case .error:
            return ZodiakColors.textNegative
        case .readonly:
            return ZodiakColors.borderPrimary
        case .normal:
            return isFocused ? ZodiakColors.actionPrimary : ZodiakColors.borderPrimary
        }
    }

    private var borderWidth: CGFloat {
        (isFocused || fieldState == .error) ? 2 : 1
    }

    private var inputBackground: Color {
        switch fieldState {
        case .disabled:
            return ZodiakColors.actionDisabled.opacity(0.1)
        case .readonly:
            return ZodiakColors.actionDisabled.opacity(0.05)
        default:
            return ZodiakColors.surface
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            if let icon = leadingIcon {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(
                        fieldState == .disabled ? ZodiakColors.textDisabled : ZodiakColors.textSecondary
                    )
                    .padding(.leading, ZodiakSpacing.s4)
                    .padding(.trailing, ZodiakSpacing.s4)
            }

            Group {
                if isSecure {
                    SecureField(LocalizedStringKey(placeholder), text: $text)
                } else {
                    TextField(LocalizedStringKey(placeholder), text: $text)
                }
            }
            .font(ZodiakTypography.bodyMedium)
            .foregroundColor(
                fieldState == .disabled ? ZodiakColors.textDisabled : ZodiakColors.textPrimary
            )
            .keyboardType(keyboardType)
            .textInputAutocapitalization(autocapitalization)
            .autocorrectionDisabled()
            .focused($isFocused)
            .disabled(effectiveDisabled)
            .submitLabel(submitLabel)
            .onSubmit { onSubmit?() }
            .onChange(of: text) { _, newValue in
                if let max = maxLength, newValue.count > max {
                    text = String(newValue.prefix(max))
                }
            }
            .padding(.leading, leadingIcon == nil ? ZodiakSpacing.s4 : 0)
            .padding(.trailing, trailingContent == nil ? ZodiakSpacing.s4 : 0)

            if let trailing = trailingContent {
                trailing
            }
        }
        .frame(minHeight: ZodiakSizing.textFieldHeight)
        .background(inputBackground)
        .cornerRadius(ZodiakRadii.xs)
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }
}

// MARK: - ZodiakTextField
// Figma: "Text input" full component — label + impl + helper/counter
//
// New in #52: state, leadingIcon, trailingContent, isSecure, submitLabel,
//             autocapitalization, maxLength (backwards-compatible additions).

struct ZodiakTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isRequired: Bool = false
    var helperText: LocalizedStringKey?
    var helperType: ZodiakTextFieldHelperType = .informational
    var isDisabled: Bool = false
    var isLoading: Bool = false
    var onSubmit: (() -> Void)?

    // New params (#52):
    var state: ZodiakFieldState?
    var leadingIcon: String?
    var trailingContent: AnyView?
    var isSecure: Bool = false
    var submitLabel: SubmitLabel = .done
    var autocapitalization: TextInputAutocapitalization = .never
    var maxLength: Int?

    private var resolvedState: ZodiakFieldState {
        if let state { return state }
        if isDisabled { return .disabled }
        if helperType == .error && helperText != nil { return .error }
        return .normal
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            // Label row
            HStack(spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(label))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(
                        resolvedState == .disabled ? ZodiakColors.textDisabled : ZodiakColors.textPrimary
                    )

                if isRequired {
                    Text("shared.label.required_marker")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textNegative)
                }
            }

            // Input container
            if isLoading {
                ZodiakSkeletonRect(
                    height: ZodiakSizing.textFieldHeight,
                    cornerRadius: ZodiakRadii.xs
                )
                .accessibilityLabel(Text(LocalizedStringKey(label)))
                .accessibilityValue(Text("shared.accessibility.loading"))
                .zodiakA11yID("textfield")
            } else {
                ZodiakTextFieldImpl(
                    text: $text,
                    placeholder: placeholder,
                    fieldState: resolvedState,
                    isSecure: isSecure,
                    keyboardType: keyboardType,
                    autocapitalization: autocapitalization,
                    submitLabel: submitLabel,
                    maxLength: maxLength,
                    leadingIcon: leadingIcon,
                    trailingContent: trailingContent,
                    onSubmit: onSubmit
                )
                .accessibilityLabel(Text(LocalizedStringKey(label)))
                .accessibilityHint(helperText.map { Text($0) } ?? Text(LocalizedStringKey(placeholder)))
                .accessibilityAddTraits(resolvedState == .error ? .isStaticText : [])
                .zodiakA11yID("textfield")
            }

            // Helper + optional character counter
            let showHelper = !isLoading && (helperText != nil || maxLength != nil)
            if showHelper {
                HStack(alignment: .top) {
                    if let helper = helperText {
                        HStack(spacing: ZodiakSpacing.s4) {
                            Image(systemName: helperType.icon)
                                .font(.system(size: 12))

                            ZodiakText(helper, style: .caption())
                        }
                        .foregroundColor(helperType.color)
                        .accessibilityLabel(Text(helper))
                    }

                    if let max = maxLength {
                        Spacer()
                        ZodiakText(
                            verbatim: "\(min(text.count, max))/\(max)",
                            style: .caption()
                        ).foregroundColor(
                            text.count >= max ? ZodiakColors.textNegative : ZodiakColors.textSecondary
                        ).accessibilityHidden(true)
                    }
                }
            }
        }
    }
}

// MARK: - ZodiakNumericField
// Campo numérico Zodiak com label, estados e helper text tipado

struct ZodiakNumericField: View {
    let label: String
    let placeholder: String
    @Binding var value: Double?
    var minimum: Double = 0
    var maximum: Double?
    var isRequired: Bool = false
    var helperText: LocalizedStringKey?
    var helperType: ZodiakTextFieldHelperType = .informational
    var isDisabled: Bool = false
    var onSubmit: (() -> Void)?

    @State private var displayText: String = ""
    @State private var isInitialized = false

    private var fieldState: ZodiakFieldState {
        if isDisabled { return .disabled }
        if helperType == .error && helperText != nil { return .error }
        return .normal
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            HStack(spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(label))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(isDisabled ? ZodiakColors.textDisabled : ZodiakColors.textPrimary)

                if isRequired {
                    Text("shared.label.required_marker")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textNegative)
                }
            }

            ZodiakTextFieldImpl(
                text: Binding(
                    get: { displayText },
                    set: { newValue in
                        let cleaned = newValue.replacingOccurrences(of: ",", with: ".")

                        if let parsed = Double(cleaned) {
                            let clamped = maximum.map { min(parsed, $0) } ?? parsed
                            let floored = max(clamped, minimum)
                            value = floored
                            displayText = newValue
                        } else if newValue.isEmpty || newValue == "-" {
                            value = nil
                            displayText = newValue
                        }
                    }
                ),
                placeholder: placeholder,
                fieldState: fieldState,
                keyboardType: .decimalPad,
                autocapitalization: .never,
                submitLabel: .done,
                onSubmit: onSubmit
            )
            .accessibilityLabel(Text(LocalizedStringKey(label)))
            .accessibilityValue(
                value.map { Text(verbatim: String(format: "%.1f", $0)) }
                    ?? Text("shared.accessibility.empty")
            )
            .zodiakA11yID("textfield")
            .onAppear {
                guard !isInitialized else { return }
                isInitialized = true

                if let val = value {
                    displayText = String(format: "%.1f", val)
                }
            }

            if let helper = helperText {
                HStack(spacing: ZodiakSpacing.s4) {
                    Image(systemName: helperType.icon)
                        .font(.system(size: 12))

                    ZodiakText(helper, style: .caption())
                }
                .foregroundColor(helperType.color)
                .accessibilityLabel(Text(helper))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        ZodiakTextField(
            label: "Nome completo",
            placeholder: "shared.placeholder.name",
            text: .constant(""),
            isRequired: true
        )

        ZodiakTextField(
            label: "E-mail",
            placeholder: "exemplo@email.com",
            text: .constant("email-invalido"),
            helperText: "Formato de e-mail inválido",
            helperType: .error,
            state: .error,
            leadingIcon: "envelope"
        )

        ZodiakTextField(
            label: "Bio",
            placeholder: "Escreva algo",
            text: .constant(""),
            maxLength: 100
        )

        ZodiakTextField(
            label: "Endereço",
            placeholder: "Rua...",
            text: .constant(""),
            isLoading: true
        )

        ZodiakNumericField(
            label: "Nota",
            placeholder: "0 – 10",
            value: .constant(7.5),
            isRequired: true,
            helperText: "Nota válida",
            helperType: .success
        )
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
