import SwiftUI

// MARK: - Chip Gallery View

struct ChipGalleryView: View {
    @State private var selectedTab = 0
    @State private var singleActiveIndex: Int? = 0
    @State private var multiActiveFilters: Set<Int> = [0, 2]

    private let tabs = ["catalog.tab.demo", "catalog.tab.variants", "catalog.tab.specs"]

    private let statusLabels = ["catalog.chip.status.all", "catalog.chip.status.approved",
                                "catalog.chip.status.rejected", "catalog.chip.status.pending"]
    private let techLabels   = ["iOS", "SwiftUI", "Design", "Mobile", "Zodiak"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.chip",
                subtitle: "catalog.chip.subtitle",
                figmaRef: "Chips"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component_name.chip")
    }
}

// MARK: - Demo Tab

private extension ChipGalleryView {
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakChip(text: "shared.state.active", isActive: true)
                ZodiakChip(text: "catalog.chip.state.inactive", isActive: false)
            }
            ZodiakText("catalog.chip.full_desc", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
        }

        gallerySectionCard(title: "catalog.section.single_select_interactive") {
            ZodiakText("catalog.chip.single_select_hint", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: ZodiakSpacing.s8) {
                    ForEach(statusLabels.indices, id: \.self) { index in
                        ZodiakChip(
                            text: LocalizedStringKey(statusLabels[index]),
                            isActive: singleActiveIndex == index,
                            onTap: { singleActiveIndex = index }
                        )
                    }
                }
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, ZodiakSpacing.s4)
            }
            if let idx = singleActiveIndex {
                ZodiakText(
                    verbatim: String(
                        format: NSLocalizedString("shared.format.selected", comment: ""),
                        String(localized: String.LocalizationValue(statusLabels[idx]))
                    ),
                    style: .caption(color: .secondary)
                )
            }
        }

        gallerySectionCard(title: "catalog.section.multi_selecao_interativo") {
            ZodiakText("catalog.chip.multi_select_hint", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: ZodiakSpacing.s8) {
                    ForEach(techLabels.indices, id: \.self) { index in
                        ZodiakChip(
                            verbatim: techLabels[index],
                            isActive: multiActiveFilters.contains(index),
                            onTap: {
                                if multiActiveFilters.contains(index) {
                                    multiActiveFilters.remove(index)
                                } else {
                                    multiActiveFilters.insert(index)
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, ZodiakSpacing.s4)
            }
            if !multiActiveFilters.isEmpty {
                ZodiakText(
                    verbatim: String(
                        format: NSLocalizedString("shared.format.filters_active", comment: ""),
                        multiActiveFilters.count
                    ),
                    style: .caption(bold: true, color: .primary)
                )
            }
        }
    }
}

// MARK: - Variants Tab

private extension ChipGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakChip(text: "shared.state.active", isActive: true)
                ZodiakChip(text: "catalog.chip.state.inactive", isActive: false)
            }
        }

        gallerySectionCard(title: "catalog.chip.variant.with_icon") {
            ZodiakText("catalog.chip.variant.with_icon_desc", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakChip(text: "shared.state.active", isActive: true)
                ZodiakChip(text: "catalog.chip.state.inactive", isActive: false)
            }
        }

        gallerySectionCard(title: "catalog.chip.variant.in_flow") {
            ZodiakText("catalog.chip.variant.in_flow_desc", style: .caption(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakFlowLayout(spacing: ZodiakSpacing.s8) {
                ForEach(techLabels.indices, id: \.self) { index in
                    ZodiakChip(verbatim: techLabels[index], isActive: index == 0)
                }
            }
        }
    }
}

// MARK: - Specs Tab

private extension ChipGalleryView {
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow("catalog.spec.lbl.radius", value: "catalog.chip.spec.radius", style: .spec())

            ZodiakInfoRow("catalog.spec.lbl.estado_ativo", value: "catalog.chip.spec.active_bg", style: .spec())

            ZodiakInfoRow("catalog.spec.lbl.estado_inativo", value: "catalog.chip.spec.inactive_bg", style: .spec())

            ZodiakInfoRow("catalog.chip.spec.text_active_lbl", value: "catalog.chip.spec.text_active", style: .spec())

            ZodiakInfoRow(
                "catalog.chip.spec.text_inactive_lbl",
                value: "catalog.chip.spec.text_inactive",
                style: .spec()
            )

            ZodiakInfoRow("catalog.spec.lbl.tipografia", value: "catalog.chip.spec.font", style: .spec())

            ZodiakInfoRow("catalog.chip.spec.icon_lbl", value: "catalog.chip.spec.icon_val", style: .spec())
        }
    }
}

#Preview {
    NavigationStack { ChipGalleryView() }
}
