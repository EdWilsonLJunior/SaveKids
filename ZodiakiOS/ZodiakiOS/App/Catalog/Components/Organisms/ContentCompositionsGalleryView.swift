// Reason: Rich gallery view with multiple demo sections — all part of single screen.
import SwiftUI

// swiftlint:disable:next type_body_length
struct ContentCompositionsGalleryView: View {
    private let listingItems = [
        ZodiakListingItem(
            eyebrow: "Research",
            title: "How design systems reduce delivery friction.",
            summary: "A short editorial summary that explains the article angle and why it matters.",
            meta: "5 min read",
            imageSystemName: "doc.text.image",
            action: {}
        ),
        ZodiakListingItem(
            eyebrow: "Engineering",
            title: "Shipping SwiftUI components with stable semantics.",
            summary: "Patterns for keeping tokens and components aligned between Figma and code.",
            meta: "8 min read",
            imageSystemName: "swift",
            action: {}
        ),
        ZodiakListingItem(
            eyebrow: "Design",
            title: "From hero to listings: compositional layers in Zodiak.",
            summary: "How larger content blocks build on top of the same atomic foundation.",
            meta: "6 min read",
            imageSystemName: "rectangle.3.group",
            action: {}
        )
    ]

    private let galleryTiles = [
        ZodiakImageTile(
            title: "Parallax block",
            subtitle: "Large visual composition",
            artworkSystemName: "mountain.2.fill"
        ),
        ZodiakImageTile(title: "Side-by-side", subtitle: "Editorial layout", artworkSystemName: "rectangle.split.2x1"),
        ZodiakImageTile(title: "Masonry tile", subtitle: "Adaptive grid", artworkSystemName: "square.grid.2x2"),
        ZodiakImageTile(title: "Gallery item", subtitle: "Media asset", artworkSystemName: "photo.on.rectangle")
    ]

    private let faqItems = [
        ZodiakFAQItem(
            question: "catalog.composition.faq.adaptive_q",
            answer: "catalog.composition.faq.adaptive_ans"
        ),
        ZodiakFAQItem(
            question: "catalog.composition.faq.assets_q",
            answer: "catalog.composition.faq.assets_ans"
        ),
        ZodiakFAQItem(
            question: "catalog.composition.faq.reuse_q",
            answer: "catalog.composition.faq.reuse_ans"
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.section.content_compositions",
                subtitle: "catalog.content_compositions.subtitle",
                figmaRef: "Heroes, Listings, Media, Image compositions"
            )

            // MARK: Hero (small, large, split — existentes)
            gallerySectionCard(title: "catalog.section.hero") {
                ZodiakHero(
                    eyebrow: "Featured",
                    title: "A hero organism ready for editorial and product surfaces.",
                    summary: "catalog.composition.hero.card_summary",
                    style: .large,
                    mediaSystemImage: "sparkles.rectangle.stack",
                    primaryAction: .init(title: "Explorar", action: {}),
                    secondaryAction: .init(title: "Saiba mais", action: {}, isSecondary: false),
                    metrics: [
                        .init(value: "26", label: "blocos portados"),
                        .init(value: "4", label: "catalog.composition.hero.families"),
                        .init(value: "100%", label: "SwiftUI"),
                        .init(value: "iPad", label: "layout adaptativo")
                    ]
                )
            }

            // MARK: Hero Fullscreen (novo)
            gallerySectionCard(title: "catalog.section.hero_fullscreen") {
                Text("catalog.contentcompositions.desc_0")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakHero(
                    eyebrow: "Imersivo",
                    title: "catalog.composition.hero.fullscreen_title",
                    summary: "catalog.composition.hero.fullscreen_summary",
                    style: .fullscreen,
                    background: ZodiakGradients.azur,
                    primaryAction: .init(title: "shared.action.watch", action: {}),
                    secondaryAction: .init(title: "Saiba mais", action: {}, isSecondary: true)
                )
                ZodiakInfoRow("catalog.spec.lbl.variante", value: "catalog.spec.val.fullscreen", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.overlay",
                    value: "catalog.spec.val.lineargradient_bottomtop_055015_opacidad",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.ipad", value: "catalog.spec.val.altura_minima_560pt", style: .spec())

                ZodiakInfoRow("catalog.spec.lbl.iphone", value: "catalog.spec.val.altura_minima_420pt", style: .spec())
            }

            // MARK: Hero Tipográfico (novo)
            gallerySectionCard(title: "catalog.section.hero_tipografico") {
                Text("catalog.contentcompositions.desc_1")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ForEach(ZodiakHeroTypographicShape.allCases, id: \.rawValue) { shape in
                    ZodiakHero(
                        eyebrow: "Shape V\(shape.rawValue + 1)",
                        title: "catalog.composition.hero.typo_title",
                        summary: "catalog.composition.hero.typo_summary",
                        style: .typographic(shape: shape),
                        primaryAction: .init(title: "Ler artigo", action: {})
                    )
                }

                ZodiakInfoRow("catalog.spec.lbl.variantes", value: "catalog.spec.val.v1_v2_v3_v4_v5", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.fundo",
                    value: "catalog.spec.val.surfaceink_ou_pagebackground",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.shape",
                    value: "catalog.spec.val.decorativo_sem_assets_externos",
                    style: .spec()
                )
            }

            // MARK: Headline Section (novo)
            gallerySectionCard(title: "catalog.section.secao_de_titulo") {
                Text("catalog.contentcompositions.desc_2")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakHeadlineSection(
                    title: "Explore our services",
                    eyebrow: "What we do",
                    style: .plain
                )
                ZodiakHeadlineSection(
                    title: "Insights for modern engineering teams",
                    eyebrow: "Engineering",
                    // swiftlint:disable:next line_length
                    intro: "A curated set of articles and guides to keep your team aligned on architecture and delivery.",
                    style: .plainWithIntro
                )
                ZodiakHeadlineSection(
                    title: "Our approach to innovation",
                    intro: "Centered on outcomes, not outputs.",
                    style: .middleAligned
                )
                ZodiakHeadlineSection(
                    title: "Case studies",
                    eyebrow: "Portfolio",
                    intro: "Filter by industry or capability.",
                    style: .withFilter,
                    background: .fog
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.variantes",
                    value: "catalog.spec.val.plain_plainwithintro_middlealigned_withf",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.fundo", value: "catalog.spec.val.page_fog", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.ipad",
                    value: "catalog.spec.val.fonte_headline_iphone_usa_title1",
                    style: .spec()
                )
            }

            // MARK: Text Block (novo)
            gallerySectionCard(title: "catalog.section.bloco_de_texto") {
                Text("catalog.contentcompositions.desc_3")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakTextBlock(
                    headingLarge: "Building design systems that last",
                    // swiftlint:disable:next line_length
                    bodyText: "A design system is only as good as the discipline used to maintain it. Consistency, documentation and adoption are the three pillars that determine whether a system becomes a true accelerator.",
                    alignment: .leading
                )
                ZodiakTextBlock(
                    headingLarge: "Centered layout",
                    // swiftlint:disable:next line_length
                    bodyText: "Use this alignment for introductory or editorial text that benefits from a more symmetrical visual weight.",
                    alignment: .center
                )
                ZodiakTextBlock(
                    headingLarge: "Duas colunas (iPad)",
                    bodyText: "catalog.composition.spec.ipad_cols",
                    headingSmall: "Adapta-se a qualquer viewport",
                    alignment: .twoColumn
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.alinhamento",
                    value: "catalog.spec.val.leading_center_twocolumn",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.duas_colunas",
                    value: "catalog.spec.val.ativo_apenas_em_ipad_horizontalsizeclass",
                    style: .spec()
                )
            }

            // MARK: Listings (existente)
            gallerySectionCard(title: "catalog.section.listings") {
                ZodiakListingGroup(title: nil, items: listingItems)
                ZodiakFAQList(title: "FAQ", items: faqItems)
            }

            // MARK: Media — Podcast Small + Video Banner (existentes)
            gallerySectionCard(title: "catalog.section.media") {
                ZodiakPodcastCard(
                    item: .init(
                        eyebrow: "shared.content.podcast",
                        title: "Design systems beyond components",
                        summary: "A conversation on operating systems of UI, not just component libraries.",
                        duration: "38 min",
                        artworkSystemName: "mic.fill",
                        action: {}
                    )
                )
                ZodiakVideoBanner(
                    item: .init(
                        eyebrow: "Video",
                        title: "A guided tour of the Zodiak foundations",
                        summary: "An overview of tokens, semantics and large-scale composition patterns.",
                        duration: "12:41",
                        artworkSystemName: "play.fill",
                        action: {}
                    )
                )
            }

            // MARK: Podcast Large (novo)
            gallerySectionCard(title: "catalog.section.podcast_grande") {
                Text("catalog.contentcompositions.desc_4")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakPodcastLarge(
                    item: .init(
                        eyebrow: "shared.content.podcast",
                        title: "Shaping the future of enterprise software",
                        // swiftlint:disable:next line_length
                        summary: "A deep dive into how design systems are transforming collaboration between design and engineering at scale across distributed teams.",
                        duration: "52 min",
                        artworkSystemName: "waveform.circle.fill",
                        action: {}
                    ),
                    guest: "Ana Souza, Principal Architect",
                    background: .page
                )

                ZodiakPodcastLarge(
                    item: .init(
                        eyebrow: "catalog.composition.demo.series_eyebrow",
                        title: "Engineering culture at Capgemini",
                        // swiftlint:disable:next line_length
                        summary: "How psychological safety and continuous delivery practices compound into measurable team performance.",
                        duration: "41 min",
                        artworkSystemName: "mic.circle.fill",
                        action: {}
                    ),
                    guest: "Carlos Mena, VP Engineering",
                    background: .fog
                )

                ZodiakInfoRow("catalog.spec.lbl.fundo", value: "catalog.spec.val.page_fog_image", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.controles",
                    value: "catalog.spec.val.back15s_playpause_forward15s",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.ipad", value: "catalog.spec.val.imagem_280pt_de_altura", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.iphone",
                    value: "catalog.spec.val.imagem_200pt_de_altura",
                    style: .spec()
                )
            }

            // MARK: Vídeo e Texto (novo)
            gallerySectionCard(title: "catalog.section.video_e_texto") {
                Text("catalog.contentcompositions.desc_5")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakVideoAndText(
                    item: .init(
                        eyebrow: "catalog.composition.demo.video_eyebrow",
                        title: "How Zodiak accelerates delivery",
                        // swiftlint:disable:next line_length
                        summary: "An inside look at how our design system cuts ramp-up time and enforces consistency across distributed squads.",
                        duration: "14:22",
                        artworkSystemName: "play.rectangle.fill",
                        action: {}
                    ),
                    orientation: .leading,
                    background: .page
                )

                ZodiakVideoAndText(
                    item: .init(
                        eyebrow: "Case",
                        title: "Migrating 300+ screens to SwiftUI",
                        // swiftlint:disable:next line_length
                        summary: "A practical account of the incremental migration strategy used across three parallel squads with zero downtime.",
                        duration: "09:58",
                        artworkSystemName: "film.fill",
                        action: {}
                    ),
                    orientation: .trailing,
                    background: .fog
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.orientacao",
                    value: "catalog.spec.val.video_a_esquerda_video_a_direita",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.fundo", value: "catalog.spec.val.page_fog", style: .spec())

                ZodiakInfoRow("catalog.spec.lbl.ipad", value: "catalog.spec.val.lado_a_lado_5050", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.iphone",
                    value: "catalog.spec.val.empilhado_verticalmente",
                    style: .spec()
                )
            }

            // MARK: Image Compositions (existentes)
            gallerySectionCard(title: "catalog.section.image_compositions") {
                ZodiakImageBanner(
                    title: "Image-led storytelling for product and editorial pages.",
                    summary: "Esse banner cobre os casos em que o bloco visual precisa abrir a narrativa.",
                    artworkSystemName: "photo.stack",
                    actionTitle: "Abrir galeria",
                    action: {}
                )
                ZodiakCarousel(items: galleryTiles)
                ZodiakMasonryGrid(items: galleryTiles)
            }

            // MARK: Imagem e Texto Simétrico (novo)
            gallerySectionCard(title: "catalog.section.imagem_e_texto_simetrico") {
                Text("catalog.contentcompositions.desc_6")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakImageTextSymmetrical(
                    heading: "Showcase text and image side by side",
                    // swiftlint:disable:next line_length
                    bodyText: "On iPad the image and text appear in a balanced 50/50 split. On iPhone they stack vertically, preserving readability at any size.",
                    artworkSystemName: "rectangle.split.2x1.fill",
                    background: .page
                )

                ZodiakImageTextSymmetrical(
                    heading: "catalog.composition.demo.fog_heading",
                    bodyText: "catalog.composition.demo.fog_body",
                    artworkSystemName: "photo.artframe",
                    background: .fog
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.fundo",
                    value: "catalog.spec.val.fundo_de_pagina_superficie_nevoa",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.ipad", value: "catalog.spec.val.split_5050_lado_a_lado", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.iphone",
                    value: "catalog.spec.val.empilhado_verticalmente",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.altura_da_imagem",
                    value: "catalog.spec.val.adaptativa_ao_conteudo_de_texto",
                    style: .spec()
                )
            }

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.familia",
                    value: "catalog.spec.val.hero_tipografico_headline_text_block_lis",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.dependencia",
                    value: "catalog.spec.val.so_tokens_e_sf_symbols_locais",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.responsividade",
                    value: "catalog.spec.val.iphone_e_ipad_com_layouts_fluidos",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.uso",
                    value: "catalog.spec.val.catalogo_editorial_marketing_e_blocos_de",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.compositions_implementadas",
                    value: "catalog.spec.val.23_23",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.section.compositions")
    }
}

#Preview { NavigationStack { ContentCompositionsGalleryView() } }
