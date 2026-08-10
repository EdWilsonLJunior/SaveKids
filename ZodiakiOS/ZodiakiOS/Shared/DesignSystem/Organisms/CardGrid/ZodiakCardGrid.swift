import SwiftUI

// MARK: - Zodiak Card Grid
// Figma: "Card grid standard" — 2–9 cards in a responsive grid
// Cards expand on "show more" when count > initialCount.
// Uses ZodiakShowMore for progressive disclosure.

// MARK: - Card Grid Item Model

struct ZodiakCardItem: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String?
    let description: String?
    let imageURL: URL?
    let imageName: String?     // SF Symbol name (used as placeholder)
    let tag: String?
    let actionLabel: String?   // Tertiary button label (spec: anatomy item 4)
    var onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        description: String? = nil,
        imageURL: URL? = nil,
        imageName: String? = nil,
        tag: String? = nil,
        actionLabel: String? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.imageURL = imageURL
        self.imageName = imageName
        self.tag = tag
        self.actionLabel = actionLabel
        self.onTap = onTap
    }
}

// MARK: - Zodiak Card View (single card atom)

struct ZodiakCard: View {
    let item: ZodiakCardItem

    var body: some View {
        Button {
            item.onTap?()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                cardImage
                    .frame(height: 120)

                // Content
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    if let tag = item.tag {
                        ZodiakEyebrow(text: tag, size: .medium, background: .onLite)
                    }
                    Text(LocalizedStringKey(item.title))
                        .font(ZodiakTypography.labelMedium)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .lineLimit(2)
                    if let subtitle = item.subtitle {
                        Text(LocalizedStringKey(subtitle))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .lineLimit(1)
                    }
                    if let desc = item.description {
                        Text(LocalizedStringKey(desc))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .lineLimit(3)
                    }
                    if let actionLabel = item.actionLabel {
                        Text(LocalizedStringKey(actionLabel))
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.actionPrimary)
                            .underline()
                    }
                }
                .padding(ZodiakSpacing.s8)
            }
        }
        .buttonStyle(.plain)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 8,
            x: 0,
            y: 2
        )
        .accessibilityLabel([item.title, item.subtitle, item.description].compactMap { $0 }.joined(separator: ", "))
        .accessibilityAddTraits(item.onTap != nil ? .isButton : [])
    }

    @ViewBuilder
    private var cardImage: some View {
        if let imageURL = item.imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                default:
                    iconFallback
                }
            }
            .clipped()
        } else {
            iconFallback
        }
    }

    private var iconFallback: some View {
        ZStack {
            Rectangle()
                .fill(ZodiakColors.surfaceSmoke)
            if let imgName = item.imageName {
                Image(systemName: imgName)
                    .font(.system(size: 28, weight: .light))
                    .foregroundColor(ZodiakColors.actionPrimary.opacity(0.4))
            }
        }
    }
}

// MARK: - Zodiak Card Grid

struct ZodiakCardGrid: View {
    let items: [ZodiakCardItem]
    var columns: Int = 2           // 1 or 2 columns
    var initialCount: Int = 6      // Figma: default shows up to 9 (desktop), 6 for mobile

    @State private var isExpanded = false

    private var visibleItems: [ZodiakCardItem] {
        isExpanded ? items : Array(items.prefix(initialCount))
    }

    private var hasMore: Bool { items.count > initialCount }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakLayoutGrid(
                columns: columns,
                horizontalSpacing: ZodiakSpacing.s8,
                verticalSpacing: ZodiakSpacing.s8,
                applyScreenPadding: false
            ) {
                ForEach(visibleItems) { item in
                    ZodiakCard(item: item)
                }
            }

            if hasMore {
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack(spacing: ZodiakSpacing.s4) {
                        // swiftlint:disable:next line_length
                        Text(isExpanded ? "shared.action.show_less" : "shared.format.show_more_count \(items.count - initialCount)")
                            .font(ZodiakTypography.bodySmall)
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, ZodiakSpacing.s8)
                    .background(ZodiakColors.surface)
                    .cornerRadius(ZodiakRadii.s)
                    .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 1)
                }
                .buttonStyle(.plain)
                // swiftlint:disable:next line_length
                .accessibilityLabel(isExpanded ? "shared.action.show_less" : "shared.format.show_more_hidden \(items.count - initialCount)")
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let sampleItems = (1...9).map { i in
        ZodiakCardItem(
            title: "Artigo \(i) — Zodiak Design System",
            subtitle: "Capgemini · \(i) min leitura",
            description: "Saiba como o Zodiak simplifica a criação de interfaces consistentes na Capgemini.",
            // swiftlint:disable:next line_length
            imageName: ["doc.text", "chart.bar", "person.2", "globe", "star", "lightbulb", "lock.shield", "cloud", "bolt"][i - 1],
            tag: ["Design", "Dev", "UX", "Tech", "Strategy", "Data", "Security", "Cloud", "AI"][i - 1]
        )
    }

    ScrollView {
        ZodiakCardGrid(items: sampleItems, initialCount: 4)
            .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
