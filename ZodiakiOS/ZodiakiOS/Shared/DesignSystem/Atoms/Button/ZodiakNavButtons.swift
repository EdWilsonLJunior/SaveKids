import SwiftUI

// MARK: - Zodiak Arrow Button
// Fonte: Zodiak Design System – Capgemini | Página "Button arrow"
// Specs: círculo, chevron.right, tamanhos S/M/L, variantes Primary/Secondary/Ghost

enum ZodiakCircularArrowSize {
    case small, medium, large
    var diameter: CGFloat {
        switch self {
        case .small: return 36
        case .medium: return ZodiakSizing.buttonHeightMedium
        case .large: return ZodiakSizing.buttonHeightLarge
        }
    }
    var iconSize: CGFloat {
        switch self {
        case .small: return 14
        case .medium: return ZodiakSizing.Icon.xs
        case .large: return ZodiakSizing.Icon.s
        }
    }
}

enum ZodiakArrowButtonDirection {
    case right, left, up, down
    var systemImage: String {
        switch self {
        case .right: return "chevron.right"
        case .left:  return "chevron.left"
        case .up:    return "chevron.up"
        case .down:  return "chevron.down"
        }
    }
}

struct ZodiakCircularArrowButton: View {
    let action: () -> Void
    var size: ZodiakCircularArrowSize = .medium
    var direction: ZodiakArrowButtonDirection = .right
    var style: ZodiakNavButtonVariant = .primary
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            Image(systemName: direction.systemImage)
                .font(.system(size: size.iconSize, weight: .medium))
                .foregroundColor(isEnabled ? iconColor : ZodiakColors.actionDisabledContent)
                .frame(width: size.diameter, height: size.diameter)
                .background(isEnabled ? bgColor : ZodiakColors.actionDisabled)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(borderColor, lineWidth: style == .secondary ? 1.5 : 0)
                )
        }
        .disabled(!isEnabled)
        .expandedTouchTarget()
        .accessibilityLabel(accessibilityLabelKey)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "nav")
    }

    private var iconColor: Color {
        switch style {
        case .primary:   return ZodiakColors.textInverse
        case .secondary: return ZodiakColors.actionPrimary
        case .ghost:     return ZodiakColors.actionPrimary
        }
    }

    private var bgColor: Color {
        switch style {
        case .primary:   return ZodiakColors.actionPrimary
        case .secondary: return Color.clear
        case .ghost:     return Color.clear
        }
    }

    private var borderColor: Color {
        switch style {
        case .primary:   return Color.clear
        case .secondary: return ZodiakColors.actionPrimary
        case .ghost:     return Color.clear
        }
    }

    private var accessibilityLabelKey: LocalizedStringKey {
        switch direction {
        case .right: return "shared.action.next"
        case .left:  return "shared.action.previous"
        case .up:    return "shared.action.move_up"
        case .down:  return "shared.action.move_down"
        }
    }
}

// MARK: - ZodiakNavButtonVariant (shared enum)

enum ZodiakNavButtonVariant {
    case primary, secondary, ghost
}

// MARK: - Zodiak Close Button
// Figma: "Button close" — fechar modais, sheets, banners

struct ZodiakRoundCloseButton: View {
    let action: () -> Void
    var size: ZodiakCircularArrowSize = .medium
    var style: ZodiakNavButtonVariant = .ghost
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.system(size: size.iconSize, weight: .medium))
                .foregroundColor(isEnabled ? closeIconColor : ZodiakColors.actionDisabledContent)
                .frame(width: size.diameter, height: size.diameter)
                .background(isEnabled ? closeBgColor : ZodiakColors.actionDisabled)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(
                        style == .secondary ? ZodiakColors.borderPrimary : Color.clear,
                        lineWidth: 1.5
                    )
                )
        }
        .disabled(!isEnabled)
        .expandedTouchTarget()
        .accessibilityLabel(Text("shared.action.close"))
        .accessibilityAddTraits(.isButton)
    }

    private var closeIconColor: Color {
        switch style {
        case .primary: return ZodiakColors.textInverse
        case .secondary, .ghost: return ZodiakColors.actionPrimary
        }
    }

    private var closeBgColor: Color {
        switch style {
        case .primary: return ZodiakColors.actionPrimary
        case .secondary: return ZodiakColors.surface
        case .ghost: return Color.clear
        }
    }
}

// MARK: - Zodiak Menu Button
// Figma: "Button menu" — hambúrguer / navegação global

struct ZodiakHamburgerButton: View {
    let action: () -> Void
    var isOpen: Bool = false
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            Image(systemName: isOpen ? "xmark" : "line.3.horizontal")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.actionDisabledContent)
                .frame(width: ZodiakSizing.buttonHeightMedium, height: ZodiakSizing.buttonHeightMedium)
                .animation(.easeInOut(duration: 0.2), value: isOpen)
        }
        .disabled(!isEnabled)
        .expandedTouchTarget()
        .accessibilityLabel(isOpen ? Text("shared.action.close_menu") : Text("shared.action.open_menu"))
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Previews

#Preview("Nav Buttons") {
    VStack(spacing: ZodiakSpacing.s24) {
        ZodiakText("Arrow Buttons", style: .title2)
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakCircularArrowButton(action: {}, direction: .left, style: .secondary)
            ZodiakCircularArrowButton(action: {}, direction: .right, style: .primary)
            ZodiakCircularArrowButton(action: {}, direction: .right, style: .ghost)
            ZodiakCircularArrowButton(action: {}, size: .large, style: .primary)
            ZodiakCircularArrowButton(action: {}, size: .small, style: .secondary)
            ZodiakCircularArrowButton(action: {}, isEnabled: false)
        }

        ZodiakText("Close Buttons", style: .title2)
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakRoundCloseButton(action: {}, style: .ghost)
            ZodiakRoundCloseButton(action: {}, style: .secondary)
            ZodiakRoundCloseButton(action: {}, style: .primary)
        }

        ZodiakText("Menu Button", style: .title2)
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakHamburgerButton(action: {})
            ZodiakHamburgerButton(action: {}, isOpen: true)
        }
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
