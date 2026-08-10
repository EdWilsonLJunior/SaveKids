import SwiftUI

// MARK: - Horizontal Card Gallery View
// Zodiak DS — Organisms > Card Variants > Horizontal Card

struct HorizontalCardGalleryView: View {
    private let items: [ZodiakHorizontalCardItem] = [
        .init(
            title: "How design tokens scale across platforms",
            subtitle: "5 min · Design Systems",
            description: "A look at how semantic layering reduces churn across web and mobile.",
            tag: "Article",
            icon: .swatchesPalette
        ),
        .init(
            title: "Swift performance tips",
            subtitle: "8 min · Engineering",
            description: "Profile first, optimise second. Practical patterns for real apps.",
            tag: "Deep Dive",
            icon: .code
        ),
        .init(
            title: "Accessibility in SwiftUI",
            subtitle: "6 min · Mobile",
            tag: "Guide",
            icon: .user
        ),
        .init(
            title: "Composing atoms into complex UIs",
            subtitle: "4 min · Architecture",
            description: "From design tokens to production components in 5 steps.",
            icon: .layers
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.horizontal_card",
                subtitle: "catalog.horizontal_card.subtitle",
                figmaRef: "Card grid — Horizontal"
            )

            // MARK: Lista
            gallerySectionCard(title: "catalog.section.lista") {
                Text("catalog.cardvariants.desc_1")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakHorizontalCardList(items: items)
            }

            // MARK: Variantes de largura de imagem
            gallerySectionCard(title: "catalog.section.variante_imagem") {
                Text("catalog.horizontalcard.spec.image_width")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakHorizontalCard(item: items[0], imageWidth: 64)
                ZodiakHorizontalCard(item: items[1], imageWidth: 96)
                ZodiakHorizontalCard(item: items[2], imageWidth: 128)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.imagem",
                    value: "catalog.spec.val.96_pt_de_largura_altura_flexivel",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.texto",
                    value: "catalog.spec.val.tag_titulo_subtitulo_descricao",
                    style: .spec()
                )

                ZodiakInfoRow("Layout", value: "HStack image-left · radius ZodiakRadii.s", style: .spec())

                ZodiakInfoRow("Tag", value: "caption · actionPrimary · opcional", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.horizontal_card")
    }
}

#Preview { NavigationStack { HorizontalCardGalleryView() } }
