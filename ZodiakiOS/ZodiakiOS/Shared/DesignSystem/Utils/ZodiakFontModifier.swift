import SwiftUI

// MARK: - ZodiakTextStyle
//
// Enum de estilos tipográficos do Zodiak Design System.
// Cada caso encapsula o Font + tracking + lineSpacing de um token canônico.
// Consome `ZodiakTypography.*` — zero valores literais permitidos aqui.
//
// Ref: Zodiak DS — FontModifier (Issue #120) · depende de #21 (ZodiakTypography)

/// Estilos tipográficos canônicos do Zodiak Design System.
///
/// Use `.zodiakStyle(_:)` para aplicar o estilo, tracking e line-height juntos:
/// ```swift
/// Text("Título").zodiakStyle(.titleLarge)
/// Text("Corpo").zodiakStyle(.bodyMedium)
/// Text("Label").zodiakStyle(.labelLarge).zodiakColor(ZodiakColors.textSecondary)
/// ```
public enum ZodiakTextStyle: CaseIterable, Sendable {
    // Display (heading 6XL–4XL)
    /// `displayLarge` — 128pt Ubuntu Light
    case displayLarge
    /// `displayMedium` — 96pt Ubuntu Light
    case displayMedium
    /// `displaySmall` — 72pt Ubuntu Light
    case displaySmall

    // Headline (heading 3XL–XL)
    /// `headlineLarge` — 56pt Ubuntu Light
    case headlineLarge
    /// `headlineMedium` — 48pt Ubuntu Light
    case headlineMedium
    /// `headlineSmall` — 40pt Ubuntu Light
    case headlineSmall

    // Title (heading L–S)
    /// `titleLarge` — 32pt Ubuntu Light
    case titleLarge
    /// `titleMedium` — 24pt Ubuntu Light
    case titleMedium
    /// `titleSmall` — 18pt Ubuntu Regular
    case titleSmall

    // Label (heading XS–2XS)
    /// `labelLarge` — 16pt Ubuntu Regular
    case labelLarge
    /// `labelMedium` — 14pt Ubuntu Regular
    case labelMedium
    /// `labelSmall` — 12pt Ubuntu Regular
    case labelSmall

    // Body
    /// `bodyXL` — 24pt Ubuntu Regular
    case bodyXL
    /// `bodyLarge` — 18pt Ubuntu Regular
    case bodyLarge
    /// `bodyMedium` — 16pt Ubuntu Regular
    case bodyMedium
    /// `bodySmall` — 14pt Ubuntu Regular
    case bodySmall

    // Caption
    /// `captionLarge` — 12pt Ubuntu Regular
    case captionLarge
    /// `captionSmall` — 11pt Ubuntu Regular
    case captionSmall

    // MARK: - Attributed values

    /// `Font` correspondente ao estilo.
    public var font: Font {
        switch self {
        case .displayLarge:   return ZodiakTypography.displayLarge
        case .displayMedium:  return ZodiakTypography.displayMedium
        case .displaySmall:   return ZodiakTypography.displaySmall
        case .headlineLarge:  return ZodiakTypography.headlineLarge
        case .headlineMedium: return ZodiakTypography.headlineMedium
        case .headlineSmall:  return ZodiakTypography.headlineSmall
        case .titleLarge:     return ZodiakTypography.titleLarge
        case .titleMedium:    return ZodiakTypography.titleMedium
        case .titleSmall:     return ZodiakTypography.titleSmall
        case .labelLarge:     return ZodiakTypography.labelLarge
        case .labelMedium:    return ZodiakTypography.labelMedium
        case .labelSmall:     return ZodiakTypography.labelSmall
        case .bodyXL:         return ZodiakTypography.bodyXL
        case .bodyLarge:      return ZodiakTypography.bodyLarge
        case .bodyMedium:     return ZodiakTypography.bodyMedium
        case .bodySmall:      return ZodiakTypography.bodySmall
        case .captionLarge:   return ZodiakTypography.captionLarge
        case .captionSmall:   return ZodiakTypography.captionSmall
        }
    }

    /// Tracking (letter-spacing) em pontos, conforme spec Supernova.
    public var tracking: CGFloat {
        switch self {
        case .displayLarge:   return ZodiakTypography.HeadingSize.sixXLarge.tracking
        case .displayMedium:  return ZodiakTypography.HeadingSize.fiveXLarge.tracking
        case .displaySmall:   return ZodiakTypography.HeadingSize.fourXLarge.tracking
        case .headlineLarge:  return ZodiakTypography.HeadingSize.threeXLarge.tracking
        case .headlineMedium: return ZodiakTypography.HeadingSize.twoXLarge.tracking
        case .headlineSmall:  return ZodiakTypography.HeadingSize.xLarge.tracking
        case .titleLarge:     return ZodiakTypography.HeadingSize.large.tracking
        case .titleMedium:    return ZodiakTypography.HeadingSize.medium.tracking
        case .titleSmall:     return ZodiakTypography.HeadingSize.small.tracking(for: .regular)
        case .labelLarge:     return ZodiakTypography.HeadingSize.xSmall.tracking(for: .regular)
        case .labelMedium:    return ZodiakTypography.HeadingSize.twoXSmall.tracking(for: .regular)
        case .labelSmall:     return ZodiakTypography.BodySize.xs.tracking
        case .bodyXL:         return ZodiakTypography.BodySize.xl.tracking
        case .bodyLarge:      return ZodiakTypography.BodySize.l.tracking
        case .bodyMedium:     return ZodiakTypography.BodySize.m.tracking
        case .bodySmall:      return ZodiakTypography.BodySize.s.tracking
        case .captionLarge:   return ZodiakTypography.BodySize.xs.tracking
        case .captionSmall:   return ZodiakTypography.BodySize.xs.tracking
        }
    }

    /// Line-spacing a aplicar via `.lineSpacing()` (aproximação do line-height do spec).
    ///
    /// SwiftUI `lineSpacing` é o espaço *entre* linhas, não a altura total.
    /// Usamos `lineHeight - fontSize` como aproximação.
    public var lineSpacing: CGFloat {
        switch self {
        case .displayLarge:   return ZodiakTypography.HeadingSize.sixXLarge.lineHeight - 128
        case .displayMedium:  return ZodiakTypography.HeadingSize.fiveXLarge.lineHeight - 96
        case .displaySmall:   return ZodiakTypography.HeadingSize.fourXLarge.lineHeight - 72
        case .headlineLarge:  return ZodiakTypography.HeadingSize.threeXLarge.lineHeight - 56
        case .headlineMedium: return ZodiakTypography.HeadingSize.twoXLarge.lineHeight - 48
        case .headlineSmall:  return ZodiakTypography.HeadingSize.xLarge.lineHeight - 40
        case .titleLarge:     return ZodiakTypography.HeadingSize.large.lineHeight - 32
        case .titleMedium:    return ZodiakTypography.HeadingSize.medium.lineHeight - 24
        case .titleSmall:     return ZodiakTypography.HeadingSize.small.lineHeight - 18
        case .labelLarge:     return ZodiakTypography.HeadingSize.xSmall.lineHeight - 16
        case .labelMedium:    return ZodiakTypography.HeadingSize.twoXSmall.lineHeight - 14
        case .labelSmall:     return ZodiakTypography.BodySize.xs.lineHeight - 12
        case .bodyXL:         return ZodiakTypography.BodySize.xl.lineHeight - 24
        case .bodyLarge:      return ZodiakTypography.BodySize.l.lineHeight - 18
        case .bodyMedium:     return ZodiakTypography.BodySize.m.lineHeight - 16
        case .bodySmall:      return ZodiakTypography.BodySize.s.lineHeight - 14
        case .captionLarge:   return ZodiakTypography.BodySize.xs.lineHeight - 12
        case .captionSmall:   return max(0, ZodiakTypography.BodySize.xs.lineHeight - 11)
        }
    }

    /// `true` se o estilo é de heading (`display*` ou `headline*`) — activa
    /// `.accessibilityAddTraits(.isHeader)` automaticamente.
    public var isHeading: Bool {
        switch self {
        case .displayLarge, .displayMedium, .displaySmall,
             .headlineLarge, .headlineMedium, .headlineSmall:
            return true

        default:
            return false
        }
    }
}

// MARK: - ZodiakStyleModifier (internal ViewModifier)

private struct ZodiakStyleModifier: ViewModifier {
    let style: ZodiakTextStyle

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .tracking(style.tracking)
            .lineSpacing(style.lineSpacing)
            .accessibilityAddTraits(style.isHeading ? .isHeader : [])
    }
}

// MARK: - View extensions

public extension View {
    /// Aplica o estilo tipográfico Zodiak (font + tracking + line-height + acessibilidade).
    ///
    /// ```swift
    /// Text("Seção").zodiakStyle(.titleLarge)
    /// Text("Corpo").zodiakStyle(.bodyMedium)
    /// ```
    ///
    /// - Parameter style: Estilo tipográfico canônico do Zodiak DS.
    func zodiakStyle(_ style: ZodiakTextStyle) -> some View {
        modifier(ZodiakStyleModifier(style: style))
    }

    /// Aplica uma cor de texto sobre qualquer view — chainable com `.zodiakStyle`.
    ///
    /// ```swift
    /// Text("Link")
    ///     .zodiakStyle(.labelLarge)
    ///     .zodiakColor(ZodiakColors.textLink)
    /// ```
    func zodiakColor(_ color: Color) -> some View {
        foregroundStyle(color)
    }
}
