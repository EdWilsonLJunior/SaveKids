import SwiftUI

// MARK: - Image Compositions Gallery

struct ImageCompositionsGalleryView: View {
    @State private var showSkeleton = false

    private let carouselItems: [ZodiakImageTile] = [
        .init(title: "Design Tokens", subtitle: "Foundations do Zodiak", artworkSystemName: "paintpalette"),
        .init(title: "Componentes UI", subtitle: "55 blocos reutilizáveis", artworkSystemName: "puzzlepiece.extension"),
        .init(
            title: "catalog.section.visual_assets",
            subtitle: "Ícones, bandeiras e logos",
            artworkSystemName: "photo.stack"),
        .init(
            title: "catalog.section.compositions",
            subtitle: "Patterns de layout maiores",
            artworkSystemName: "rectangle.3.group")
    ]

    private let masonryItems: [ZodiakImageTile] = [
        .init(title: "Insights", artworkSystemName: "lightbulb"),
        .init(title: "Comunidade", artworkSystemName: "person.3.fill"),
        .init(title: "Inovação", artworkSystemName: "sparkles"),
        .init(title: "Tecnologia", artworkSystemName: "cpu"),
        .init(title: "Sustentabilidade", artworkSystemName: "leaf"),
        .init(title: "Globalização", artworkSystemName: "globe")
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.image_compositions.title",
                subtitle: "catalog.image_compositions.subtitle",
                figmaRef: "09 ▪️ IMAGE COMPOSITIONS"
            )

            // MARK: Image Banner
            gallerySectionCard(title: "catalog.section.image_banner") {
                Text("catalog.image_compositions.desc_banner")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakImageBanner(
                    title: "Design System em produção",
                    summary: "Componentes, tokens e padrões prontos para times iOS e Android.",
                    artworkSystemName: "iphone",
                    actionTitle: "Explorar componentes",
                    action: {}
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.altura",
                    value: "catalog.spec.val.image_banner_min_220pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.gradiente",
                    value: "catalog.spec.val.zodiakgradients_azur",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.overlay",
                    value: "catalog.spec.val.gradiente_escuro_para_legibilidade",
                    style: .spec()
                )
            }

            // MARK: Carousel
            gallerySectionCard(title: "catalog.section.carousel") {
                Text("catalog.image_compositions.desc_carousel")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakCarousel(items: carouselItems, showCounter: true)

                ZodiakInfoRow(
                    "catalog.spec.lbl.paginacao",
                    value: "catalog.spec.val.carousel_tabview_page",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.altura",
                    value: "catalog.spec.val.carousel_card_300pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.counter",
                    value: "catalog.spec.val.carousel_zodiak_slider_counter",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.autoplay",
                    value: "catalog.spec.val.carousel_autoplay_duration_opcional",
                    style: .spec()
                )
            }

            // MARK: Masonry
            gallerySectionCard(title: "catalog.section.masonry") {
                Text("catalog.image_compositions.desc_masonry")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakMasonryGrid(items: masonryItems)

                ZodiakInfoRow(
                    "catalog.spec.lbl.colunas",
                    value: "catalog.spec.val.masonry_2_colunas_alternadas",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.altura",
                    value: "catalog.spec.val.masonry_alternado_220_160pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.gradiente",
                    value: "catalog.spec.val.masonry_brand_azur_alternado",
                    style: .spec()
                )
            }

            // MARK: Image Text Symmetrical
            gallerySectionCard(title: "catalog.section.image_texto_simetrico") {
                Text("catalog.image_compositions.desc_symmetrical")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakImageTextSymmetrical(
                    heading: "Lado a lado em iPad, empilhado em iPhone.",
                    // swiftlint:disable:next line_length
                    bodyText: "O layout 50/50 aproveita o espaço maior do iPad para apresentar imagem e texto em harmonia visual.",
                    artworkSystemName: "ipad.landscape",
                    background: .page
                )

                ZodiakImageTextSymmetrical(
                    heading: "Versão com fundo de superfície.",
                    bodyText: "A variante fog destaca o bloco do fundo da página com a cor de superfície.",
                    artworkSystemName: "photo.artframe",
                    background: .fog
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.ipad",
                    value: "catalog.spec.val.image_texto_50_50_ipad",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.iphone",
                    value: "catalog.spec.val.image_texto_stacked_iphone",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.background",
                    value: "catalog.spec.val.image_texto_page_fog",
                    style: .spec()
                )
            }

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.radius",
                    value: "catalog.spec.val.zodiakradii_m_32pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.adaptativo",
                    value: "catalog.spec.val.horizontalSizeClass_regular",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.placeholder",
                    value: "catalog.spec.val.image_sf_symbol_placeholder",
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

                ZodiakCard(item: ZodiakCardItem(
                    title: "Imagem de exemplo",
                    subtitle: "Composition · 5 min",
                    imageName: "photo"
                ))
                .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.image_compositions.title")
    }
}

// MARK: - Preview

#Preview("Image Compositions — Light") {
    NavigationStack { ImageCompositionsGalleryView() }
}

#Preview("Image Compositions — Dark") {
    NavigationStack { ImageCompositionsGalleryView() }
        .preferredColorScheme(.dark)
}
