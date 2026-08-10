import SwiftUI

// MARK: - Zodiak Checkbox
// Fonte: Zodiak Design System – Capgemini | Página "catalog.component_name.checkbox"
// Specs: Size S (16pt box), Size L (20pt box)
// States: Default, Hover, Focus, Error, Disabled
// Types: Default (unchecked), Selected (checked), Indeterminate (dash)

// MARK: - Types & State

/// Combined interaction state for a Zodiak checkbox.
enum ZodiakCheckboxState {
    /// Normal interactive state.
    case normal

    /// Input is disabled and cannot be toggled.
    case disabled

    /// Validation has failed; renders the error border colour.
    case error
}

enum ZodiakCheckboxSize {
    case small, large

    /// Small: 18×18px, Large: 24×24px — per Zodiak spec
    var boxSize: CGFloat { self == .small ? 18 : 24 }

    var labelFont: Font {
        self == .small ? ZodiakTypography.bodySmall : ZodiakTypography.bodyMedium
    }
}

enum ZodiakCheckboxType {
    case unchecked, checked, indeterminate
}

// MARK: - ZodiakCheckbox (single)

struct ZodiakCheckbox: View {
    let label: String?
    @Binding var isChecked: Bool
    var isIndeterminate: Bool = false
    var size: ZodiakCheckboxSize = .large

    /// Preferred way to set checkbox state. When provided, `isEnabled` and `isError` are ignored.
    var state: ZodiakCheckboxState?

    /// Deprecated: use `state: .disabled` instead.
    @available(*, deprecated, renamed: "state")
    var isEnabled: Bool = true

    /// Deprecated: use `state: .error` instead.
    @available(*, deprecated, renamed: "state")
    var isError: Bool = false

    // MARK: - Resolved state helpers

    private var effectiveIsEnabled: Bool {
        if let state {
            return state != .disabled
        }

        return isEnabled
    }

    private var effectiveIsError: Bool {
        if let state {
            return state == .error
        }

        return isError
    }

    var body: some View {
        Button {
            guard effectiveIsEnabled else { return }
            isChecked.toggle()
        } label: {
            HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
                boxView

                if let label {
                    Text(LocalizedStringKey(label))
                        .font(size.labelFont)
                        .foregroundColor(effectiveIsEnabled ? ZodiakColors.textPrimary : ZodiakColors.textDisabled)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .disabled(!effectiveIsEnabled)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label.map { Text(verbatim: $0) } ?? Text("catalog.component_name.checkbox"))
        .accessibilityValue(
            isIndeterminate
                ? Text("shared.accessibility.indeterminate")
                : isChecked
                    ? Text("shared.accessibility.selected")
                    : Text("shared.accessibility.not_selected")
        )
        .accessibilityAddTraits(isChecked ? [.isButton, .isSelected] : .isButton)
        .accessibilityHint(effectiveIsEnabled ? Text(verbatim: "") : Text("shared.state.unavailable"))
        .zodiakA11yID("checkbox")
    }

    @ViewBuilder
    private var boxView: some View {
        let boxSize = size.boxSize

        ZStack {
            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                .fill(boxFill)
                .frame(width: boxSize, height: boxSize)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                        .stroke(boxBorder, lineWidth: (isChecked || isIndeterminate) ? 0 : 1.5)
                )

            if isIndeterminate {
                Image(systemName: "minus")
                    .font(.system(size: boxSize * 0.6, weight: .bold))
                    .foregroundColor(ZodiakColors.textInverse)
            } else if isChecked {
                Image(systemName: "checkmark")
                    .font(.system(size: boxSize * 0.6, weight: .bold))
                    .foregroundColor(ZodiakColors.textInverse)
            }
        }
        .frame(width: boxSize, height: boxSize)
    }

    private var boxFill: Color {
        if !effectiveIsEnabled {
            return ZodiakColors.actionDisabled
        }

        return (isChecked || isIndeterminate) ? ZodiakColors.actionPrimary : Color.clear
    }

    private var boxBorder: Color {
        if !effectiveIsEnabled {
            return ZodiakColors.actionDisabled
        }

        if effectiveIsError {
            return ZodiakColors.actionWarning
        }

        return ZodiakColors.actionPrimary
    }
}

// MARK: - ZodiakCheckboxGroup
// Figma: "catalog.component_name.checkbox" COMPONENT_SET — Amount up to 10, Headline optional

struct ZodiakCheckboxGroup: View {
    let headline: String?
    @Binding var selections: Set<String>
    let options: [String]
    var size: ZodiakCheckboxSize = .large
    var isEnabled: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            if let headline {
                Text(LocalizedStringKey(headline))
                    .font(ZodiakTypography.labelLarge)
                    .foregroundColor(ZodiakColors.textPrimary)
                    .padding(.bottom, ZodiakSpacing.s8)
            }

            ForEach(options, id: \.self) { option in
                ZodiakCheckbox(
                    label: option,
                    isChecked: Binding(
                        get: {
                            selections.contains(option)
                        },
                        set: { checked in
                            if checked {
                                selections.insert(option)
                            } else {
                                selections.remove(option)
                            }
                        }
                    ),
                    size: size,
                    state: isEnabled ? .normal : .disabled
                )
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(headline ?? "Grupo de checkboxes")
    }
}

// MARK: - Previews

#Preview("Checkbox") {
    @Previewable @State var checked = false
    @Previewable @State var selections: Set<String> = ["Opção 1"]

    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
            ZodiakText("catalog.component_name.checkbox", style: .title2)

            ZodiakCheckbox(label: "Item selecionado", isChecked: .constant(true))
            ZodiakCheckbox(label: "Item não selecionado", isChecked: .constant(false))
            ZodiakCheckbox(label: "catalog.section.disabled", isChecked: .constant(false), state: .disabled)
            ZodiakCheckbox(label: "shared.state.error_label", isChecked: .constant(false), state: .error)
            ZodiakCheckbox(label: "Small checked", isChecked: .constant(true), size: .small)

            Divider()

            ZodiakCheckboxGroup(
                headline: "Selecione as opções",
                selections: $selections,
                options: ["Opção 1", "Opção 2", "Opção 3"]
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
