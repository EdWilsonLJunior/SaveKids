import SwiftUI

// MARK: - Zodiak Preview (documentação viva)
// Exibe os tokens e componentes principais do Zodiak Design System

#Preview("Cores") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("Zodiak Color Tokens", style: .headline)

            Group {
                colorRow("brand", ZodiakColors.brand)
                colorRow("brandOrange", ZodiakColors.brandOrange)
                colorRow("background", ZodiakColors.background)
                colorRow("surface", ZodiakColors.surface)
                colorRow("surfacePositive", ZodiakColors.surfacePositive)
                colorRow("surfaceNegative", ZodiakColors.surfaceNegative)
                colorRow("textPrimary", ZodiakColors.textPrimary)
                colorRow("textSecondary", ZodiakColors.textSecondary)
                colorRow("textNegative", ZodiakColors.textNegative)
                colorRow("actionPrimary", ZodiakColors.actionPrimary)
                colorRow("actionWarningSecondary", ZodiakColors.actionWarningSecondary)
                colorRow("borderPrimary", ZodiakColors.borderPrimary)
            }
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

private func colorRow(_ name: String, _ color: Color) -> some View {
    HStack(spacing: ZodiakSpacing.s8) {
        RoundedRectangle(cornerRadius: ZodiakRadii.xs)
            .fill(color)
            .frame(width: 40, height: 24)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                    .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
            )
        ZodiakText(name, style: .body())
    }
}

#Preview("Tipografia") {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
        ZodiakText("Headline — Ubuntu Light 32pt", style: .headline)
        ZodiakText("Title 1 — Ubuntu Light 24pt", style: .title1)
        ZodiakText("Title 2 — Ubuntu Regular 18pt", style: .title2)
        ZodiakText("Title 3 — Ubuntu Regular 16pt", style: .title3)
        ZodiakText("Body — Ubuntu Regular 16pt", style: .body())
        ZodiakText("Caption — Ubuntu Regular 12pt", style: .caption())
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}

#Preview("Botões") {
    VStack(spacing: ZodiakSpacing.s16) {
        ZodiakButtonPrimary(title: "Primary — Confirmar", action: {})
        ZodiakButtonSecondary(title: "Secondary — Cancelar", action: {})
        ZodiakButtonTertiary(title: "Tertiary — Saiba mais", action: {})
        ZodiakDangerButton(title: "Warning — Excluir", action: {})
        ZodiakButtonPrimary(title: "catalog.section.disabled", action: {}, isEnabled: false)
        ZodiakSmallButton(title: "Small Button", action: {})
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}

#Preview("Componentes") {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s16) {
            ZodiakResultCard(
                title: "feature.grades.final_average",
                value: "8.5",
                subtitle: "Acima da média da turma"
            )

            ZodiakResultCardWithBadge(
                title: "Situação",
                value: "shared.state.passed",
                badgeText: "shared.state.passed_decorated",
                badgeColor: ZodiakColors.surfacePositive,
                subtitle: nil
            )

            HStack(spacing: ZodiakSpacing.s16) {
                ZodiakSuccessBadge(text: "shared.state.passed_decorated")
                ZodiakErrorBadge(text: "shared.state.failed_decorated")
                ZodiakWarningBadge(text: "catalog.spec.warning_badge")
            }

            ZodiakSwitch(label: "feature.pix.pay_with_pix", isOn: .constant(true))

            ZodiakLabelledField(
                label: "Nome completo",
                placeholder: "shared.placeholder.name",
                text: .constant("")
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

#Preview("Tabs") {
    struct TabsPreview: View {
        @State var selectedSmall = 0
        @State var selectedMedium = 1

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
                    ZodiakText("Size: Small", style: .title3)
                    ZodiakTabs(
                        tabs: ["Overview", "Specs", "Guidelines"],
                        selectedIndex: $selectedSmall,
                        size: .small
                    )

                    ZodiakText("Size: Medium", style: .title3)
                    ZodiakTabs(
                        tabs: ["Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5"],
                        selectedIndex: $selectedMedium,
                        size: .medium
                    )

                    ZodiakText("Container (S)", style: .title3)
                    ZodiakTabContainer(
                        tabs: ["feature.theme_toggle.colors_section", "catalog.home.tab_components"],
                        selectedIndex: $selectedSmall,
                        size: .small
                    ) { index in
                        VStack {
                            if index == 0 {
                                ZodiakText("Conteúdo da aba Cores", style: .body()).padding(ZodiakSpacing.s16)
                            } else {
                                ZodiakText("Conteúdo da aba Componentes", style: .body()).padding(ZodiakSpacing.s16)
                            }
                        }
                    }
                }
                .padding(ZodiakSpacing.s16)
            }
            .background(ZodiakColors.background)
        }
    }
    return TabsPreview()
}

#Preview("Gradientes") {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
        ZodiakText("Zodiak Gradients", style: .title2)

        gradientRow("brand", ZodiakGradients.brand)
        gradientRow("marine", ZodiakGradients.marine)
        gradientRow("azur", ZodiakGradients.azur)
        gradientRow("overlayDark", ZodiakGradients.overlayDark)
        gradientRow("glass", ZodiakGradients.glass)
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}

private func gradientRow(_ name: String, _ gradient: LinearGradient) -> some View {
    HStack(spacing: ZodiakSpacing.s8) {
        RoundedRectangle(cornerRadius: ZodiakRadii.s)
            .fill(gradient)
            .frame(width: 88, height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
            )
        ZodiakText(name, style: .body())
    }
}

#Preview("Novos Componentes") {
    struct NewComponentsPreview: View {
        @State private var checked = true
        @State private var selections: Set<String> = ["Design"]
        @State private var country: String? = "br"

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
                    ZodiakText("Content", style: .title2)
                    ZodiakEyebrow(text: "Featured", size: .medium, background: .onLite)
                    ZodiakAuthor(name: "Marie Dupont", role: "Senior Consultant", date: "23 abr 2026")
                    ZodiakTextLink(label: "Ler estudo completo", action: {}, isExternal: true)
                    ZodiakDivider(hierarchy: .primary, style: .thin)

                    ZodiakText("Inputs", style: .title2)
                    ZodiakCheckbox(label: "Aceito os termos", isChecked: $checked)
                    ZodiakCheckboxGroup(
                        headline: "Áreas de interesse",
                        selections: $selections,
                        options: ["Design", "iOS", "SwiftUI"]
                    )
                    ZodiakDropdown(
                        label: "País",
                        selection: $country,
                        options: [
                            ("br", "shared.country.brazil"),
                            ("pt", "shared.country.portugal"),
                            ("fr", "shared.country.france")
                        ]
                    )

                    ZodiakCombobox(
                        label: "catalog.component_name.combobox",
                        selection: $country,
                        options: [
                            ("br", "shared.country.brazil"),
                            ("pt", "shared.country.portugal"),
                            ("fr", "shared.country.france")
                        ]
                    )

                    ZodiakMultiselect(
                        label: "catalog.component_name.multiselect",
                        options: ["Design", "SwiftUI", "iOS", "catalog.section.accessibility"],
                        selections: $selections
                    )

                    ZodiakText("Feedback", style: .title2)
                    ZodiakNotice(
                        title: "Saiba mais sobre acessibilidade",
                        message: "As recomendações abaixo seguem o padrão do Zodiak.",
                        category: .information,
                        action: {},
                        actionLabel: "Abrir documentação"
                    )

                    ZodiakNotificationBanner(
                        title: "Atualização disponível",
                        message: "Há novos componentes importados do Zodiak neste catálogo.",
                        variant: .information,
                        actionLabel: "Ver detalhes",
                        action: {}
                    )

                    ZodiakText("Navigation", style: .title2)
                    HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakCircularArrowButton(action: {}, direction: .left, style: .secondary)
                        ZodiakCircularArrowButton(action: {}, direction: .right, style: .primary)
                        ZodiakRoundCloseButton(action: {}, style: .ghost)
                        ZodiakHamburgerButton(action: {})
                    }

                    ZodiakMiniMenu(items: [
                        .init(id: "edit", label: "shared.action.edit", icon: "pencil", action: {}),
                        .init(id: "duplicate", label: "shared.action.duplicate", icon: "square.on.square", action: {}),
                        .init(id: "delete", label: "Eliminar", icon: "trash", isDestructive: true, action: {})
                    ])
                }
                .padding(ZodiakSpacing.s16)
            }
            .background(ZodiakColors.background)
        }
    }

    return NewComponentsPreview()
}

#Preview("Composições Tipográficas") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakPreamble(
                eyebrow: "Insights",
                title: "A typographic layer to complement the existing UI components.",
                // swiftlint:disable:next line_length
                summary: "Esses blocos ajudam a trazer para o app a parte editorial do Zodiak além de inputs, botões e feedbacks."
            )

            ZodiakQuote(
                quote: "Consistency is not repetition; it is a shared structure that lets teams move faster.",
                author: "Zodiak",
                role: "Design principles"
            )

            ZodiakKeyFigures(items: [
                .init(value: "92%", label: "Adoção", detail: "entre equipes piloto"),
                .init(value: "4.1x", label: "Agilidade", detail: "na composição de telas"),
                .init(value: "26", label: "Blocos", detail: "já portados para SwiftUI"),
                .init(value: "167", label: "Páginas Figma", detail: "catalogadas no arquivo")
            ])
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

#Preview("Heroes e Listings") {
    let listingItems = [
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

    return ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakHero(
                eyebrow: "Featured",
                title: "A hero organism ready for editorial and product surfaces.",
                summary: "Ele cobre variantes pequenas, grandes e split com base nos tokens já portados para SwiftUI.",
                style: .large,
                mediaSystemImage: "sparkles.rectangle.stack",
                primaryAction: .init(title: "Explorar", action: {}),
                secondaryAction: .init(title: "Saiba mais", action: {}, isSecondary: false),
                metrics: [
                    .init(value: "26", label: "blocos portados"),
                    .init(value: "3", label: "variantes hero"),
                    .init(value: "100%", label: "SwiftUI"),
                    .init(value: "iPad", label: "layout adaptativo")
                ]
            )

            ZodiakListingGroup(title: "Listings", items: listingItems)
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

#Preview("Media e Imagens") {
    let media = ZodiakMediaItem(
        eyebrow: "shared.content.podcast",
        title: "Design systems beyond components",
        summary: "A conversation on operating systems of UI, not just component libraries.",
        duration: "38 min",
        artworkSystemName: "mic.fill",
        action: {}
    )

    let gallery = [
        ZodiakImageTile(
            title: "Parallax block",
            subtitle: "Large visual composition",
            artworkSystemName: "mountain.2.fill"
        ),
        ZodiakImageTile(title: "Side-by-side", subtitle: "Editorial layout", artworkSystemName: "rectangle.split.2x1"),
        ZodiakImageTile(title: "Masonry tile", subtitle: "Adaptive grid", artworkSystemName: "square.grid.2x2"),
        ZodiakImageTile(title: "Gallery item", subtitle: "Media asset", artworkSystemName: "photo.on.rectangle")
    ]

    return ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakPodcastCard(item: media)

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

            ZodiakImageBanner(
                title: "Image-led storytelling for product and editorial pages.",
                summary: "Esse banner cobre os casos em que o bloco visual precisa abrir a narrativa.",
                artworkSystemName: "photo.stack",
                actionTitle: "Abrir galeria",
                action: {}
            )

            ZodiakImageBlock(
                title: "A standalone image composition block",
                summary: "Use esse bloco como base para hero secundário, gallery intro ou media teaser.",
                artworkSystemName: "photo.artframe"
            )

            ZodiakCarousel(items: gallery)
            ZodiakMasonryGrid(items: gallery)
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
