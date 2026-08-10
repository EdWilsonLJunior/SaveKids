import SwiftUI

// MARK: - Multiselect Gallery View

struct MultiselectGalleryView: View {
    @State private var selectedTab = 0
    @State private var selectedTopics: Set<String> = ["Design", "iOS"]
    @State private var selectedTags: Set<String> = []
    @State private var selectedError: Set<String> = []

    private let topics = ["Design", "iOS", "Android", "Backend", "DevOps", "Data Science", "AI/ML", "UX Research"]
    private let tags = [
        NSLocalizedString("catalog.multiselect.tag.urgent", comment: ""),
        NSLocalizedString("catalog.multiselect.tag.in_progress", comment: ""),
        NSLocalizedString("shared.state.review", comment: ""),
        NSLocalizedString("shared.state.completed", comment: ""),
        NSLocalizedString("catalog.multiselect.tag.blocked", comment: "")
    ]

    private let tabs = ["catalog.tab.demo", "catalog.tab.variants", "catalog.tab.specs"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.multiselect",
                subtitle: "catalog.multiselect.subtitle",
                figmaRef: "catalog.component_name.multiselect"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component_name.multiselect")
    }
}

// MARK: - Demo Tab

private extension MultiselectGalleryView {
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakText("catalog.multiselect.desc_0", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)

            ZodiakMultiselect(
                label: "catalog.multiselect.label_areas",
                options: topics,
                selections: $selectedTopics
            )

            if !selectedTopics.isEmpty {
                ZodiakText(
                    verbatim: String(
                        format: NSLocalizedString("shared.format.multi_select_count", comment: ""),
                        selectedTopics.count
                    ),
                    style: .caption(color: .secondary)
                )
                ZodiakButtonSecondary(title: "shared.action.clear_all") {
                    selectedTopics = []
                }
            }
        }
    }
}

// MARK: - Variants Tab

private extension MultiselectGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        gallerySectionCard(title: "catalog.section.selecao_multipla") {
            ZodiakMultiselect(
                label: "catalog.multiselect.label_areas",
                options: topics,
                selections: $selectedTopics
            )
        }

        gallerySectionCard(title: "catalog.section.estado_vazio") {
            ZodiakMultiselect(
                label: "catalog.multiselect.label_tags",
                options: tags,
                selections: $selectedTags,
                placeholder: "shared.action.select"
            )
        }

        gallerySectionCard(title: "catalog.section.estados") {
            ZodiakText("catalog.section.estado_de_erro", style: .caption(color: .secondary))
            ZodiakMultiselect(
                label: "catalog.multiselect.label_areas",
                options: topics,
                selections: $selectedError,
                errorMessage: NSLocalizedString("catalog.multiselect.error_min_one", comment: "")
            )

            ZodiakDivider(hierarchy: .secondary)

            ZodiakText("catalog.section.disabled", style: .caption(color: .secondary))
            ZodiakMultiselect(
                label: "catalog.multiselect.label_areas",
                options: topics,
                selections: .constant(["Design", "iOS"]),
                isEnabled: false
            )
        }
    }
}

// MARK: - Specs Tab

private extension MultiselectGalleryView {
    @ViewBuilder
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.componente",
                value: "catalog.spec.val.zodiakmultiselect",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.parametros",
                value: "catalog.spec.val.label_options_selections_placeholder_ise",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.chips",
                value: "catalog.spec.val.zodiakchip_no_header_quando_ha_selecao",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.checkboxes",
                value: "catalog.spec.val.zodiakcheckbox_inline_na_lista_expandida",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.zodiak_ds",
                value: "catalog.spec.val.input_multiselect",
                style: .spec()
            )
        }
    }
}

#Preview {
    NavigationStack {
        MultiselectGalleryView()
    }
}
