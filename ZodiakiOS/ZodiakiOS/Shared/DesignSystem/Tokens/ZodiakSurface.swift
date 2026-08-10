import Foundation

// MARK: - ZodiakSurface
// Superfície sobre a qual um componente é renderizado.
// Controla a resolução de cores de contraste em botões, ícones e outros componentes interativos.
// Ref: Zodiak DS — Button Regular (Supernova, Mai 2026) · Issues #32 · #28

/// Superfície de renderização do Zodiak Design System.
///
/// Use para comunicar ao componente qual é o contexto visual de fundo, garantindo
/// que cores e contrastes resolvam corretamente conforme as specs Zodiak.
///
/// ```swift
/// ZodiakButtonPrimary(title: "Confirmar", surface: .onHeavy, action: {})
/// ZodiakIconButtonPrimary(icon: "heart.fill", label: "Curtir", surface: .onPhoto, action: {})
/// ```
public enum ZodiakSurface {
    /// Superfície clara/branca — padrão. Fundos `background`, `surface`, `surfaceLite`.
    case onLite
    /// Superfície escura — fundos `surfaceInk`, `surfaceMarine`, heroes e banners escuros.
    case onHeavy
    /// Superfície fotográfica — sobre imagens. Contraste garantido sem fundo sólido.
    case onPhoto
}
