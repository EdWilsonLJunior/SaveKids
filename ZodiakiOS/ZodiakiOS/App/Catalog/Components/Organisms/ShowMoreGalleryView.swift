import SwiftUI

// MARK: - Show More Gallery View
// Figma: "Show more" component

private struct DemoProject: Identifiable {
    let id = UUID()
    let name: String
    let client: String
    let status: String
}

struct ShowMoreGalleryView: View {
    @State private var initialCount = 3
    @State private var showAllVariants = false

    private let projects: [DemoProject] = [
        .init(name: "Portal Capgemini", client: "Capgemini BR", status: "shared.state.in_progress"),
        .init(name: "Zodiak Catalog iOS", client: "Interno", status: "shared.state.in_progress"),
        .init(name: "App de Relatórios", client: "Total Energies", status: "shared.state.completed"),
        .init(name: "Dashboard Analytics", client: "Capgemini FR", status: "shared.state.completed"),
        .init(name: "Integração SAP", client: "Michelin", status: "shared.state.review"),
        .init(name: "Portal RH Digital", client: "Airbus", status: "catalog.showmore.status.planning"),
        .init(name: "Sistema de Billing", client: "Orange", status: "shared.state.in_progress"),
        .init(name: "App Mobile Clientes", client: "BNP Paribas", status: "shared.state.completed"),
        .init(name: "Redesign Intranet", client: "Capgemini ES", status: "catalog.showmore.status.paused")
    ]

    // swiftlint:disable:next line_length
    private let teamMembers = ["Ana Souza", "Bruno Lima", "Carla Neves", "Diego Martins", "Elena Silva", "Fábio Costa", "Gabriela Rocha", "Henrique Dias"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.show_more",
                subtitle: "catalog.show_more.subtitle",
                figmaRef: "Show more"
            )

            // MARK: Lista de projetos
            gallerySectionCard(title: LocalizedStringKey(String(
                format: String(localized: "shared.format.project_list"),
                projects.count, initialCount))) {
                    Stepper(
                        String(format: String(localized: "shared.format.initial_count"), initialCount),
                        value: $initialCount,
                        in: 1...(projects.count - 1)
                    )
                        .font(ZodiakTypography.bodySmall)
                        .tint(ZodiakColors.actionPrimary)

                    ZodiakShowMore(items: projects, initialCount: initialCount) { project in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(project.name)
                                    .font(ZodiakTypography.bodySmall)
                                    .foregroundColor(ZodiakColors.textPrimary)
                                Text(project.client)
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(ZodiakColors.textSecondary)
                            }
                            Spacer()
                            ZodiakChip(verbatim: project.status, isActive: project.status == "shared.state.in_progress")
                        }
                        .padding(.vertical, ZodiakSpacing.s8)
                        .padding(.horizontal, ZodiakSpacing.s8)
                        ZodiakDivider(hierarchy: .secondary).padding(.leading, ZodiakSpacing.s8)
                    }
            }

            // MARK: Lista simples (strings)
            gallerySectionCard(title: LocalizedStringKey(String(
                format: String(localized: "shared.format.team_members"),
                teamMembers.count))) {
                    ZodiakShowMore(
                        items: teamMembers.map { NameItem(name: $0) },
                        initialCount: 3,
                        showLabel: "shared.action.view_full_team",
                        hideLabel: "shared.action.collapse"
                    ) { item in
                        HStack(spacing: ZodiakSpacing.s8) {
                            Circle()
                                .fill(ZodiakColors.actionPrimary.opacity(0.15))
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Text(String(item.name.prefix(1)))
                                        .font(ZodiakTypography.bodySmall)
                                        .foregroundColor(ZodiakColors.actionPrimary)
                                )
                            Text(item.name)
                                .font(ZodiakTypography.bodyMedium)
                                .foregroundColor(ZodiakColors.textPrimary)
                            Spacer()
                        }
                        .padding(.vertical, ZodiakSpacing.s4)
                        .padding(.horizontal, ZodiakSpacing.s8)
                        ZodiakDivider(hierarchy: .secondary).padding(.leading, 48)
                    }
            }

            // MARK: Background variants
            gallerySectionCard(title: "catalog.section.variantes") {
                    Text("catalog.show_more.variants_desc")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    VStack(spacing: ZodiakSpacing.s8) {
                        // onLite (default)
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                            Text(LocalizedStringKey("catalog.showmore.spec.onlite"))
                                .font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
                            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                .fill(ZodiakColors.surface)
                                .overlay(
                                    ZodiakShowMore(items: (1...5).map { SimpleItem(n: $0) }, initialCount: 2) { item in
                                        Text("Item \(item.n)").font(ZodiakTypography.captionLarge)
                                            .padding(.horizontal, ZodiakSpacing.s8)
                                            .padding(.vertical, ZodiakSpacing.s4)
                                    }
                                    .padding(.vertical, ZodiakSpacing.s4)
                                )
                        }

                        // onHeavy
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                            Text(LocalizedStringKey("catalog.showmore.spec.onheavy"))
                                .font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
                            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                .fill(ZodiakColors.surfaceInk)
                                .overlay(
                                    ZodiakShowMore(
                                        items: (1...5).map { SimpleItem(n: $0) },
                                        initialCount: 2,
                                        bgVariant: .onHeavy
                                    ) { item in
                                        Text("Item \(item.n)").font(ZodiakTypography.captionLarge)
                                            .foregroundColor(ZodiakColors.textInverse)
                                            .padding(.horizontal, ZodiakSpacing.s8)
                                            .padding(.vertical, ZodiakSpacing.s4)
                                    }
                                    .padding(.vertical, ZodiakSpacing.s4)
                                )
                        }
                    }
            }

            // MARK: Hierarchy
            gallerySectionCard(title: "catalog.section.hierarquia") {
                    Text("catalog.show_more.hierarchy_desc")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        Text(LocalizedStringKey("catalog.showmore.spec.secondary_btn"))
                            .font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
                        ZodiakShowMore(
                            items: (1...5).map { SimpleItem(n: $0) },
                            initialCount: 2,
                            hierarchy: .secondary
                        ) { item in
                            Text("Item \(item.n)").font(ZodiakTypography.captionLarge)
                                .padding(.horizontal, ZodiakSpacing.s8)
                                .padding(.vertical, ZodiakSpacing.s4)
                        }

                        Text(LocalizedStringKey("catalog.showmore.spec.tertiary_btn"))
                            .font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
                        ZodiakShowMore(
                            items: (1...5).map { SimpleItem(n: $0) },
                            initialCount: 2,
                            hierarchy: .tertiary
                        ) { item in
                            Text("Item \(item.n)").font(ZodiakTypography.captionLarge)
                                .padding(.horizontal, ZodiakSpacing.s8)
                                .padding(.vertical, ZodiakSpacing.s4)
                        }
                    }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.generic",
                        value: "catalog.spec.val.zodiakshowmoreitem_identifiable_row_view",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.initialcount",
                        value: "catalog.spec.val.numero_de_itens_visiveis_inicialmente",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.showlabel",
                        value: "catalog.spec.val.texto_do_botao_de_expansao",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.springresponse_035_damping_085",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.contador",
                        value: "catalog.spec.val.mostra_itens_ocultos_mostrar_mais_6",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.bgvariant",
                        value: "onLite · onHeavy · onPhoto",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.hierarquia",
                        value: "secondary (16pt) · tertiary (14pt — default)",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.anatomia",
                        value: "catalog.showmore.spec.anatomy_value",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.show_more")
    }
}

private struct NameItem: Identifiable {
    let id = UUID()
    let name: String
}

private struct SimpleItem: Identifiable {
    let id = UUID()
    let n: Int
}

#Preview { NavigationStack { ShowMoreGalleryView() } }
