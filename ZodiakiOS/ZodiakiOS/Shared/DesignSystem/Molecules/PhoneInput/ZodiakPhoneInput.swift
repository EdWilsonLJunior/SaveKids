import SwiftUI

// MARK: - Zodiak Phone Input
// Figma: "Phone input" — phone number field with country code selector
// Dial code prefix: flag emoji + country code (e.g. 🇧🇷 +55)
// On tap of prefix: bottom sheet country picker (Figma: "Building block_phone_country_menu")

// MARK: - Country Model

struct ZodiakPhoneCountry: Identifiable, Hashable {
    let id: String        // ISO country code
    let flag: String      // emoji flag
    let name: String
    let dialCode: String

    static let all: [Self] = [
        .init(id: "BR", flag: "🇧🇷", name: "shared.country.brazil", dialCode: "+55"),
        .init(id: "US", flag: "🇺🇸", name: "shared.country.usa", dialCode: "+1"),
        .init(id: "PT", flag: "🇵🇹", name: "shared.country.portugal", dialCode: "+351"),
        .init(id: "FR", flag: "🇫🇷", name: "shared.country.france", dialCode: "+33"),
        .init(id: "DE", flag: "🇩🇪", name: "shared.country.germany", dialCode: "+49"),
        .init(id: "ES", flag: "🇪🇸", name: "shared.country.spain", dialCode: "+34"),
        .init(id: "IT", flag: "🇮🇹", name: "shared.country.italy", dialCode: "+39"),
        .init(id: "GB", flag: "🇬🇧", name: "shared.country.uk", dialCode: "+44"),
        .init(id: "CA", flag: "🇨🇦", name: "shared.country.canada", dialCode: "+1"),
        .init(id: "AR", flag: "🇦🇷", name: "shared.country.argentina", dialCode: "+54"),
        .init(id: "CL", flag: "🇨🇱", name: "shared.country.chile", dialCode: "+56"),
        .init(id: "MX", flag: "🇲🇽", name: "shared.country.mexico", dialCode: "+52"),
        .init(id: "CO", flag: "🇨🇴", name: "shared.country.colombia", dialCode: "+57"),
        .init(id: "JP", flag: "🇯🇵", name: "shared.country.japan", dialCode: "+81"),
        .init(id: "CN", flag: "🇨🇳", name: "shared.country.china", dialCode: "+86"),
        .init(id: "IN", flag: "🇮🇳", name: "shared.country.india", dialCode: "+91"),
        .init(id: "AU", flag: "🇦🇺", name: "shared.country.australia", dialCode: "+61")
    ]
}

// MARK: - ZodiakPhoneInput

struct ZodiakPhoneInput: View {
    let label: String
    @Binding var phoneNumber: String
    @State var selectedCountry: ZodiakPhoneCountry = ZodiakPhoneCountry.all[0]
    var isRequired: Bool = false
    var helperText: String?
    var helperType: ZodiakTextFieldHelperType = .informational
    var isDisabled: Bool = false

    @FocusState private var isFocused: Bool
    @State private var showCountryPicker = false

    private var borderColor: Color {
        if isDisabled { return ZodiakColors.actionDisabled }
        if helperType == .error, helperText != nil { return ZodiakColors.textNegative }
        if isFocused { return ZodiakColors.actionPrimary }
        return ZodiakColors.borderPrimary
    }

    private var borderWidth: CGFloat {
        (isFocused || (helperType == .error && helperText != nil)) ? 2 : 1
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            // Label
            HStack(spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(label))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(isDisabled ? ZodiakColors.textDisabled : ZodiakColors.textPrimary)
                if isRequired {
                    Text("shared.label.required_marker")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textNegative)
                }
            }

            // Input row
            HStack(spacing: 0) {
                // Country picker button
                Button {
                    showCountryPicker = true
                } label: {
                    HStack(spacing: ZodiakSpacing.s4) {
                        Text(selectedCountry.flag)
                            .font(.system(size: 18))
                        Text(selectedCountry.dialCode)
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(isDisabled ? ZodiakColors.textDisabled : ZodiakColors.textPrimary)
                        ZodiakIconView(.chevronDown, size: .small, color: ZodiakColors.textSecondary)
                    }
                    .padding(.horizontal, ZodiakSpacing.s8)
                    .frame(height: ZodiakSizing.textFieldHeight)
                }
                .disabled(isDisabled)
                .contentShape(Rectangle())

                // Divider
                Rectangle()
                    .fill(borderColor)
                    .frame(width: borderWidth, height: ZodiakSizing.textFieldHeight - ZodiakSpacing.s16)

                // Phone number field
                TextField("shared.placeholder.phone_number", text: $phoneNumber)
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(isDisabled ? ZodiakColors.textDisabled : ZodiakColors.textPrimary)
                    .keyboardType(.phonePad)
                    .focused($isFocused)
                    .disabled(isDisabled)
                    .padding(.horizontal, ZodiakSpacing.s8)
                    .zodiakA11yID("phone-input")
            }
            .frame(height: ZodiakSizing.textFieldHeight)
            .background(isDisabled ? ZodiakColors.actionDisabled.opacity(0.1) : ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.xs)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                    .stroke(borderColor, lineWidth: borderWidth)
            )

            // Helper text
            if let helperText {
                HStack(spacing: ZodiakSpacing.s4) {
                    Image(systemName: helperType.icon).font(.caption2)
                    Text(LocalizedStringKey(helperText)).font(ZodiakTypography.captionLarge)
                }
                .foregroundColor(helperType.color)
            }
        }
        .sheet(isPresented: $showCountryPicker) {
            ZodiakCountryPickerSheet(
                countries: ZodiakPhoneCountry.all,
                selected: $selectedCountry
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Country Picker Sheet
// Figma: "Building block_phone_country_menu" — bottom sheet variant for mobile

private struct ZodiakCountryPickerSheet: View {
    let countries: [ZodiakPhoneCountry]
    @Binding var selected: ZodiakPhoneCountry
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    private var filtered: [ZodiakPhoneCountry] {
        if searchText.isEmpty { return countries }
        return countries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.dialCode.contains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filtered) { country in
                Button {
                    selected = country
                    dismiss()
                } label: {
                    HStack(spacing: ZodiakSpacing.s8) {
                        Text(country.flag).font(.system(size: 24))
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                            Text(LocalizedStringKey(country.name))
                                .font(ZodiakTypography.bodyMedium)
                                .foregroundColor(ZodiakColors.textPrimary)
                            Text(country.dialCode)
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        Spacer()
                        if selected.id == country.id {
                            ZodiakIconView(.check, size: .small, color: ZodiakColors.actionPrimary)
                        }
                    }
                }
                .listRowBackground(ZodiakColors.surface)
            }
            .searchable(text: $searchText, prompt: "shared.placeholder.search_country")
            .navigationTitle("shared.label.country_code")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("shared.action.cancel") { dismiss() }
                        .foregroundColor(ZodiakColors.actionPrimary)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        ZodiakPhoneInput(label: "Telefone", phoneNumber: .constant(""))
        ZodiakPhoneInput(
            label: "Celular",
            phoneNumber: .constant("11 99999-8888"),
            isRequired: true
        )
        ZodiakPhoneInput(
            label: "Telefone (erro)",
            phoneNumber: .constant("11 9"),
            helperText: "Número inválido",
            helperType: .error
        )
    }
    .padding()
    .background(ZodiakColors.background)
}
