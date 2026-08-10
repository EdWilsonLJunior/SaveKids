import SwiftUI

// MARK: - Zodiak Dropdown
// Fonte: Zodiak Design System – Capgemini | Página "catalog.component_name.dropdown"
// Specs: Size M (height 48pt), States: Default / Filled / Hover / Focus / Error / Disabled
// Pill inferior não — cornerRadius XS (4pt) nos inputs, borda borderPrimary

struct ZodiakDropdown<T: Hashable>: View {
    let label: String
    @Binding var selection: T?
    let options: [(value: T, label: String)]
    var placeholder: String = "shared.action.select"
    var errorMessage: String?
    var isEnabled: Bool = true

    @State private var isOpen = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            // Label
            Text(LocalizedStringKey(label))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(labelColor)
                .accessibilityHidden(true)

            // Trigger button
            Button {
                guard isEnabled else { return }
                withAnimation(reduceMotion ? .easeInOut(duration: 0.1) : .easeInOut(duration: 0.2)) {
                    isOpen.toggle()
                }
            } label: {
                HStack {
                    Group {
                        if let selectedLabel {
                            Text(verbatim: selectedLabel)
                        } else {
                            Text(LocalizedStringKey(placeholder))
                        }
                    }
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(selectedLabel != nil ? ZodiakColors.textPrimary : ZodiakColors.textSecondary)
                    .tracking(ZodiakTypography.BodySize.m.tracking)

                    Spacer()

                    ZodiakIconView(
                        isOpen ? .chevronUp : .chevronDown,
                        size: .small,
                        color: isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled
                    )
                    .zodiakAnimation(.easeInOut(duration: 0.2), value: isOpen)
                }
                .padding(.horizontal, ZodiakSpacing.s16)
                .frame(height: ZodiakSizing.textFieldHeight)
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.xs)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                        .stroke(borderColor, lineWidth: isOpen ? 2 : 1.5)
                )
            }
            .disabled(!isEnabled)
            .accessibilityLabel(Text(LocalizedStringKey(label)))
            .accessibilityValue(Text(LocalizedStringKey(selectedLabel ?? placeholder)))
            .accessibilityHint(isEnabled ? Text("shared.action.tap_to_expand") : Text("shared.state.unavailable"))
            .accessibilityAddTraits(.isButton)
            .zodiakA11yID("dropdown")

            // Inline options list (open state)
            if isOpen {
                VStack(spacing: 0) {
                    ForEach(options, id: \.value) { option in
                        Button {
                            selection = option.value
                            withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.15)) { isOpen = false }
                        } label: {
                            HStack {
                                Text(LocalizedStringKey(option.label))
                                    .font(ZodiakTypography.bodyMedium)
                                    .foregroundColor(ZodiakColors.textPrimary)
                                    .tracking(ZodiakTypography.BodySize.m.tracking)
                                Spacer()
                                if selection == option.value {
                                    ZodiakIconView(.check, size: .small, color: ZodiakColors.actionPrimary)
                                }
                            }
                            .padding(.horizontal, ZodiakSpacing.s16)
                            .frame(height: 44)
                            .background(selection == option.value
                                ? ZodiakColors.actionPrimary.opacity(0.08)
                                : Color.clear)
                        }
                        .accessibilityLabel(Text(LocalizedStringKey(option.label)))
                        .accessibilityAddTraits(selection == option.value ? [.isButton, .isSelected] : .isButton)

                        if option.value != options.last?.value {
                            ZodiakDivider(hierarchy: .secondary)
                                .padding(.horizontal, ZodiakSpacing.s16)
                        }
                    }
                }
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.xs)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                        .stroke(ZodiakColors.borderPrimary, lineWidth: 1.5)
                )
                .zodiakShadow()
                .transition(reduceMotion ? .opacity : .opacity.combined(with: .move(edge: .top)))
            }

            // Error message
            if let errorMessage {
                HStack(spacing: ZodiakSpacing.s4) {
                    Image(ZodiakIcon.octagonWarning.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    Text(LocalizedStringKey(errorMessage))
                        .font(ZodiakTypography.captionLarge)
                }
                .foregroundColor(ZodiakColors.actionWarning)
                .accessibilityLabel(
                    Text("\(String(localized: "shared.a11y.error_prefix")): \(errorMessage)")
                )
            }
        }
    }

    private var selectedLabel: String? {
        options.first { $0.value == selection }?.label
    }

    private var labelColor: Color {
        if !isEnabled { return ZodiakColors.textDisabled }
        if errorMessage != nil { return ZodiakColors.actionWarning }
        return ZodiakColors.textSecondary
    }

    private var borderColor: Color {
        if !isEnabled { return ZodiakColors.actionDisabled }
        if errorMessage != nil { return ZodiakColors.actionWarning }
        if isOpen { return ZodiakColors.actionPrimary }
        return ZodiakColors.borderPrimary
    }
}

// MARK: - Previews

#Preview("Dropdown") {
    @Previewable @State var selected: String?
    @Previewable @State var selectedFilled: String? = "br"

    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakDropdown(
                label: "País",
                selection: $selected,
                options: [
                    ("br", "shared.country.brazil"),
                    ("pt", "shared.country.portugal"),
                    ("fr", "shared.country.france")
                ],
                placeholder: "Selecione um país"
            )
            ZodiakDropdown(
                label: "País (preenchido)",
                selection: $selectedFilled,
                options: [
                    ("br", "shared.country.brazil"),
                    ("pt", "shared.country.portugal"),
                    ("fr", "shared.country.france")
                ]
            )
            ZodiakDropdown(
                label: "Com erro",
                selection: $selected,
                options: [("br", "shared.country.brazil"), ("pt", "shared.country.portugal")],
                errorMessage: "Selecione uma opção"
            )
            ZodiakDropdown(
                label: "catalog.section.disabled",
                selection: $selected,
                options: [("br", "shared.country.brazil")],
                isEnabled: false
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
