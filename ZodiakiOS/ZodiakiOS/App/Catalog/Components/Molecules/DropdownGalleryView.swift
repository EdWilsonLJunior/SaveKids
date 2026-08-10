import SwiftUI

// MARK: - Dropdown Gallery View

struct DropdownGalleryView: View {
    @State private var selectedTab = 0
    @State private var selectedRole: String?
    @State private var selectedPriority: String? = "high"
    @State private var selectedError: String?

    private let roles: [(value: String, label: String)] = [
        ("designer", "Designer"),
        ("developer", "Developer"),
        ("pm", "Product Manager"),
        ("architect", "Architect"),
        ("qa", "QA Engineer")
    ]

    private var priorityOptions: [(value: String, label: String)] {
        [
            ("critical", NSLocalizedString("catalog.dropdown.priority.critical", comment: "")),
            ("high", NSLocalizedString("catalog.dropdown.priority.high", comment: "")),
            ("medium", NSLocalizedString("catalog.dropdown.priority.medium", comment: "")),
            ("low", NSLocalizedString("catalog.dropdown.priority.low", comment: ""))
        ]
    }

    private let tabs = ["catalog.tab.demo", "catalog.tab.variants", "catalog.tab.specs"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.dropdown",
                subtitle: "catalog.dropdown.subtitle",
                figmaRef: "catalog.component_name.dropdown"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component_name.dropdown")
    }
}

// MARK: - Demo Tab

private extension DropdownGalleryView {
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakText("catalog.dropdown.desc_0", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)

            ZodiakDropdown(
                label: "catalog.dropdown.label_role",
                selection: $selectedRole,
                options: roles
            )

            if let code = selectedRole,
               let name = roles.first(where: { $0.value == code })?.label {
                ZodiakText(
                    verbatim: String(
                        format: NSLocalizedString("shared.format.selected", comment: ""),
                        name
                    ),
                    style: .caption(color: .secondary)
                )
            }

            if selectedRole != nil {
                ZodiakButtonSecondary(title: "shared.action.reset") {
                    selectedRole = nil
                }
            }
        }
    }
}

// MARK: - Variants Tab

private extension DropdownGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            ZodiakText("catalog.section.enabled", style: .caption(color: .secondary))
            ZodiakDropdown(
                label: "catalog.dropdown.label_role",
                selection: $selectedRole,
                options: roles
            )

            ZodiakDivider(hierarchy: .secondary)

            ZodiakText("catalog.section.estado_de_erro", style: .caption(color: .secondary))
            ZodiakDropdown(
                label: "catalog.dropdown.label_role",
                selection: $selectedError,
                options: roles,
                errorMessage: NSLocalizedString("catalog.text_field.required_state", comment: "")
            )

            ZodiakDivider(hierarchy: .secondary)

            ZodiakText("catalog.section.disabled", style: .caption(color: .secondary))
            ZodiakDropdown(
                label: "catalog.dropdown.label_role",
                selection: Binding<String?>.constant("designer"),
                options: roles,
                isEnabled: false
            )
        }

        gallerySectionCard(title: "catalog.section.com_valor_pre_selecionado") {
            ZodiakDropdown(
                label: "catalog.dropdown.label_priority",
                selection: $selectedPriority,
                options: priorityOptions
            )
        }
    }
}

// MARK: - Specs Tab

private extension DropdownGalleryView {
    @ViewBuilder
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.componente",
                value: "catalog.spec.val.zodiakdropdownt_hashable",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.parametros",
                value: "catalog.spec.val.label_selection_options_placeholder_erro",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.altura",
                value: "catalog.spec.val.zodiakspacingtextfieldheight_48pt",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.animacao",
                value: "catalog.spec.val.easeinout_02s_no_chevron_e_lista",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.selecao",
                value: "catalog.spec.val.checkmark_trailing_no_item_ativo",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.zodiak_ds",
                value: "catalog.spec.val.input_dropdown",
                style: .spec()
            )
        }
    }
}

#Preview {
    NavigationStack {
        DropdownGalleryView()
    }
}
