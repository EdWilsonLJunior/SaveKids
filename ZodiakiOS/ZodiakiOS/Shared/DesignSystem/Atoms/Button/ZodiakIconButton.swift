import SwiftUI

// MARK: - Zodiak Icon Button
// Figma: "Button icon" — circular icon-only button
// Sizes: small (38pt), medium (48pt), large (56pt)
// Styles: primary (filled), secondary (outlined), tertiary (tonal)
// Contexts: onLite (default), onHeavy (dark surfaces), onPhoto (images — secondary only)

enum ZodiakIconButtonSize {
    case small, medium, large

    var diameter: CGFloat {
        switch self {
            case .small:  return ZodiakSizing.buttonHeightSmall   // 38pt
            case .medium: return ZodiakSizing.buttonHeightMedium  // 48pt
            case .large:  return ZodiakSizing.buttonHeightLarge   // 56pt
        }
    }

    var iconSize: CGFloat {
        switch self {
            case .small:  return ZodiakSizing.Icon.s   // 20pt
            case .medium: return ZodiakSizing.Icon.m   // 24pt
            case .large:  return ZodiakSizing.Icon.l   // 32pt
        }
    }
}

enum ZodiakIconButtonStyle {
    case primary    // filled background
    case secondary  // outlined border
    case tertiary   // subtle tonal fill
    case ghost      // no background, no border — icon-only
}

/// Forma do container do botão de ícone.
enum ZodiakIconButtonShape {
    case circle        // totalmente circular — padrão spec
    case roundedSquare // squircle — raio ZodiakRadii.m
}

enum ZodiakIconButtonContext {
    case onLite   // default — lite/white surfaces
    case onHeavy  // dark surfaces (Hero, Banner, surfaceInk, surfaceMarine)
    case onPhoto  // over photographic images (secondary only)
}

// MARK: - Icon Button Style (pressed feedback)

private struct ZodiakIconButtonPressedStyle: ButtonStyle {
    let context: ZodiakIconButtonContext
    let isEnabled: Bool
    let shape: ZodiakIconButtonShape

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                overlayShape.fill(pressedOverlay(configuration.isPressed))
            )
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }

    private var overlayShape: AnyShape {
        switch shape {
            case .circle:
                return AnyShape(Circle())

            case .roundedSquare:
                return AnyShape(RoundedRectangle(cornerRadius: ZodiakRadii.m))
        }
    }

    private func pressedOverlay(_ isPressed: Bool) -> Color {
        guard isEnabled, isPressed else { return .clear }

        switch context {
            case .onLite:
                return Color.black.opacity(0.12)

            case .onHeavy:
                return Color.white.opacity(0.15)

            case .onPhoto:
                return Color.black.opacity(0.10)
        }
    }
}

// MARK: - ZodiakIconButton (primitivo interno)
// NÃO instanciar diretamente em código de produto — use os tipos públicos abaixo.

struct ZodiakIconButton: View {
    let icon: String
    let action: () -> Void
    var size: ZodiakIconButtonSize = .medium
    var style: ZodiakIconButtonStyle = .primary
    var context: ZodiakIconButtonContext = .onLite
    var isEnabled: Bool = true
    var isLoading: Bool = false
    var shape: ZodiakIconButtonShape = .circle
    var accessibilityLabel: String = "catalog.spec.label_action"

    private var effectiveEnabled: Bool {
        isEnabled && !isLoading
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Image(systemName: icon)
                    .font(.system(size: size.iconSize, weight: .regular))
                    .foregroundColor(resolvedIconColor)
                    .opacity(isLoading ? 0 : 1)

                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(resolvedIconColor)
                        .scaleEffect(size == .small ? 0.7 : 1)
                }
            }
            .frame(width: size.diameter, height: size.diameter)
            .background(resolvedBgColor)
            .clipShape(containerShape)
            .overlay(
                containerShape.stroke(
                    resolvedBorderColor,
                    lineWidth: style == .secondary ? 1.5 : 0
                )
            )
        }
        .buttonStyle(
            ZodiakIconButtonPressedStyle(
                context: context,
                isEnabled: effectiveEnabled,
                shape: shape
            )
        )
        .disabled(!effectiveEnabled)
        .zodiakFocusRing(
            cornerRadius: shape == .circle
            ? size.diameter / 2
            : ZodiakRadii.m
        )
        .accessibilityLabel(LocalizedStringKey(accessibilityLabel))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(accessibilityHintKey)
        .zodiakA11yID("button", role: "icon")
    }

    private var containerShape: AnyShape {
        switch shape {
            case .circle:
                return AnyShape(Circle())

            case .roundedSquare:
                return AnyShape(RoundedRectangle(cornerRadius: ZodiakRadii.m))
        }
    }

    private var accessibilityHintKey: LocalizedStringKey {
        if !isEnabled {
            return "shared.state.unavailable"
        }

        if isLoading {
            return "shared.state.loading"
        }

        return ""
    }

    private var resolvedIconColor: Color {
        guard effectiveEnabled else {
            return ZodiakColors.actionDisabledContent
        }

        switch context {
            case .onLite:
                switch style {
                    case .primary:
                        return ZodiakColors.textInverse

                    case .secondary, .tertiary, .ghost:
                        return ZodiakColors.actionPrimary
                }

            case .onHeavy:
                switch style {
                    case .primary:
                        return ZodiakColors.textAlwaysBlack

                    case .secondary, .tertiary, .ghost:
                        return ZodiakColors.actionPrimaryOnHeavy
                }

            case .onPhoto:
                return ZodiakColors.textAlwaysWhite
        }
    }

    private var resolvedBgColor: Color {
        guard effectiveEnabled else {
            return style == .ghost ? .clear : ZodiakColors.actionDisabled
        }

        switch context {
            case .onLite:
                switch style {
                    case .primary:
                        return ZodiakColors.actionPrimary

                    case .secondary:
                        return .clear

                    case .tertiary:
                        return ZodiakColors.actionPrimary.opacity(0.08)

                    case .ghost:
                        return .clear
                }

            case .onHeavy:
                switch style {
                    case .primary:
                        return ZodiakColors.actionPrimaryOnHeavy

                    case .secondary:
                        return .clear

                    case .tertiary:
                        return ZodiakColors.actionPrimaryOnHeavy.opacity(0.08)

                    case .ghost:
                        return .clear
                }

            case .onPhoto:
                return .clear
        }
    }

    private var resolvedBorderColor: Color {
        guard effectiveEnabled, style == .secondary else {
            return .clear
        }

        switch context {
            case .onLite:
                return ZodiakColors.actionPrimary

            case .onHeavy:
                return ZodiakColors.actionPrimaryOnHeavy

            case .onPhoto:
                return ZodiakColors.textAlwaysWhite
        }
    }
}

// MARK: - Shape helper

private struct AnyShape: Shape, @unchecked Sendable {
    private let makePath: @Sendable (CGRect) -> Path

    init<S: Shape & Sendable>(_ shape: S) {
        self.makePath = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        makePath(rect)
    }
}

// MARK: - 4 Public API types (wrappers finos — fixam o style)

/// Botão ícone primário Zodiak (fundo sólido). Âncora de hierarquia principal.
struct ZodiakIconButtonPrimary: View {
    let icon: String
    let action: () -> Void
    var size: ZodiakIconButtonSize = .medium
    var context: ZodiakIconButtonContext = .onLite
    var isLoading: Bool = false
    var shape: ZodiakIconButtonShape = .circle
    var isEnabled: Bool = true
    var accessibilityLabel: String

    var body: some View {
        ZodiakIconButton(
            icon: icon,
            action: action,
            size: size,
            style: .primary,
            context: context,
            isEnabled: isEnabled,
            isLoading: isLoading,
            shape: shape,
            accessibilityLabel: accessibilityLabel
        )
    }
}

/// Botão ícone secundário Zodiak (borda, fundo transparente).
struct ZodiakIconButtonSecondary: View {
    let icon: String
    let action: () -> Void
    var size: ZodiakIconButtonSize = .medium
    var context: ZodiakIconButtonContext = .onLite
    var isLoading: Bool = false
    var shape: ZodiakIconButtonShape = .circle
    var isEnabled: Bool = true
    var accessibilityLabel: String

    var body: some View {
        ZodiakIconButton(
            icon: icon,
            action: action,
            size: size,
            style: .secondary,
            context: context,
            isEnabled: isEnabled,
            isLoading: isLoading,
            shape: shape,
            accessibilityLabel: accessibilityLabel
        )
    }
}

/// Botão ícone terciário Zodiak (tonal fill suave).
struct ZodiakIconButtonTertiary: View {
    let icon: String
    let action: () -> Void
    var size: ZodiakIconButtonSize = .medium
    var context: ZodiakIconButtonContext = .onLite
    var isLoading: Bool = false
    var shape: ZodiakIconButtonShape = .circle
    var isEnabled: Bool = true
    var accessibilityLabel: String

    var body: some View {
        ZodiakIconButton(
            icon: icon,
            action: action,
            size: size,
            style: .tertiary,
            context: context,
            isEnabled: isEnabled,
            isLoading: isLoading,
            shape: shape,
            accessibilityLabel: accessibilityLabel
        )
    }
}

/// Botão ícone ghost Zodiak (sem fundo, sem borda — ícone isolado).
struct ZodiakIconButtonGhost: View {
    let icon: String
    let action: () -> Void
    var size: ZodiakIconButtonSize = .medium
    var context: ZodiakIconButtonContext = .onLite
    var isLoading: Bool = false
    var shape: ZodiakIconButtonShape = .circle
    var isEnabled: Bool = true
    var accessibilityLabel: String

    var body: some View {
        ZodiakIconButton(
            icon: icon,
            action: action,
            size: size,
            style: .ghost,
            context: context,
            isEnabled: isEnabled,
            isLoading: isLoading,
            shape: shape,
            accessibilityLabel: accessibilityLabel
        )
    }
}

// MARK: - Zodiak Close Button
// Figma: "Button close" — standard circular dismiss / cancel button
// Always: medium (40pt), tertiary style, xmark icon

struct ZodiakCloseButton: View {
    let action: () -> Void
    var accessibilityLabel: String = "shared.action.close"

    var body: some View {
        ZodiakIconButtonTertiary(
            icon: "xmark",
            action: action,
            size: .medium,
            accessibilityLabel: accessibilityLabel
        )
    }
}

// MARK: - Zodiak Arrow Button
// Figma: "Button arrow" — text CTA with directional chevron
// Usage: "Ver mais", "Saiba mais", inline navigation links

enum ZodiakArrowDirection {
    case left, right
}

struct ZodiakArrowLink: View {
    let title: String
    let action: () -> Void
    var direction: ZodiakArrowDirection = .right
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            HStack(spacing: ZodiakSpacing.s4) {
                if direction == .left {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12, weight: .semibold))
                }

                ZodiakText(
                    LocalizedStringKey(title),
                    style: .body(color: isEnabled ? .link : .disabled)
                )
                .underline()

                if direction == .right {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                }
            }
            .foregroundColor(isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled)
        }
        .disabled(!isEnabled)
        .accessibilityLabel(LocalizedStringKey(title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "" : "shared.state.unavailable")
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        // Icon button — sizes
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakIconButton(icon: "plus", action: {}, size: .small)
            ZodiakIconButton(icon: "plus", action: {}, size: .medium)
            ZodiakIconButton(icon: "plus", action: {}, size: .large)
        }

        // Icon button — styles onLite
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakIconButton(icon: "heart.fill", action: {}, style: .primary)
            ZodiakIconButton(icon: "heart.fill", action: {}, style: .secondary)
            ZodiakIconButton(icon: "heart.fill", action: {}, style: .tertiary)
            ZodiakIconButton(icon: "heart.fill", action: {}, isEnabled: false)
        }

        // Icon button — onHeavy
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakIconButton(icon: "heart.fill", action: {}, style: .primary, context: .onHeavy)
            ZodiakIconButton(icon: "heart.fill", action: {}, style: .secondary, context: .onHeavy)
            ZodiakIconButton(icon: "heart.fill", action: {}, style: .tertiary, context: .onHeavy)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surfaceInk)
        .cornerRadius(ZodiakRadii.s)

        // Close button
        HStack {
            ZodiakCloseButton(action: {})
            Spacer()
        }

        // Arrow buttons
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            ZodiakArrowLink(title: "Ver todos os projetos", action: {})
            ZodiakArrowLink(title: "shared.action.back", action: {}, direction: .left)
            ZodiakArrowLink(title: "catalog.section.disabled", action: {}, isEnabled: false)
        }
    }
    .padding()
    .background(ZodiakColors.background)
}
