import SwiftUI

// MARK: - Zodiak Typographic Card
// Figma: Organisms > Card grid — Typographic
// No image; pure typographic layout.
// Leading slot: icon (SF Symbol) or number (0–9). Spec: "Icon / Number" property.
// Size: small (mobile) | medium (tablet+desktop).
// Background: page (white) | azur (dark blue).

// MARK: - Supporting Enums

enum ZodiakTypographicCardLeading {
    case icon(ZodiakIcon)
    case number(Int)    // 0–9
    case none
}

enum ZodiakTypographicCardSize {
    case small, medium
    var headlineFont: Font {
        switch self {
        case .small:  return ZodiakTypography.titleMedium     // heading-m: 24pt
        case .medium: return ZodiakTypography.titleSmall     // heading-s: 18pt
        }
    }
}

enum ZodiakTypographicCardBackground {
    case page   // Page background — textPrimary text
    case azur   // Azur context — textInverse text on surfaceAzur
    var backgroundColor: Color {
        switch self {
        case .page: return ZodiakColors.surface
        case .azur: return ZodiakColors.surfaceAzur
        }
    }
    var textColor: Color {
        switch self {
        case .page: return ZodiakColors.textPrimary
        case .azur: return ZodiakColors.textAlwaysWhite
        }
    }
    var secondaryTextColor: Color {
        switch self {
        case .page: return ZodiakColors.textSecondary
        case .azur: return ZodiakColors.textAlwaysWhite.opacity(0.7)
        }
    }
    var eyebrowBackground: ZodiakEyebrowBackground {
        switch self {
        case .page: return .onLite
        case .azur: return .onHeavy
        }
    }
}

// MARK: - Model

struct ZodiakTypographicCardItem: Identifiable {
    let id: UUID
    let category: String?
    let title: String
    let body: String?
    let meta: String?
    let metaRole: String?
    let leading: ZodiakTypographicCardLeading
    let size: ZodiakTypographicCardSize
    let cardBackground: ZodiakTypographicCardBackground
    let actionLabel: String?   // Tertiary button label (spec: "Show Button")
    var onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        category: String? = nil,
        title: String,
        body: String? = nil,
        meta: String? = nil,
        metaRole: String? = nil,
        leading: ZodiakTypographicCardLeading = .none,
        size: ZodiakTypographicCardSize = .medium,
        cardBackground: ZodiakTypographicCardBackground = .page,
        actionLabel: String? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.category = category
        self.title = title
        self.body = body
        self.meta = meta
        self.metaRole = metaRole
        self.leading = leading
        self.size = size
        self.cardBackground = cardBackground
        self.actionLabel = actionLabel
        self.onTap = onTap
    }
}

// MARK: - Views

struct ZodiakTypographicCard: View {
    let item: ZodiakTypographicCardItem

    var body: some View {
        Button { item.onTap?() } label: {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                // Leading: icon or number (spec "Icon / Number" property)
                switch item.leading {
                case .icon(let zodiakIcon):
                    ZodiakIconView(zodiakIcon, size: .large, color: item.cardBackground.textColor)

                case .number(let value):
                    Text("\(value)")
                        .font(ZodiakTypography.titleLarge)
                        .fontWeight(.light)
                        .foregroundColor(item.cardBackground.textColor)

                case .none:
                    EmptyView()
                }

                if let category = item.category {
                    ZodiakEyebrow(
                        text: category,
                        size: .medium,
                        background: item.cardBackground.eyebrowBackground
                    )
                }

                Text(LocalizedStringKey(item.title))
                    .font(item.size.headlineFont)
                    .foregroundColor(item.cardBackground.textColor)
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)

                if let body = item.body {
                    Text(LocalizedStringKey(body))
                        .font(ZodiakTypography.bodyMedium)
                        .foregroundColor(item.cardBackground.secondaryTextColor)
                        .lineLimit(3)
                }

                if let meta = item.meta {
                    Spacer(minLength: ZodiakSpacing.s8)
                    ZodiakAuthor(
                        name: meta,
                        role: item.metaRole,
                        avatarInitials: String(meta.prefix(2)).uppercased()
                    )
                }

                if let actionLabel = item.actionLabel {
                    Text(LocalizedStringKey(actionLabel))
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(item.cardBackground.textColor)
                        .underline()
                }
            }
            .padding(ZodiakSpacing.s8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(item.cardBackground.backgroundColor)
            .cornerRadius(ZodiakRadii.s)
            .overlay(RoundedRectangle(cornerRadius: ZodiakRadii.s).stroke(ZodiakColors.borderSecondary, lineWidth: 1))
        }
        .buttonStyle(.plain)
        .accessibilityLabel([item.category, item.title].compactMap { $0 }.joined(separator: " - "))
    }
}

struct ZodiakTypographicCardGrid: View {
    let items: [ZodiakTypographicCardItem]
    var columns: Int = 2

    private var cols: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: ZodiakSpacing.s8), count: columns)
    }

    var body: some View {
        LazyVGrid(columns: cols, spacing: ZodiakSpacing.s8) {
            ForEach(items) { ZodiakTypographicCard(item: $0) }
        }
    }
}

// MARK: - Preview

#Preview("Typographic Cards") {
    ScrollView {
        ZodiakTypographicCardGrid(
            items: [
                .init(
                    category: "Research",
                    title: "Why semantic tokens matter",
                    body: "Short body explaining the concept and outcomes.",
                    meta: "12 Apr 2026",
                    leading: .icon(.searchMagnifyingGlass)
                ),
                .init(
                    category: "Engineering",
                    title: "Composable architectures in Swift",
                    body: "How small units compose into large applications.",
                    meta: "8 Apr 2026",
                    leading: .number(2)
                ),
                .init(
                    category: "Design",
                    title: "Color ramps and accessibility",
                    body: "Contrast ratios, primitives and semantic mapping.",
                    meta: "3 Apr 2026",
                    leading: .icon(.swatchesPalette),
                    cardBackground: .azur,
                    actionLabel: "Read more"
                ),
                .init(
                    category: "Strategy",
                    title: "Design systems ROI",
                    meta: "1 Apr 2026",
                    leading: .number(4),
                    size: .small
                )
            ]
        )
        .padding()
    }
}
