import SwiftUI

// MARK: - Chip Group Gallery View
// Figma: "Chips group" + "Chips for input"

struct ChipGroupGalleryView: View {
    @State private var selectedTab = 0
    @State private var playgroundSelected: Set<String> = ["Design", "iOS"]
    @State private var allowsMultiple = true
    @State private var enableMaxLimit = false
    @State private var singleSelected: Set<String> = ["M"]
    @State private var daysSelected: Set<String> = []
    @State private var filtersSelected: Set<String> = []

    private let tabs = ["catalog.tab.demo", "catalog.tab.variants", "catalog.tab.specs"]
    private let areas   = ["Design", "iOS", "Android", "Web", "Backend", "QA", "DevOps", "UX Research"]
    private let sizes   = ["XS", "S", "M", "L", "XL", "XXL"]
    private let filters = ["Urgent", "High priority", "In progress", "Review", "Done", "Paused"]
    private static let weekdays: [String] = {
        let fmt = DateFormatter()
        fmt.locale = .current
        return fmt.shortWeekdaySymbols
    }()

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.chip_group",
                subtitle: "catalog.chip_group.subtitle",
                figmaRef: "Chips group, Chips for input"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component.chip_group")
    }
}

// MARK: - Demo Tab

private extension ChipGroupGalleryView {
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakSwitch(label: "catalog.chip_group.playground_multi", isOn: $allowsMultiple)
                .onChange(of: allowsMultiple) { _, isOn in
                    if !isOn { enableMaxLimit = false }
                }
            ZodiakSwitch(
                label: "catalog.chip_group.playground_max",
                isOn: $enableMaxLimit,
                isEnabled: allowsMultiple
            )
            ZodiakChipGroup(
                options: areas,
                selectedOptions: $playgroundSelected,
                allowsMultipleSelection: allowsMultiple,
                maxSelection: enableMaxLimit ? 3 : nil,
                label: NSLocalizedString("catalog.chip_group.areas_label", comment: "")
            )
            ZodiakText(
                verbatim: String(
                    format: NSLocalizedString("shared.format.multi_select_count", comment: ""),
                    playgroundSelected.count
                ),
                style: .caption(color: .secondary)
            )
        }
    }
}

// MARK: - Variants Tab

private extension ChipGroupGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        gallerySectionCard(title: "catalog.section.single_select") {
            ZodiakText("catalog.chip.single_select_hint", style: .caption(color: .secondary))
            ZodiakChipGroup(
                options: sizes,
                selectedOptions: $singleSelected,
                allowsMultipleSelection: false,
                label: NSLocalizedString("catalog.chip_group.size_label", comment: "")
            )
        }

        gallerySectionCard(title: "catalog.section.maximo_de_selecoes_max_3") {
            ZodiakText("catalog.chip_group.desc_0", style: .caption(color: .secondary))
            ZodiakChipGroup(
                options: Self.weekdays,
                selectedOptions: $daysSelected,
                maxSelection: 3,
                label: String(
                    format: NSLocalizedString("shared.format.available_days", comment: ""),
                    daysSelected.count
                )
            )
        }

        gallerySectionCard(title: "catalog.section.chips_para_filtros_input") {
            if filtersSelected.isEmpty {
                ZodiakText("catalog.chip_group.desc_1", style: .caption(color: .secondary))
            } else {
                ZodiakText(
                    verbatim: String(
                        format: NSLocalizedString("shared.format.filters_active", comment: ""),
                        filtersSelected.count
                    ),
                    style: .caption(bold: true, color: .primary)
                )
            }
            ZodiakChipGroup(
                options: filters,
                selectedOptions: $filtersSelected,
                label: NSLocalizedString("catalog.chip_group.filters_label", comment: "")
            )
            if !filtersSelected.isEmpty {
                ZodiakButtonSecondary(title: "shared.action.clear_filters") {
                    filtersSelected.removeAll()
                }
            }
        }
    }
}

// MARK: - Specs Tab

private extension ChipGroupGalleryView {
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.layout",
                value: "catalog.spec.val.zodiakflowlayout_wrapping_automatico",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.atom_base",
                value: "catalog.spec.val.zodiakchip_pill_radius_999pt",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.selecao",
                value: "catalog.spec.val.allowsmultipleselection_maxselection",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.estado_ativo",
                value: "catalog.spec.val.actionprimary_bg_textinverse",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.estado_inativo",
                value: "catalog.spec.val.borderprimary_bg_textsecondary",
                style: .spec()
            )
        }
    }
}

#Preview { NavigationStack { ChipGroupGalleryView() } }
