import SwiftUI

// MARK: - System Buttons Gallery View
// Figma: "Button system" + "Button system warning"
// Compact buttons for digital product / browser interfaces (not general websites)

struct SystemButtonsGalleryView: View {
    @State private var isEnabled = true

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.system_buttons",
                subtitle: "catalog.system_buttons.subtitle",
                figmaRef: "Button system, Button system warning"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground") {
                    HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakSystemButton(
                            title: "shared.action.save",
                            action: {},
                            icon: "square.and.arrow.down",
                            style: .filled,
                            isEnabled: isEnabled
                        )
                        ZodiakSystemButton(
                            title: "shared.action.cancel",
                            action: {},
                            style: .outlined,
                            isEnabled: isEnabled)
                        ZodiakSystemButton(
                            title: "Preview",
                            action: {},
                            icon: "eye",
                            style: .ghost,
                            isEnabled: isEnabled
                        )
                    }

                    ZodiakSystemWarningButton(
                        title: "catalog.sysbtn.demo.discard",
                        action: {},
                        isEnabled: isEnabled,
                        confirmationTitle: "Descartar?",
                        confirmationMessage: "catalog.sysbtn.confirm.unsaved"
                    )

                    Toggle("catalog.section.enabled", isOn: $isEnabled)
                        .tint(ZodiakColors.actionPrimary)
                        .font(ZodiakTypography.bodySmall)
            }

            // MARK: ZodiakSystemButton — 3 estilos
            gallerySectionCard(title: "catalog.section.system_button_3_estilos") {
                    styleRow("filled", "catalog.sysbtn.spec.filled_desc") {
                        ZodiakSystemButton(title: "Publicar", action: {}, icon: "arrow.up.circle", style: .filled)
                        ZodiakSystemButton(title: "Publicar", action: {}, style: .filled, isEnabled: false)
                    }

                    styleRow("outlined", "catalog.sysbtn.spec.outlined_desc") {
                        ZodiakSystemButton(title: "Exportar", action: {}, style: .outlined)
                        ZodiakSystemButton(title: "Exportar", action: {}, style: .outlined, isEnabled: false)
                    }

                    styleRow("ghost", "catalog.sysbtn.spec.ghost_desc") {
                        ZodiakSystemButton(
                            title: "shared.action.duplicate",
                            action: {},
                            icon: "doc.on.doc",
                            style: .ghost
                        )
                        ZodiakSystemButton(
                            title: "shared.action.duplicate",
                            action: {},
                            style: .ghost,
                            isEnabled: false
                        )
                    }
            }

            // MARK: Tamanhos
            gallerySectionCard(title: "catalog.section.tamanhos") {
                    styleRow("Small — 38pt (default)", "Layouts compactos") {
                        ZodiakSystemButton(title: "Salvar", action: {}, icon: "square.and.arrow.down",
                                          style: .filled, size: .small)
                        ZodiakSystemButton(title: "Cancelar", action: {}, style: .outlined, size: .small)
                    }

                    styleRow("Medium — 48pt", "catalog.spec.lbl.default_usage") {
                        ZodiakSystemButton(title: "Salvar", action: {}, icon: "square.and.arrow.down",
                                          style: .filled, size: .medium)
                        ZodiakSystemButton(title: "Cancelar", action: {}, style: .outlined, size: .medium)
                    }
            }

            // MARK: System Warning
            gallerySectionCard(title: "catalog.section.system_warning_button") {
                    Text("catalog.systembuttons.desc_0")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    // Primary variant
                    styleRow("Primary", "catalog.sysbtn.spec.warning_primary_desc") {
                        ZodiakSystemWarningButton(
                            title: "Excluir arquivo",
                            action: {},
                            confirmationTitle: "Excluir arquivo?",
                            confirmationMessage: "catalog.btn.confirm.irreversible"
                        )
                        ZodiakSystemWarningButton(title: "Excluir", action: {}, isEnabled: false)
                    }

                    // Secondary variant
                    styleRow("Secondary", "catalog.sysbtn.spec.warning_secondary_desc") {
                        ZodiakSystemWarningSecondaryButton(
                            title: "Revogar acesso",
                            action: {},
                            confirmationTitle: "Revogar acesso?",
                            confirmationMessage: nil
                        )
                        ZodiakSystemWarningSecondaryButton(title: "Revogar", action: {}, isEnabled: false)
                    }

                    // Tamanhos: Small (default) + Medium
                    styleRow("catalog.sysbtn.spec.sizes_note", "catalog.sysbtn.spec.sizes_value") {
                        ZodiakSystemWarningButton(title: "Small", action: {}, size: .small)
                        ZodiakSystemWarningButton(title: "Medium", action: {}, size: .medium)
                    }
            }

            // MARK: Quando usar
            gallerySectionCard(title: "catalog.section.quando_usar_vs_zodiakbutton") {
                    comparisonRow(
                        "ZodiakButton",
                        "Sites Capgemini, landing pages, marketing",
                        "hand.tap",
                        ZodiakColors.actionPrimary
                    )

                    comparisonRow(
                        "ZodiakSystemButton",
                        "Apps SaaS, portais internos, dashboards, browser UI",
                        "cpu",
                        ZodiakColors.actionActive
                    )
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.altura",
                        value: "Small 38pt (default) · Medium 48pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.radius",
                        value: "catalog.spec.val.xs_4pt_nao_e_pill",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.tipografia",
                        value: "catalog.spec.val.bodysmall_14pt_menor_que_button",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.largura",
                        value: "catalog.sysbtn.spec.sizes_value",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.warning_bg",
                        value: "catalog.spec.val.actionwarningsecondary_9e0029",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component.system_buttons")
    }

    @ViewBuilder private func styleRow<V: View>(
        _ name: String, _ desc: String, @ViewBuilder content: () -> V
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(LocalizedStringKey(name)).font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
            Text(LocalizedStringKey(desc))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
            HStack(spacing: ZodiakSpacing.s8) {
                content()
            }
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }

    private func comparisonRow(_ name: String, _ desc: String, _ icon: String, _ color: Color) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Image(systemName: icon).font(.system(size: 14)).foregroundColor(color).frame(width: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizedStringKey(name))
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

#Preview { NavigationStack { SystemButtonsGalleryView() } }
