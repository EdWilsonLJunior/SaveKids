import SwiftUI

// MARK: - Hero Compositions Gallery

struct HeroCompositionsGalleryView: View {
    @State private var showSkeleton = false

    private let primaryAction = ZodiakHeroAction(title: "Explorar", action: {})
    private let secondaryAction = ZodiakHeroAction(title: "Saiba mais", action: {}, isSecondary: true)

    private let metrics: [ZodiakHeroMetric] = [
        .init(value: "55", label: "catalog.home.tab_components"),
        .init(value: "220", label: "catalog.home.icons"),
        .init(value: "113", label: "catalog.home.flags")
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.hero_compositions.title",
                subtitle: "catalog.hero_compositions.subtitle",
                figmaRef: "05 ▪️ HERO"
            )

            // MARK: Hero Small
            gallerySectionCard(title: "catalog.section.hero_small") {
                Text("catalog.hero_compositions.desc_small")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakHero(
                    eyebrow: "catalog.spec.design_system",
                    title: "Compacto e direto.",
                    summary: "Versão condensada do hero — ideal para introduzir seções sem dominar a página.",
                    style: .small,
                    primaryAction: primaryAction
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.altura",
                    value: "catalog.spec.val.hero_small_auto",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.padding",
                    value: "catalog.spec.val.zodiakspacing_xs",
                    style: .spec()
                )
            }

            // MARK: Hero Large
            gallerySectionCard(title: "catalog.section.hero") {
                Text("catalog.hero_compositions.desc_large")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakHero(
                    eyebrow: "Capgemini · Zodiak",
                    title: "Grande impacto visual com métricas.",
                    summary: "Versão ampla com artwork decorativo e grade de métricas. Adapta o padding em iPad.",
                    style: .large,
                    mediaSystemImage: "sparkles",
                    primaryAction: primaryAction,
                    secondaryAction: secondaryAction,
                    metrics: metrics
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.artwork",
                    value: "catalog.spec.val.hero_artwork_bottom_trailing",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.metricas",
                    value: "catalog.spec.val.hero_metricas_grade",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.padding_ipad",
                    value: "catalog.spec.val.zodiakspacing_m",
                    style: .spec()
                )
            }

            // MARK: Hero Split
            gallerySectionCard(title: "catalog.section.hero_split") {
                Text("catalog.hero_compositions.desc_split")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakHero(
                    eyebrow: "iPhone / iPad",
                    title: "Layout lado a lado em iPad.",
                    summary: "Em iPhone empilha verticalmente. Em iPad, texto à esquerda e artwork à direita.",
                    style: .split,
                    mediaSystemImage: "ipad.landscape",
                    primaryAction: primaryAction
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.iphone",
                    value: "catalog.spec.val.hero_split_iphone_stacked",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.ipad",
                    value: "catalog.spec.val.hero_split_ipad_side",
                    style: .spec()
                )
            }

            // MARK: Hero Typographic
            gallerySectionCard(title: "catalog.section.hero_tipografico") {
                Text("catalog.hero_compositions.desc_typographic")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ForEach(ZodiakHeroTypographicShape.allCases, id: \.rawValue) { shape in
                    ZodiakHero(
                        eyebrow: "Forma V\(shape.rawValue + 1)",
                        title: "catalog.composition_name.hero_typographic",
                        summary: "Tipografia e forma geométrica como protagonistas — sem imagem de fundo.",
                        style: .typographic(shape: shape),
                        primaryAction: primaryAction
                    )
                }

                ZodiakInfoRow(
                    "catalog.spec.lbl.variantes",
                    value: "catalog.spec.val.hero_tipografico_5_formas",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.background",
                    value: "catalog.spec.val.hero_tipografico_sem_foto",
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
                    "catalog.spec.lbl.gradiente",
                    value: "catalog.spec.val.zodiakgradients_brand_default",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.acoes",
                    value: "catalog.spec.val.hero_primary_secondary_opcao",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.adaptativo",
                    value: "catalog.spec.val.horizontalSizeClass_regular",
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

                ZodiakHero(
                    eyebrow: "catalog.spec.design_system",
                    title: "Zodiak Hero",
                    summary: "Validação do @Environment(.redactionReasons) no gradiente de background.",
                    style: .small
                )
                .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.hero_compositions.title")
    }
}

// MARK: - Preview

#Preview("Hero Compositions — Light") {
    NavigationStack { HeroCompositionsGalleryView() }
}

#Preview("Hero Compositions — Dark") {
    NavigationStack { HeroCompositionsGalleryView() }
        .preferredColorScheme(.dark)
}
