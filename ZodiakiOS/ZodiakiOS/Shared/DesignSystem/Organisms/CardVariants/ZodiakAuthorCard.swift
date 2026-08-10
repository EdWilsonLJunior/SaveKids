import SwiftUI

// MARK: - Zodiak Author Card
// Figma: Organisms > Card grid — Author
// Anatomy (spec): image → ZodiakAuthor → headline → tertiary button.
// Author size is always S (spec: all viewports).

struct ZodiakAuthorCardItem: Identifiable {
    let id: UUID
    let name: String
    let role: String?
    let date: String?
    let headline: String
    let articleImageName: String?   // SF Symbol for article image placeholder (item 1)
    let actionLabel: String?        // Tertiary button label (spec: anatomy item 4)
    var onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        name: String,
        role: String? = nil,
        date: String? = nil,
        headline: String,
        articleImageName: String? = nil,
        actionLabel: String? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.name = name
        self.role = role
        self.date = date
        self.headline = headline
        self.articleImageName = articleImageName
        self.actionLabel = actionLabel
        self.onTap = onTap
    }
}

struct ZodiakAuthorCard: View {
    let item: ZodiakAuthorCardItem

    var body: some View {
        Button { item.onTap?() } label: {
            VStack(alignment: .leading, spacing: 0) {
                // Item 1: Article image
                ZStack {
                    Rectangle()
                        .fill(ZodiakColors.surfaceSmoke)
                    if let imgName = item.articleImageName {
                        Image(systemName: imgName)
                            .font(.system(size: 28, weight: .light))
                            .foregroundColor(ZodiakColors.actionPrimary.opacity(0.4))
                    }
                }
                .frame(height: 100)

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    // Item 2: ZodiakAuthor molecule (size S — always, per spec)
                    ZodiakAuthor(name: item.name, role: item.role, date: item.date)

                    Divider()
                        .background(ZodiakColors.borderSecondary)

                    // Item 3: Headline
                    Text(LocalizedStringKey(item.headline))
                        .font(ZodiakTypography.labelMedium)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)

                    // Item 4: Tertiary button label (visual only — card is the tap target)
                    if let actionLabel = item.actionLabel {
                        Text(LocalizedStringKey(actionLabel))
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.actionPrimary)
                            .underline()
                    }
                }
                .padding(ZodiakSpacing.s8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
            .overlay(RoundedRectangle(cornerRadius: ZodiakRadii.s).stroke(ZodiakColors.borderSecondary, lineWidth: 1))
            .clipped()
        }
        .buttonStyle(.plain)
        .accessibilityLabel([item.name, item.role, item.headline].compactMap { $0 }.joined(separator: ", "))
    }
}

struct ZodiakAuthorCardGrid: View {
    let items: [ZodiakAuthorCardItem]
    var columns: Int = 2

    private var cols: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: ZodiakSpacing.s8), count: columns)
    }

    var body: some View {
        LazyVGrid(columns: cols, spacing: ZodiakSpacing.s8) {
            ForEach(items) { ZodiakAuthorCard(item: $0) }
        }
    }
}

// MARK: - Preview

#Preview("Author Cards") {
    ScrollView {
        ZodiakAuthorCardGrid(
            items: [
                .init(
                    name: "Alice Martin",
                    role: "Lead Designer",
                    date: "Apr 2026",
                    headline: "Why design tokens matter at the platform level",
                    articleImageName: "paintpalette"
                ),
                .init(
                    name: "Tom Kowalski",
                    role: "Front-end Dev",
                    date: "Mar 2026",
                    headline: "Composable architectures in Swift",
                    articleImageName: "swift",
                    actionLabel: "Read more"
                ),
                .init(
                    name: "Sara Chen",
                    role: "UX Researcher",
                    date: "Feb 2026",
                    headline: "Accessibility as a quality gate, not an afterthought",
                    articleImageName: "figure.and.child.holdinghands"
                ),
                .init(
                    name: "Luca Rossi",
                    role: "Architect",
                    date: "Jan 2026",
                    headline: "iOS architecture patterns compared: MVVM vs TCA",
                    articleImageName: "iphone",
                    actionLabel: "Read more"
                )
            ]
        )
        .padding()
    }
}
