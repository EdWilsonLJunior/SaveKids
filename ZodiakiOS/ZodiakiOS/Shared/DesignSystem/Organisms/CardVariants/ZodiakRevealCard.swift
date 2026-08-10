import SwiftUI

// MARK: - Zodiak Reveal Card
// Figma: Organisms > Card grid — Reveal
// Image card with text overlay that expands on tap to reveal more detail.

// MARK: - Supporting Enum

enum ZodiakRevealCardBackground {
    case gradient
    case solid(Color)
}

// MARK: - Model

struct ZodiakRevealCardItem: Identifiable {
    let id: UUID
    let title: String
    let revealText: String
    let imageSystemName: String
    let tag: String?
    let background: ZodiakRevealCardBackground
    let collapseIconName: String
    let revealedIconName: String
    let detailLines: [String]
    var onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        revealText: String,
        imageSystemName: String = "photo",
        tag: String? = nil,
        background: ZodiakRevealCardBackground = .gradient,
        collapseIconName: String = "plus.circle",
        revealedIconName: String = "minus.circle",
        detailLines: [String] = [],
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.revealText = revealText
        self.imageSystemName = imageSystemName
        self.tag = tag
        self.background = background
        self.collapseIconName = collapseIconName
        self.revealedIconName = revealedIconName
        self.detailLines = detailLines
        self.onTap = onTap
    }
}

// MARK: - Views

struct ZodiakRevealCard: View {
    let item: ZodiakRevealCardItem
    var height: CGFloat = 200

    @State private var isRevealed: Bool = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background
            ZStack {
                switch item.background {
                case .gradient:
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [ZodiakColors.surfaceInk, ZodiakColors.surfaceMarine],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                    Image(systemName: item.imageSystemName)
                        .font(.system(size: 48, weight: .ultraLight))
                        .foregroundColor(.white.opacity(0.15))

                case .solid(let color):
                    Rectangle().fill(color)
                        .overlay(
                            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                                .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
                        )
                }
            }
            .frame(height: height)

            // Default layer: just title
            if !isRevealed {
                HStack {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        if let tag = item.tag {
                            Text(LocalizedStringKey(tag.uppercased()))
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        Text(LocalizedStringKey(item.title))
                            .font(ZodiakTypography.titleSmall)
                            .foregroundColor(.white)
                            .lineLimit(2)
                    }
                    Spacer()
                    Image(systemName: item.collapseIconName)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(ZodiakSpacing.s8)
                .background(
                    LinearGradient(
                        colors: [.clear, Color.black.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .transition(.opacity)
            }

            // Revealed layer: expanded info
            if isRevealed {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    HStack {
                        Text(LocalizedStringKey(item.title))
                            .font(ZodiakTypography.labelMedium)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: item.revealedIconName)
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Text(LocalizedStringKey(item.revealText))
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(.white.opacity(0.85))
                        .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)
                    if !item.detailLines.isEmpty {
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                            ForEach(item.detailLines.indices, id: \.self) { index in
                                Text(item.detailLines[index])
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(.white.opacity(0.65))
                            }
                        }
                    }
                }
                .padding(ZodiakSpacing.s8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black.opacity(0.72))
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .frame(height: height)
        .cornerRadius(ZodiakRadii.s)
        .clipped()
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.25)) {
                isRevealed.toggle()
                item.onTap?()
            }
        }
        .accessibilityLabel(item.title)
        .accessibilityHint(isRevealed ? Text("shared.action.tap_to_collapse") : Text("shared.action.tap_to_reveal"))
        .accessibilityAddTraits(.isButton)
    }
}

struct ZodiakRevealCardGrid: View {
    let items: [ZodiakRevealCardItem]
    /// `nil` = adaptive (auto by device/orientation). Int = fixed, clamped to device max.
    var columns: Int?
    var cardHeight: CGFloat = 200

    var body: some View {
        ZodiakLayoutGrid(
            columns: columns,
            horizontalSpacing: ZodiakSpacing.s8,
            verticalSpacing: ZodiakSpacing.s8,
            applyScreenPadding: false
        ) {
            ForEach(items) { ZodiakRevealCard(item: $0, height: cardHeight) }
        }
    }
}

// MARK: - Preview

#Preview("Reveal Cards") {
    ScrollView {
        ZodiakRevealCardGrid(
            items: [
                .init(
                    title: "Paris HQ",
                    revealText: "Our flagship office housing 3 200 consultants across 12 floors. Open since 2019.",
                    imageSystemName: "building.2",
                    tag: "Office"
                ),
                .init(
                    title: "Innovation Lab",
                    revealText: "Dedicated space for prototyping, user testing and emerging tech pilots.",
                    imageSystemName: "flask",
                    tag: "Lab"
                ),
                .init(
                    title: "Design Studio",
                    // swiftlint:disable:next line_length
                    revealText: "40-seat studio with collaborative walls, dedicated Figma workstations and workshop space.",
                    imageSystemName: "paintbrush",
                    tag: "Studio"
                ),
                .init(
                    title: "Data Center",
                    revealText: "Tier-3 certified facility powering hybrid cloud for enterprise clients.",
                    imageSystemName: "server.rack",
                    tag: "Infrastructure"
                )
            ]
        )
        .padding()
    }
}
