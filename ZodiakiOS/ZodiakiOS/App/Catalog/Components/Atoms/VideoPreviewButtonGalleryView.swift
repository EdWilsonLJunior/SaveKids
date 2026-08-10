import AVKit
import SwiftUI

// MARK: - Video Preview Button Gallery View
// Figma: "Video preview button"

// swiftlint:disable type_body_length
struct VideoPreviewButtonGalleryView: View {
    // MARK: Tab state
    @State private var selectedTab = 0

    // MARK: Manual-mode state (tab Exemplos)
    @State private var isPlaying1 = true
    @State private var isPlaying2 = true
    @State private var progress = 0.40
    @State private var isSimulationPlaying = false

    // MARK: Real-video state
    @State private var realVideoPlayer: AVPlayer?
    @State private var isRealVideoPlaying = false
    @State private var showProgressRing = true
    @State private var videoProgress: Double = 0.0
    @State private var progressObserver: Any?

    // 16:9 aspect ratio for the video container
    private let videoAspectRatio: CGFloat = 16 / 9

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.video_preview_button",
                subtitle: "catalog.video_preview_button.subtitle",
                figmaRef: "Video preview button"
            )

            ZodiakTabs(
                tabs: [
                    "catalog.tab.exemplos",
                    "catalog.tab.tamanhos",
                    "catalog.tab.specs"
                ],
                selectedIndex: $selectedTab
            )
            .padding(.horizontal, -ZodiakSpacing.s8) // slight inset so tabs align with content

            if selectedTab == 0 {
                examplesContent
            } else if selectedTab == 1 {
                sizesContent
            } else {
                specsContent
            }
        }
        .zodiakPage(title: "catalog.component_name.video_preview_button")
        .onDisappear {
            realVideoPlayer?.pause()
            if let obs = progressObserver { realVideoPlayer?.removeTimeObserver(obs) }
        }
    }

    // MARK: - Examples tab

    @ViewBuilder private var examplesContent: some View {
        // Com anel de progresso (modo Manual)
        gallerySectionCard(title: "catalog.section.com_anel_de_progresso") {
            HStack(spacing: ZodiakSpacing.s4) {
                ZodiakBadge(
                    text: "catalog.videopreviewbutton.mode_manual",
                    backgroundColor: ZodiakColors.surfacePositive,
                    foregroundColor: ZodiakColors.textPrimary
                )
                ZodiakChip(
                    text: isPlaying1
                        ? "catalog.videopreviewbutton.state_playing"
                        : "catalog.videopreviewbutton.state_paused",
                    isActive: isPlaying1
                )
                Spacer()
            }
            ZodiakText("catalog.videopreviewbutton.desc_0", style: .caption(color: .secondary))
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                    .fill(ZodiakColors.surfaceMarine)
                    .aspectRatio(videoAspectRatio, contentMode: .fit)
                    .overlay(
                        Image(systemName: isPlaying1 ? "video.fill" : "pause.rectangle.fill")
                            .font(.system(size: 36, weight: .ultraLight))
                            .foregroundColor(Color.white.opacity(0.20))
                    )
                ZodiakVideoPreviewButton(
                    isPlaying: $isPlaying1,
                    progress: progress,
                    action: {}
                )
                .padding(ZodiakSpacing.s8)
            }
            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakProgressBar(progress: progress, showLabel: true)
                HStack(spacing: ZodiakSpacing.s16) {
                    ZodiakIconButton(
                        icon: "minus",
                        action: { withAnimation { progress = max(0, progress - 0.1) } },
                        size: .small,
                        style: .secondary,
                        context: .onLite,
                        accessibilityLabel: "catalog.spec.decrement_10pct"
                    )
                    Spacer()
                    ZodiakIconButton(
                        icon: "plus",
                        action: { withAnimation { progress = min(1.0, progress + 0.1) } },
                        size: .small,
                        style: .secondary,
                        context: .onLite,
                        accessibilityLabel: "catalog.spec.increment_10pct"
                    )
                }
            }
        }

        // Sem anel de progresso
        gallerySectionCard(title: "catalog.section.sem_anel_de_progresso") {
            HStack(spacing: ZodiakSpacing.s4) {
                ZodiakChip(
                    text: isPlaying2
                        ? "catalog.videopreviewbutton.state_playing"
                        : "catalog.videopreviewbutton.state_paused",
                    isActive: isPlaying2
                )
                Spacer()
            }
            ZodiakText("catalog.videopreviewbutton.desc_1", style: .caption(color: .secondary))
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                    .fill(ZodiakColors.surfaceInk)
                    .aspectRatio(videoAspectRatio, contentMode: .fit)
                ZodiakVideoPreviewButton(isPlaying: $isPlaying2, action: {})
                    .padding(ZodiakSpacing.s8)
            }
        }

        // Simulação de vídeo — modo Auto
        gallerySectionCard(title: "catalog.section.simulacao_de_video") {
            HStack(spacing: ZodiakSpacing.s4) {
                ZodiakBadge(
                    text: "catalog.videopreviewbutton.mode_auto",
                    backgroundColor: ZodiakColors.actionPrimary,
                    foregroundColor: ZodiakColors.textInverse
                )
                ZodiakChip(
                    text: isSimulationPlaying
                        ? "catalog.videopreviewbutton.state_playing"
                        : "catalog.videopreviewbutton.state_paused",
                    isActive: isSimulationPlaying
                )
                Spacer()
            }
            ZodiakText("catalog.videopreviewbutton.simulation_desc", style: .caption(color: .secondary))
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                    .fill(ZodiakColors.surfaceInk)
                    .aspectRatio(videoAspectRatio, contentMode: .fit)
                    .overlay(
                        Image(systemName: isSimulationPlaying ? "play.fill" : "video.slash")
                            .font(.system(size: 36, weight: .ultraLight))
                            .foregroundColor(Color.white.opacity(0.20))
                    )
                ZodiakVideoPreviewButton(
                    isPlaying: $isSimulationPlaying,
                    duration: 3.0,
                    onComplete: {},
                    action: {}
                )
                .padding(ZodiakSpacing.s8)
            }
        }

        // Vídeo real
        gallerySectionCard(title: "catalog.section.video_real") {
            ZodiakText("catalog.videopreviewbutton.desc_real_video", style: .caption(color: .secondary))

            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let player = realVideoPlayer {
                        VideoPlayer(player: player)
                            .aspectRatio(videoAspectRatio, contentMode: .fit)
                            .clipShape(
                                RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                            )
                    } else {
                        RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                            .fill(ZodiakColors.surfaceInk)
                            .aspectRatio(videoAspectRatio, contentMode: .fit)
                            .overlay(
                                ZodiakSpinner()
                            )
                    }
                }
                ZodiakVideoPreviewButton(
                    isPlaying: $isRealVideoPlaying,
                    progress: videoProgress,
                    action: {},
                    showRing: showProgressRing
                )
                .padding(ZodiakSpacing.s8)
            }
            .task { await loadRealVideo() }
            .onChange(of: isRealVideoPlaying) { _, playing in
                if playing { realVideoPlayer?.play() } else { realVideoPlayer?.pause() }
            }

            // Progresso — imediatamente abaixo do vídeo
            ZodiakProgressBar(progress: videoProgress, showLabel: true)

            // Controlos
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakSwitch(
                    label: "catalog.videopreviewbutton.show_ring",
                    isOn: $showProgressRing
                )

                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        ZodiakText("catalog.videopreviewbutton.restart", style: .body(bold: true))
                        ZodiakText(
                            "catalog.videopreviewbutton.restart_desc",
                            style: .caption(color: .secondary)
                        )
                    }
                    Spacer()
                    ZodiakIconButton(
                        icon: "backward.end.fill",
                        action: { restartVideo() },
                        size: .small,
                        style: .secondary,
                        context: .onLite,
                        accessibilityLabel: "shared.action.restart"
                    )
                }
            }
        }
    }

    // MARK: - Sizes tab

    @ViewBuilder private var sizesContent: some View {
        gallerySectionCard(title: "catalog.section.tamanhos") {
            HStack(alignment: .bottom, spacing: ZodiakSpacing.s24) {
                ForEach([
                    ("Small (32pt)", ZodiakIconButtonSize.small),
                    ("Medium (40pt)", .medium),
                    ("Large (48pt)", .large)
                ], id: \.0) { label, sz in
                    VStack(spacing: ZodiakSpacing.s4) {
                        ZStack {
                            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                                .fill(ZodiakColors.surfaceMarine)
                                .frame(height: 80)
                            ZodiakVideoPreviewButton(
                                isPlaying: .constant(true),
                                progress: 0.6,
                                action: {},
                                size: sz
                            )
                            .allowsHitTesting(false)
                        }
                        ZodiakText(verbatim: label, style: .caption(color: .secondary))
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .zodiakCardWidth()
        }
    }

    // MARK: - Specs tab

    @ViewBuilder private var specsContent: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.componente",
                value: "catalog.spec.val.zodiakvideopreviewbutton",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.isplaying",
                value: "catalog.spec.val.bindingbool_controla_icone_playpause",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.progress",
                value: "catalog.spec.val.double_0010_nil_oculta_o_anel",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.duration",
                value: "catalog.spec.val.timeinterval_modo_auto",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.oncomplete",
                value: "catalog.spec.val.callback_fim_reproducao",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.posicao",
                value: "catalog.spec.val.sempre_bottom_right_do_video",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.fundo",
                value: "rgba(0,0,0,0.20) + ultraThinMaterial blur (onPhoto)",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.stroke",
                value: "1px mobile · 1.4px desktop (strokeWidth param)",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.zodiak_ds",
                value: "catalog.spec.val.buttons_video_preview_button",
                style: .spec()
            )
        }
    }

    // MARK: - Video helpers

    @MainActor
    private func loadRealVideo() async {
        guard realVideoPlayer == nil else { return }
        guard let url = Bundle.main.url(
            forResource: "generate-GettyImages-2176429963",
            withExtension: "mp4"
        ) else { return }

        // Load asset off main thread to avoid blocking UI
        let asset = AVURLAsset(url: url)
        let isPlayable = (try? await asset.load(.isPlayable)) ?? false
        guard isPlayable else { return }

        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        realVideoPlayer = player

        // Periodic observer: update videoProgress every 0.5s
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        progressObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [self] time in
            guard let duration = player.currentItem?.duration,
                  duration.isNumeric, duration.seconds > 0 else { return }
            videoProgress = time.seconds / duration.seconds
        }

        // Auto-reset at end
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { _ in
            isRealVideoPlaying = false
            videoProgress = 0.0
        }
    }

    private func restartVideo() {
        realVideoPlayer?.pause()
        realVideoPlayer?.seek(to: .zero)
        isRealVideoPlaying = false
        videoProgress = 0.0
    }
}
// swiftlint:enable type_body_length

#Preview {
    NavigationStack {
        VideoPreviewButtonGalleryView()
    }
}
