import SwiftUI

// MARK: - Typographic Card Gallery View
// Zodiak DS — Organisms > Card Variants > Typographic Card

struct TypographicCardGalleryView: View {
    private let items: [ZodiakTypographicCardItem] = [
        .init(
            category: "Research",
            title: "Why semantic tokens matter",
            body: "Short body explaining the concept and outcomes of consistent theming.",
            meta: "12 Apr 2026",
            leading: .icon(.searchMagnifyingGlass),
            actionLabel: "Read more"
        ),
        .init(
            category: "Engineering",
            title: "Composable architectures in Swift",
            body: "How small units compose into large applications.",
            meta: "8 Apr 2026",
            leading: .number(2)
        ),
        .init(
            category: "Design",
            title: "Color ramps and accessibility",
            body: "Contrast ratios, primitives and semantic mapping.",
            meta: "3 Apr 2026",
            leading: .icon(.swatchesPalette),
            cardBackground: .azur,
            actionLabel: "Read more"
        ),
        .init(
            category: "Strategy",
            title: "Design systems ROI",
            meta: "1 Apr 2026",
            leading: .number(4),
            size: .small
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.typographic_card",
                subtitle: "catalog.typographic_card.subtitle",
                figmaRef: "Card grid — Typographic"
            )

            // MARK: Grid
            gallerySectionCard(title: "catalog.section.grid") {
                Text("catalog.cardvariants.desc_3")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakTypographicCardGrid(items: items)
            }

            // MARK: Leading: ícone vs número
            gallerySectionCard(title: "catalog.section.leading_slot") {
                Text("catalog.typocard.spec.leading_desc")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakTypographicCardGrid(items: [
                    .init(category: "Design", title: "catalog.typocard.demo.with_icon", leading: .icon(.star)),
                    .init(category: "Dev", title: "catalog.typocard.demo.with_number", leading: .number(1)),
                    .init(category: "Research", title: "Sem leading", leading: .none),
                    .init(category: "UX", title: "catalog.typocard.demo.large_number", leading: .number(42))
                ])
            }

            // MARK: Background: page vs azur
            gallerySectionCard(title: "catalog.section.background") {
                ZodiakTypographicCardGrid(items: [
                    .init(
                        category: "Page",
                        title: "catalog.typocard.demo.default_bg",
                        body: "Fundo surface · texto textPrimary",
                        leading: .icon(.fileBlank)
                    ),
                    .init(
                        category: "Azur",
                        title: "Background azur",
                        body: "Fundo surfaceAzur · texto textInverse",
                        leading: .icon(.moon),
                        cardBackground: .azur
                    )
                ])
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.accent",
                    value: "catalog.spec.val.barra_322_pt_em_actionprimary",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.layout",
                    value: "catalog.spec.val.grid_2_colunas_sem_imagem",
                    style: .spec()
                )

                ZodiakInfoRow("Size", value: ".small (heading-m 24pt) · .medium (heading-s 18pt)", style: .spec())

                ZodiakInfoRow("Background", value: ".page (surface) · .azur (surfaceAzur)", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.typographic_card")
    }
}

#Preview { NavigationStack { TypographicCardGalleryView() } }
