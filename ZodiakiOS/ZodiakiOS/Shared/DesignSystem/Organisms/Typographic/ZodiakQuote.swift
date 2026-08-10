import SwiftUI

// MARK: - Zodiak Quote
// Figma: "Quote"
// Citação destacada com autor opcional e estilo editorial.

struct ZodiakQuote: View {
    let quote: String
    var author: String?
    var role: String?
    var onHeavy: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            Image(systemName: "quote.opening")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(onHeavy ? ZodiakColors.brandOrange : ZodiakColors.actionPrimary)

            Text(LocalizedStringKey(quote))
                .font(ZodiakTypography.titleMedium)
                .tracking(ZodiakTypography.HeadingSize.medium.tracking(for: .light))
                .foregroundColor(onHeavy ? ZodiakColors.textInverse : ZodiakColors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            if author != nil || role != nil {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    if let author {
                        Text(LocalizedStringKey(author))
                            .font(ZodiakTypography.bodySmall.bold())
                            .foregroundColor(onHeavy ? ZodiakColors.textInverse : ZodiakColors.textPrimary)
                    }
                    if let role {
                        Text(LocalizedStringKey(role))
                            .font(ZodiakTypography.captionLarge)
                            // swiftlint:disable:next line_length
                            .foregroundColor(onHeavy ? ZodiakColors.textInverse.opacity(0.78) : ZodiakColors.textSecondary)
                    }
                }
            }
        }
        .padding(ZodiakSpacing.s16)
        .background(onHeavy ? ZodiakColors.surfaceInk : ZodiakColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                .stroke(onHeavy ? ZodiakColors.brandOrange.opacity(0.25) : ZodiakColors.borderSecondary, lineWidth: 1)
        )
    }
}

#Preview("Quote") {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s32) {
            ZodiakQuote(
                quote: "Design systems are only useful when they reduce friction for the people shipping products.",
                author: "Marcos Rocha",
                role: "iOS Engineer"
            )

            ZodiakQuote(
                quote: "Clarity scales better than novelty when systems need to stay coherent across teams.",
                author: "Capgemini",
                role: "Zodiak Guidelines",
                onHeavy: true
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
