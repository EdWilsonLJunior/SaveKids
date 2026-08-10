import SwiftUI

struct EmptyStateGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.empty_state",
                subtitle: "catalog.empty_state.subtitle",
                figmaRef: "Empty state"
            )

            // MARK: Variantes contextuais
            gallerySectionCard(title: "catalog.section.contextos_comuns") {
                VStack(spacing: ZodiakSpacing.s8) {
                    ZodiakEmptyState(
                        icon: "tray",
                        title: "catalog.emptystate.title.no_results",
                        description: "catalog.emptystate.desc.no_results",
                        action: ("shared.action.clear_filters", {})
                    )

                    ZodiakEmptyState(
                        icon: "wifi.slash",
                        title: "catalog.emptystate.title.no_connection",
                        description: "catalog.emptystate.desc.no_connection",
                        action: ("catalog.emptystate.cta.retry", {})
                    )

                    ZodiakEmptyState(
                        icon: "heart",
                        title: "catalog.emptystate.title.no_favorites",
                        description: "catalog.emptystate.desc.no_favorites"
                    )

                    ZodiakEmptyState(
                        icon: "bell.slash",
                        title: "catalog.emptystate.title.all_done",
                        description: "catalog.emptystate.desc.all_done"
                    )
                }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.icone_container",
                    value: "catalog.spec.val.9696pt_circle_surfacesmoke",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.sf_symbol",
                    value: "catalog.spec.val.4040pt_textdisabled",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.titulo",
                    value: "catalog.spec.val.zodiaktypographytitle3_textprimary",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.descricao",
                    value: "catalog.spec.val.body_textsecondary_center",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.cta",
                    value: "catalog.spec.val.zodiakbutton_primary_opcional",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component_name.empty_state")
    }
}

#Preview { NavigationStack { EmptyStateGalleryView() } }
