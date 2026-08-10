import SwiftUI

// MARK: - Combobox Gallery View

struct ComboboxGalleryView: View {
    // MARK: - State

    @State private var selectedTab = 0
    @State private var selectedCountry: String?
    @State private var selectedTech: String?
    @State private var selectedShort: String?

    // MARK: - Data

    private var countryOptions: [(value: String, label: String)] {
        [
            ("de", NSLocalizedString("shared.country.germany", comment: "")),
            ("ar", NSLocalizedString("shared.country.argentina", comment: "")),
            ("au", NSLocalizedString("shared.country.australia", comment: "")),
            ("br", NSLocalizedString("shared.country.brazil", comment: "")),
            ("ca", NSLocalizedString("shared.country.canada", comment: "")),
            ("cl", NSLocalizedString("shared.country.chile", comment: "")),
            ("cn", NSLocalizedString("shared.country.china", comment: "")),
            ("co", NSLocalizedString("shared.country.colombia", comment: "")),
            ("fr", NSLocalizedString("shared.country.france", comment: "")),
            ("in", NSLocalizedString("shared.country.india", comment: "")),
            ("it", NSLocalizedString("shared.country.italy", comment: "")),
            ("jp", NSLocalizedString("shared.country.japan", comment: "")),
            ("mx", NSLocalizedString("shared.country.mexico", comment: "")),
            ("pt", NSLocalizedString("shared.country.portugal", comment: "")),
            ("es", NSLocalizedString("shared.country.spain", comment: "")),
            ("gb", NSLocalizedString("shared.country.uk", comment: "")),
            ("us", NSLocalizedString("shared.country.usa", comment: ""))
        ]
    }

    private let techOptions: [(value: String, label: String)] =
        ["Swift", "Kotlin", "React", "Angular", "Vue", "Python", "Go"]
            .map { (value: $0, label: $0) }

    private let tabs = ["catalog.tab.demo", "catalog.tab.variants", "catalog.tab.specs"]

    // MARK: - Body

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.combobox",
                subtitle: "catalog.combobox.subtitle",
                figmaRef: "catalog.component_name.combobox"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component_name.combobox")
    }
}

// MARK: - Demo Tab

private extension ComboboxGalleryView {
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakText("catalog.combobox.desc_0", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)

            ZodiakCombobox(
                label: "catalog.combobox.label_country",
                selection: $selectedCountry,
                options: countryOptions,
                placeholder: "shared.placeholder.search_country"
            )

            if let code = selectedCountry,
               let name = countryOptions.first(where: { $0.value == code })?.label {
                ZodiakText(
                    verbatim: String(
                        format: NSLocalizedString("shared.format.selected", comment: ""),
                        name
                    ),
                    style: .caption(color: .secondary)
                )
            }

            if selectedCountry != nil {
                ZodiakButtonSecondary(title: "shared.action.reset") {
                    selectedCountry = nil
                }
            }
        }
    }
}

// MARK: - Variants Tab

private extension ComboboxGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            ZodiakText("catalog.section.enabled", style: .caption(color: .secondary))
            ZodiakCombobox(
                label: "catalog.combobox.label_tech",
                selection: $selectedTech,
                options: techOptions,
                placeholder: "shared.action.select"
            )

            ZodiakDivider(hierarchy: .secondary)

            ZodiakText("catalog.section.estado_de_erro", style: .caption(color: .secondary))
            ZodiakCombobox(
                label: "catalog.combobox.label_tech",
                selection: .constant(nil),
                options: techOptions,
                placeholder: "shared.action.select",
                errorMessage: NSLocalizedString("catalog.text_field.required_state", comment: "")
            )

            ZodiakDivider(hierarchy: .secondary)

            ZodiakText("catalog.section.disabled", style: .caption(color: .secondary))
            ZodiakCombobox(
                label: "catalog.combobox.label_tech",
                selection: Binding<String?>.constant("Swift"),
                options: techOptions,
                isEnabled: false
            )
        }

        gallerySectionCard(title: "catalog.combobox.section_long_list") {
            ZodiakText("catalog.combobox.desc_long_list", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakCombobox(
                label: "catalog.combobox.label_country",
                selection: $selectedCountry,
                options: countryOptions,
                placeholder: "shared.placeholder.search_country"
            )
        }

        gallerySectionCard(title: "catalog.combobox.section_short_list") {
            ZodiakText("catalog.combobox.desc_short_list", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakCombobox(
                label: "catalog.combobox.label_tech",
                selection: $selectedShort,
                options: Array(techOptions.prefix(4)),
                placeholder: "shared.action.select"
            )
        }
    }
}

// MARK: - Specs Tab

private extension ComboboxGalleryView {
    @ViewBuilder
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.componente",
                value: "catalog.spec.val.zodiakcomboboxt_hashable",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.parametros",
                value: "catalog.spec.val.label_selection_options_placeholder_isen",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.filtro",
                value: "catalog.spec.val.localizedcaseinsensitivecontains_na_quer",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.estado_vazio",
                value: "catalog.spec.val.nenhum_resultado_inline",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.icone",
                value: "catalog.spec.val.magnifyingglass_leading",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.zodiak_ds",
                value: "catalog.spec.val.input_combobox",
                style: .spec()
            )
        }
    }
}

#Preview {
    NavigationStack {
        ComboboxGalleryView()
    }
}
