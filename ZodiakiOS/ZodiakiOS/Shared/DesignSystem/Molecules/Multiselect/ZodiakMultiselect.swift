import SwiftUI

// MARK: - Zodiak Multiselect
// Figma: "catalog.component_name.multiselect"
// Implementação com resumo em chips + lista expansível com checkboxes.

struct ZodiakMultiselect: View {
    let label: String
    let options: [String]
    @Binding var selections: Set<String>
    var placeholder: String = "shared.placeholder.select_options"
    var isEnabled: Bool = true
    var errorMessage: String?

    @State private var isOpen = false

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(LocalizedStringKey(label))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(labelColor)

            Button {
                guard isEnabled else { return }
                withAnimation(.easeInOut(duration: 0.18)) { isOpen.toggle() }
            } label: {
                HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
                    if selections.isEmpty {
                        Text(LocalizedStringKey(placeholder))
                            .font(ZodiakTypography.bodyMedium)
                            .foregroundColor(ZodiakColors.textSecondary)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: ZodiakSpacing.s4) {
                                ForEach(Array(selections).sorted(), id: \.self) { item in
                                    ZodiakChip(verbatim: item, isActive: true)
                                }
                            }
                        }
                    }

                    Spacer(minLength: 0)

                    ZodiakIconView(
                        isOpen ? .chevronUp : .chevronDown,
                        size: .small,
                        color: isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled
                    )
                }
                .padding(.horizontal, ZodiakSpacing.s16)
                .frame(minHeight: ZodiakSizing.textFieldHeight)
                .padding(.vertical, selections.isEmpty ? 0 : ZodiakSpacing.s4)
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.xs)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                        .stroke(borderColor, lineWidth: isOpen ? 2 : 1.5)
                )
            }
            .buttonStyle(.plain)
            .disabled(!isEnabled)
            .zodiakA11yID("multiselect")

            if isOpen {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        ZodiakCheckbox(
                            label: option,
                            isChecked: Binding(
                                get: { selections.contains(option) },
                                set: { checked in
                                    if checked { selections.insert(option) } else { selections.remove(option) }
                                }
                            ),
                            size: .large,
                            isEnabled: isEnabled
                        )
                        .padding(.horizontal, ZodiakSpacing.s16)
                        .padding(.vertical, ZodiakSpacing.s4)

                        if option != options.last {
                            ZodiakDivider(hierarchy: .secondary)
                                .padding(.horizontal, ZodiakSpacing.s16)
                        }
                    }
                }
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.xs)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                        .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
                )
                .transition(.opacity.combined(with: .move(edge: .top)))
            }

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
            }
        }
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

#Preview("Multiselect") {
    @Previewable @State var selections: Set<String> = ["Design", "SwiftUI"]

    return ScrollView {
        VStack(spacing: ZodiakSpacing.s32) {
            ZodiakMultiselect(
                label: "Competências",
                options: ["Design", "SwiftUI", "iOS", "catalog.section.accessibility", "Pesquisa"],
                selections: $selections
            )

            ZodiakMultiselect(
                label: "Com erro",
                options: ["A", "B", "C"],
                selections: $selections,
                errorMessage: "Selecione ao menos uma opção"
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
