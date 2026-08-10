import SwiftUI

// MARK: - Theme Card Component
struct ThemeCard: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) private var locale
    let theme: QuizTheme
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(systemName: theme.icon)
                    .imageScale(.large)
                    .font(ZodiakTypography.bodyXL)
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .frame(width: 40)

                ZodiakText(theme.displayName, style: .title3)

                Spacer()

                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .font(ZodiakTypography.bodySmall.weight(.semibold))
                    .foregroundColor(ZodiakColors.textSecondary)
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
            .shadow(color: ZodiakColors.borderPrimary.opacity(0.3), radius: 4, x: 0, y: 2)
        }
        .mouseHoverEffect()
        .expandedTouchTarget()
        // swiftlint:disable:next line_length
        .accessibilityLabel(Text(verbatim: String(format: String(localized: "feature.quiz_game.theme_label", locale: locale), theme.displayName)))
        .accessibilityHint(
            Text(verbatim: String(
                format: String(localized: "feature.quiz_game.theme_accessibility", locale: locale),
                theme.displayName
            ))
        )
    }
}

#Preview {
    VStack(spacing: ZodiakSpacing.s8) {
        ForEach(QuizTheme.allCases) { theme in
            ThemeCard(theme: theme, onSelect: {})
        }
    }
    .padding(ZodiakSpacing.s8)
}
