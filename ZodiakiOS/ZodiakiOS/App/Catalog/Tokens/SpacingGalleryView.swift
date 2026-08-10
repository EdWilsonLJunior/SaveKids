import SwiftUI

// MARK: - Spacing Gallery View

struct SpacingGalleryView: View {
    @State private var selectedTab = 0

    private let tabLabels = [
        "catalog.spacing.tab.tokens",
        "catalog.spacing.tab.chart",
        "catalog.spacing.tab.aliases"
    ]

    // Fonte única de verdade: ZodiakSpacing.allTokens
    // (name = Swift property · label = Supernova canonical · value = CGFloat)

    private let allAliases: [(name: String, value: CGFloat, description: String)] = [
        ("componentMin", ZodiakSpacing.componentMin, "catalog.spacing.alias_min_padding"),
        ("componentPad", ZodiakSpacing.componentPad, "catalog.spacing.alias_field_padding"),
        ("buttonGap", ZodiakSpacing.buttonGap, "catalog.spacing.alias_button_gap"),
        ("screenPad", ZodiakSpacing.screenPad, "catalog.spacing.alias_screen_padding"),
        ("screenPadLarge", ZodiakSpacing.screenPadLarge, "catalog.spacing.alias_ipad_padding"),
        ("sectionGap", ZodiakSpacing.sectionGap, "catalog.spacing.alias_section_gap"),
        ("itemGap", ZodiakSpacing.itemGap, "catalog.spacing.alias_item_gap"),
        ("formFieldGap", ZodiakSpacing.formFieldGap, "catalog.spacing.alias_form_field_gap"),
        ("inlineGap", ZodiakSpacing.inlineGap, "catalog.spacing.alias_inline_gap")
    ]

    // Maior valor da escala — denominador das proporções
    private let maxSpacingValue: CGFloat = ZodiakSpacing.s176
    // Altura máxima das barras verticais no chart (Tab 1)
    private let maxChartHeight: CGFloat = 80

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.spacing",
                subtitle: "catalog.spacing.token_count_desc",
                figmaRef: "Spacing"
            )
            ZodiakTabs(tabs: tabLabels, selectedIndex: $selectedTab)
            if selectedTab == 0 {
                gallerySectionCard(title: "catalog.spacing.horizontal_scale") {
                    ZodiakText("catalog.spacing.horizontal_desc", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                    VStack(spacing: ZodiakSpacing.s4) {
                        ForEach(ZodiakSpacing.allTokens, id: \.name) { token in
                            spacingRow(token: token)
                        }
                    }
                }
            } else if selectedTab == 1 {
                gallerySectionCard(title: "catalog.spacing.vertical_scale") {
                    ZodiakText("catalog.spacing.vertical_desc", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                    // 7 colunas × 2 linhas = 14 tokens — sem scroll horizontal
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: ZodiakSpacing.s4), count: 7),
                        spacing: ZodiakSpacing.s8
                    ) {
                        ForEach(ZodiakSpacing.allTokens, id: \.name) { token in
                            verticalBar(label: token.label, value: token.value)
                        }
                    }
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surface)
                    .cornerRadius(ZodiakRadii.xs)
                }
            } else {
                gallerySectionCard(title: "catalog.spacing.semantic_aliases") {
                    // Callout — todos os aliases são experimentais, nenhum é oficial no Zodiak DS
                    HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                        Image(systemName: "flask.fill")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.actionPrimary)
                            .frame(width: 18, alignment: .center)
                        Text(LocalizedStringKey("catalog.spacing.experimental_callout"))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(ZodiakSpacing.s8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ZodiakColors.actionPrimary.opacity(0.07))
                    .cornerRadius(ZodiakRadii.xs)
                    VStack(spacing: ZodiakSpacing.s4) {
                        ForEach(allAliases, id: \.name) { alias in
                            aliasRow(alias: alias)
                        }
                    }
                }
            }
        }
        .zodiakPage(title: "catalog.component.spacing")
    }

    // MARK: - Token Row (Tab 0)

    // token: allTokens element — name = Swift prop, label = Supernova tier
    private func spacingRow(token: (name: String, label: String, value: CGFloat)) -> some View {
        HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
            // Nome canônico Supernova (ex: "3XS") — destaque como pill
            Text(verbatim: token.label)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .frame(width: 28, alignment: .center)
                .padding(.horizontal, ZodiakSpacing.s4)
                .padding(.vertical, ZodiakSpacing.s4)
                .background(ZodiakColors.actionPrimary.opacity(0.1))
                .cornerRadius(ZodiakRadii.xs)
            // Propriedade Swift (ex: ".s4") — secundário
            Text(verbatim: ".\(token.name)")
                .font(ZodiakTypography.captionLarge.monospacedDigit())
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 48, alignment: .leading)
                .lineLimit(1)
            // Barra exata: largura = valor real em pontos (ex: .s40 → 40pt de cor)
            // A track cinza preenche todo o espaço disponível como escala de referência
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    ZodiakColors.borderPrimary.opacity(0.3)
                        .frame(width: geo.size.width, height: 8)
                    ZodiakColors.actionPrimary
                        .frame(width: max(min(token.value, geo.size.width), 2), height: 8)
                }
                .cornerRadius(ZodiakRadii.xs)
            }
            .frame(height: 8)
            // Valor em pt
            Text(verbatim: "\(Int(token.value))pt")
                .font(ZodiakTypography.captionLarge.monospacedDigit())
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 44, alignment: .trailing)
        }
        .padding(.vertical, ZodiakSpacing.s4)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.xs)
    }

    // MARK: - Vertical Bar (Tab 1) — célula do LazyVGrid 7 colunas

    private func verticalBar(label: String, value: CGFloat) -> some View {
        let scaledHeight = max((value / maxSpacingValue) * maxChartHeight, 2)
        return VStack(spacing: ZodiakSpacing.s4) {
            Spacer(minLength: 0)
            ZodiakColors.actionPrimary
                .frame(width: 12, height: scaledHeight)
                .cornerRadius(ZodiakRadii.xs)
            Text(verbatim: label)
                .font(ZodiakTypography.captionSmall)
                .foregroundColor(ZodiakColors.textSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: maxChartHeight + 20)
    }

    // MARK: - Alias Row (Tab 2)

    private func aliasRow(alias: (name: String, value: CGFloat, description: String)) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            HStack(spacing: ZodiakSpacing.s8) {
                Text(verbatim: ".\(alias.name)")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                Spacer()
                Text(verbatim: "\(Int(alias.value))pt")
                    .font(ZodiakTypography.captionLarge.monospacedDigit())
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .padding(.horizontal, ZodiakSpacing.s8)
                    .padding(.vertical, ZodiakSpacing.s4)
                    .background(ZodiakColors.actionPrimary.opacity(0.1))
                    .cornerRadius(ZodiakRadii.xs)
            }
            Text(LocalizedStringKey(alias.description))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
            // Barra proporcional (escala relativa ao maior token da escala)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    ZodiakColors.borderPrimary.opacity(0.3)
                        .frame(width: geo.size.width, height: 6)
                    ZodiakColors.actionPrimary
                        .frame(width: max((alias.value / maxSpacingValue) * geo.size.width, 2), height: 6)
                }
                .cornerRadius(ZodiakRadii.xs)
            }
            .frame(height: 6)
        }
        .padding(ZodiakSpacing.s8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.xs)
    }
}

#Preview {
    NavigationStack {
        SpacingGalleryView()
    }
}
