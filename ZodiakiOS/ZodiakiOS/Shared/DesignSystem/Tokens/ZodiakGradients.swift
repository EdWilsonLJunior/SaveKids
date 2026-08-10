import SwiftUI

// MARK: - Zodiak Gradient Tokens
// Fonte: Zodiak Design System – Capgemini | Página "Gradients"
// Gradientes lineares usados em heroes, banners e sobreposições.

enum ZodiakGradients {
    // MARK: - Brand Gradients
    /// Gradient azul principal — hero sections e headers
    /// De: #070a16 (Blue.shade950) → #0058ab (Blue.shade500)
    static let brand = LinearGradient(
        colors: [ZodiakPrimitives.Blue.shade950, ZodiakPrimitives.Blue.shade500],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    /// Gradient marine — seções de destaque escuras
    /// De: #121a38 (Blue.shade900) → #1c4076 (Blue.shade700)
    static let marine = LinearGradient(
        colors: [ZodiakPrimitives.Blue.shade900, ZodiakPrimitives.Blue.shade700],
        startPoint: .top,
        endPoint: .bottom
    )

    /// Gradient azul médio — cards e banners intermediários
    /// De: #1d365a (Blue.shade800) → #0058ab (Blue.shade500)
    static let azur = LinearGradient(
        colors: [ZodiakPrimitives.Blue.shade800, ZodiakPrimitives.Blue.shade500],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Accent Gradients
    /// Gradient laranja — CTAs e destaques brand orange
    /// De: #f9a464 (brandOrange) → #f64059 (actionWarning)
    static let orange = LinearGradient(
        colors: [ZodiakPrimitives.Orange.shade400, ZodiakPrimitives.Red.shade500],
        startPoint: .leading,
        endPoint: .trailing
    )

    // MARK: - Overlay Gradients
    /// Sobreposição escura — sobre imagens (hero full screen, image containers)
    /// De: rgba(7,10,22, 0.7) → transparente
    static let overlayDark = LinearGradient(
        colors: [
            ZodiakPrimitives.Blue.shade950.opacity(0.75),
            Color.clear
        ],
        startPoint: .bottom,
        endPoint: .top
    )

    /// Sobreposição suave — sobre imagens em cards
    /// De: rgba(18,26,56, 0.5) → transparente
    static let overlayMedium = LinearGradient(
        colors: [
            ZodiakPrimitives.Blue.shade900.opacity(0.5),
            Color.clear
        ],
        startPoint: .bottom,
        endPoint: .top
    )

    /// Fade branco para baixo — separadores de seção em fundo claro
    static let fadeWhiteDown = LinearGradient(
        colors: [Color.clear, Color.white.opacity(0.95)],
        startPoint: .top,
        endPoint: .bottom
    )

    // MARK: - Surface Gradient (glass/blur hint)
    /// Fundo de card com efeito translúcido (blur=30 do Figma)
    static let glass = LinearGradient(
        colors: [
            Color.white.opacity(0.15),
            Color.white.opacity(0.05)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Photo Gradient (Spec: Color > Overlay > Photo Overlay)
    /// Gradiente oficial Zodiak para garantir contraste de texto sobre fotos.
    /// linear-gradient(0deg, #00000000 0%, #000000 75%) — escuro embaixo, transparente em cima.
    /// Aplicar como overlay direto na `Image` antes do conteúdo de texto.
    static let photoOverlay = LinearGradient(
        stops: [
            .init(color: Color.black.opacity(0), location: 0.0),
            .init(color: Color.black, location: 0.75)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
