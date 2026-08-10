import SwiftUI

// MARK: - Filter Button Gallery View
// Figma: "Button filter" + "Filter inputs"

struct FilterButtonGalleryView: View {
    @State private var activeFilters: Set<String> = []
    @State private var showFilterSheet = false

    // swiftlint:disable:next line_length
    private let filterOptions = ["Urgente", "Alta prioridade", "shared.state.in_progress", "shared.state.completed", "Minha equipe", "Vence hoje"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.filter_button",
                subtitle: "catalog.filter_button.subtitle",
                figmaRef: "Button filter, Filter inputs"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground") {
                    HStack {
                        ZodiakFilterButton(
                            action: { showFilterSheet = true },
                            activeFilterCount: activeFilters.count
                        )
                        Spacer()
                        if !activeFilters.isEmpty {
                            Button("shared.action.clear") { activeFilters.removeAll() }
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textNegative)
                        }
                    }

                    // Active filter chips
                    if !activeFilters.isEmpty {
                        ZodiakFlowLayout(spacing: ZodiakSpacing.s4) {
                            ForEach(Array(activeFilters), id: \.self) { filter in
                                HStack(spacing: ZodiakSpacing.s4) {
                                    Text(filter)
                                        .font(ZodiakTypography.captionLarge)
                                        .foregroundColor(ZodiakColors.textInverse)
                                    Button {
                                        activeFilters.remove(filter)
                                    } label: {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 9, weight: .bold))
                                            .foregroundColor(ZodiakColors.textInverse.opacity(0.7))
                                    }
                                }
                                .padding(.horizontal, ZodiakSpacing.s8)
                                .padding(.vertical, ZodiakSpacing.s4)
                                .background(ZodiakColors.actionPrimary)
                                .cornerRadius(ZodiakRadii.l)
                            }
                        }
                    } else {
                        Text("catalog.filterbutton.desc_0")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textDisabled)
                    }
            }

            // MARK: Estados
            gallerySectionCard(title: "catalog.section.estados") {
                    HStack(spacing: ZodiakSpacing.s8) {
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakFilterButton(action: {})
                            Text("catalog.filterbutton.desc_1")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakFilterButton(action: {}, activeFilterCount: 2)
                            Text("catalog.filterbutton.desc_2")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakFilterButton(action: {}, activeFilterCount: 9)
                            Text("catalog.filterbutton.desc_3")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakFilterButton(action: {}, isEnabled: false)
                            Text("catalog.spec.label_disabled")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }
            }

            // MARK: Contexto de uso
            gallerySectionCard(title: "catalog.section.quando_usar") {
                    usageRow("Listagens longas", "Produtos, projetos, pessoas", "list.bullet")

                    usageRow("Resultados de busca", "Refinar resultados sem nova busca", "magnifyingglass")

                    usageRow("Dashboards", "catalog.filterbtn.usage.dashboard_desc", "chart.bar")
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.altura",
                        value: "catalog.spec.val.38pt_buttonheightsmall",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.forma",
                        value: "catalog.spec.val.pill_radius_l_999pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.badge",
                        value: "catalog.spec.val.circulo_actionwarningsecondary_com_conta",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.estado_ativo",
                        value: "catalog.spec.val.fundo_actionprimary_textinverse",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.estado_padrao",
                        value: "catalog.spec.val.borda_actionprimary_texto_actionprimary",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component.filter_button")
        .sheet(isPresented: $showFilterSheet) {
            NavigationStack {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    Text("catalog.filterbutton.desc_4")
                        .font(ZodiakTypography.titleSmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .padding(.horizontal, ZodiakSpacing.s16)

                    ZodiakChipGroup(
                        options: filterOptions,
                        selectedOptions: $activeFilters,
                        label: "Status e prioridade"
                    )
                    .padding(.horizontal, ZodiakSpacing.s16)

                    Spacer()

                    VStack(spacing: ZodiakSpacing.s8) {
                        // Reason: filter-count interpolation inside LocalizedStringKey cannot be split
                        // swiftlint:disable:next line_length
                        let applyTitle: LocalizedStringKey = "catalog.spec.apply_label \(!activeFilters.isEmpty ? "(\(activeFilters.count))" : "")"
                        ZodiakButtonPrimary(
                            title: applyTitle,
                            action: { showFilterSheet = false }
                        )
                        ZodiakButtonTertiary(title: "shared.action.clear_all", action: { activeFilters.removeAll() })
                    }
                    .padding(ZodiakSpacing.s16)
                }
                .padding(.top, ZodiakSpacing.s16)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("shared.action.cancel") { showFilterSheet = false }
                            .foregroundColor(ZodiakColors.actionPrimary)
                    }
                }
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
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

#Preview { NavigationStack { FilterButtonGalleryView() } }
