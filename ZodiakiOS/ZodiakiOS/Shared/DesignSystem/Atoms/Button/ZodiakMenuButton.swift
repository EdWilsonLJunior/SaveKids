import SwiftUI

// MARK: - Zodiak Menu Button
// Figma: "Button menu" — triggers a context menu with multiple action options
// Pill shape, chevron trailing icon, uses SwiftUI Menu.
// Sizes: small (38px) / medium (48px — default). Max width: 312px.

// MARK: - Supporting Enum

/// Visual hierarchy of the menu button.
/// - `primary`: filled `actionPrimary` — most important action (use once per view).
/// - `secondary`: outlined border — important but not primary.
/// - `tertiary`: ghost tonal — less frequent actions.
enum ZodiakMenuButtonVariant {
    case primary, secondary, tertiary
}

// MARK: - View

struct ZodiakMenuButton<MenuItems: View>: View {
    let title: LocalizedStringKey
    var icon: String?
    var variant: ZodiakMenuButtonVariant = .primary
    var size: ZodiakButtonSize = .medium
    var isEnabled: Bool = true
    @ViewBuilder let menuItems: () -> MenuItems

    var body: some View {
        Menu {
            menuItems()
        } label: {
            HStack(spacing: ZodiakSpacing.s4) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .regular))
                }
                Text(title)
                    .font(size == .small ? ZodiakTypography.bodySmall : ZodiakTypography.button)
                Image(systemName: "chevron.down")
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundColor(isEnabled ? resolvedForeground : ZodiakColors.actionDisabledContent)
            .padding(.horizontal, ZodiakSpacing.s16)
            .frame(height: size.height)
            .frame(maxWidth: 312)
            .background(isEnabled ? resolvedBackground : ZodiakColors.actionDisabled)
            .cornerRadius(ZodiakRadii.l)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .stroke(
                        isEnabled && variant == .secondary ? ZodiakColors.actionPrimary : .clear,
                        lineWidth: 1.5
                    )
            )
        }
        .disabled(!isEnabled)
        .accessibilityLabel(Text(title))
        .accessibilityHint(isEnabled ? "shared.action.tap_to_view_options" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "menu")
    }

    private var resolvedForeground: Color {
        switch variant {
        case .primary:              return ZodiakColors.textInverse
        case .secondary, .tertiary: return ZodiakColors.actionPrimary
        }
    }

    private var resolvedBackground: Color {
        switch variant {
        case .primary:   return ZodiakColors.actionPrimary
        case .secondary: return .clear
        case .tertiary:  return ZodiakColors.actionPrimary.opacity(0.08)
        }
    }
}

// MARK: - Preview

#Preview("Menu Button") {
    VStack(spacing: ZodiakSpacing.s8) {
        ZodiakMenuButton(title: "Primary") {
            Button("shared.action.edit") {}
            Button("shared.action.duplicate") {}
            Button("shared.action.delete", role: .destructive) {}
        }
        ZodiakMenuButton(title: "Secondary", variant: .secondary) {
            Button("shared.action.edit") {}
        }
        ZodiakMenuButton(title: "Tertiary", variant: .tertiary) {
            Button("shared.action.edit") {}
        }
        ZodiakMenuButton(title: "Disabled", isEnabled: false) {
            Button("shared.action.edit") {}
        }
    }
    .padding()
    .background(ZodiakColors.background)
}
