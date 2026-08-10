import SwiftUI

// MARK: - Zodiak System Button
// Figma: "Button system" — compact button for digital product / browser interface UI
// Smaller than regular button, rectangular with subtle radius, no pill.
// Sizes: small (38px — default) / medium (48px). Width adapts to content.

// MARK: - Supporting Enum

enum ZodiakSystemButtonStyle {
    case filled, outlined, ghost
}

// MARK: - View

struct ZodiakSystemButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var icon: String?
    var style: ZodiakSystemButtonStyle = .filled
    var size: ZodiakButtonSize = .small
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            HStack(spacing: ZodiakSpacing.s4) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 12, weight: .regular))
                }
                Text(title)
                    .font(size == .medium ? ZodiakTypography.button : ZodiakTypography.bodySmall)
            }
            .foregroundColor(resolvedForeground)
            .padding(.horizontal, ZodiakSpacing.s8)
            .frame(height: size.height)
            .background(resolvedBackground)
            .cornerRadius(ZodiakRadii.xs)   // xs (4pt) — NOT pill
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                    .stroke(resolvedBorder, lineWidth: style == .outlined ? 1.5 : 0)
            )
        }
        .disabled(!isEnabled)
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "system")
    }

    private var resolvedForeground: Color {
        guard isEnabled else { return ZodiakColors.actionDisabledContent }
        switch style {
        case .filled:   return ZodiakColors.textInverse
        case .outlined: return ZodiakColors.actionPrimary
        case .ghost:    return ZodiakColors.actionPrimary
        }
    }

    private var resolvedBackground: Color {
        guard isEnabled else { return ZodiakColors.actionDisabled }
        switch style {
        case .filled:   return ZodiakColors.actionPrimary
        case .outlined: return .clear
        case .ghost:    return ZodiakColors.actionPrimary.opacity(0.08)
        }
    }

    private var resolvedBorder: Color {
        isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.actionDisabled
    }
}

// MARK: - Preview

#Preview("System Button") {
    VStack(spacing: ZodiakSpacing.s8) {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakSystemButton(title: "shared.action.save", action: {}, icon: "square.and.arrow.down", style: .filled)
            ZodiakSystemButton(title: "shared.action.cancel", action: {}, style: .outlined)
            ZodiakSystemButton(title: "Preview", action: {}, style: .ghost)
        }
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakSystemButton(title: "Filled", action: {}, style: .filled, isEnabled: false)
            ZodiakSystemButton(title: "Outlined", action: {}, style: .outlined, isEnabled: false)
            ZodiakSystemButton(title: "Ghost", action: {}, style: .ghost, isEnabled: false)
        }
    }
    .padding()
    .background(ZodiakColors.background)
}
