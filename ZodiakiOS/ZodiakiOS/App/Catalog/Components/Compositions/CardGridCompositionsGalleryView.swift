import SwiftUI

// MARK: - Card Grid Compositions Gallery

struct CardGridCompositionsGalleryView: View {
    @State private var showSkeleton = false

    private let standardCards: [ZodiakCardItem] = [
        .init(
            title: "Design Tokens", subtitle: "Foundations",
            description: "Cores, tipografia e espaçamento.", imageName: "paintpalette", tag: "Base"),
        .init(
            title: "catalog.home.tab_components", subtitle: "UI Library",
            description: "55 componentes reutilizáveis.", imageName: "puzzlepiece.extension", tag: "Atoms"),
        .init(
            title: "catalog.section.compositions", subtitle: "Patterns",
            description: "Layouts maiores e mais complexos.", imageName: "rectangle.3.group", tag: "Organism"),
        .init(
            title: "catalog.section.visual_assets", subtitle: "Brand",
            description: "Ícones, bandeiras e logos.", imageName: "photo.stack", tag: "Assets")
    ]

    private let authorCards: [ZodiakAuthorCardItem] = [
        .init(
            name: "Marie Dupont", role: "Lead UX Designer",
            date: "25 Apr 2026",
            headline: "Building scalable design systems from scratch"
        ),
        .init(
            name: "Carlos Ferreira", role: "iOS Engineer",
            date: "22 Apr 2026",
            headline: "SwiftUI state management in large-scale apps"
        ),
        .init(
            name: "Aisha Johnson", role: "Product Manager",
            date: "18 Apr 2026",
            headline: "Accessibility as a product quality signal"
        ),
        .init(
            name: "Luca Bianchi", role: "Visual Designer",
            date: "15 Apr 2026",
            headline: "Color tokens and semantic layering in practice"
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.card_grid_compositions.title",
                subtitle: "catalog.card_grid_compositions.subtitle",
                figmaRef: "08 ▪️ CARD GRIDS"
            )

            // MARK: Standard
            gallerySectionCard(title: "catalog.section.card_grid_standard") {
                Text("catalog.card_grid_compositions.desc_standard")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakCardGrid(items: standardCards, columns: 2, initialCount: 4)

                ZodiakInfoRow(
                    "catalog.spec.lbl.colunas",
                    value: "catalog.spec.val.card_grid_2_colunas",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.show_more",
                    value: "catalog.spec.val.card_grid_show_more_progressivo",
                    style: .spec()
                )
            }

            // MARK: Author Grid
            gallerySectionCard(title: "catalog.section.card_grid_author") {
                Text("catalog.card_grid_compositions.desc_author")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakAuthorCardGrid(items: authorCards, columns: 2)

                ZodiakInfoRow(
                    "catalog.spec.lbl.avatar",
                    value: "catalog.spec.val.card_author_avatar_48pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.colunas",
                    value: "catalog.spec.val.card_grid_2_colunas",
                    style: .spec()
                )
            }

            // MARK: Tall Grid
            gallerySectionCard(title: "catalog.section.card_grid_tall") {
                Text("catalog.card_grid_compositions.desc_tall")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakCardGrid(items: standardCards, columns: 1, initialCount: 3)

                ZodiakInfoRow(
                    "catalog.spec.lbl.layout",
                    value: "catalog.spec.val.card_grid_tall_1_coluna",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.imagem",
                    value: "catalog.spec.val.card_image_120pt",
                    style: .spec()
                )
            }

            // MARK: Typographic Grid
            gallerySectionCard(title: "catalog.section.card_grid_tipografico") {
                Text("catalog.card_grid_compositions.desc_typographic")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakHeadlineSection(
                    title: "Insights do Zodiak Design System",
                    eyebrow: "Artigos",
                    style: .plain
                )

                ZodiakCardGrid(
                    items: standardCards.map { item in
                        ZodiakCardItem(
                            title: item.title,
                            subtitle: item.subtitle,
                            description: item.description,
                            imageName: nil,
                            tag: item.tag
                        )
                    },
                    columns: 2,
                    initialCount: 4
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.composicao",
                    value: "catalog.spec.val.card_tipografico_headline_grid",
                    style: .spec()
                )
            }

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.card_altura_imagem",
                    value: "catalog.spec.val.card_image_120pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.radius",
                    value: "catalog.spec.val.zodiakradii_s_16pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.spacing",
                    value: "catalog.spec.val.zodiakspacing_twoXSmall_8pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.tap_target",
                    value: "catalog.spec.val.44pt_minimo_por_item",
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

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: ZodiakSpacing.s8
                ) {
                    ForEach(standardCards.prefix(4)) { item in
                        ZodiakCard(item: item)
                            .zodiakSkeleton(active: showSkeleton)
                    }
                }
            }
        }
        .zodiakPage(title: "catalog.card_grid_compositions.title")
    }
}

// MARK: - Preview

#Preview("Card Grid — Light") {
    NavigationStack { CardGridCompositionsGalleryView() }
}

#Preview("Card Grid — Dark") {
    NavigationStack { CardGridCompositionsGalleryView() }
        .preferredColorScheme(.dark)
}
