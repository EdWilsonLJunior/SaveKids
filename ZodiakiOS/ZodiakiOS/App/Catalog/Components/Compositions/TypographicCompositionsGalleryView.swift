import SwiftUI

// MARK: - Typographic Compositions Gallery

struct TypographicCompositionsGalleryView: View {
    @State private var showSkeleton = false

    private let keyFigures: [ZodiakKeyFigureItem] = [
        .init(value: "92%", label: "Satisfação do cliente", detail: "entre usuários ativos"),
        .init(value: "3.4×", label: "Velocidade de entrega", detail: "na montagem de UI"),
        .init(value: "55", label: "catalog.home.tab_components", detail: "reutilizados em produção"),
        .init(value: "11", label: "Squads", detail: "consumindo o sistema")
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.typographic_compositions.title",
                subtitle: "catalog.typographic_compositions.subtitle",
                figmaRef: "06 ▪️ TYPOGRAPHIC"
            )

            // MARK: Headline Section
            gallerySectionCard(title: "catalog.section.headline_section") {
                Text("catalog.typographic_compositions.desc_headline")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakHeadlineSection(
                    title: "Plain — Cabeçalho simples",
                    eyebrow: "catalog.section.default",
                    style: .plain
                )

                ZodiakDivider()

                ZodiakHeadlineSection(
                    title: "Com introdução e texto descritivo.",
                    eyebrow: "Com Intro",
                    intro: "Adicione contexto abaixo do título com um parágrafo introdutório.",
                    style: .plainWithIntro
                )

                ZodiakDivider()

                ZodiakHeadlineSection(
                    title: "Alinhado ao centro",
                    eyebrow: "Middle",
                    style: .middleAligned
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.variantes",
                    value: "catalog.spec.val.headline_4_estilos",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.ipad",
                    value: "catalog.spec.val.headline_font_headline",
                    style: .spec()
                )
            }

            // MARK: Key Figures
            gallerySectionCard(title: "catalog.section.key_figures") {
                Text("catalog.typographic_compositions.desc_keyfigures")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakKeyFigures(items: keyFigures, columns: 2)

                ZodiakDivider()

                ZodiakKeyFigures(items: Array(keyFigures.prefix(2)), columns: 2, onHeavy: true)
                    .padding(ZodiakSpacing.s16)
                    .background(ZodiakColors.surfaceInk)
                    .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))

                ZodiakInfoRow(
                    "catalog.spec.lbl.colunas",
                    value: "catalog.spec.val.keyfigures_colunas_configuravel",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.variante",
                    value: "catalog.spec.val.keyfigures_on_heavy",
                    style: .spec()
                )
            }

            // MARK: Preamble
            gallerySectionCard(title: "catalog.section.preamble") {
                Text("catalog.typographic_compositions.desc_preamble")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakPreamble(
                    eyebrow: "catalog.home.zodiak_ds_full",
                    title: "Leading with experience and measurable outcomes.",
                    summary: "Use esse bloco para introduzir uma página institucional, artigo ou módulo editorial."
                )

                ZodiakPreamble(
                    eyebrow: "On Heavy",
                    title: "Preamble em fundo escuro mantém a hierarquia.",
                    summary: "Mesmo componente adaptado para superfícies de alto contraste.",
                    background: ZodiakColors.surfaceInk,
                    onHeavy: true
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.eyebrow",
                    value: "catalog.spec.val.preamble_eyebrow_opcional",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.on_heavy",
                    value: "catalog.spec.val.preamble_on_heavy",
                    style: .spec()
                )
            }

            // MARK: Quote
            gallerySectionCard(title: "catalog.section.quote") {
                Text("catalog.typographic_compositions.desc_quote")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakQuote(
                    quote: "Design systems are only useful when they reduce friction for the people shipping products.",
                    author: "Capgemini",
                    role: "Zodiak Design Guidelines"
                )

                ZodiakQuote(
                    quote: "Clarity scales better than novelty when systems need to stay coherent across teams.",
                    author: "Zodiak",
                    role: "Foundations · Principles",
                    onHeavy: true
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.icone",
                    value: "catalog.spec.val.quote_icon_quote_opening",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.autor",
                    value: "catalog.spec.val.quote_autor_role_opcionais",
                    style: .spec()
                )
            }

            // MARK: Text Block
            gallerySectionCard(title: "catalog.section.text_block") {
                Text("catalog.typographic_compositions.desc_textblock")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakTextBlock(
                    headingLarge: "Leading — alinhamento padrão",
                    // swiftlint:disable:next line_length
                    bodyText: "O alinhamento à esquerda é o padrão para blocos de texto editoriais em português. Garante legibilidade e hierarquia clara.",
                    alignment: .leading
                )

                ZodiakDivider()

                ZodiakTextBlock(
                    headingLarge: "Center — alinhamento central",
                    // swiftlint:disable:next line_length
                    bodyText: "Use o centro para CTAs isoladas, citações curtas ou landing sections com impacto visual.",
                    alignment: .center
                )

                ZodiakDivider()

                ZodiakTextBlock(
                    headingLarge: "Two Column (iPad)",
                    // swiftlint:disable:next line_length
                    bodyText: "Em iPad, o conteúdo se distribui em duas colunas balanceadas. Em iPhone recai automaticamente para single column.",
                    headingSmall: "Adaptativo via horizontalSizeClass",
                    alignment: .twoColumn
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.variantes",
                    value: "catalog.spec.val.textblock_3_alinhamentos",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.two_column",
                    value: "catalog.spec.val.textblock_ipad_only",
                    style: .spec()
                )
            }

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.headline_section",
                    value: "catalog.spec.val.typographic_headline_section_figma",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.key_figures",
                    value: "catalog.spec.val.typographic_key_figures_figma",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.preamble",
                    value: "catalog.spec.val.typographic_preamble_figma",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.quote",
                    value: "catalog.spec.val.typographic_quote_figma",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.text_block",
                    value: "catalog.spec.val.typographic_text_block_figma",
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

                ZodiakHeadlineSection(
                    title: "Título de exemplo",
                    eyebrow: "Eyebrow",
                    style: .plain
                )
                .zodiakSkeleton(active: showSkeleton)

                ZodiakKeyFigures(items: Array(keyFigures.prefix(2)))
                    .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.typographic_compositions.title")
    }
}

// MARK: - Preview

#Preview("Typographic — Light") {
    NavigationStack { TypographicCompositionsGalleryView() }
}

#Preview("Typographic — Dark") {
    NavigationStack { TypographicCompositionsGalleryView() }
        .preferredColorScheme(.dark)
}
