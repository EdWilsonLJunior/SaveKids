import SwiftUI

// MARK: - Zodiak Accessibility Helpers
// Centraliza modificadores de a11y reusáveis: hit-target ≥44pt, redução de
// movimento, identifiers determinísticos para UI tests.
//
// Convenção `accessibilityIdentifier`: "zodiak.<atom>.<role>.<context>"
//   Ex: "zodiak.button.primary.submit", "zodiak.checkbox.toggle.terms".
//
// Phase 2 — WCAG 2.1 AA. Ver docs/accessibility-audit.md.

//// MARK: - Hit Target (Apple HIG mínimo: 44×44pt)
//
//extension View {
//    /// Garante área tocável mínima 44×44pt (Apple HIG / WCAG 2.5.5).
//    /// Útil em `ZodiakIconButton(size: .small)` (38pt) e badges interativos.
//    func zodiakHitTarget(_ minimum: CGFloat = 44) -> some View {
//        contentShape(Rectangle())
//            .frame(minWidth: minimum, minHeight: minimum)
//    }
//}

// MARK: - Reduce Motion

/// Observa `accessibilityReduceMotion` e retorna animação substituta quando ativo.
/// Use em vez de `.animation(.spring(...))` direto:
///
/// ```swift
/// @ZodiakReduceMotionAware var animation = .spring(duration: 0.3)
/// MyView().animation(animation, value: state)
/// ```
@propertyWrapper
struct ZodiakReduceMotionAware: DynamicProperty {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let standard: Animation
    private let reduced: Animation

    init(standard: Animation = .spring(response: 0.3, dampingFraction: 0.8),
         reduced: Animation = .easeInOut(duration: 0.15)) {
        self.standard = standard
        self.reduced = reduced
    }

    var wrappedValue: Animation {
        reduceMotion ? reduced : standard
    }
}

extension View {
    /// Aplica animação respeitando `accessibilityReduceMotion`.
    /// Em vez de `.animation(.spring, value: x)`, use:
    /// `.zodiakAnimation(.spring, value: x)`.
    func zodiakAnimation<V: Equatable>(
        _ animation: Animation = .spring(response: 0.3, dampingFraction: 0.8),
        reduced: Animation = .easeInOut(duration: 0.15),
        value: V
    ) -> some View {
        modifier(ZodiakAnimationModifier(standard: animation, reduced: reduced, value: value))
    }
}

private struct ZodiakAnimationModifier<V: Equatable>: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let standard: Animation
    let reduced: Animation
    let value: V

    func body(content: Content) -> some View {
        content.animation(reduceMotion ? reduced : standard, value: value)
    }
}

// MARK: - Differentiate Without Color

extension View {
    /// Quando `accessibilityDifferentiateWithoutColor` está ativo, exibe `iconOverlay`
    /// sobre a view (ícone/forma garantindo distinção sem depender de cor).
    @ViewBuilder
    func zodiakDifferentiateWithoutColor<Overlay: View>(
        @ViewBuilder _ iconOverlay: () -> Overlay
    ) -> some View {
        modifier(ZodiakDifferentiateWithoutColorModifier(iconOverlay: iconOverlay()))
    }
}

private struct ZodiakDifferentiateWithoutColorModifier<Overlay: View>: ViewModifier {
    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiate
    let iconOverlay: Overlay

    func body(content: Content) -> some View {
        content.overlay(alignment: .topTrailing) {
            if differentiate {
                iconOverlay
            }
        }
    }
}

// MARK: - Accessibility Identifier (DSL)

extension View {
    /// Atalho semântico para `accessibilityIdentifier`. Use em UI tests:
    /// `app.buttons["zodiak.button.primary.submit"].tap()`.
    func zodiakA11yID(_ atom: String, role: String? = nil, context: String? = nil) -> some View {
        let parts = [atom, role, context].compactMap { $0 }.joined(separator: ".")
        return accessibilityIdentifier("zodiak.\(parts)")
    }
}

// MARK: - Focus Ring (keyboard / Tab nav)

extension View {
    /// Aplica focus ring 2pt via `actionFocus` (onLite) ou `actionFocusOnHeavy` (onHeavy)
    /// quando a view recebe foco por teclado/Tab. Já usado em buttons; exposto aqui
    /// para custom interactives.
    func zodiakFocusRing(
        cornerRadius: CGFloat,
        onHeavy: Bool = false,
        focused: Bool
    ) -> some View {
        overlay {
            if focused {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        onHeavy ? ZodiakColors.actionFocusOnHeavy : ZodiakColors.actionFocus,
                        lineWidth: 2
                    )
            }
        }
    }
}

// MARK: - Heading semantics

extension View {
    /// Marca a view como heading semântico para VoiceOver (níveis 1–6, spec #118).
    ///
    /// ```swift
    /// ZodiakText("Título", style: .headline).zodiakHeading(level: 1)
    /// ```
    func zodiakHeading(level: Int) -> some View {
        let clampedLevel = min(max(level, 1), 6)
        let trait: AccessibilityHeadingLevel = {
            switch clampedLevel {
            case 1: return .h1
            case 2: return .h2
            case 3: return .h3
            case 4: return .h4
            case 5: return .h5
            default: return .h6
            }
        }()
        return self
            .accessibilityAddTraits(.isHeader)
            .accessibilityHeading(trait)
    }
}

// MARK: - RTL Mirror

extension View {
    /// Espelha a view horizontalmente em locales RTL (spec #118).
    ///
    /// Use em ícones direcionais (setas, chevrons) que precisam de flip RTL
    /// quando `ZodiakIcon.shouldMirrorForRTL` for `true`.
    func zodiakMirrorRTL() -> some View {
        modifier(ZodiakRTLMirrorModifier())
    }
}

private struct ZodiakRTLMirrorModifier: ViewModifier {
    @Environment(\.layoutDirection) private var layoutDirection

    func body(content: Content) -> some View {
        content
            .scaleEffect(x: layoutDirection == .rightToLeft ? -1 : 1, y: 1)
    }
}

// MARK: - Live-region announcement

extension View {
    /// Dispara um anúncio VoiceOver (live-region polite) quando `trigger` muda.
    ///
    /// ```swift
    /// button.zodiakAnnouncement("Copiado!", trigger: didCopy)
    /// ```
    func zodiakAnnouncement<T: Equatable>(_ message: String, trigger: T) -> some View {
        onChange(of: trigger) { _, _ in
            UIAccessibility.post(notification: .announcement, argument: message)
        }
    }
}
