import SwiftUI

// MARK: - Zodiak Shadow Tokens
//
// O Zodiak Design System (Capgemini) define um único shadow oficial.
// O design segue uma abordagem flat — sombras são usadas com parcimônia e
// apenas quando nenhuma outra solução visual atinge a clareza desejada.
//
// Especificação Supernova (`shadow-capgemini`):
//   x=4pt  y=0pt  blur=70pt  spread=3pt  color=rgba(0,0,0,0.03)
//
// Limitação SwiftUI: `.shadow(color:radius:x:y:)` não suporta `spread`.
// Para fidelidade pixel-perfect: usar background expandido `(.padding(-spread))`.
// Para uso geral: o shadow sem spread é visualmente equivalente e suficiente.
//
// Ref: Zodiak DS — Shadows (Supernova, Mai 2026) · Issue #18

// MARK: - ZodiakShadow (value type)

/// Estrutura que encapsula um token de sombra do Zodiak Design System.
///
/// Use `.zodiakShadow()` ao invés de chamar `.shadow(...)` diretamente:
/// ```swift
/// cardView.zodiakShadow()              // shadow padrão
/// cardView.zodiakShadow(.capgemini)    // explícito (mesmo resultado)
/// cardView.zodiakShadow(.none)         // sem sombra (superfície plana)
/// ```
public struct ZodiakShadow: Equatable {
    /// Cor da sombra (inclui opacidade).
    public let color: Color
    /// Raio de blur (= `blur / 2` em relação à notação Figma).
    public let radius: CGFloat
    /// Offset horizontal.
    public let x: CGFloat
    /// Offset vertical.
    public let y: CGFloat

    // MARK: - Tokens canônicos

    /// Sem sombra — superfície plana.
    public static let none = Self(
        color: .clear,
        radius: 0,
        x: 0,
        y: 0
    )

    /// Shadow oficial do Zodiak — `shadow-capgemini`.
    ///
    /// Especificação Figma: `4px 0 70px 3px rgba(0,0,0,0.03)`.
    /// Conversão para SwiftUI: `radius = blur/2 = 35`, `spread` ignorado.
    public static let capgemini = Self(
        color: Color.black.opacity(0.03),
        radius: 35,
        x: 4,
        y: 0
    )

    /// Shadow padrão — alias de `.capgemini`.
    public static let `default` = capgemini
}

// MARK: - ZodiakShadows (namespace de tokens estáticos)

/// Namespace de tokens de sombra do Zodiak Design System.
///
/// Para uso via modifier, prefira `.zodiakShadow()` em vez de acessar
/// as propriedades estáticas diretamente.
///
/// ```swift
/// // ✅ Recomendado
/// cardView.zodiakShadow()
///
/// // ⚠️ Legado — ainda funciona, mas menos ergonômico
/// cardView.shadow(
///     color: ZodiakShadows.color,
///     radius: ZodiakShadows.radius,
///     x: ZodiakShadows.x,
///     y: ZodiakShadows.y
/// )
/// ```
public enum ZodiakShadows {
    // MARK: - Tokens principais

    /// Shadow padrão (`.capgemini`) — use `.zodiakShadow()` para aplicar.
    public static let standard: ZodiakShadow = .capgemini

    // MARK: - Propriedades estáticas (backward-compat)

    /// Cor do shadow oficial — `rgba(0,0,0,0.03)`.
    public static let color: Color = ZodiakShadow.capgemini.color

    /// Raio de blur em SwiftUI — 35pt (= 70px Figma / 2).
    public static let radius: CGFloat = ZodiakShadow.capgemini.radius

    /// Offset horizontal — 4pt.
    public static let x: CGFloat = ZodiakShadow.capgemini.x

    /// Offset vertical — 0pt.
    public static let y: CGFloat = ZodiakShadow.capgemini.y

    /// Spread Figma — 3pt. Não aplicável diretamente em SwiftUI `.shadow`.
    /// Documentado para referência; usar `background.padding(-3)` se necessário.
    public static let spread: CGFloat = 3
}

// MARK: - View modifier

public extension View {
    /// Aplica o shadow canônico do Zodiak Design System.
    ///
    /// ```swift
    /// ZodiakCard(content: ...).zodiakShadow()
    /// ```
    ///
    /// - Parameter shadow: Token de sombra a aplicar. Padrão: `.capgemini`.
    @ViewBuilder
    func zodiakShadow(_ shadow: ZodiakShadow = .capgemini) -> some View {
        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}
