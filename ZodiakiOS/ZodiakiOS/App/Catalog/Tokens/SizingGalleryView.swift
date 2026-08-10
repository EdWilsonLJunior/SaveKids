import SwiftUI

// MARK: - Sizing Gallery

struct SizingGalleryView: View {
    private let sizeTokens: [(name: String, label: String, value: CGFloat)] = [
        ("twoXSmall", "2XS", ZodiakSizing.twoXSmall),
        ("xs", "XS", ZodiakSizing.xs),
        ("s", "S", ZodiakSizing.s),
        ("m", "M", ZodiakSizing.m),
        ("l", "L", ZodiakSizing.l),
        ("xl", "XL", ZodiakSizing.xl),
        ("twoXLarge", "2XL", ZodiakSizing.twoXLarge),
        ("threeXLarge", "3XL", ZodiakSizing.threeXLarge),
        ("fourXLarge", "4XL", ZodiakSizing.fourXLarge),
        ("fiveXLarge", "5XL", ZodiakSizing.fiveXLarge),
        ("sixXLarge", "6XL", ZodiakSizing.sixXLarge),
        ("sevenXLarge", "7XL", ZodiakSizing.sevenXLarge),
        ("eightXLarge", "8XL", ZodiakSizing.eightXLarge)
    ]

    private let componentHeights: [(label: String, height: CGFloat, alias: String)] = [
        ("buttonHeightSmall", ZodiakSizing.buttonHeightSmall, "38pt"),
        ("buttonHeightMedium", ZodiakSizing.buttonHeightMedium, "48pt"),
        ("buttonHeightLarge", ZodiakSizing.buttonHeightLarge, "56pt"),
        ("textFieldHeight", ZodiakSizing.textFieldHeight, "48pt")
    ]

    private let iconSizes: [(label: String, size: CGFloat)] = [
        ("XS", ZodiakSizing.Icon.xs),
        ("S", ZodiakSizing.Icon.s),
        ("M", ZodiakSizing.Icon.m),
        ("L", ZodiakSizing.Icon.l),
        ("XL", ZodiakSizing.Icon.xl)
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.sizing.title",
                subtitle: "catalog.sizing.subtitle",
                figmaRef: "FOUNDATIONS · SIZING"
            )

            // MARK: Tokens Primitivos
            gallerySectionCard(title: "catalog.section.tokens_primitivos") {
                Text("catalog.sizing.desc_primitives")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                VStack(spacing: ZodiakSpacing.s4) {
                    ForEach(sizeTokens, id: \.name) { token in
                        HStack(spacing: ZodiakSpacing.s8) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(verbatim: token.label)
                                    .font(ZodiakTypography.bodySmall)
                                    .foregroundColor(ZodiakColors.textPrimary)
                                Text(verbatim: ".\(token.name)")
                                    .font(ZodiakTypography.captionLarge.monospacedDigit())
                                    .foregroundColor(ZodiakColors.textSecondary)
                            }
                            .frame(width: 100, alignment: .leading)
                            ZodiakColors.actionPrimary
                                .opacity(0.8)
                                .frame(width: token.value, height: 14)
                                .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.xs))
                            Text(verbatim: "\(Int(token.value))pt")
                                .font(ZodiakTypography.captionLarge.monospacedDigit())
                                .foregroundColor(ZodiakColors.textSecondary)
                            Spacer()
                        }
                        .padding(.horizontal, ZodiakSpacing.s8)
                        .padding(.vertical, ZodiakSpacing.s4)
                        .background(ZodiakColors.background)
                        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.xs))
                    }
                }

                ZodiakInfoRow(
                    "catalog.spec.lbl.base",
                    value: "catalog.spec.val.sizing_base_8pt",
                    style: .spec()
                )
            }

            // MARK: Alturas de Componente
            gallerySectionCard(title: "catalog.section.alturas_de_componente") {
                Text("catalog.sizing.desc_heights")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                VStack(spacing: ZodiakSpacing.s4) {
                    ForEach(componentHeights, id: \.label) { item in
                        HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
                            // Barra visual com altura exata
                            RoundedRectangle(cornerRadius: ZodiakRadii.l)
                                .fill(ZodiakColors.actionPrimary.opacity(0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: ZodiakRadii.l)
                                        .stroke(ZodiakColors.actionPrimary.opacity(0.4), lineWidth: 1)
                                )
                                .frame(width: 120, height: item.height)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.label)
                                    .font(ZodiakTypography.bodySmall)
                                    .foregroundColor(ZodiakColors.textPrimary)
                                Text(item.alias)
                                    .font(ZodiakTypography.captionLarge.monospaced())
                                    .foregroundColor(ZodiakColors.textSecondary)
                            }

                            Spacer()
                        }

                        if item.label != componentHeights.last?.label {
                            Divider()
                        }
                    }
                }

                ZodiakInfoRow(
                    "catalog.spec.lbl.base",
                    value: "catalog.spec.val.sizing_base_8pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.hig",
                    value: "catalog.spec.val.touch_44pt_hig",
                    style: .spec()
                )
            }

            // MARK: Dimensões de Ícone
            gallerySectionCard(title: "catalog.section.dimensoes_de_icone") {
                Text("catalog.sizing.desc_icons")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                HStack(alignment: .bottom, spacing: ZodiakSpacing.s16) {
                    ForEach(iconSizes, id: \.label) { item in
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZStack {
                                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                    .fill(ZodiakColors.surface)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                            .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
                                    )
                                    .frame(width: item.size + 16, height: item.size + 16)

                                Image(systemName: "sparkles")
                                    .font(.system(size: item.size * 0.65))
                                    .foregroundColor(ZodiakColors.actionPrimary)
                            }

                            Text(item.label)
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)

                            Text("\(Int(item.size))pt")
                                .font(ZodiakTypography.captionLarge.monospaced())
                                .foregroundColor(ZodiakColors.textPrimary)
                        }
                    }
                }
                .frame(maxWidth: .infinity)

                ZodiakInfoRow(
                    "catalog.spec.lbl.tamanhos",
                    value: "catalog.spec.val.icon_5_tamanhos_16_40pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.formato",
                    value: "catalog.spec.val.icon_outlined_svg",
                    style: .spec()
                )
            }

            // MARK: Touch Areas
            gallerySectionCard(title: "catalog.section.touch_areas") {
                Text("catalog.sizing.desc_touch_areas")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                HStack(spacing: ZodiakSpacing.s24) {
                    // Ícone 24pt com touch area 44pt
                    VStack(spacing: ZodiakSpacing.s4) {
                        ZStack {
                            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                .foregroundColor(ZodiakColors.actionWarning.opacity(0.5))
                                .frame(width: 44, height: 44)

                            Image(systemName: "xmark")
                                .font(.system(size: 16))
                                .foregroundColor(ZodiakColors.actionPrimary)
                                .frame(width: 24, height: 24)
                                .background(ZodiakColors.surface)
                                .cornerRadius(ZodiakRadii.xs)
                        }
                        Text("catalog.sizing.label.icon_24pt")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        Text("catalog.sizing.label.touch_44pt")
                            .font(ZodiakTypography.captionLarge.bold())
                            .foregroundColor(ZodiakColors.actionWarning)
                    }
                    .frame(maxWidth: .infinity)

                    // Botão 48pt nativo
                    VStack(spacing: ZodiakSpacing.s4) {
                        ZodiakButtonPrimary(title: "catalog.spec.label_action", action: {})
                            .frame(maxWidth: 120)
                        Text("catalog.sizing.label.height_48pt")
                            .font(ZodiakTypography.captionLarge.bold())
                            .foregroundColor(ZodiakColors.textPositive)
                    }
                    .frame(maxWidth: .infinity)
                }

                ZodiakInfoRow(
                    "catalog.spec.lbl.icone_touch",
                    value: "catalog.spec.val.sizing_icone_touch_44pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.modifier",
                    value: "catalog.spec.val.touch_expandedTouchTarget",
                    style: .spec()
                )
            }

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.base",
                    value: "catalog.spec.val.sizing_base_8pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.button_small",
                    value: "catalog.spec.val.sizing_button_small_38pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.button_medium",
                    value: "catalog.spec.val.sizing_button_medium_48pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.button_large",
                    value: "catalog.spec.val.sizing_button_large_56pt",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.textfield",
                    value: "catalog.spec.val.sizing_textfield_48pt",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.sizing.title")
    }
}

// MARK: - Preview

#Preview("Sizing — Light") {
    NavigationStack { SizingGalleryView() }
}

#Preview("Sizing — Dark") {
    NavigationStack { SizingGalleryView() }
        .preferredColorScheme(.dark)
}
