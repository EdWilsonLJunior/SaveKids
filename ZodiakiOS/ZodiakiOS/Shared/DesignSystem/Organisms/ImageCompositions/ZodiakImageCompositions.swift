import SwiftUI

// MARK: - Zodiak Image Compositions
// Blocos adaptados para composições visuais maiores usando placeholders locais.

struct ZodiakImageTile: Identifiable {
    let id: String
    let title: String
    var subtitle: String?
    var artworkSystemName: String
    var imageURL: URL?

    init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String? = nil,
        artworkSystemName: String,
        imageURL: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.artworkSystemName = artworkSystemName
        self.imageURL = imageURL
    }
}

struct ZodiakImageBlock: View {
    let title: String
    var summary: String?
    var artworkSystemName: String = "photo"
    var imageURL: URL?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            artworkView
                .frame(height: 220)
                .clipped()

            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(title))
                    .font(ZodiakTypography.labelLarge)
                    .foregroundColor(ZodiakColors.textPrimary)

                if let summary {
                    Text(LocalizedStringKey(summary))
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
        }
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
        )
    }

    @ViewBuilder
    private var artworkView: some View {
        if let url = imageURL {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFill()
                } else {
                    tileArtwork(icon: artworkSystemName)
                }
            }
        } else {
            tileArtwork(icon: artworkSystemName)
        }
    }

    private func tileArtwork(icon: String) -> some View {
        ZStack {
            ZodiakGradients.marine
            Image(systemName: icon)
                .font(.system(size: 56, weight: .ultraLight))
                .foregroundColor(ZodiakColors.textInverse.opacity(0.75))
        }
    }
}

// MARK: - ZodiakCarousel
// Figma: "Image Compositions / Carousel"
// Paged full-width carousel with optional counter, autoplay and tap callback.
// - showCounter: shows ZodiakSliderCounter below the slides (default true)
// - showNavigationButtons: shows previous/next arrow buttons in the counter (default true)
// - autoplay: advances slide automatically at given interval (pauses on Reduce Motion)
// - onSelect: called when user taps a slide; omit for view-only carousel
struct ZodiakCarousel: View {
    let items: [ZodiakImageTile]
    var autoplay: Duration?
    var showCounter: Bool = true
    var showNavigationButtons: Bool = true
    var onSelect: ((ZodiakImageTile) -> Void)?

    @State private var currentIndex: Int = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            TabView(selection: $currentIndex) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    slideView(for: item)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 300)
            .accessibilityElement(children: .contain)

            if showCounter && items.count > 1 {
                ZodiakSliderCounter(
                    totalItems: items.count,
                    currentIndex: $currentIndex,
                    showNavigationButtons: showNavigationButtons
                )
            }
        }
        .task(id: autoplay != nil) {
            guard let interval = autoplay, !reduceMotion, items.count > 1 else { return }
            while !Task.isCancelled {
                try? await Task.sleep(for: interval)
                guard !Task.isCancelled else { break }
                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                    currentIndex = (currentIndex + 1) % items.count
                }
            }
        }
    }

    @ViewBuilder
    private func slideView(for item: ZodiakImageTile) -> some View {
        if let handler = onSelect {
            Button { handler(item) } label: { slideContent(item: item) }
                .buttonStyle(.plain)
                .accessibilityLabel(item.title)
                .accessibilityAddTraits(.isButton)
        } else {
            slideContent(item: item)
                .accessibilityLabel(item.title)
        }
    }

    private func slideContent(item: ZodiakImageTile) -> some View {
        ZodiakImageBlock(
            title: item.title,
            summary: item.subtitle,
            artworkSystemName: item.artworkSystemName,
            imageURL: item.imageURL
        )
    }
}

struct ZodiakMasonryGrid: View {
    let items: [ZodiakImageTile]

    private let columns = [
        GridItem(.flexible(), spacing: ZodiakSpacing.s8),
        GridItem(.flexible(), spacing: ZodiakSpacing.s8)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: ZodiakSpacing.s8) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZStack {
                        RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                            .fill(index.isMultiple(of: 2) ? ZodiakGradients.brand : ZodiakGradients.azur)
                        Image(systemName: item.artworkSystemName)
                            .font(.system(size: 34, weight: .ultraLight))
                            .foregroundColor(ZodiakColors.textInverse)
                    }
                    .frame(height: index.isMultiple(of: 2) ? 220 : 160)

                    Text(LocalizedStringKey(item.title))
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
            }
        }
    }
}

// MARK: - ZodiakImageTextSymmetrical
// Figma: "Image/text symmetrical"
// Layout 50/50 entre imagem e texto. Lado-a-lado em iPad, empilhado em iPhone.

enum ZodiakImageTextBackground {
    case page
    case fog

    var color: Color {
        switch self {
        case .page: return .clear
        case .fog:  return ZodiakColors.surface
        }
    }
}

struct ZodiakImageTextSymmetrical: View {
    let heading: String
    let bodyText: String
    var artworkSystemName: String = "photo"
    var background: ZodiakImageTextBackground = .page

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
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
        )
    }

    private var imageColumn: some View {
        ZStack {
            ZodiakGradients.marine
            Image(systemName: artworkSystemName)
                .font(.system(size: 56, weight: .ultraLight))
                .foregroundColor(ZodiakColors.textInverse.opacity(0.65))
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: isRegularWidth ? 280 : 200)
    }

    private var textColumn: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            Text(LocalizedStringKey(heading))
                .font(ZodiakTypography.titleSmall)
                .foregroundColor(ZodiakColors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Text(LocalizedStringKey(bodyText))
                .font(ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(ZodiakSpacing.s16)
    }

    // iPad: colunas lado a lado com altura sincronizada
    private var sideBySideLayout: some View {
        HStack(alignment: .top, spacing: 0) {
            imageColumn
            textColumn
        }
    }

    // iPhone: empilhado
    private var stackedLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            imageColumn
            textColumn
        }
    }
}

#Preview("Image Compositions") {
    let items = [
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
            ZodiakImageBlock(
                title: "A standalone image composition block",
                summary: "Use esse bloco como base para hero secundário, gallery intro ou media teaser.",
                artworkSystemName: "photo.artframe"
            )

            ZodiakCarousel(items: items)

            ZodiakMasonryGrid(items: items)

            ZodiakImageTextSymmetrical(
                heading: "Showcase text and image side by side",
                // swiftlint:disable:next line_length
                bodyText: "On iPad the image and text appear in a balanced 50/50 split. On iPhone they stack vertically, preserving readability at any size.",
                artworkSystemName: "rectangle.split.2x1.fill"
            )

            ZodiakImageTextSymmetrical(
                heading: "Surface fog variant",
                // swiftlint:disable:next line_length
                bodyText: "The fog background adds a subtle container that separates this block from the page background.",
                artworkSystemName: "photo.artframe",
                background: .fog
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
