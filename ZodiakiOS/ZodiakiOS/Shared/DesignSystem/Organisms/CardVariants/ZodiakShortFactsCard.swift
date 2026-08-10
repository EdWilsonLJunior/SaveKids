import SwiftUI

// MARK: - Zodiak Short Facts Card
// Figma: Organisms > Card grid — Short Facts
// Compact card showing a key stat/fact with icon + value + label.

struct ZodiakShortFactItem: Identifiable {
    let id: UUID
    let icon: String
    let value: String
    let label: String
    let color: Color

    init(
        id: UUID = UUID(),
        icon: String,
        value: String,
        label: String,
        color: Color = ZodiakColors.actionPrimary
    ) {
        self.id = id
        self.icon = icon
        self.value = value
        self.label = label
        self.color = color
    }
}

struct ZodiakShortFactsCard: View {
    let items: [ZodiakShortFactItem]
    var columns: Int = 2

    private var cols: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: ZodiakSpacing.s4), count: columns)
    }

    var body: some View {
        LazyVGrid(columns: cols, spacing: ZodiakSpacing.s4) {
            ForEach(items) { item in
                HStack(spacing: ZodiakSpacing.s4) {
                    ZStack {
                        RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                            .fill(item.color.opacity(0.12))
                            .frame(width: 36, height: 36)
                        Image(systemName: item.icon)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(item.color)
                    }
                    VStack(alignment: .leading, spacing: 1) {
                        Text(item.value)
                            .font(ZodiakTypography.labelMedium)
                            .foregroundColor(ZodiakColors.textPrimary)
                        Text(LocalizedStringKey(item.label))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .lineLimit(1)
                    }
                }
                .padding(ZodiakSpacing.s4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.s)
                // swiftlint:disable:next line_length
                .overlay(RoundedRectangle(cornerRadius: ZodiakRadii.s).stroke(ZodiakColors.borderSecondary, lineWidth: 1))
            }
        }
    }
}

// MARK: - Preview

#Preview("Short Facts") {
    ZodiakShortFactsCard(
        items: [
            .init(icon: "person.3", value: "3 200", label: "Consultores"),
            .init(icon: "globe.europe.africa", value: "18", label: "Países", color: ZodiakColors.surfacePositive),
            .init(icon: "building.2", value: "42", label: "Escritórios", color: ZodiakColors.brand),
            .init(icon: "star", value: "94%", label: "Satisfação", color: ZodiakColors.surfaceAzur)
        ]
    )
    .padding()
}
