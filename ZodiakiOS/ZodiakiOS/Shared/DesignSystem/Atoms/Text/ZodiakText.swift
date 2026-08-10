    import SwiftUI

    // MARK: - ZodiakTextColor
    /// Cores semânticas disponíveis para texto no Zodiak Design System.
    enum ZodiakTextColor {
        case primary
        case secondary
        case disabled
        case negative
        case link
        case linkHover
        case linkPressed
        case linkInverse
        case inverse

        var resolvedColor: Color {
            switch self {
            case .primary:     return ZodiakColors.textPrimary
            case .secondary:   return ZodiakColors.textSecondary
            case .disabled:    return ZodiakColors.textDisabled
            case .negative:    return ZodiakColors.textNegative
            case .link:        return ZodiakColors.textLink
            case .linkHover:   return ZodiakColors.textLinkHover
            case .linkPressed: return ZodiakColors.textLinkPressed
            case .linkInverse: return ZodiakColors.textLinkInverse
            case .inverse:     return ZodiakColors.textInverse
            }
        }
    }

    // MARK: - ZodiakTextViewStyle
    /// Estilos tipográficos do Zodiak Design System.
    /// Headings menores (`headline`/`title1`/`title2`/`title3`/`subtitleSmall`) são fixos.
    /// Headings grandes aceitam `weight` (Light 300 / Regular 400).
    /// Body styles aceitam variantes de bold e color.
    enum ZodiakTextViewStyle {
        // MARK: Display headings (Ubuntu — peso configurável)
        /// heading-6xl: 128pt
        case headline6XL(weight: ZodiakTypography.HeadingWeight = .light)
        /// heading-5xl: 96pt
        case headline5XL(weight: ZodiakTypography.HeadingWeight = .light)
        /// heading-4xl: 72pt
        case headline4XL(weight: ZodiakTypography.HeadingWeight = .light)
        /// heading-3xl: 56pt
        case headline3XL(weight: ZodiakTypography.HeadingWeight = .light)
        /// heading-2xl: 48pt
        case headline2XL(weight: ZodiakTypography.HeadingWeight = .light)
        /// heading-xl: 40pt
        case headlineXL(weight: ZodiakTypography.HeadingWeight = .light)

        // MARK: Standard headings
        /// heading-l: Ubuntu-Light 32pt / line-height 40
        case headline
        /// heading-m: Ubuntu-Light 24pt / line-height 32 / tracking +0.3
        case title1
        /// heading-s: Ubuntu-Regular 18pt / line-height 26 / tracking +0.2
        case title2
        /// heading-xs: Ubuntu-Regular 16pt / line-height 21 / tracking +0.3
        case title3
        /// heading-2xs: Ubuntu-Regular 14pt / line-height 18
        case subtitleSmall

        // MARK: Body
        /// body-xl: Ubuntu-Regular 24pt / line-height 36
        case bodyXL(bold: Bool = false, color: ZodiakTextColor = .primary)
        /// body-l: Ubuntu-Regular 18pt / line-height 30
        case bodyLarge(bold: Bool = false, color: ZodiakTextColor = .primary)
        /// body-m: Ubuntu-Regular 16pt / line-height 26 / tracking +0.24
        case body(bold: Bool = false, color: ZodiakTextColor = .primary)
        /// body-s: Ubuntu-Regular 14pt / line-height 21
        case bodySmall(bold: Bool = false, color: ZodiakTextColor = .primary)
        /// body-xs: Ubuntu-Regular 12pt / line-height 18 / tracking +0.3
        case caption(bold: Bool = false, color: ZodiakTextColor = .secondary)

        // MARK: Italic (decorativo — uso esparso)
        /// body italic — `size` controla o tamanho.
        case italic(size: ZodiakTypography.BodySize = .m, color: ZodiakTextColor = .primary)
    }

    // MARK: - ZodiakText
    /// Componente unificado de texto do Zodiak Design System.
    /// Aplica fonte Ubuntu, tracking, line-height oficial e cor semântica automaticamente.
    ///
    /// **Uso:**
    /// ```swift
    /// ZodiakText("Título da tela", style: .title2)
    /// ZodiakText("Display", style: .headline3XL(weight: .regular))
    /// ZodiakText("Corpo em negrito", style: .body(bold: true))
    /// ZodiakText("catalog.color.secondary_text", style: .body(color: .secondary))
    /// ```
    struct ZodiakText: View {
        private enum Content {
            case key(LocalizedStringKey)
            case verbatim(String)
        }
        private let content: Content
        let style: ZodiakTextViewStyle
        var alignment: TextAlignment = .leading
        var lineLimit: Int?

        /// Inicializador principal: `text` é tratado como chave de localização (LocalizedStringKey).
        /// Use para strings estáticas de UI. Passe a chave literal, não `String(localized:)`.
        init(
            _ text: String,
            style: ZodiakTextViewStyle,
            alignment: TextAlignment = .leading,
            lineLimit: Int? = nil
        ) {
            self.content = .key(LocalizedStringKey(text))
            self.style = style
            self.alignment = alignment
            self.lineLimit = lineLimit
        }

        /// Use quando já tem uma `LocalizedStringKey` (ex: de constantes).
        init(
            _ key: LocalizedStringKey,
            style: ZodiakTextViewStyle,
            alignment: TextAlignment = .leading,
            lineLimit: Int? = nil
        ) {
            self.content = .key(key)
            self.style = style
            self.alignment = alignment
            self.lineLimit = lineLimit
        }

        /// Inicializador verbatim: exibe `text` sem lookup de localização.
        /// Use para dados dinâmicos (nomes, valores, conteúdo gerado).
        init(
            verbatim text: String,
            style: ZodiakTextViewStyle,
            alignment: TextAlignment = .leading,
            lineLimit: Int? = nil
        ) {
            self.content = .verbatim(text)
            self.style = style
            self.alignment = alignment
            self.lineLimit = lineLimit
        }

        var body: some View {
            resolvedText
                .multilineTextAlignment(alignment)
                .lineLimit(lineLimit)
        }

        private var baseText: Text {
            switch content {
            case .key(let key):     return Text(key)
            case .verbatim(let str): return Text(verbatim: str)
            }
        }

        @ViewBuilder
        private var resolvedText: some View {
            switch style {
            // MARK: Display headings
            case .headline6XL(let weight): heading(.sixXLarge, weight: weight, isHeader: true)
            case .headline5XL(let weight): heading(.fiveXLarge, weight: weight, isHeader: true)
            case .headline4XL(let weight): heading(.fourXLarge, weight: weight, isHeader: true)
            case .headline3XL(let weight): heading(.threeXLarge, weight: weight, isHeader: true)
            case .headline2XL(let weight): heading(.twoXLarge, weight: weight, isHeader: true)
            case .headlineXL(let weight):  heading(.xLarge, weight: weight, isHeader: true)

            // MARK: Standard headings
            case .headline:
                heading(.large, weight: .light, isHeader: true)

            case .title1:
                heading(.medium, weight: .light, isHeader: true)

            case .title2:
                heading(.small, weight: .regular, isHeader: true)

            case .title3:
                heading(.xSmall, weight: .regular, isHeader: true)

            case .subtitleSmall:
                heading(.twoXSmall, weight: .regular, isHeader: true)

            // MARK: Body
            case .bodyXL(let bold, let color):
                bodyView(.xl, bold: bold, color: color)

            case .bodyLarge(let bold, let color):
                bodyView(.l, bold: bold, color: color)

            case .body(let bold, let color):
                bodyView(.m, bold: bold, color: color)

            case .bodySmall(let bold, let color):
                bodyView(.s, bold: bold, color: color)

            case .caption(let bold, let color):
                bodyView(.xs, bold: bold, color: color)

            // MARK: Italic
            case .italic(let size, let color):
                baseText
                    .font(ZodiakTypography.bodyItalicFont(size))
                    .tracking(ZodiakTypography.bodyTracking(size))
                    .lineSpacing(ZodiakTypography.bodyLineHeight(size) - size.pointSize)
                    .foregroundColor(color.resolvedColor)
                    .accessibilityLabel(baseText)
            }
        }

        // MARK: Render helpers

        @ViewBuilder
        private func heading(
            _ size: ZodiakTypography.HeadingSize,
            weight: ZodiakTypography.HeadingWeight,
            isHeader: Bool
        ) -> some View {
            let font = ZodiakTypography.heading(size, weight: weight)
            let tracking = ZodiakTypography.headingTracking(size, weight: weight)
            let lineSpacing = ZodiakTypography.headingLineHeight(size) - size.pointSize
            let view = baseText
                .font(font)
                .tracking(tracking)
                .lineSpacing(lineSpacing)
                .foregroundColor(ZodiakColors.textPrimary)
                .accessibilityLabel(baseText)
            if isHeader {
                view.accessibilityAddTraits(.isHeader)
            } else {
                view
            }
        }

        @ViewBuilder
        private func bodyView(
            _ size: ZodiakTypography.BodySize,
            bold: Bool,
            color: ZodiakTextColor
        ) -> some View {
            baseText
                .font(ZodiakTypography.bodyFont(size))
                .tracking(ZodiakTypography.bodyTracking(size))
                .lineSpacing(ZodiakTypography.bodyLineHeight(size) - size.pointSize)
                .fontWeight(bold ? .semibold : .regular)
                .foregroundColor(color.resolvedColor)
                .accessibilityLabel(baseText)
        }
    }

    // MARK: - Preview
    #Preview {
        ScrollView {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakText("Display 3XL — 56pt Light", style: .headline3XL())
                ZodiakText("Display 2XL — 48pt Regular", style: .headline2XL(weight: .regular))
                ZodiakText("Display XL — 40pt Light", style: .headlineXL())
                ZodiakText("Headline — 32pt Light", style: .headline)
                ZodiakText("Title 1 — 24pt Light", style: .title1)
                ZodiakText("Title 2 — 18pt Regular", style: .title2)
                ZodiakText("Title 3 — 16pt Regular", style: .title3)
                ZodiakText("Subtitle Small — 14pt Regular", style: .subtitleSmall)
                ZodiakText("Body XL — 24pt Regular", style: .bodyXL())
                ZodiakText("Body Large — 18pt Regular", style: .bodyLarge())
                ZodiakText("Body — 16pt Regular", style: .body())
                ZodiakText("Body Bold — 16pt Semibold", style: .body(bold: true))
                ZodiakText("Body italic decorativo", style: .italic())
                ZodiakText("Body Small — 14pt Regular", style: .bodySmall())
                ZodiakText("Caption — 12pt Regular", style: .caption())
            }
            .padding(ZodiakSpacing.s24)
        }
    }
