import SwiftUI

// MARK: - Menu Button Gallery View
// Figma: "Button menu"

struct MenuButtonGalleryView: View {
    @State private var lastAction = ""

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.menu_button",
                subtitle: "catalog.menu_button.subtitle",
                figmaRef: "Button menu"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground") {
                    if !lastAction.isEmpty {
                        HStack(spacing: ZodiakSpacing.s4) {
                            Image(systemName: "checkmark.circle.fill").foregroundColor(ZodiakColors.surfacePositive)
                            Text(verbatim: "Ação selecionada: \"\(lastAction)\"")
                                .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)
                        }
                    }

                    ZodiakMenuButton(title: "catalog.menu.title.project_actions") {
                        Button { lastAction = "shared.action.edit" } label: {
                            Label("shared.action.edit", systemImage: "pencil")
                        }
                        Button { lastAction = "shared.action.duplicate" } label: {
                            Label("shared.action.duplicate", systemImage: "doc.on.doc")
                        }
                        Button { lastAction = "shared.action.archive" } label: {
                            Label("shared.action.archive", systemImage: "archivebox")
                        }

                        Button(role: .destructive) { lastAction = "shared.action.delete" } label: {
                            Label("shared.action.delete", systemImage: "trash")
                        }
                    }
            }

            // MARK: Variantes
            gallerySectionCard(title: "catalog.section.variantes") {
                    variantRow("Primary", "catalog.menu.spec.primary_desc") {
                        ZodiakMenuButton(title: "catalog.menu.label.actions", variant: .primary) {
                            Button("catalog.spec.format_pdf") {}
                            Button("catalog.spec.format_excel") {}
                        }
                        ZodiakMenuButton(title: "catalog.menu.label.actions", variant: .primary, isEnabled: false) {
                            EmptyView()
                        }
                    }

                    variantRow("Secondary", "catalog.menu.spec.secondary_desc") {
                        ZodiakMenuButton(title: "Exportar", variant: .secondary) {
                            Button("catalog.spec.format_pdf") {}
                            Button("catalog.spec.format_csv") {}
                        }
                        ZodiakMenuButton(title: "Exportar", variant: .secondary, isEnabled: false) {
                            EmptyView()
                        }
                    }

                    variantRow("Tertiary", "catalog.menu.spec.tertiary_desc") {
                        ZodiakMenuButton(title: "catalog.menu.label.more_options", variant: .tertiary) {
                            Button("catalog.spec.sort_name_asc") {}
                            Button("catalog.spec.sort_name_desc") {}
                        }
                        ZodiakMenuButton(
                            title: "catalog.menu.label.more_options",
                            variant: .tertiary,
                            isEnabled: false
                        ) {
                            EmptyView()
                        }
                    }
            }

            // MARK: Tamanhos
            gallerySectionCard(title: "catalog.section.tamanhos") {
                    variantRow("Small — 38pt", "catalog.menu.spec.small_desc") {
                        ZodiakMenuButton(title: "Ordenar", size: .small) {
                            Button("catalog.spec.sort_name_asc") {}
                            Button("catalog.spec.sort_name_desc") {}
                        }
                    }

                    variantRow("Medium — 48pt (default)", "catalog.spec.lbl.default_usage") {
                        ZodiakMenuButton(title: "Ordenar", size: .medium) {
                            Button("catalog.spec.sort_name_asc") {}
                            Button("catalog.spec.sort_name_desc") {}
                        }
                    }
            }

            // MARK: Com ícone
            gallerySectionCard(title: "catalog.section.variantes") {
                    // Com ícone
                    ZodiakMenuButton(title: "Exportar", icon: "square.and.arrow.up") {
                        Button("catalog.spec.format_pdf") {}
                        Button("catalog.spec.format_excel") {}
                        Button("catalog.spec.format_csv") {}
                    }

                    // Sem ícone
                    ZodiakMenuButton(title: "Ordenar por") {
                        Button("catalog.spec.sort_name_asc") {}
                        Button("catalog.spec.sort_name_desc") {}
                        Button("catalog.spec.label_creation_date") {}
                        Button("catalog.spec.label_last_update") {}
                    }

                    // Desabilitado
                    ZodiakMenuButton(title: "catalog.menu.label.unavailable", isEnabled: false) {
                        EmptyView()
                    }
            }

            // MARK: Comportamento
            gallerySectionCard(title: "catalog.section.comportamento") {
                    behaviorRow("Menu nativo iOS", "Usa SwiftUI Menu — adapta-se a iPhone e iPad automaticamente")

                    behaviorRow("catalog.menu.behavior.chevron", "catalog.menu.spec.chevron_desc")

                    behaviorRow("catalog.menu.label.optional_icon", "catalog.menu.spec.icon_desc")

                    behaviorRow("Role destructive", "Itens .destructive aparecem em vermelho automaticamente")
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.altura",
                        value: "catalog.spec.val.48pt_buttonheightmedium",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.forma",
                        value: "catalog.spec.val.pill_radius_l_999pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.fundo",
                        value: "Primary: filled actionPrimary · Secondary: outlined · Tertiary: ghost",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.trailing",
                        value: "catalog.spec.val.chevrondown_11pt_semibold",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.largura",
                        value: "catalog.menu.spec.max_width",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component.menu_button")
    }

    private func behaviorRow(_ title: String, _ detail: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(LocalizedStringKey(title)).font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
            Text(LocalizedStringKey(detail))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }

    @ViewBuilder
    private func variantRow<V: View>(
        _ name: String,
        _ desc: String,
        @ViewBuilder content: () -> V
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
    }
}

#Preview { NavigationStack { MenuButtonGalleryView() } }
