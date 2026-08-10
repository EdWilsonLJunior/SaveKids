import SwiftUI

// MARK: - List Gallery View

struct ListGalleryView: View {
    @State private var showSkeleton = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.list",
                subtitle: "catalog.list.subtitle",
                figmaRef: "Content Display / List"
            )

            // MARK: Não-ordenada
            gallerySectionCard(title: "catalog.section.nao_ordenada_unordered") {
                Text("catalog.list.desc_0")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakList(
                        items: [
                            "catalog.list.item.clear_content",
                            "catalog.list.item.highlight_key",
                            "catalog.list.guideline_parallel"
                        ],
                        headline: "Headline for list",
                        variant: .unordered
                    )
            }

            // MARK: Ordenada
            gallerySectionCard(title: "catalog.section.ordenada_ordered") {
                Text("catalog.list.desc_1")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakList(
                        items: [
                            "catalog.list.item.open_login",
                            "catalog.list.item.access_settings",
                            "catalog.list.item.confirm_save"
                        ],
                        headline: "Headline for list",
                        variant: .ordered
                    )
            }

            // MARK: Sem headline
            gallerySectionCard(title: "catalog.section.sem_headline") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        ZodiakList(
                            items: [
                                "catalog.list.guideline_short",
                                "catalog.list.guideline_parallel"
                            ],
                            variant: .unordered
                        )
                        ZodiakDivider()
                        ZodiakList(
                            items: [
                                "catalog.list.example_first_item",
                                "catalog.list.example_second_item"
                            ],
                            variant: .ordered
                        )
                    }
            }

            // MARK: Alinhamento
            gallerySectionCard(title: "catalog.section.alinhamento") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        Text("catalog.list.desc_2")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        ZodiakList(
                            items: ["catalog.list.item.one", "catalog.list.item.two", "catalog.list.item.three"],
                            headline: "catalog.list.aligned_left",
                            variant: .unordered,
                            alignment: .leading
                        )
                        ZodiakDivider()
                        Text("catalog.spec.centered")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        ZodiakList(
                            items: ["catalog.list.item.one", "catalog.list.item.two", "catalog.list.item.three"],
                            headline: "catalog.spec.centered",
                            variant: .unordered,
                            alignment: .center
                        )
                    }
            }

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.headline",
                        value: "catalog.spec.val.heading_m_ubuntu_regular_24pt_textprimar",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.body",
                        value: "catalog.spec.val.body_l_300_ubuntu_light_18pt_textprimary",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.linha_decorativa",
                        value: "catalog.spec.val.actionprimary_2pt_de_largura",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.variantes",
                        value: "catalog.spec.val.unordered_ordered_1_2_3",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.alinhamento",
                        value: "catalog.spec.val.leading_padrao_center",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.headline",
                        value: "catalog.spec.val.opcional_showhide_via_parametro",
                        style: .spec()
                    )
            }

            gallerySectionCard(title: LocalizedStringKey("catalog.skeletonloader.section.loading_state")) {
                Toggle(isOn: $showSkeleton) {
                    Text("catalog.skeletonloader.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
                .tint(ZodiakColors.actionPrimary)

                ZodiakList(
                    items: ["Item 1", "Item 2", "Item 3"],
                    headline: "Lista de exemplo",
                    variant: .unordered
                )
                .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.component_name.list")
    }
}

#Preview {
    NavigationStack {
        ListGalleryView()
    }
}
