import SwiftUI

// MARK: - Zodiak Key Figures
// Figma: "Key figures"
// Grade responsiva para métricas e números de destaque.

struct ZodiakKeyFigureItem: Identifiable {
    let id = UUID()
    let value: String
    let label: String
    var detail: String?
}

struct ZodiakKeyFigureCard: View {
    let item: ZodiakKeyFigureItem
    var onHeavy: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(item.value)
                .font(ZodiakTypography.titleLarge)
                .foregroundColor(onHeavy ? ZodiakColors.textInverse : ZodiakColors.actionPrimary)

            Text(LocalizedStringKey(item.label))
                .font(ZodiakTypography.bodySmall.bold())
                .foregroundColor(onHeavy ? ZodiakColors.textInverse : ZodiakColors.textPrimary)

            if let detail = item.detail {
                Text(LocalizedStringKey(detail))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(onHeavy ? ZodiakColors.textInverse.opacity(0.8) : ZodiakColors.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(ZodiakSpacing.s16)
        .background(onHeavy ? ZodiakColors.surfaceInk : ZodiakColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                .stroke(onHeavy ? ZodiakColors.borderPrimary.opacity(0.18) : ZodiakColors.borderSecondary, lineWidth: 1)
        )
    }
}

struct ZodiakKeyFigures: View {
    let items: [ZodiakKeyFigureItem]
    var columns: Int = 2
    var onHeavy: Bool = false

    private var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: ZodiakSpacing.s8), count: max(columns, 1))
    }

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: ZodiakSpacing.s8) {
            ForEach(items) { item in
                ZodiakKeyFigureCard(item: item, onHeavy: onHeavy)
            }
        }
    }
}

#Preview("Key Figures") {
    let items = [
        ZodiakKeyFigureItem(value: "92%", label: "Satisfação", detail: "entre usuários ativos"),
        ZodiakKeyFigureItem(value: "3.4x", label: "Velocidade", detail: "na montagem de UI"),
        ZodiakKeyFigureItem(value: "48", label: "catalog.home.tab_components", detail: "reutilizados em produção"),
        ZodiakKeyFigureItem(value: "11", label: "Squads", detail: "consumindo o sistema")
    ]

    return ScrollView {
        VStack(spacing: ZodiakSpacing.s32) {
            ZodiakKeyFigures(items: items)

            ZodiakKeyFigures(items: Array(items.prefix(2)), onHeavy: true)
                .padding(ZodiakSpacing.s16)
                .background(ZodiakColors.surfaceInk)
                .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
