import SwiftUI

// MARK: - Zodiak Tall Card
// Figma: Organisms > Card grid — Tall
// Full-width card with large image, gradient overlay and text at bottom.

struct ZodiakTallCardItem: Identifiable {
    let id: UUID
    let eyebrow: String?
    let title: String
    let description: String?
    let imageSystemName: String
    var imageHeight: CGFloat
    var onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        eyebrow: String? = nil,
        title: String,
        description: String? = nil,
        imageSystemName: String = "photo",
        imageHeight: CGFloat = 260,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.eyebrow = eyebrow
        self.title = title
        self.description = description
        self.imageSystemName = imageSystemName
        self.imageHeight = imageHeight
        self.onTap = onTap
    }
}

struct ZodiakTallCard: View {
    let item: ZodiakTallCardItem

    var body: some View {
        Button { item.onTap?() } label: {
            ZStack(alignment: .bottomLeading) {
                // Background image area
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [ZodiakColors.surfaceMarine, ZodiakColors.surfaceSmoke],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                    Image(systemName: item.imageSystemName)
                        .font(.system(size: 56, weight: .ultraLight))
                        .foregroundColor(.white.opacity(0.12))
                }
                .frame(height: item.imageHeight)

                // Gradient overlay
                LinearGradient(
                    colors: [.clear, Color.black.opacity(0.65)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                .frame(height: item.imageHeight)

                // Text overlay
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    if let eyebrow = item.eyebrow {
                        Text(LocalizedStringKey(eyebrow.uppercased()))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Text(LocalizedStringKey(item.title))
                        .font(ZodiakTypography.labelLarge)
                        .foregroundColor(.white)
                        .lineLimit(3)
                    if let desc = item.description {
                        Text(LocalizedStringKey(desc))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(.white.opacity(0.75))
                            .lineLimit(2)
                    }
                }
                .padding(ZodiakSpacing.s8)
            }
            .cornerRadius(ZodiakRadii.s)
            .clipped()
        }
        .buttonStyle(.plain)
        .accessibilityLabel([item.eyebrow, item.title].compactMap { $0 }.joined(separator: " - "))
    }
}

// MARK: - Preview

#Preview("Tall Cards") {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s8) {
            // swiftlint:disable:next line_length
            ZodiakTallCard(item: .init(eyebrow: "Feature", title: "Design system at scale", description: "Patterns that survived 200+ screens.", imageSystemName: "rectangle.3.group.fill"))
            // swiftlint:disable:next line_length
            ZodiakTallCard(item: .init(eyebrow: "Case Study", title: "Migrating to SwiftUI", description: "A 12-month journey from UIKit.", imageSystemName: "swift", imageHeight: 200))
        }
        .padding()
    }
}
