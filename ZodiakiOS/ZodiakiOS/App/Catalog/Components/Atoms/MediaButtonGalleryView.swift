import SwiftUI

// MARK: - Media Button Gallery View
// Figma: "Media button"

struct MediaButtonGalleryView: View {
    @State private var isPlaying = false
    @State private var isMuted = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.media_button",
                subtitle: "catalog.media_button.subtitle",
                figmaRef: "Media button"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground_audio_player") {
                Text("catalog.mediabutton.desc_0")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                VStack(spacing: ZodiakSpacing.s8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: ZodiakRadii.m)
                            .fill(ZodiakColors.surfaceSmoke)
                            .frame(height: 90)
                        HStack(spacing: ZodiakSpacing.s16) {
                            ZodiakMediaButton(mediaAction: .back15s, action: {}, variant: .onLite, size: .medium)
                            ZodiakMediaButton(
                                mediaAction: isPlaying ? .pause : .play,
                                action: { isPlaying.toggle() },
                                variant: .onLite, size: .large
                            )
                            ZodiakMediaButton(mediaAction: .forward15s, action: {}, variant: .onLite, size: .medium)
                        }
                    }
                }
            }

            // MARK: onLite — Primary vs Tertiary
            gallerySectionCard(title: "catalog.section.onlite_hierarquia") {
                Text("catalog.mediabutton.desc_1")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakMediaButton(mediaAction: .play, action: {}, variant: .onLite)
                    ZodiakMediaButton(mediaAction: .pause, action: {}, variant: .onLite)
                    ZodiakMediaButton(mediaAction: .stop, action: {}, variant: .onLite)
                }

                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakMediaButton(mediaAction: .skipBack, action: {}, variant: .onLite, size: .medium)
                    ZodiakMediaButton(mediaAction: .back15s, action: {}, variant: .onLite, size: .medium)
                    ZodiakMediaButton(mediaAction: .forward15s, action: {}, variant: .onLite, size: .medium)
                    ZodiakMediaButton(mediaAction: .skipForward, action: {}, variant: .onLite, size: .medium)
                    ZodiakMediaButton(mediaAction: .shuffle, action: {}, variant: .onLite, size: .medium)
                    ZodiakMediaButton(mediaAction: .speed("1×"), action: {}, variant: .onLite, size: .medium)
                }

                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakMediaButton(
                        mediaAction: .muteOff,
                        action: { isMuted.toggle() },
                        variant: .onLite,
                        size: .medium
                    )
                    ZodiakMediaButton(mediaAction: .minVolume, action: {}, variant: .onLite, size: .medium)
                    ZodiakMediaButton(mediaAction: .maxVolume, action: {}, variant: .onLite, size: .medium)
                    ZodiakMediaButton(mediaAction: .close, action: {}, variant: .onLite, size: .medium)
                }
            }

            // MARK: onHeavy
            gallerySectionCard(title: "catalog.section.onheavy_sobre_fundo_escuro") {
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakMediaButton(mediaAction: .play, action: {}, variant: .onHeavy)
                    ZodiakMediaButton(mediaAction: .pause, action: {}, variant: .onHeavy)
                    ZodiakMediaButton(mediaAction: .back15s, action: {}, variant: .onHeavy, size: .medium)
                    ZodiakMediaButton(mediaAction: .forward15s, action: {}, variant: .onHeavy, size: .medium)
                    ZodiakMediaButton(mediaAction: .speed("2×"), action: {}, variant: .onHeavy, size: .medium)
                }
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.actionPrimary)
                .cornerRadius(ZodiakRadii.s)
            }

            // MARK: onPhoto
            gallerySectionCard(title: "catalog.section.onphoto_sobre_imagemvideo") {
                ZStack {
                    RoundedRectangle(cornerRadius: ZodiakRadii.m)
                        .fill(ZodiakColors.surfaceMarine)
                        .frame(height: 120)
                    HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakMediaButton(mediaAction: .back15s, action: {}, variant: .onPhoto, size: .medium)
                        ZodiakMediaButton(mediaAction: .play, action: {}, variant: .onPhoto)
                        ZodiakMediaButton(mediaAction: .forward15s, action: {}, variant: .onPhoto, size: .medium)
                    }
                }
            }

            // MARK: Estados
            gallerySectionCard(title: "catalog.section.desabilitado") {
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakMediaButton(mediaAction: .play, action: {}, variant: .onLite, isEnabled: false)
                    ZodiakMediaButton(
                        mediaAction: .back15s,
                        action: {},
                        variant: .onLite,
                        size: .medium,
                        isEnabled: false
                    )
                    ZodiakMediaButton(
                        mediaAction: .shuffle,
                        action: {},
                        variant: .onLite,
                        size: .medium,
                        isEnabled: false
                    )
                }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.componente",
                    value: "catalog.spec.val.zodiakmediabutton",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.variantes",
                    value: "catalog.spec.val.onlite_onheavy_onphoto",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.tamanhos",
                    value: "catalog.spec.val.small_38pt_medium_48pt_large_56pt",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.primary", value: "catalog.spec.val.play_pause_stop", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.tertiary",
                    value: "catalog.spec.val.todos_os_demais_controles",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.zodiak_ds",
                    value: "catalog.spec.val.buttons_media_button",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component_name.media_button")
    }
}

#Preview {
    NavigationStack {
        MediaButtonGalleryView()
    }
}
