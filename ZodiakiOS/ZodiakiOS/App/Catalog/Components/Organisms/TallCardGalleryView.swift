import SwiftUI

// MARK: - Tall Card Gallery View
// Zodiak DS — Organisms > Card Variants > Tall Card

struct TallCardGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.tall_card",
                subtitle: "catalog.tall_card.subtitle",
                figmaRef: "Card grid — Tall"
            )

            // MARK: Default (260pt)
            gallerySectionCard(title: "catalog.section.padrao_260pt") {
                Text("catalog.cardvariants.desc_2")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakTallCard(item: .init(
                    eyebrow: "Feature",
                    title: "Design system at scale: patterns that survived 200+ screens",
                    description: "Aprenda o que mantemos e o que descartamos depois de 18 meses.",
                    imageSystemName: "rectangle.3.group.fill"
                ))
            }

            // MARK: Altura personalizada
            gallerySectionCard(title: "catalog.section.altura_personalizada") {
                ZodiakTallCard(item: .init(
                    eyebrow: "Case Study",
                    title: "Migrating to SwiftUI",
                    description: "catalog.tallcard.demo.description",
                    imageSystemName: "swift",
                    imageHeight: 200
                ))
                ZodiakTallCard(item: .init(
                    eyebrow: "Deep Dive",
                    title: "Accessibility as a quality gate",
                    imageSystemName: "accessibility",
                    imageHeight: 180
                ))
            }

            // MARK: Sem eyebrow e sem descrição
            gallerySectionCard(title: "catalog.section.apenas_titulo") {
                ZodiakTallCard(item: .init(
                    title: "The future of AI in enterprise software",
                    imageSystemName: "brain.head.profile",
                    imageHeight: 200
                ))
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.imagem",
                    value: "catalog.spec.val.260_pt_padrao_configuravel",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.overlay",
                    value: "catalog.spec.val.gradiente_escuro_centro_base",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.texto",
                    value: "catalog.spec.val.eyebrow_titulo_descricao_sobre_imagem",
                    style: .spec()
                )

                ZodiakInfoRow("Eyebrow", value: "caption uppercase · white 70% · opcional", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.tall_card")
    }
}

#Preview { NavigationStack { TallCardGalleryView() } }
