import SwiftUI

// MARK: - Zodiak Typography Tokens
//
// Tokens tipográficos do Zodiak Design System (Capgemini).
// Typeface: Ubuntu — Light (300), Regular (400), Regular Italic (400).
//
// ⚠️ OS ARQUIVOS ESTÃO EM Resources/ — nomes PostScript corretos confirmados:
//    Ubuntu-Light.ttf     → "Ubuntu-Light"
//    Ubuntu-Regular.ttf   → "Ubuntu-Regular"
//    Ubuntu-Italic.ttf    → "Ubuntu-Italic"   (italic do peso Regular)
//    Ubuntu-LightItalic.ttf → "Ubuntu-LightItalic"
//    Para usar, o Info.plist precisa declarar estes arquivos em UIAppFonts.
//    Com GENERATE_INFOPLIST_FILE = YES, adicionar via Xcode:
//    Target → Build Settings → "Privacy - ..." → Info.plist Values → UIAppFonts
//    (ou adicionar INFOPLIST_KEY_UIAppFonts ao pbxproj).
//
// Nomes canônicos (Supernova):
//   displayLarge/Medium/Small       (heading 6XL–4XL, 128/96/72pt)
//   headlineLarge/Medium/Small      (heading 3XL–XL,  56/48/40pt)
//   titleLarge/Medium/Small         (heading L–S,     32/24/18pt)
//   labelLarge/Medium/Small         (heading XS–2XS,  16/14/12pt)
//   bodyLarge/Medium/Small          (body L–M–S,      18/16/14pt)
//   captionLarge/Small              (body XS,         12/11pt)
//
// Ref: Zodiak DS — Typography (Supernova, Mai 2026) · Issue #21

/// Tokens tipográficos do Zodiak Design System.
///
/// Use os nomes canônicos em código novo:
/// ```swift
/// Text("Título").font(ZodiakTypography.titleLarge)
/// Text("Corpo").font(ZodiakTypography.bodyMedium)
/// Text("Label").font(ZodiakTypography.labelLarge)
/// ```
///
/// Para aplicar tracking + line-height automaticamente, use o modifier
/// `.zodiakStyle(_:)` (requer `ZodiakFontModifier` — issue #120).

enum ZodiakTypography {
    // MARK: - Font Names
    fileprivate static let light = "Ubuntu-Light"
    fileprivate static let regular = "Ubuntu-Regular"
    fileprivate static let regularItalic = "Ubuntu-RegularItalic"

    // MARK: - Canonical Supernova Token Names
    //
    // Nomes canônicos alinhados com a nomenclatura Supernova do Zodiak DS.
    // Use sempre estes nomes em código novo.
    // Os nomes iOS-específicos anteriores (headline6XL, title1, body…)
    // são mantidos abaixo como aliases deprecados.

    // Display — heading 6XL–4XL (Ubuntu Light 300)
    /// `heading-6xl-300`: 128pt · line-height 134pt · tracking -1.5pt
    static let displayLarge: Font = customFont(light, size: 128, relativeTo: .largeTitle)
    /// `heading-5xl-300`: 96pt · line-height 108pt · tracking -0.8pt
    static let displayMedium: Font = customFont(light, size: 96, relativeTo: .largeTitle)
    /// `heading-4xl-300`: 72pt · line-height 84pt · tracking -1.2pt
    static let displaySmall: Font = customFont(light, size: 72, relativeTo: .largeTitle)

    // Headline — heading 3XL–XL (Ubuntu Light 300)
    /// `heading-3xl-300`: 56pt · line-height 68pt · tracking -0.6pt
    static let headlineLarge: Font = customFont(light, size: 56, relativeTo: .largeTitle)
    /// `heading-2xl-300`: 48pt · line-height 58pt · tracking -0.3pt
    static let headlineMedium: Font = customFont(light, size: 48, relativeTo: .largeTitle)
    /// `heading-xl-300`: 40pt · line-height 50pt · tracking -0.2pt
    static let headlineSmall: Font = customFont(light, size: 40, relativeTo: .largeTitle)

    // Title — heading L–S (Ubuntu Light/Regular)
    /// `heading-l-300`: 32pt · line-height 40pt · tracking 0pt
    static let titleLarge: Font = customFont(light, size: 32, relativeTo: .title)
    /// `heading-m-300`: 24pt · line-height 32pt · tracking +0.3pt
    static let titleMedium: Font = customFont(light, size: 24, relativeTo: .title2)
    /// `heading-s-400`: 18pt · line-height 26pt · tracking +0.2pt
    static let titleSmall: Font = customFont(regular, size: 18, relativeTo: .title3)

    // Label — heading XS–2XS (Ubuntu Regular 400)
    /// `heading-xs-400`: 16pt · line-height 21pt · tracking +0.3pt
    static let labelLarge: Font = customFont(regular, size: 16, relativeTo: .headline)
    /// `heading-2xs-400`: 14pt · line-height 18pt · tracking +1.4%
    static let labelMedium: Font = customFont(regular, size: 14, relativeTo: .subheadline)
    /// 12pt — token extra, pendente confirmação Supernova
    static let labelSmall: Font = customFont(regular, size: 12, relativeTo: .caption)

    // Body — body L–S (Ubuntu Regular 400) — nomes já canônicos
    /// `body-xl-400`: 24pt · line-height 36pt · tracking +1.2%
    static let bodyXL: Font = customFont(regular, size: 24, relativeTo: .title2)
    /// `body-l-400`: 18pt · line-height 30pt · tracking +1.2%
    static let bodyLarge: Font = customFont(regular, size: 18, relativeTo: .body)
    /// `body-m-400`: 16pt · line-height 26pt · tracking +1.5%
    static let bodyMedium: Font = customFont(regular, size: 16, relativeTo: .body)
    /// `body-s-400`: 14pt · line-height 21pt · tracking +2.2%
    static let bodySmall: Font = customFont(regular, size: 14, relativeTo: .callout)

    // Caption (Ubuntu Regular 400)
    /// `body-xs-400`: 12pt · line-height 18pt · tracking +2.5%
    static let captionLarge: Font = customFont(regular, size: 12, relativeTo: .caption)
    /// 11pt — token extra, pendente confirmação Supernova
    static let captionSmall: Font = customFont(regular, size: 11, relativeTo: .caption2)

    // MARK: - Italic (decorativo — não usar em headings nem para ênfase em parágrafos)
    /// body-xl italic
    static let bodyXLItalic: Font = customFont(regularItalic, size: 24, relativeTo: .title2)
    /// body-l italic
    static let bodyLargeItalic: Font = customFont(regularItalic, size: 18, relativeTo: .body)
    /// body-m italic
    static let bodyItalic: Font = customFont(regularItalic, size: 16, relativeTo: .body)
    /// body-s italic
    static let bodySmallItalic: Font = customFont(regularItalic, size: 14, relativeTo: .callout)
    /// body-xs italic
    static let captionItalic: Font = customFont(regularItalic, size: 12, relativeTo: .caption)

    // MARK: - Semantic alias
    /// Botão: body-m Ubuntu-Regular 16pt (= `bodyMedium`)
    static let button: Font = bodyMedium

    // MARK: - Inventory (single source of truth for galleries / docs)
    /// Estilos canônicos expostos no catálogo — usados por TypographyGalleryView e CatalogHomeView.
    /// Não inclui italics nem displays de heading editorial.
    static let allMainStyles: [(name: String, font: Font, size: String)] = [
        ("Title Large", titleLarge, "32pt"),
        ("Title Medium", titleMedium, "24pt"),
        ("Title Small", titleSmall, "18pt"),
        ("Label Large", labelLarge, "16pt"),
        ("Body Large", bodyLarge, "18pt"),
        ("Body Medium", bodyMedium, "16pt"),
        ("Body Small", bodySmall, "14pt"),
        ("Label Medium", labelMedium, "14pt"),
        ("Caption Large", captionLarge, "12pt"),
        ("Button", button, "16pt")
    ]

    // MARK: - Private Factory
    fileprivate static func customFont(
        _ name: String,
        size: CGFloat,
        relativeTo style: Font.TextStyle? = nil
    ) -> Font {
        if UIFont(name: name, size: size) != nil {
            if let style {
                return .custom(name, size: size, relativeTo: style)
            }
            return .custom(name, size: size)
        }
        // Fallback para SF Pro enquanto Ubuntu não está instalado
        let weight: Font.Weight = name.contains("Light") ? .light : .regular
        let italic = name.contains("Italic")
        let base: Font
        if let style {
            base = .system(style, design: .default).weight(weight)
            return italic ? base.italic() : base
        }
        let nonScaled: Font = .system(size: size, weight: weight, design: .default)
        return italic ? nonScaled.italic() : nonScaled
    }
}

// MARK: - Heading Size + Weight (dual-weight API)
extension ZodiakTypography {
    /// Tamanho de heading (t-shirt sizing per Zodiak).
    enum HeadingSize {
        case twoXSmall, xSmall, small, medium, large, xLarge, twoXLarge, threeXLarge, fourXLarge, fiveXLarge, sixXLarge

        var pointSize: CGFloat {
            switch self {
            case .twoXSmall:  return 14
            case .xSmall:     return 16
            case .small:      return 18
            case .medium:     return 24
            case .large:      return 32
            case .xLarge:     return 40
            case .twoXLarge:  return 48
            case .threeXLarge: return 56
            case .fourXLarge: return 72
            case .fiveXLarge: return 96
            case .sixXLarge:  return 128
            }
        }

        var lineHeight: CGFloat {
            switch self {
            case .twoXSmall:  return 18
            case .xSmall:     return 21
            case .small:      return 26
            case .medium:     return 32
            case .large:      return 40
            case .xLarge:     return 50
            case .twoXLarge:  return 58
            case .threeXLarge: return 68
            case .fourXLarge: return 84
            case .fiveXLarge: return 108
            case .sixXLarge:  return 134
            }
        }

        /// Tracking em pontos (positivo = expansão, negativo = compressão).
        var tracking: CGFloat {
            switch self {
            case .twoXSmall:  return 14 * 0.014   // +1.4% ≈ 0.196
            case .xSmall:     return 0.3
            case .small:      return 0.2
            case .medium:     return 0.3
            case .large:      return 0.0
            case .xLarge:     return -0.2
            case .twoXLarge:  return -0.3
            case .threeXLarge: return -0.6
            case .fourXLarge: return -1.2
            case .fiveXLarge: return -0.8
            case .sixXLarge:  return -1.5
            }
        }

        /// Tracking em pontos específico por peso (peso 400 difere do 300 em tamanhos menores).
        /// Valores alinhados com ZodiakReact `preset.css` e spec Supernova.
        func tracking(for weight: HeadingWeight) -> CGFloat {
            guard weight == .regular else { return tracking }
            let map: [Self: CGFloat] = [
                .twoXSmall: 0.168, .xSmall: 0.2, .small: 0.1, .medium: 0.2,
                .large: -0.3, .xLarge: -0.3, .twoXLarge: -0.5,
                .threeXLarge: -0.4, .fourXLarge: -1.0, .fiveXLarge: -0.8, .sixXLarge: -1.1
            ]
            return map[self] ?? tracking
        }

        /// `Font.TextStyle` mais próximo para Dynamic Type scaling.
        var dynamicTypeStyle: Font.TextStyle {
            switch self {
            case .twoXSmall:    return .subheadline
            case .xSmall:       return .headline
            case .small:        return .title3
            case .medium:       return .title2
            case .large:        return .title

            case .xLarge,
                 .twoXLarge,
                 .threeXLarge,
                 .fourXLarge,
                 .fiveXLarge,
                 .sixXLarge:    return .largeTitle
            }
        }
    }

    /// Peso de heading. Body styles usam apenas `.regular` + italic.
    enum HeadingWeight {
        case light    // Ubuntu-Light 300 — default para headings grandes
        case regular  // Ubuntu-Regular 400 — ênfase em headings menores

        var fontName: String {
            switch self {
            case .light:   return ZodiakTypography.light
            case .regular: return ZodiakTypography.regular
            }
        }
    }

    /// Retorna a `Font` Ubuntu para um heading com peso explícito (Dynamic Type aware).
    /// Ex: `ZodiakTypography.heading(.large, weight: .regular)` → 32pt Regular.
    static func heading(_ size: HeadingSize, weight: HeadingWeight = .light) -> Font {
        customFont(weight.fontName, size: size.pointSize, relativeTo: size.dynamicTypeStyle)
    }

    /// Line-height em pontos para um heading.
    static func headingLineHeight(_ size: HeadingSize) -> CGFloat {
        size.lineHeight
    }

    /// Tracking em pontos para um heading, respeitando o peso.
    /// Peso 400 (`.regular`) tem tracking diferente do 300 (`.light`) em alguns tamanhos.
    static func headingTracking(_ size: HeadingSize, weight: HeadingWeight = .light) -> CGFloat {
        size.tracking(for: weight)
    }
}

// MARK: - Body Size (single-weight)
extension ZodiakTypography {
    enum BodySize {
        case xs, s, m, l, xl

        var pointSize: CGFloat {
            switch self {
            case .xs: return 12
            case .s:  return 14
            case .m:  return 16
            case .l:  return 18
            case .xl: return 24
            }
        }

        var lineHeight: CGFloat {
            switch self {
            case .xs: return 18
            case .s:  return 21
            case .m:  return 26
            case .l:  return 30
            case .xl: return 36
            }
        }

        /// Tracking em pontos. Body usa percentuais relativos ao font-size.
        var tracking: CGFloat {
            switch self {
            case .xs: return 12 * 0.025   // 2.5% ≈ 0.30
            case .s:  return 14 * 0.022   // 2.2% ≈ 0.31
            case .m:  return 16 * 0.015   // 1.5% ≈ 0.24
            case .l:  return 18 * 0.012   // 1.2% ≈ 0.22
            case .xl: return 24 * 0.012   // 1.2% ≈ 0.29
            }
        }

        /// `Font.TextStyle` mais próximo para Dynamic Type scaling.
        var dynamicTypeStyle: Font.TextStyle {
            switch self {
            case .xs: return .caption
            case .s:  return .callout
            case .m:  return .body
            case .l:  return .body
            case .xl: return .title2
            }
        }
    }

    /// Retorna `Font` body Ubuntu-Regular para um tamanho (Dynamic Type aware).
    static func bodyFont(_ size: BodySize) -> Font {
        customFont(regular, size: size.pointSize, relativeTo: size.dynamicTypeStyle)
    }

    /// Retorna `Font` body italic Ubuntu-RegularItalic para um tamanho.
    /// ⚠️ Uso decorativo apenas — não para ênfase em texto corrido.
    static func bodyItalicFont(_ size: BodySize) -> Font {
        customFont(regularItalic, size: size.pointSize, relativeTo: size.dynamicTypeStyle)
    }

    /// Line-height em pontos para um body size.
    static func bodyLineHeight(_ size: BodySize) -> CGFloat {
        size.lineHeight
    }

    /// Tracking em pontos para um body size.
    static func bodyTracking(_ size: BodySize) -> CGFloat {
        size.tracking
    }
}

// MARK: - Line Height Constants (legacy aliases — em pontos)
// Use `ZodiakText` que aplica `.lineSpacing()` automaticamente; estas constantes
// são exportadas para componentes que precisam controlar o layout manualmente.
extension ZodiakTypography {
    static let lineHeightHeadline: CGFloat       = 40   // heading-l
    static let lineHeightTitle1: CGFloat         = 32   // heading-m
    static let lineHeightTitle2: CGFloat         = 26   // heading-s
    static let lineHeightTitle3: CGFloat         = 21   // heading-xs
    static let lineHeightSubtitleSmall: CGFloat  = 18   // heading-2xs
    static let lineHeightBodyXL: CGFloat         = 36
    static let lineHeightBodyLarge: CGFloat      = 30
    static let lineHeightBody: CGFloat           = 26
    static let lineHeightBodySmall: CGFloat      = 21
    static let lineHeightCaption: CGFloat        = 18
}
