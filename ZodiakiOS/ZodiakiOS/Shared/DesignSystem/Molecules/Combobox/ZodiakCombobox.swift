import SwiftUI

// MARK: - Zodiak Combobox
// Figma: "catalog.component_name.combobox"
// Implementação adaptada para iOS/iPadOS com busca inline, lista expansível e seleção única.

struct ZodiakCombobox<T: Hashable>: View {
    let label: String
    @Binding var selection: T?
    let options: [(value: T, label: String)]
    var placeholder: String = "shared.placeholder.search_or_select"
    var isEnabled: Bool = true
    var errorMessage: String?

    @State private var query = ""
    @State private var isOpen = false
    @FocusState private var isFocused: Bool

    private var filteredOptions: [(value: T, label: String)] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return options }
        return options.filter { $0.label.localizedCaseInsensitiveContains(query) }
    }

    private var selectedLabel: String? {
        options.first { $0.value == selection }?.label
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(LocalizedStringKey(label))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(labelColor)

            VStack(spacing: 0) {
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakIconView(
                        .searchMagnifyingGlass,
                        size: .small,
                        color: isEnabled ? ZodiakColors.textSecondary : ZodiakColors.textDisabled
                    )

                    TextField(
                        LocalizedStringKey(selectedLabel ?? placeholder),
                        text: $query,
                        prompt: Text(LocalizedStringKey(selectedLabel ?? placeholder))
                            .foregroundColor(ZodiakColors.textSecondary)
                    )
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(isEnabled ? ZodiakColors.textPrimary : ZodiakColors.textDisabled)
                    .disabled(!isEnabled)
                    .focused($isFocused)
                    .onTapGesture {
                        guard isEnabled else { return }
                        withAnimation(.easeInOut(duration: 0.18)) { isOpen = true }
                    }
                    .onChange(of: query) { _, _ in
                        guard isEnabled else { return }
                        withAnimation(.easeInOut(duration: 0.18)) { isOpen = true }
                    }
                    .zodiakA11yID("combobox")

                    if !query.isEmpty {
                        Button {
                            query = ""
                            selection = nil
                            withAnimation(.easeInOut(duration: 0.18)) { isOpen = false }
                        } label: {
                            ZodiakIconView(.close, size: .small, color: ZodiakColors.textSecondary)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(Text("shared.action.clear"))
                    } else {
                        Button {
                            guard isEnabled else { return }
                            withAnimation(.easeInOut(duration: 0.18)) { isOpen.toggle() }
                        } label: {
                            ZodiakIconView(
                                isOpen ? .chevronUp : .chevronDown,
                                size: .small,
                                color: isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, ZodiakSpacing.s16)
                .frame(height: ZodiakSizing.textFieldHeight)
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.xs)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                        .stroke(borderColor, lineWidth: isOpen || isFocused ? 2 : 1.5)
                )

                if isOpen {
                    VStack(spacing: 0) {
                        if filteredOptions.isEmpty {
                            Text("shared.state.no_results")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, ZodiakSpacing.s16)
                                .padding(.vertical, ZodiakSpacing.s8)
                        } else {
                            ForEach(filteredOptions, id: \.value) { option in
                                Button {
                                    selection = option.value
                                    query = option.label
                                    withAnimation(.easeInOut(duration: 0.18)) { isOpen = false }
                                    isFocused = false
                                } label: {
                                    HStack {
                                        Text(LocalizedStringKey(option.label))
                                            .font(ZodiakTypography.bodyMedium)
                                            .foregroundColor(ZodiakColors.textPrimary)
                                        Spacer(minLength: 0)
                                        if selection == option.value {
                                            ZodiakIconView(.check, size: .small, color: ZodiakColors.actionPrimary)
                                        }
                                    }
                                    .padding(.horizontal, ZodiakSpacing.s16)
                                    .frame(height: 44)
                                }
                                .buttonStyle(.plain)

                                if option.value != filteredOptions.last?.value {
                                    ZodiakDivider(hierarchy: .secondary)
                                        .padding(.horizontal, ZodiakSpacing.s16)
                                }
                            }
                        }
                    }
                    .background(ZodiakColors.surface)
                    .cornerRadius(ZodiakRadii.xs)
                    .overlay(
                        RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                            .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
                    )
                    .padding(.top, ZodiakSpacing.s4)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
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
        .onAppear {
            if query.isEmpty, let selectedLabel {
                query = selectedLabel
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
        if isOpen || isFocused { return ZodiakColors.actionPrimary }
        return ZodiakColors.borderPrimary
    }
}

#Preview("Combobox") {
    @Previewable @State var country: String? = "br"

    return ScrollView {
        VStack(spacing: ZodiakSpacing.s32) {
            ZodiakCombobox(
                label: "País",
                selection: $country,
                options: [
                    ("br", "shared.country.brazil"),
                    ("pt", "shared.country.portugal"),
                    ("fr", "shared.country.france"),
                    ("de", "shared.country.germany")
                ]
            )

            ZodiakCombobox(
                label: "Com erro",
                selection: $country,
                options: [("br", "shared.country.brazil"), ("pt", "shared.country.portugal")],
                errorMessage: "Escolha um país"
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
