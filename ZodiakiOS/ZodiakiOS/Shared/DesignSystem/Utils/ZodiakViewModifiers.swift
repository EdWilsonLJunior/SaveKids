import SwiftUI

// MARK: - Keyboard Dismiss Modifier
struct KeyboardDismissModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
    }
}

// MARK: - Card Style Modifier
// Shadow: 4px 0 70px 3px rgba(0,0,0,0.03) — único shadow oficial Zodiak (flat design)
struct ZodiakCardStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
            .zodiakShadow()
    }
}

// MARK: - Blur Background Modifier
// Zodiak Blur — único blur oficial (Zodiak DS "Blurs")
// Aplica o efeito de blur ao container que fica sobre um fundo fotográfico.
// Estrutura esperada:
//   Image(photo).overlay(ZodiakBlur.pageOverlay)   ← passo 1: overlay na foto
//   contentView.zodiakBlurBackground()             ← passo 2: blur no container
struct ZodiakBlurBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    Rectangle().fill(.ultraThinMaterial)
                    ZodiakBlur.colorOverlay
                }
            }
    }
}

// MARK: - Error Style Modifier
struct ZodiakErrorStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(ZodiakTypography.captionLarge)
            .foregroundColor(ZodiakColors.textNegative)
    }
}

// MARK: - Primary Button Style
// Pill (radius 999), bg: actionPrimary, texto: textInverse
struct ZodiakPrimaryButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(isEnabled ? ZodiakColors.textInverse : ZodiakColors.actionDisabledContent)
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800) // spec: max width 800px
            .background(
                isEnabled
                    ? (configuration.isPressed ? ZodiakColors.actionPressed : ZodiakColors.actionPrimary)
                    : ZodiakColors.actionDisabled
            )
            .cornerRadius(ZodiakRadii.l)
            .overlay(
                // Focus ring: 1px border, actionFocus token
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .stroke(Color.clear, lineWidth: 0) // ring aplicado via .focused no caller
            )
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Secondary Button Style
// Pill (radius 999), borda: actionPrimary, fill no pressed
struct ZodiakSecondaryButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(
                isEnabled
                    ? (configuration.isPressed ? ZodiakColors.textInverse : ZodiakColors.actionPrimary)
                    : ZodiakColors.actionDisabled
            )
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800) // spec: max width 800px
            .background(
                configuration.isPressed && isEnabled
                    ? ZodiakColors.actionPressed
                    : Color.clear
            )
            .cornerRadius(ZodiakRadii.l)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .stroke(
                        isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.actionDisabled,
                        lineWidth: 1
                    )
            )
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Danger Button Style
// Pill, height 48pt, bg: actionWarningSecondary (#9e0029)
struct ZodiakDangerButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(isEnabled ? ZodiakColors.textInverse : ZodiakColors.actionDisabledContent)
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800) // spec: max width 800px
            .background(
                isEnabled
                    ? (configuration.isPressed
                        ? ZodiakColors.actionWarningSecondaryHover
                        : ZodiakColors.actionWarningSecondary)
                    : ZodiakColors.actionDisabled
            )
            .cornerRadius(ZodiakRadii.l)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Small Button Style (height 38pt)
// MARK: - Small Button Style (height 38pt)
struct ZodiakSmallButtonStyle: ButtonStyle {
    var isEnabled: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(ZodiakTypography.bodySmall)
            .foregroundColor(isEnabled ? ZodiakColors.textInverse : ZodiakColors.actionDisabledContent)
            .padding(.horizontal, ZodiakSpacing.s16)
            .frame(height: ZodiakSizing.buttonHeightSmall)
            .background(
                isEnabled
                    ? (configuration.isPressed ? ZodiakColors.actionPressed : ZodiakColors.actionPrimary)
                    : ZodiakColors.actionDisabled
            )
            .cornerRadius(ZodiakRadii.l)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - onHeavy Button Styles (Gap A)
// Para uso sobre fundos escuros: Hero, Banner, surfaceInk, surfaceMarine.
// Primary onHeavy: fundo branco, texto textAlwaysBlack.
// Secondary onHeavy: borda branca, sem background, fill no pressed.
// Tertiary onHeavy: proibido pela spec (risco de acessibilidade sobre foto/fundo pesado).

struct ZodiakPrimaryOnHeavyButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(isEnabled ? ZodiakColors.textAlwaysBlack : ZodiakColors.actionDisabledContent)
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800)
            .background(
                isEnabled
                    ? (configuration.isPressed ? ZodiakColors.actionPressedOnHeavy : ZodiakColors.actionPrimaryOnHeavy)
                    : ZodiakColors.actionDisabled
            )
            .cornerRadius(ZodiakRadii.l)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct ZodiakSecondaryOnHeavyButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(
                isEnabled
                    ? (configuration.isPressed ? ZodiakColors.textAlwaysBlack : ZodiakColors.actionPrimaryOnHeavy)
                    : ZodiakColors.actionDisabledContent
            )
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800)
            .background(
                configuration.isPressed && isEnabled
                    ? ZodiakColors.actionPressedOnHeavy
                    : Color.clear
            )
            .cornerRadius(ZodiakRadii.l)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .stroke(
                        isEnabled ? ZodiakColors.actionPrimaryOnHeavy : ZodiakColors.actionDisabled,
                        lineWidth: 1
                    )
            )
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - onPhoto Button Styles (Phase 4 — surface context onPhoto)
// Spec PDF: actionPrimaryOnPhoto = rgba(0,0,0,0) — botão totalmente transparente
// com borda 1px e texto brancos sobre fundos fotográficos.
// ⚠️ Tertiary onPhoto é PROIBIDO pela spec Zodiak (acessibilidade).

struct ZodiakPrimaryOnPhotoButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(isEnabled ? ZodiakColors.textAlwaysWhite : ZodiakColors.actionDisabledContent)
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800)
            .background(
                isEnabled
                    ? (configuration.isPressed
                        ? ZodiakPrimitives.Overlay.white50
                        : ZodiakColors.actionPrimaryOnPhoto)
                    : ZodiakPrimitives.Overlay.black10
            )
            .cornerRadius(ZodiakRadii.l)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .stroke(
                        isEnabled ? ZodiakColors.textAlwaysWhite : ZodiakColors.actionDisabled,
                        lineWidth: 1
                    )
            )
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Mouse Hover Modifier
struct MouseHoverModifier: ViewModifier {
    @State private var isHovered = false

    func body(content: Content) -> some View {
        content
            .onContinuousHover { phase in
                if case .active = phase { isHovered = true } else { isHovered = false }
            }
            .scaleEffect(isHovered ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: isHovered)
    }
}

// MARK: - Focus Ring Modifier (Gap D)
/// Aplica o focus ring de 1px com token `actionFocus` quando o botão recebe foco por teclado.
/// Usar `.zodiakFocusRing()` depois do button style em qualquer botão do DS.
struct ZodiakFocusRingModifier: ViewModifier {
    var cornerRadius: CGFloat = ZodiakRadii.l
    @FocusState private var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(isFocused ? ZodiakColors.actionFocus : Color.clear, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.15), value: isFocused)
    }
}

// MARK: - Page Behavior Modifier
/// Encapsulates navigation and keyboard behavior shared by all catalog gallery screens.
/// Separates page-level UX concerns from layout — layout is the caller's responsibility.
struct ZodiakPageBehavior: ViewModifier {
    let title: LocalizedStringKey

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ZodiakColors.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .dismissKeyboardOnTap()
    }
}

// MARK: - View Extensions
extension View {
    func cardStyle() -> some View {
        modifier(ZodiakCardStyleModifier())
    }

    /// Aplica blur de fundo Zodiak ao container (passo 2 do padrão de blur).
    /// O fundo fotográfico deve ter `.overlay(ZodiakBlur.pageOverlay)` (passo 1).
    func zodiakBlurBackground() -> some View {
        modifier(ZodiakBlurBackgroundModifier())
    }

    /// Desofca o conteúdo de fundo quando um modal ou overlay está ativo.
    /// Usa `ZodiakBlur.overlayRadius` (8pt) com animação easeInOut.
    ///
    ///     ZodiakActivityTemplate(...) { ... }
    ///         .zodiakContentBlur(isActive: viewModel.selectedCard != nil)
    func zodiakContentBlur(isActive: Bool) -> some View {
        blur(radius: isActive ? ZodiakBlur.overlayRadius : 0)
            .animation(.easeInOut(duration: 0.25), value: isActive)
    }

    func errorStyle() -> some View {
        modifier(ZodiakErrorStyleModifier())
    }

    func zodiakPrimaryButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium) -> some View {
        buttonStyle(ZodiakPrimaryButtonStyle(isEnabled: isEnabled, size: size))
    }

    func zodiakSecondaryButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium) -> some View {
        buttonStyle(ZodiakSecondaryButtonStyle(isEnabled: isEnabled, size: size))
    }

    func zodiakDangerButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium) -> some View {
        buttonStyle(ZodiakDangerButtonStyle(isEnabled: isEnabled, size: size))
    }

    func zodiakSmallButtonStyle(isEnabled: Bool = true) -> some View {
        buttonStyle(ZodiakSmallButtonStyle(isEnabled: isEnabled))
    }

    /// Button style para uso sobre fundos escuros (Gap A — onHeavy primary).
    func zodiakPrimaryOnHeavyButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium) -> some View {
        buttonStyle(ZodiakPrimaryOnHeavyButtonStyle(isEnabled: isEnabled, size: size))
    }

    /// Button style para uso sobre fundos escuros (Gap A — onHeavy secondary).
    func zodiakSecondaryOnHeavyButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium) -> some View {
        buttonStyle(ZodiakSecondaryOnHeavyButtonStyle(isEnabled: isEnabled, size: size))
    }

    /// Button style para uso sobre superfícies fotográficas (Phase 4 — onPhoto).
    /// PDF Zodiak: actionPrimaryOnPhoto = transparente + borda 1px + texto branco.
    /// ⚠️ Tertiary onPhoto é proibido pela spec.
    func zodiakPrimaryOnPhotoButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium) -> some View {
        buttonStyle(ZodiakPrimaryOnPhotoButtonStyle(isEnabled: isEnabled, size: size))
    }

    func dismissKeyboardOnTap() -> some View {
        modifier(KeyboardDismissModifier())
    }

    func mouseHoverEffect() -> some View {
        modifier(MouseHoverModifier())
    }

    /// Aplica focus ring de 1px com token `actionFocus` (spec Gap D).
    /// Usar em qualquer botão do DS que precise responder a navegação por teclado.
    func zodiakFocusRing(cornerRadius: CGFloat = ZodiakRadii.l) -> some View {
        modifier(ZodiakFocusRingModifier(cornerRadius: cornerRadius))
    }

    /// Applies standard Zodiak page behavior: navigation title, toolbar background and keyboard dismiss.
    /// Chain after the root layout view of every catalog gallery screen.
    ///
    ///     ZodiakGalleryShell { ... }
    ///         .zodiakPage(title: "catalog.component.buttons")
    func zodiakPage(title: LocalizedStringKey) -> some View {
        modifier(ZodiakPageBehavior(title: title))
    }

    /// Expande hit target para acessibilidade (mínimo 44×44pt WCAG) e habilita
    /// `hoverEffect(.automatic)` para pointer interactions em iPad/Mac Catalyst.
    func expandedTouchTarget() -> some View {
        contentShape(Rectangle())
            .hoverEffect(.automatic)
    }

    /// Overlays a shimmer animation. Designed to complement `.redacted(reason: .placeholder)`.
    /// When `active` is false, returns the content unchanged — no animation overhead.
    func shimmer(active: Bool = true) -> some View {
        modifier(ShimmerModifier(active: active))
    }

    /// Aplica o padrão de largura "cap + expand" para cards em layout single-column.
    /// Limita a `ZodiakSizing.cardMaxWidth` (480pt) e expande até a largura disponível.
    /// Resultado: ocupa toda a largura no iPhone; fica centralizado e limitado no iPad.
    ///
    ///     CreditCardView(card: card)
    ///         .zodiakCardWidth()
    func zodiakCardWidth() -> some View {
        self
            .frame(maxWidth: ZodiakSizing.cardMaxWidth)
            .frame(maxWidth: .infinity)
    }

    /// Applies SwiftUI's native redaction with Zodiak's shimmer animation.
    ///
    /// Loading state is always caller-owned — never a component parameter.
    /// Follows the same environment propagation pattern as `.disabled()`, `.tint()`.
    ///
    ///     ZodiakCard(item: item)
    ///         .zodiakSkeleton(active: isLoading)
    func zodiakSkeleton(active: Bool) -> some View {
        self
            .redacted(reason: active ? .placeholder : [])
            .shimmer(active: active)
    }
}

// MARK: - Shimmer Modifier
// Zodiak extension over SwiftUI's native .redacted(reason: .placeholder) API.
// Adds an animated shimmer sweep to the placeholder state.
// Deliberate design extension for the Apple ecosystem —
// aligned with Material Design 3, IBM Carbon, and Shopify Polaris patterns.
struct ShimmerModifier: ViewModifier {
    var active: Bool = true
    @State private var phase: CGFloat = -1.0

    func body(content: Content) -> some View {
        if active {
            content
                .overlay(
                    GeometryReader { _ in
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .white.opacity(0.35), location: 0.5),
                                .init(color: .clear, location: 1.0)
                            ],
                            startPoint: .init(x: phase, y: 0),
                            endPoint: .init(x: phase + 0.5, y: 0)
                        )
                    }
                    .mask(content)
                )
                .onAppear {
                    withAnimation(.linear(duration: 1.4).repeatForever(autoreverses: false)) {
                        phase = 1.5
                    }
                }
        } else {
            content
        }
    }
}
