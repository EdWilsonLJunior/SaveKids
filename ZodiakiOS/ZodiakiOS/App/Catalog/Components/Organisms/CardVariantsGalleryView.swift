import SwiftUI

// swiftlint:disable type_body_length
// Reason: Large gallery view with multiple card variant sections and static sample data.
struct CardVariantsGalleryView: View {
    @State private var showSkeleton = false

    private let authorItems: [ZodiakAuthorCardItem] = [
        .init(
            name: "Alice Martin",
            role: "Lead Designer",
            date: "23 Apr 2026",
            headline: "Why design tokens matter at the platform level",
            articleImageName: "paintpalette"
        ),
        .init(
            name: "Tom Kowalski",
            role: "Front-end Dev",
            date: "15 Apr 2026",
            headline: "Composable architectures in Swift",
            articleImageName: "swift",
            actionLabel: "Read more"
        ),
        .init(
            name: "Sara Chen",
            role: "UX Researcher",
            date: "10 Apr 2026",
            headline: "Accessibility as a quality gate, not an afterthought",
            articleImageName: "figure.and.child.holdinghands"
        ),
        .init(
            name: "Luca Rossi",
            role: "Architect",
            date: "5 Apr 2026",
            headline: "iOS architecture patterns compared: MVVM vs TCA",
            articleImageName: "iphone",
            actionLabel: "Read more"
        )
    ]

    private let horizontalItems: [ZodiakHorizontalCardItem] = [
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
        )
    ]

    private let typographicItems: [ZodiakTypographicCardItem] = [
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

    private let revealItems: [ZodiakRevealCardItem] = [
        .init(
            title: "Paris HQ",
            revealText: "catalog.cardvariants.demo.hq_reveal",
            imageSystemName: "building.2",
            tag: "catalog.cardvariants.demo.office_tag"
        ),
        .init(
            title: "Innovation Lab",
            revealText: "catalog.cardvariants.demo.lab_reveal",
            imageSystemName: "flask",
            tag: "Lab"
        ),
        .init(
            title: "Design Studio",
            revealText: "40 lugares, paredes colaborativas e workstations Figma dedicadas.",
            imageSystemName: "paintbrush",
            tag: "catalog.cardvariants.demo.studio_tag"
        ),
        .init(
            title: "Data Center",
            revealText: "catalog.cardvariants.demo.dc_reveal",
            imageSystemName: "server.rack",
            tag: "Infra"
        )
    ]

    private let shortFactItems: [ZodiakShortFactItem] = [
        .init(icon: "person.3", value: "3 200", label: "Consultores"),
        .init(
            icon: "globe.europe.africa", value: "18",
            label: "catalog.shortfacts.demo.countries",
            color: ZodiakColors.surfacePositive
        ),
        .init(
            icon: "building.2", value: "42",
            label: "catalog.shortfacts.demo.offices",
            color: ZodiakColors.brand
        ),
        .init(
            icon: "star", value: "94%",
            label: "catalog.shortfacts.demo.satisfaction",
            color: ZodiakColors.surfaceAzur
        ),
        .init(
            icon: "checkmark.shield", value: "ISO 27001",
            label: "catalog.shortfacts.demo.certification",
            color: ZodiakColors.actionPrimary
        ),
        .init(icon: "bolt", value: "48h", label: "Onboarding", color: ZodiakColors.surfacePositive)
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.composition_name.card_variants",
                subtitle: "catalog.card_variants.subtitle",
                figmaRef: "Card grid — author, horizontal, tall, typographic, reveal, short facts"
            )

            // Author Cards
            gallerySectionCard(title: "catalog.section.author_card") {
                    Text("catalog.cardvariants.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                    ZodiakAuthorCardGrid(items: authorItems)
                    ZodiakInfoRow(
                        "catalog.spec.lbl.layout",
                        value: "catalog.spec.val.grid_2_colunas_flexivel",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.author",
                        value: "catalog.spec.val.zodiak_author_size_s",
                        style: .spec()
                    )
            }

            // Horizontal Cards
            gallerySectionCard(title: "catalog.section.horizontal_card") {
                    Text("catalog.cardvariants.desc_1")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                    ZodiakHorizontalCardList(items: horizontalItems)
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
            }

            // Tall Cards
            gallerySectionCard(title: "catalog.section.tall_card") {
                    Text("catalog.cardvariants.desc_2")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakTallCard(item: .init(
                        eyebrow: "Feature",
                        title: "Design system at scale: patterns that survived 200+ screens",
                        description: "Aprenda o que mantemos e o que descartamos depois de 18 meses.",
                        imageSystemName: "rectangle.3.group.fill"
                    ))

                    ZodiakTallCard(item: .init(
                        eyebrow: "Case Study",
                        title: "Migrating to SwiftUI",
                        description: "Uma jornada de 12 meses do UIKit.",
                        imageSystemName: "swift",
                        imageHeight: 200
                    ))

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
            }

            // Typographic Cards
            gallerySectionCard(title: "catalog.section.typographic_card") {
                    Text("catalog.cardvariants.desc_3")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                    ZodiakTypographicCardGrid(items: typographicItems)
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
            }

            // Reveal Cards
            gallerySectionCard(title: "catalog.section.reveal_card") {
                    Text("catalog.cardvariants.desc_4")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                    ZodiakRevealCardGrid(items: revealItems)
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
            }

            // Short Facts
            gallerySectionCard(title: "catalog.section.short_facts") {
                    Text("catalog.cardvariants.desc_5")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                    ZodiakShortFactsCard(items: shortFactItems)
                    ZodiakInfoRow(
                        "catalog.spec.lbl.icone",
                        value: "catalog.spec.val.3636_pt_fundo_12_opacidade_cor",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.grid",
                        value: "catalog.spec.val.2_colunas_flexiblegrid",
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

                ForEach(authorItems.prefix(2)) { item in
                    ZodiakAuthorCard(item: item)
                        .zodiakSkeleton(active: showSkeleton)
                }
            }
        }
        .zodiakPage(title: "catalog.composition_name.card_variants")
    }
}

#Preview { NavigationStack { CardVariantsGalleryView() } }
// swiftlint:enable type_body_length
