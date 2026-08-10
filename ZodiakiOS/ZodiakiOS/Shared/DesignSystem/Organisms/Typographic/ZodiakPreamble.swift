import SwiftUI

// MARK: - Zodiak Preamble
// Figma: "Preamble"
// Bloco introdutório para abrir páginas, artigos e seções editoriais.

struct ZodiakPreamble: View {
    let eyebrow: String?
    let title: String
    let summary: String
    var background: Color = .clear
    var onHeavy: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            if let eyebrow {
                ZodiakEyebrow(
                    text: eyebrow,
                    size: .medium,
                    background: onHeavy ? .onHeavy : .onLite
                )
            }

            Text(LocalizedStringKey(title))
                .font(ZodiakTypography.titleLarge)
                .foregroundColor(onHeavy ? ZodiakColors.textInverse : ZodiakColors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Text(LocalizedStringKey(summary))
                .font(ZodiakTypography.bodyLarge)
                .foregroundColor(onHeavy ? ZodiakColors.textInverse.opacity(0.88) : ZodiakColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(background == .clear ? 0 : ZodiakSpacing.s16)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
    }
}

#Preview("Preamble") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakPreamble(
                eyebrow: "Insights",
                title: "Leading with experience and measurable outcomes.",
                // swiftlint:disable:next line_length
                summary: "Use esse bloco para introduzir um artigo, uma página institucional ou um módulo editorial maior."
            )

            ZodiakPreamble(
                eyebrow: "Featured",
                title: "A strong headline on dark surfaces.",
                summary: "O preamble em fundo escuro mantém a mesma hierarquia, mudando apenas o contraste semântico.",
                background: ZodiakColors.surfaceInk,
                onHeavy: true
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
