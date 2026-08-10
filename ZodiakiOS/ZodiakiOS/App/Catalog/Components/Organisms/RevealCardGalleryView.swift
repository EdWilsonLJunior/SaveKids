import SwiftUI

// MARK: - Reveal Card Gallery View
// Zodiak DS — Organisms > Card Variants > Reveal Card

struct RevealCardGalleryView: View {
    private let items: [ZodiakRevealCardItem] = [
        .init(
            title: "Paris HQ",
            revealText: "catalog.reveal.text.paris_hq",
            imageSystemName: "building.2",
            tag: "catalog.reveal.tag.office"
        ),
        .init(
            title: "Innovation Lab",
            revealText: "catalog.reveal.text.innovation_lab",
            imageSystemName: "flask",
            tag: "catalog.reveal.tag.lab"
        ),
        .init(
            title: "Design Studio",
            revealText: "catalog.reveal.text.design_studio",
            imageSystemName: "paintbrush",
            tag: "catalog.reveal.tag.studio"
        ),
        .init(
            title: "Data Center",
            revealText: "catalog.reveal.text.data_center",
            imageSystemName: "server.rack",
            tag: "catalog.reveal.tag.infra"
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.reveal_card",
                subtitle: "catalog.reveal_card.subtitle",
                figmaRef: "Card grid — Reveal"
            )

            // MARK: Grid (toque para revelar)
            gallerySectionCard(title: "catalog.section.grid") {
                Text("catalog.cardvariants.desc_4")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakRevealCardGrid(items: items)
            }

            // MARK: Background sólido
            gallerySectionCard(title: "catalog.section.background_solido") {
                ZodiakText("catalog.reveal.desc.solid_bg", style: .caption())
                ZodiakRevealCardGrid(items: [
                    .init(
                        title: "Azur Office",
                        revealText: "catalog.reveal.text.azur_office",
                        imageSystemName: "building.columns",
                        tag: "catalog.reveal.tag.azur",
                        background: .solid(ZodiakColors.surfaceAzur)
                    ),
                    .init(
                        title: "Marine Space",
                        revealText: "catalog.reveal.text.marine_space",
                        imageSystemName: "water.waves",
                        tag: "catalog.reveal.tag.marine",
                        background: .solid(ZodiakColors.surfaceMarine)
                    )
                ])
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.default",
                    value: "catalog.spec.val.titulo_icone_no_fundo_gradiente",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.revelado",
                    value: "catalog.spec.val.overlay_preto_72_texto_expandido",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.animacao",
                    value: "catalog.spec.val.easeinout_025s_move_opacity",
                    style: .spec()
                )

                ZodiakInfoRow("Background", value: "catalog.revealcard.spec.background_value", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.reveal_card")
    }
}

#Preview { NavigationStack { RevealCardGalleryView() } }
