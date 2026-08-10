import SwiftUI

// MARK: - Zodiak Empty State
// Figma: "Empty state" — placeholder shown when a list/page has no content

public struct ZodiakEmptyState: View {
    let icon: String
    let title: String
    let description: String?
    let action: (label: String, handler: () -> Void)?

    public init(
        icon: String = "tray",
        title: String,
        description: String? = nil,
        action: (label: String, handler: () -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.action = action
    }

    public var body: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            Spacer(minLength: ZodiakSpacing.s32)

            // Illustration area
            ZStack {
                Circle()
                    .fill(ZodiakColors.surfaceSmoke)
                    .frame(width: 96, height: 96)
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ZodiakSizing.Icon.xl, height: ZodiakSizing.Icon.xl)
                    .foregroundColor(ZodiakColors.textDisabled)
            }

            VStack(spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(title))
                    .font(ZodiakTypography.labelLarge)
                    .foregroundColor(ZodiakColors.textPrimary)
                    .multilineTextAlignment(.center)

                if let description {
                    Text(LocalizedStringKey(description))
                        .font(ZodiakTypography.bodyMedium)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, ZodiakSpacing.s40)
                }
            }

            if let action {
                ZodiakButtonPrimary(title: LocalizedStringKey(action.label), action: action.handler)
                    .padding(.top, ZodiakSpacing.s4)
            }

            Spacer(minLength: ZodiakSpacing.s32)
        }
        .frame(maxWidth: .infinity)
    }
}
