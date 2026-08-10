import SwiftUI

// MARK: - Zodiak Blur Tokens
// Fonte: Zodiak Design System – Capgemini | Página "Blurs"
//
// Dois cenários suportados:
//
// 1. Background blur (fundo fotográfico)
//    Image(photo).overlay(ZodiakBlur.pageOverlay)   ← passo 1
//    contentView.zodiakBlurBackground()             ← passo 2
//
// 2. Content blur (desfoque do conteúdo de fundo quando modal/overlay está ativo)
//    anyView.zodiakContentBlur(isActive: $showModal)  ← animação incluída
//
// Regras:
//   - Usar apenas as cores especificadas (não substituir por outras)
//   - Conteúdo sobre blur SEMPRE claro (branco) — nunca texto/botão escuro

enum ZodiakBlur {
    /// Raio do blur de fundo sobre foto — 30pt (especificação Figma)
    static let radius: CGFloat = 30

    /// Raio do blur aplicado ao conteúdo de fundo quando um modal/overlay está ativo — 8pt
    static let overlayRadius: CGFloat = 8

    /// Overlay aplicado à imagem/foto de fundo antes do container blur
    /// rgba(23, 26, 34, 0.40) — tom escuro Capgemini
    static let pageOverlay = Color(
        red: 23 / 255,
        green: 26 / 255,
        blue: 34 / 255
    ).opacity(0.4)

    /// Fill do container com efeito blur
    /// rgba(255, 255, 255, 0.05) — véu branco translúcido
    static let colorOverlay = Color.white.opacity(0.05)
}
