// Reason: Multi-variant media block organism — all variants belong in same file.
import SwiftUI

// MARK: - Zodiak Media Blocks
// Adaptações SwiftUI para os blocos da seção "Media" do Zodiak.

struct ZodiakMediaItem: Identifiable {
    let id = UUID()
    let eyebrow: String?
    let title: String
    let summary: String?
    let duration: String?
    let artworkSystemName: String
    var action: (() -> Void)?
}

struct ZodiakPodcastCard: View {
    let item: ZodiakMediaItem

    var body: some View {
        Button {
            item.action?()
        } label: {
            HStack(spacing: ZodiakSpacing.s8) {
                mediaArtwork(icon: item.artworkSystemName, size: 96)

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    if let eyebrow = item.eyebrow {
                        ZodiakEyebrow(text: eyebrow, size: .small, background: .onLite)
                    }

                    Text(LocalizedStringKey(item.title))
                        .font(ZodiakTypography.labelLarge)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)

                    if let summary = item.summary {
                        Text(LocalizedStringKey(summary))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .lineLimit(3)
                    }

                    HStack(spacing: ZodiakSpacing.s4) {
                        Image(ZodiakIcon.headphones.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                        if let duration = item.duration {
                            Text(duration)
                                .font(ZodiakTypography.captionLarge)
                        }
                    }
                    .foregroundColor(ZodiakColors.textSecondary)
                }

                Spacer(minLength: 0)
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                    .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private func mediaArtwork(icon: String, size: CGFloat) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                .fill(ZodiakGradients.azur)
                .frame(width: size, height: size)
            Image(systemName: icon)
                .font(.system(size: size * 0.32, weight: .light))
                .foregroundColor(ZodiakColors.textInverse)
        }
    }
}

struct ZodiakVideoBanner: View {
    let item: ZodiakMediaItem

    var body: some View {
        Button {
            item.action?()
        } label: {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                    .fill(ZodiakGradients.marine)
                    .frame(minHeight: 240)
                    .overlay(alignment: .center) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 72, height: 72)
                            Image(systemName: item.artworkSystemName)
                                .font(.system(size: 30, weight: .medium))
                                .foregroundColor(ZodiakColors.textInverse)
                        }
                    }

                ZodiakGradients.overlayDark
                    .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous))

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    if let eyebrow = item.eyebrow {
                        ZodiakEyebrow(text: eyebrow, size: .small, background: .onHeavy)
                    }
                    Text(LocalizedStringKey(item.title))
                        .font(ZodiakTypography.titleMedium)
                        .foregroundColor(ZodiakColors.textInverse)
                        .fixedSize(horizontal: false, vertical: true)
                    if let summary = item.summary {
                        Text(LocalizedStringKey(summary))
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textInverse.opacity(0.85))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(ZodiakSpacing.s16)
            }
        }
        .buttonStyle(.plain)
    }
}

struct ZodiakImageBanner: View {
    let title: String
    let summary: String?
    var artworkSystemName: String = "photo.on.rectangle"
    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                .fill(ZodiakGradients.azur)
                .frame(minHeight: 220)
                .overlay(alignment: .topTrailing) {
                    Image(systemName: artworkSystemName)
                        .font(.system(size: 84, weight: .ultraLight))
                        .foregroundColor(Color.white.opacity(0.16))
                        .padding(ZodiakSpacing.s16)
                }

            ZodiakGradients.overlayMedium
                .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous))

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                Text(LocalizedStringKey(title))
                    .font(ZodiakTypography.titleMedium)
                    .foregroundColor(ZodiakColors.textInverse)
                    .fixedSize(horizontal: false, vertical: true)

                if let summary {
                    Text(LocalizedStringKey(summary))
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textInverse.opacity(0.84))
                        .fixedSize(horizontal: false, vertical: true)
                }

                if let actionTitle, let action {
                    ZodiakButtonSecondary(title: LocalizedStringKey(actionTitle), action: action)
                        .padding(.top, ZodiakSpacing.s4)
                }
            }
            .padding(ZodiakSpacing.s16)
        }
    }
}

// MARK: - ZodiakPodcastLarge
// Figma: "Podcast large"
// Player de podcast full-width com descrição longa, imagem/ilustração e info do convidado.

enum ZodiakPodcastLargeBackground {
    case page
    case fog
    case image

    var cardColor: Color {
        switch self {
        case .page:  return ZodiakColors.surface
        case .fog:   return ZodiakColors.surface
        case .image: return Color.black.opacity(0.55)
        }
    }

    var outerBackground: Color {
        switch self {
        case .page:  return .clear
        case .fog:   return ZodiakColors.surface
        case .image: return ZodiakColors.surfaceInk
        }
    }
}

struct ZodiakPodcastLarge: View {
    let item: ZodiakMediaItem
    var guest: String?
    var background: ZodiakPodcastLargeBackground = .page
    @State private var isPlaying = false

    @Environment(\.horizontalSizeClass) private var sizeClass
    private var isRegularWidth: Bool { sizeClass == .regular }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Imagem/ilustração de topo
            ZStack {
                if background == .image {
                    ZodiakGradients.marine
                } else {
                    ZodiakGradients.azur
                }
                Image(systemName: item.artworkSystemName)
                    .font(.system(size: isRegularWidth ? 96 : 72, weight: .ultraLight))
                    .foregroundColor(ZodiakColors.textInverse.opacity(0.65))
            }
            .frame(maxWidth: .infinity)
            .frame(height: isRegularWidth ? 280 : 200)

            // Conteúdo do player
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                if let eyebrow = item.eyebrow {
                    ZodiakEyebrow(text: eyebrow, size: .small, background: .onLite)
                }

                Text(LocalizedStringKey(item.title))
                    .font(ZodiakTypography.titleSmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)

                if let guest {
                    Text(LocalizedStringKey(guest))
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                }

                if let summary = item.summary {
                    Text(LocalizedStringKey(summary))
                        .font(ZodiakTypography.bodyMedium)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, ZodiakSpacing.s4)
                }

                // Controles de playback
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakMediaButton(mediaAction: .back15s, action: {})
                    ZodiakMediaButton(
                        mediaAction: isPlaying ? .pause : .play,
                        action: { isPlaying.toggle() },
                        size: .large
                    )
                    ZodiakMediaButton(mediaAction: .forward15s, action: {})

                    if let duration = item.duration {
                        Spacer()
                        Text(duration)
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                }
                .padding(.top, ZodiakSpacing.s4)
            }
            .padding(ZodiakSpacing.s16)
            .background(background.cardColor)
        }
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
        )
        .padding(background == .fog ? ZodiakSpacing.s8 : 0)
        .background(background.outerBackground)
    }
}

// MARK: - ZodiakVideoAndText
// Figma: "Video and text"
// Vídeo com título e descrição. Lado-a-lado em iPad, empilhado em iPhone.

enum ZodiakVideoAndTextOrientation {
    case leading   // vídeo à esquerda
    case trailing  // vídeo à direita
}

enum ZodiakVideoAndTextBackground {
    case page
    case fog

    var color: Color {
        switch self {
        case .page: return .clear
        case .fog:  return ZodiakColors.surface
        }
    }
}

struct ZodiakVideoAndText: View {
    let item: ZodiakMediaItem
    var orientation: ZodiakVideoAndTextOrientation = .leading
    var background: ZodiakVideoAndTextBackground = .page

    @Environment(\.horizontalSizeClass) private var sizeClass
    private var isRegularWidth: Bool { sizeClass == .regular }

    var body: some View {
        Group {
            if isRegularWidth {
                sideBySideLayout
            } else {
                stackedLayout
            }
        }
        .background(background.color)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous))
    }

    private var videoThumbnail: some View {
        ZStack {
            ZodiakGradients.marine
            Image(systemName: item.artworkSystemName)
                .font(.system(size: 56, weight: .ultraLight))
                .foregroundColor(ZodiakColors.textInverse.opacity(0.6))
            // Botão de play sobreposto
            Circle()
                .fill(Color.white.opacity(0.15))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "play.fill")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(ZodiakColors.textInverse)
                        .offset(x: 2)
                )
        }
        .frame(minHeight: 200)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
        .contentShape(Rectangle())
        .onTapGesture { item.action?() }
    }

    private var textContent: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            if let eyebrow = item.eyebrow {
                ZodiakEyebrow(text: eyebrow, size: .small, background: .onLite)
            }

            Text(LocalizedStringKey(item.title))
                .font(ZodiakTypography.titleSmall)
                .foregroundColor(ZodiakColors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            if let summary = item.summary {
                Text(LocalizedStringKey(summary))
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            ZodiakButtonPrimary(title: "shared.action.watch", action: { item.action?() })
                .padding(.top, ZodiakSpacing.s4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(ZodiakSpacing.s16)
    }

    @ViewBuilder
    private var sideBySideLayout: some View {
        let videoFirst = (orientation == .leading)
        HStack(alignment: .top, spacing: 0) {
            if videoFirst {
                videoThumbnail.frame(maxWidth: .infinity)
                textContent.frame(maxWidth: .infinity)
            } else {
                textContent.frame(maxWidth: .infinity)
                videoThumbnail.frame(maxWidth: .infinity)
            }
        }
    }

    private var stackedLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            videoThumbnail
            textContent
        }
    }
}

#Preview("Media Blocks") {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s32) {
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

            ZodiakImageBanner(
                title: "Image-led storytelling for product and editorial pages.",
                summary: "Use esse banner quando a peça visual precisa carregar a maior parte do impacto inicial.",
                artworkSystemName: "photo.stack",
                actionTitle: "Abrir galeria",
                action: {}
            )

            ZodiakPodcastLarge(
                item: .init(
                    eyebrow: "shared.content.podcast",
                    title: "Shaping the future of enterprise software",
                    // swiftlint:disable:next line_length
                    summary: "A deep dive into how design systems are transforming collaboration between design and engineering at scale. Featuring leaders from Capgemini's global delivery network.",
                    duration: "52 min",
                    artworkSystemName: "waveform.circle.fill",
                    action: {}
                ),
                guest: "Ana Souza, Principal Architect",
                background: .fog
            )

            ZodiakVideoAndText(
                item: .init(
                    eyebrow: "Vídeo",
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
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
