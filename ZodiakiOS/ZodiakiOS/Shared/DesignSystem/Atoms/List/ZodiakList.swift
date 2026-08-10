import SwiftUI

// MARK: - Zodiak List
// Fonte: Zodiak Design System – Capgemini | Content Display > List
// Overview:  https://doc-zodiak.capgemini.com/latest/components/content-display/list/overview-AWLIWcod
// Specs:     https://doc-zodiak.capgemini.com/latest/components/content-display/list/specs-Q6yzE0Gn
// Guidelines:https://doc-zodiak.capgemini.com/latest/components/content-display/list/guidelines-dLzSzMgM
//
// Anatomy:
//   1. Headline (optional) — heading-m / 24pt
//   2. Decorative vertical line — actionPrimary, 2pt wide
//   3. List items — bullet (•) ou numbered (1.) — body-l / 18pt

// MARK: - Supporting Types

enum ZodiakListVariant {
    /// Lista não-ordenada com marcadores (•)
    case unordered
    /// Lista ordenada com números (1. 2. 3.)
    case ordered
}

enum ZodiakListAlignment {
    case leading, center
}

// MARK: - ZodiakList

struct ZodiakList: View {
    let items: [String]
    var headline: String?
    var variant: ZodiakListVariant = .unordered
    var alignment: ZodiakListAlignment = .leading

    var body: some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            decorativeLine
            VStack(alignment: hAlignment, spacing: ZodiakSpacing.s8) {
                if let headline {
                    Text(LocalizedStringKey(headline))
                        .font(ZodiakTypography.titleMedium)              // heading-m-400-regular 24pt
                        .foregroundColor(ZodiakColors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: contentAlignment)
                }
                VStack(alignment: hAlignment, spacing: ZodiakSpacing.s4) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        itemRow(index: index, text: item)
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
    }

    // MARK: - Private Views

    private var decorativeLine: some View {
        Rectangle()
            .fill(ZodiakColors.actionPrimary)
            .frame(width: 2)
            .accessibilityHidden(true)
    }

    private func itemRow(index: Int, text: String) -> some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s4) {
            Text(bulletString(for: index))
                .font(ZodiakTypography.bodyLarge)                   // body-l-300 18pt
                .foregroundColor(ZodiakColors.textPrimary)
                .frame(minWidth: variant == .ordered ? 24 : 14, alignment: .leading)
                .accessibilityHidden(true)
            Text(LocalizedStringKey(text))
                .font(ZodiakTypography.bodyLarge)                   // body-l-300 18pt
                .foregroundColor(ZodiakColors.textPrimary)
                .frame(maxWidth: .infinity, alignment: contentAlignment)
                .accessibilityLabel(
                    variant == .ordered
                    ? Text(verbatim: "\(index + 1). \(text)")
                    : Text(verbatim: text)
                )
        }
    }

    // MARK: - Private Helpers

    private var hAlignment: HorizontalAlignment {
        alignment == .center ? .center : .leading
    }

    private var contentAlignment: Alignment {
        alignment == .center ? .center : .leading
    }

    private func bulletString(for index: Int) -> String {
        switch variant {
        case .unordered: return "•"
        case .ordered:   return "\(index + 1)."
        }
    }
}

// MARK: - Previews

#Preview("ZodiakList") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakList(
                items: [
                    "Tornar o conteúdo claro e escaneável",
                    "Destacar pontos-chave",
                    "Quebrar conteúdo denso"
                ],
                headline: "Headline for list",
                variant: .unordered
            )
            ZodiakList(
                items: [
                    "Primeiro passo a seguir",
                    "Segundo passo com mais detalhes",
                    "Passo final para concluir"
                ],
                headline: "Headline for list",
                variant: .ordered
            )
            ZodiakList(
                items: [
                    "Item centralizado um",
                    "Item centralizado dois",
                    "Item centralizado três"
                ],
                headline: "catalog.spec.centered",
                variant: .unordered,
                alignment: .center
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
