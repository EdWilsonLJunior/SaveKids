import SwiftUI

// MARK: - Phone Input Gallery View
// Figma: "Phone input"

struct PhoneInputGalleryView: View {
    @State private var phone1 = ""
    @State private var phone2 = "11 99999-8888"
    @State private var phone3 = "9"

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.phone_field",
                subtitle: "catalog.phone_input.subtitle",
                figmaRef: "Phone input"
            )

            // MARK: Live demos
            gallerySectionCard(title: "catalog.section.exemplos_interativos") {
                    Text("catalog.phoneinput.desc_0")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    ZodiakPhoneInput(label: "Telefone", phoneNumber: $phone1)

                    ZodiakPhoneInput(
                        label: "Celular",
                        phoneNumber: $phone2,
                        isRequired: true
                    )

                    ZodiakPhoneInput(
                        label: "catalog.phoneinput.demo.invalid_label",
                        phoneNumber: $phone3,
                        helperText: "catalog.phoneinput.error.invalid",
                        helperType: .error
                    )
            }

            // MARK: Países suportados
            // swiftlint:disable:next line_length
            gallerySectionCard(title: LocalizedStringKey(String(format: String(localized: "shared.format.available_countries"), ZodiakPhoneCountry.all.count))) {
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        spacing: ZodiakSpacing.s4
                    ) {
                        ForEach(ZodiakPhoneCountry.all) { country in
                            HStack(spacing: ZodiakSpacing.s4) {
                                Text(country.flag).font(.system(size: 16))
                                Text(country.dialCode)
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(ZodiakColors.textSecondary)
                                Spacer()
                                Text(country.name)
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(ZodiakColors.textPrimary)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 2)
                        }
                    }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.prefixo",
                        value: "catalog.spec.val.flag_emoji_dial_code_eg_55",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.seletor",
                        value: "catalog.spec.val.bottom_sheet_com_busca_searchable",
                        style: .spec()
                    )

                    ZodiakInfoRow("catalog.spec.lbl.teclado", value: "catalog.spec.val.phonepad", style: .spec())

                    ZodiakInfoRow("catalog.spec.lbl.default", value: "catalog.spec.val.brasil_55", style: .spec())

                    ZodiakInfoRow(
                        "catalog.spec.lbl.helper_states",
                        value: "catalog.spec.val.informational_warning_error_success",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component.phone_field")
    }
}

#Preview { NavigationStack { PhoneInputGalleryView() } }
