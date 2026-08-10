import SwiftUI

/// Card de resultado com título, valor grande e subtítulo opcional
struct ZodiakResultCard: View {
    let title: String
    let value: String
    let subtitle: String?
    var valueColor: Color = ZodiakColors.actionPrimary

    var body: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            ZodiakText(title, style: .title2)

            Text(value)
                .font(ZodiakTypography.titleLarge)
                .foregroundColor(valueColor)
                .tracking(ZodiakTypography.HeadingSize.medium.tracking(for: .light))

            if let subtitle {
                ZodiakText(subtitle, style: .body(color: .secondary))
            }
        }
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}

/// Card de resultado com badge de status no canto superior direito
struct ZodiakResultCardWithBadge: View {
    let title: String
    let value: String
    let badgeText: String
    let badgeColor: Color
    let subtitle: String?
    var valueColor: Color = ZodiakColors.actionPrimary

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack {
                ZodiakText(title, style: .title2)
                Spacer()
                ZodiakBadge(
                    text: LocalizedStringKey(badgeText),
                    backgroundColor: badgeColor,
                    foregroundColor: ZodiakColors.textInverse
                )
            }

            Text(value)
                .font(ZodiakTypography.titleLarge)
                .foregroundColor(valueColor)
                .tracking(ZodiakTypography.HeadingSize.medium.tracking(for: .light))

            if let subtitle {
                ZodiakText(subtitle, style: .body(color: .secondary))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        ZodiakResultCard(title: "Média", value: "8.5", subtitle: "feature.grades.above_average")
        ZodiakResultCardWithBadge(
            title: "Situação",
            value: "shared.state.passed",
            badgeText: "✓",
            badgeColor: ZodiakColors.surfacePositive,
            subtitle: nil
        )
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
