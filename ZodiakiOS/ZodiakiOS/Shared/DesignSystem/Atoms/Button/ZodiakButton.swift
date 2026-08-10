import SwiftUI

// MARK: - ZodiakButtonVariant (para ZodiakButtonImpl)
/// Estilo visual do botão regular Zodiak.
enum ZodiakButtonVariant {
    case primary, secondary, tertiary, ghost
}

// MARK: - ZodiakButtonImpl (primitivo interno)
// Componente de implementação compartilhado pelos 4 tipos públicos.
// NÃO instanciar diretamente em código de produto — use ZodiakButtonPrimary / Secondary / Tertiary / Ghost.
struct ZodiakButtonImpl: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var variant: ZodiakButtonVariant = .primary
    var surface: ZodiakSurface = .onLite
    var size: ZodiakButtonSize = .medium
    var isLoading: Bool = false
    var isEnabled: Bool = true
    var icon: String?
    var iconPlacement: ZodiakButtonIconPlacement = .leading

    private var effectiveEnabled: Bool {
        isEnabled && !isLoading
    }

    var body: some View {
        styledButton
            .accessibilityLabel(title)
            .accessibilityAddTraits(.isButton)
            .accessibilityHint(accessibilityHintKey)
    }

    // MARK: - Styled Button

    @ViewBuilder
    private var styledButton: some View {
        switch resolvedVisualStyle {
            case .primary:
                coreButton
                    .zodiakPrimaryButtonStyle(isEnabled: effectiveEnabled, size: size)
                    .defaultZodiakButtonFocus()

            case .primaryOnHeavy:
                coreButton
                    .zodiakPrimaryOnHeavyButtonStyle(isEnabled: effectiveEnabled, size: size)
                    .defaultZodiakButtonFocus()

            case .primaryOnPhoto:
                coreButton
                    .zodiakPrimaryOnPhotoButtonStyle(isEnabled: effectiveEnabled, size: size)
                    .defaultZodiakButtonFocus()

            case .secondary:
                coreButton
                    .zodiakSecondaryButtonStyle(isEnabled: effectiveEnabled, size: size)
                    .defaultZodiakButtonFocus()

            case .secondaryOnHeavy:
                coreButton
                    .zodiakSecondaryOnHeavyButtonStyle(isEnabled: effectiveEnabled, size: size)
                    .defaultZodiakButtonFocus()

            case .textOnly:
                coreButton
                    .zodiakFocusRing(cornerRadius: ZodiakRadii.xs)
                    .expandedTouchTarget()
        }
    }

    private var resolvedVisualStyle: ResolvedVisualStyle {
        switch (variant, surface) {
            case (.primary, .onHeavy):
                return .primaryOnHeavy

            case (.primary, .onPhoto):
                return .primaryOnPhoto

            case (.secondary, .onHeavy):
                return .secondaryOnHeavy

            case (.secondary, _):
                return .secondary

            case (.tertiary, _), (.ghost, _):
                return .textOnly

            case (.primary, _):
                return .primary
        }
    }

    private enum ResolvedVisualStyle {
        case primary
        case primaryOnHeavy
        case primaryOnPhoto
        case secondary
        case secondaryOnHeavy
        case textOnly
    }

    // MARK: - Core Button

    private var coreButton: some View {
        Button(action: action) {
            buttonContent
        }
        .disabled(!effectiveEnabled)
    }

    @ViewBuilder
    private var buttonContent: some View {
        ZStack {
            labelContent
                .opacity(isLoading ? 0 : 1)

            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }

    private var labelContent: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            iconView(.leading)

            textView

            iconView(.trailing)
        }
    }

    @ViewBuilder
    private func iconView(_ placement: ZodiakButtonIconPlacement) -> some View {
        if let icon, iconPlacement == placement {
            Image(systemName: icon)
                .font(.system(size: iconSize, weight: .regular))
        }
    }

    private var iconSize: CGFloat {
        size == .small ? 14 : 16
    }

    // MARK: - Text

    @ViewBuilder
    private var textView: some View {
        switch variant {
            case .tertiary:
                ZodiakText(title, style: actionTextStyle)
                    .underline()

            case .ghost:
                ZodiakText(title, style: actionTextStyle)

            case .primary, .secondary:
                ZodiakText(title, style: defaultTextStyle)
        }
    }

    private var defaultTextStyle: ZodiakTextViewStyle {
        textStyle(color: defaultTextColor)
    }

    private var actionTextStyle: ZodiakTextViewStyle {
        textStyle(color: actionTextColor)
    }

    private var defaultTextColor: ZodiakTextColor {
        guard effectiveEnabled else {
            return .disabled
        }

        switch variant {
            case .primary:
                return .inverse

            case .secondary:
                return .link

            case .tertiary, .ghost:
                return .link
        }
    }

    private var actionTextColor: ZodiakTextColor {
        effectiveEnabled ? .link : .disabled
    }

    private func textStyle(color: ZodiakTextColor) -> ZodiakTextViewStyle {
        switch size {
            case .small:
                return .bodySmall(color: color)

            case .medium, .large:
                return .body(color: color)
        }
    }

    // MARK: - Accessibility

    private var accessibilityHintKey: LocalizedStringKey {
        if !isEnabled {
            return "shared.state.unavailable"
        }

        if isLoading {
            return "shared.state.loading"
        }

        return ""
    }
}

// MARK: - Private helpers

private extension View {
    func defaultZodiakButtonFocus() -> some View {
        self
            .zodiakFocusRing()
            .expandedTouchTarget()
    }
}

// MARK: - Button Size
/// Zodiak button sizes: small (38pt), medium (48pt — default), large (56pt), fullwidth.
enum ZodiakButtonSize {
    case small, medium, large

    var height: CGFloat {
        switch self {
            case .small:  return ZodiakSizing.buttonHeightSmall
            case .medium: return ZodiakSizing.buttonHeightMedium
            case .large:  return ZodiakSizing.buttonHeightLarge
        }
    }

    var font: Font {
        switch self {
            case .small: return ZodiakTypography.bodySmall
            default:     return ZodiakTypography.button
        }
    }

    var textStyle: ZodiakTextViewStyle {
        switch self {
            case .small:
                return .bodySmall()
            default:
                return .body()
        }
    }
}

// MARK: - Icon Placement
enum ZodiakButtonIconPlacement {
    case leading, trailing
}

// MARK: - Zodiak Button (Primary)
// Specs: pill radius 999pt, Ubuntu-Regular | onLite surface
// Tamanhos: small 38pt / medium 48pt (default) / large 56pt
// Ícone opcional: leading ou trailing (spec: not arrow for same-app navigation)

struct ZodiakButtonPrimary: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .medium
    var surface: ZodiakSurface = .onLite
    var isLoading: Bool = false
    var icon: String?
    var iconPlacement: ZodiakButtonIconPlacement = .leading
    var isEnabled: Bool = true

    var body: some View {
        ZodiakButtonImpl(
            title: title,
            action: action,
            variant: .primary,
            surface: surface,
            size: size,
            isLoading: isLoading,
            isEnabled: isEnabled,
            icon: icon,
            iconPlacement: iconPlacement
        )
        .zodiakA11yID("button", role: "primary")
    }
}

// MARK: - Zodiak Secondary Button
// Borda + texto no tom actionPrimary; fill no hover/pressed
// Tamanhos: small / medium (default) / large. Ícone opcional.

struct ZodiakButtonSecondary: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .medium
    var surface: ZodiakSurface = .onLite
    var isLoading: Bool = false
    var icon: String?
    var iconPlacement: ZodiakButtonIconPlacement = .leading
    var isEnabled: Bool = true

    var body: some View {
        ZodiakButtonImpl(
            title: title,
            action: action,
            variant: .secondary,
            surface: surface,
            size: size,
            isLoading: isLoading,
            isEnabled: isEnabled,
            icon: icon,
            iconPlacement: iconPlacement
        )
        .zodiakA11yID("button", role: "secondary")
    }
}

// MARK: - Zodiak Tertiary Button
// Texto com underline, sem background. Hierarquia mínima.
// Nota: PROIBIDO em superfícies fotográficas (spec onPhoto acessibilidade).

struct ZodiakButtonTertiary: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .medium
    var isLoading: Bool = false
    var isEnabled: Bool = true

    var body: some View {
        ZodiakButtonImpl(
            title: title,
            action: action,
            variant: .tertiary,
            surface: .onLite,
            size: size,
            isLoading: isLoading,
            isEnabled: isEnabled
        )
        .zodiakA11yID("button", role: "tertiary")
    }
}

// MARK: - ZodiakButtonGhost
// Texto sem decoração, hierarquia mínima. Superfície onLite apenas.

struct ZodiakButtonGhost: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .medium
    var isLoading: Bool = false
    var isEnabled: Bool = true

    var body: some View {
        ZodiakButtonImpl(
            title: title,
            action: action,
            variant: .ghost,
            surface: .onLite,
            size: size,
            isLoading: isLoading,
            isEnabled: isEnabled
        )
        .zodiakA11yID("button", role: "ghost")
    }
}

// MARK: - Zodiak Warning Button (Danger)
// Fundo vermelho escuro, ícone de aviso obrigatório.
// Specs: bg=#9e0029, hover=#c00036, ícone exclamationmark.triangle
// Spec rule: "Warning buttons should always be followed by a user confirmation."

struct ZodiakDangerButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var isEnabled: Bool = true

    /// Se fornecido, exibe um `.confirmationDialog` antes de disparar `action` (spec obrigatório).
    var confirmationTitle: LocalizedStringKey?
    var confirmationMessage: LocalizedStringKey?

    @State private var showConfirmation = false

    var body: some View {
        Button {
            if confirmationTitle != nil {
                showConfirmation = true
            } else {
                action()
            }
        } label: {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(ZodiakIcon.octagonWarning.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)

                ZodiakText(
                    title,
                    style: .body(color: isEnabled ? .inverse : .disabled)
                )
            }
        }
        .disabled(!isEnabled)
        .zodiakDangerButtonStyle(isEnabled: isEnabled)
        .expandedTouchTarget()
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(
            isEnabled
            ? "shared.state.irreversible_action"
            : "shared.state.unavailable"
        )
        .zodiakA11yID("button", role: "danger")
        .confirmationDialog(
            confirmationTitle ?? "",
            isPresented: $showConfirmation,
            titleVisibility: .visible
        ) {
            Button(role: .destructive, action: action) {
                ZodiakText(title, style: .body(color: .negative))
            }

            Button("shared.action.cancel", role: .cancel) {}
        } message: {
            if let msg = confirmationMessage {
                ZodiakText(msg, style: .bodySmall(color: .secondary))
            }
        }
    }
}

// MARK: - Zodiak Small Button (Primary, altura 38pt)

struct ZodiakSmallButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var isEnabled: Bool = true
    var isLoading: Bool = false
    var icon: String?
    var iconPlacement: ZodiakButtonIconPlacement = .leading

    var body: some View {
        ZodiakButtonImpl(
            title: title,
            action: action,
            variant: .primary,
            surface: .onLite,
            size: .small,
            isLoading: isLoading,
            isEnabled: isEnabled,
            icon: icon,
            iconPlacement: iconPlacement
        )
        .zodiakA11yID("button", role: "small")
    }
}

// MARK: - Previews
#Preview {
    VStack(spacing: ZodiakSpacing.s4) {
        ZodiakButtonPrimary(title: "shared.action.confirm", action: {})
        ZodiakButtonPrimary(title: "shared.action.confirm", action: {}, icon: "arrow.down.circle")
        ZodiakButtonPrimary(title: "catalog.section.disabled", action: {}, isEnabled: false)
        ZodiakButtonPrimary(title: "shared.action.confirm", action: {}, size: .large)

        ZodiakButtonSecondary(title: "Secundário", action: {})
        ZodiakButtonSecondary(title: "catalog.section.disabled", action: {}, isEnabled: false)

        ZodiakButtonTertiary(title: "Saiba mais", action: {})
        ZodiakButtonGhost(title: "Agora não", action: {})

        ZodiakDangerButton(title: "shared.action.delete", action: {})

        ZodiakDangerButton(
            title: "shared.action.delete",
            action: {},
            confirmationTitle: "shared.confirm.delete_title",
            confirmationMessage: "shared.confirm.delete_message"
        )

        ZodiakSmallButton(title: "Pequeno", action: {})

        // onHeavy
        ZStack {
            RoundedRectangle(cornerRadius: ZodiakRadii.m)
                .fill(ZodiakColors.surfaceInk)
                .frame(height: 100)

            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakButtonPrimary(
                    title: "shared.action.confirm",
                    action: {},
                    surface: .onHeavy
                )

                ZodiakButtonSecondary(
                    title: "Secundário",
                    action: {},
                    surface: .onHeavy
                )
            }
            .padding(.horizontal, ZodiakSpacing.s16)
        }

        // onPhoto (Phase 4)
        ZStack {
            LinearGradient(
                colors: [ZodiakColors.surfaceInk, ZodiakColors.surfaceMarine],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 100)
            .cornerRadius(ZodiakRadii.m)
            .overlay(ZodiakColors.heroPhotographic.cornerRadius(ZodiakRadii.m))

            ZodiakButtonPrimary(
                title: "shared.action.confirm",
                action: {},
                surface: .onPhoto
            )
            .padding(.horizontal, ZodiakSpacing.s16)
        }
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
