import SwiftUI

struct TooltipGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.tooltip",
                subtitle: "catalog.tooltip.subtitle",
                figmaRef: "catalog.component_name.tooltip"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground_pressione_e_segure") {
                    Text("catalog.tooltip.desc_0")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)

                    HStack(spacing: ZodiakSpacing.s32) {
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakTooltip("Acima", placement: .top) {
                                iconTarget("arrow.up")
                            }
                            Text("catalog.tooltip.desc_1")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }

                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakTooltip("Abaixo", placement: .bottom) {
                                iconTarget("arrow.down")
                            }
                            Text("catalog.tooltip.desc_2")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }

                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakTooltip("catalog.tooltip.demo.trailing", placement: .trailing) {
                                iconTarget("arrow.right")
                            }
                            Text("catalog.tooltip.desc_3")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, ZodiakSpacing.s8)
            }

            // MARK: Via modifier
            gallerySectionCard(title: "catalog.section.via_zodiaktooltip_modifier") {
                    HStack(spacing: ZodiakSpacing.s8) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 20))
                            .foregroundColor(ZodiakColors.actionPrimary)
                            .zodiakTooltip("catalog.tooltip.demo.info")

                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 20))
                            .foregroundColor(ZodiakColors.textSecondary)
                            .zodiakTooltip("Clique para saber mais", placement: .bottom)
                    }
                    .padding(.vertical, ZodiakSpacing.s4)
            }

            // MARK: Casos de uso
            gallerySectionCard(title: "catalog.section.casos_de_uso") {
                    usageRow("catalog.tooltip.usage.icons", "catalog.tooltip.usage.icons_desc", "hand.tap")

                    usageRow(
                        "catalog.tooltip.usage.form_fields",
                        "catalog.tooltip.usage.form_fields_desc",
                        "rectangle.and.pencil.and.ellipsis"
                    )

                    usageRow("Truncated text", "Mostrar texto completo que foi truncado na UI", "text.alignleft")
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.fundo",
                        value: "catalog.spec.val.surfaceink_shadow_radius_6",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.radius",
                        value: "catalog.spec.val.zodiakradiixs_4pt",
                        style: .spec()
                    )

                    ZodiakInfoRow("catalog.spec.lbl.ativacao", value: "catalog.spec.val.longpress_03s", style: .spec())

                    ZodiakInfoRow("catalog.spec.lbl.auto_dismiss", value: "catalog.spec.val.25s", style: .spec())

                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.opacity_scale09",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.tooltip")
    }

    private func iconTarget(_ icon: String) -> some View {
        Image(systemName: icon)
            .font(.system(size: 14))
            .foregroundColor(ZodiakColors.actionPrimary)
            .frame(width: 36, height: 36)
            .background(ZodiakColors.surfaceSmoke)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.xs, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs, style: .continuous)
                    .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
            )
    }

    private func usageRow(_ title: String, _ desc: String, _ icon: String) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Image(systemName: icon).font(.system(size: 14)).foregroundColor(ZodiakColors.actionPrimary).frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizedStringKey(title))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(LocalizedStringKey(desc))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }
}

#Preview { NavigationStack { TooltipGalleryView() } }
