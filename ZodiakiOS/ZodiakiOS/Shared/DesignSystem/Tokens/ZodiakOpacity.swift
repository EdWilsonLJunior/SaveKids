import Foundation

// MARK: - Zodiak Opacity Tokens
//
// Tokens de opacidade semânticos do Zodiak Design System.
// Use estes valores em vez de literais para garantir consistência visual.
//
// Ref: Zodiak DS — Opacity (Supernova, Mai 2026) · Issue #22

/// Namespace de tokens de opacidade do Zodiak Design System.
///
/// ```swift
/// // Feedback de hover em superfícies
/// ZodiakColors.surface.opacity(ZodiakOpacity.hover)
///
/// // Elemento desabilitado
/// button.opacity(ZodiakOpacity.disabled)
///
/// // Overlay de modal/drawer
/// Color.black.opacity(ZodiakOpacity.overlay)
/// ```
public enum ZodiakOpacity {
    // MARK: - Tokens canônicos

    /// Opacidade para elementos desabilitados — `0.4`.
    public static let disabled: Double = 0.4

    /// Opacidade para overlays de modal e drawer — `0.4` (`rgba(23,26,34,0.4)`).
    public static let overlay: Double = 0.4

    /// Opacidade para estado selecionado — `0.5`.
    public static let selected: Double = 0.5

    /// Opacidade para estado concluído — `0.6`.
    public static let completed: Double = 0.6

    /// Opacidade para feedback de hover — `0.3`.
    public static let hover: Double = 0.3
}
