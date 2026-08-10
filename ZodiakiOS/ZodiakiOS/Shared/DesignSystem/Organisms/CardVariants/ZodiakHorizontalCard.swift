import SwiftUI

// MARK: - Zodiak Horizontal Card
// Figma: Organisms > Card grid — Horizontal
// Image on the left, text on the right. Compact list/feed layout.

struct ZodiakHorizontalCardItem: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String?
    let subtitleTags: [String]
    let description: String?
    let tag: String?
    let author: String?
    let icon: ZodiakIcon
    var onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        subtitleTags: [String] = [],
        description: String? = nil,
        tag: String? = nil,
        author: String? = nil,
        icon: ZodiakIcon = .image,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.subtitleTags = subtitleTags
        self.description = description
        self.tag = tag
        self.author = author
        self.icon = icon
        self.onTap = onTap
    }
}

struct ZodiakHorizontalCard: View {
    let item: ZodiakHorizontalCardItem
    var imageWidth: CGFloat = 96

    var body: some View {
        Button { item.onTap?() } label: {
            HStack(alignment: .top, spacing: 0) {
                // Image
                ZStack {
                    Rectangle().fill(ZodiakColors.surfaceMarine)
                    ZodiakIconView(item.icon, size: .large, color: ZodiakColors.textAlwaysWhite)
                }
                .frame(width: imageWidth)
                .clipped()

                // Text
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    if let tag = item.tag {
                        ZodiakEyebrow(text: tag, size: .small, background: .onLite)
                    }
                    Text(LocalizedStringKey(item.title))
                        .font(ZodiakTypography.labelMedium)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .lineLimit(2)
                    if let subtitle = item.subtitle {
                        Text(LocalizedStringKey(subtitle))
                            .font(ZodiakTypography.captionSmall)
                            .foregroundColor(ZodiakColors.actionPrimary)
                            .lineLimit(1)
                    } else if !item.subtitleTags.isEmpty {
                        HStack(spacing: ZodiakSpacing.s4) {
                            ForEach(item.subtitleTags, id: \.self) { tag in
                                Text(tag)
                                    .font(ZodiakTypography.captionSmall)
                                    .foregroundColor(ZodiakColors.actionPrimary)
                                    .padding(.horizontal, ZodiakSpacing.s4)
                                    .padding(.vertical, 2)
                                    .overlay(Capsule().strokeBorder(ZodiakColors.actionPrimary, lineWidth: 1))
                            }
                        }
                    }
                    if let desc = item.description {
                        Text(LocalizedStringKey(desc))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .lineLimit(2)
                    }
                    if let author = item.author {
                        ZodiakAuthor(
                            name: author,
                            avatarInitials: String(author.prefix(2)).uppercased()
                        )
                    }
                }
                .padding(ZodiakSpacing.s4)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
            .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
            .clipped()
        }
        .buttonStyle(.plain)
        .accessibilityLabel([item.title, item.subtitle].compactMap { $0 }.joined(separator: ", "))
    }
}

struct ZodiakHorizontalCardList: View {
    let items: [ZodiakHorizontalCardItem]

    var body: some View {
        VStack(spacing: ZodiakSpacing.s4) {
            ForEach(items) { ZodiakHorizontalCard(item: $0) }
        }
    }
}

// MARK: - Preview

#Preview("Horizontal Cards") {
    ScrollView {
        ZodiakHorizontalCardList(
            items: [
                .init(
                    title: "How design tokens scale",
                    subtitle: "5 min · Design Systems",
                    description: "A look at how semantic layering reduces churn.",
                    tag: "Article",
                    icon: .swatchesPalette
                ),
                .init(
                    title: "Swift performance tips",
                    subtitle: "8 min · Engineering",
                    description: "Profile first, optimise second.",
                    tag: "Deep Dive",
                    icon: .code
                ),
                .init(
                    title: "Accessibility in SwiftUI",
                    subtitle: "6 min · Mobile",
                    tag: "Guide",
                    icon: .user
                )
            ]
        )
        .padding()
    }
}
