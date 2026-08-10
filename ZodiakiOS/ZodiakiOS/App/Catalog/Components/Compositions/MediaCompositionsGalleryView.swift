import SwiftUI

// MARK: - Media Compositions Gallery

struct MediaCompositionsGalleryView: View {
    @State private var showSkeleton = false

    private let podcastSmallItem = ZodiakMediaItem(
        eyebrow: "shared.content.podcast",
        title: "Design Systems ao Vivo",
        summary: "Como times distribuídos mantêm consistência visual em escala.",
        duration: "42 min",
        artworkSystemName: "mic.fill"
    )

    private let podcastLargeItem = ZodiakMediaItem(
        eyebrow: "Capgemini Talks",
        title: "Projetando para acessibilidade em apps iOS",
        // swiftlint:disable:next line_length
        summary: "Uma conversa profunda sobre os desafios de garantir WCAG 2.1 AA em produtos mobile, com demos ao vivo e análise de casos reais de grandes equipes.",
        duration: "58 min",
        artworkSystemName: "waveform"
    )

    private let videoBannerItem = ZodiakMediaItem(
        eyebrow: "Vídeo",
        title: "Zodiak Design System — Visão Geral",
        summary: "Explore tokens, componentes e composições que formam o Zodiak.",
        duration: nil,
        artworkSystemName: "play.circle.fill",
        action: {}
    )

    private let videoTextItem = ZodiakMediaItem(
        eyebrow: "Tutorial",
        title: "Configurando tokens no Xcode",
        summary: "Aprenda a importar e usar design tokens do Zodiak em projetos SwiftUI.",
        duration: "18 min",
        artworkSystemName: "video.fill",
        action: {}
    )

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.media_compositions.title",
                subtitle: "catalog.media_compositions.subtitle",
                figmaRef: "07 ▪️ MEDIA"
            )

            // MARK: Podcast Small
            gallerySectionCard(title: "catalog.section.podcast_small") {
                Text("catalog.media_compositions.desc_podcast_small")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakPodcastCard(item: podcastSmallItem)

                ZodiakInfoRow(
                    "catalog.spec.lbl.artwork",
                    value: "catalog.spec.val.podcast_small_artwork_96pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.layout",
                    value: "catalog.spec.val.podcast_small_horizontal",
                    style: .spec()
                )
            }

            // MARK: Podcast Large
            gallerySectionCard(title: "catalog.section.podcast_large") {
                Text("catalog.media_compositions.desc_podcast_large")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakPodcastLarge(
                    item: podcastLargeItem,
                    guest: "Com Marcos Rocha, iOS Engineer",
                    background: .page
                )

                ZodiakPodcastLarge(
                    item: podcastLargeItem,
                    guest: "Com Marcos Rocha, iOS Engineer",
                    background: .fog
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.ipad",
                    value: "catalog.spec.val.podcast_large_ipad_280pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.iphone",
                    value: "catalog.spec.val.podcast_large_iphone_200pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.background",
                    value: "catalog.spec.val.podcast_large_page_fog_image",
                    style: .spec()
                )
            }

            // MARK: Video Banner
            gallerySectionCard(title: "catalog.section.video_banner") {
                Text("catalog.media_compositions.desc_video_banner")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakVideoBanner(item: videoBannerItem)

                ZodiakInfoRow(
                    "catalog.spec.lbl.altura",
                    value: "catalog.spec.val.video_banner_min_240pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.gradiente",
                    value: "catalog.spec.val.zodiakgradients_marine",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.play",
                    value: "catalog.spec.val.video_banner_play_circle_72pt",
                    style: .spec()
                )
            }

            // MARK: Vídeo e Texto
            gallerySectionCard(title: "catalog.section.video_e_texto") {
                Text("catalog.media_compositions.desc_video_text")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakVideoAndText(
                    item: videoTextItem,
                    orientation: .leading,
                    background: .fog
                )

                ZodiakVideoAndText(
                    item: videoTextItem,
                    orientation: .trailing,
                    background: .fog
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.orientacao",
                    value: "catalog.spec.val.video_texto_leading_trailing",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.ipad",
                    value: "catalog.spec.val.video_texto_ipad_side_by_side",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.iphone",
                    value: "catalog.spec.val.video_texto_iphone_stacked",
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
                    "catalog.spec.lbl.modelo_de_dados",
                    value: "catalog.spec.val.media_ZodiakMediaItem",
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
                    title: "Mídia de exemplo",
                    subtitle: "Media · 8 min",
                    imageName: "play.rectangle"
                ))
                .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.media_compositions.title")
    }
}

// MARK: - Preview

#Preview("Media — Light") {
    NavigationStack { MediaCompositionsGalleryView() }
}

#Preview("Media — Dark") {
    NavigationStack { MediaCompositionsGalleryView() }
        .preferredColorScheme(.dark)
}
