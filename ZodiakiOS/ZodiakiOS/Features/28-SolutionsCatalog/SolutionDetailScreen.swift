import SwiftUI

// MARK: - SolutionDetailScreen

struct SolutionDetailScreen: View {
    let solution: Solution
    @ObservedObject var viewModel: SolutionsCatalogViewModel
    @Environment(\.horizontalSizeClass) private var sizeClass

    private var relatedSolutions: [Solution] {
        viewModel.relatedSolutions(for: solution)
    }

    var body: some View {
        ZodiakActivityTemplate(title: solution.title) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
                // Section 1: Hero with embedded metrics
                ZodiakHero(
                    eyebrow: solution.category.rawValue,
                    title: solution.title,
                    summary: solution.description,
                    style: solution.category.heroStyle,
                    background: ZodiakGradients.brand,
                    metrics: solution.metrics.map { ZodiakHeroMetric(value: $0.value, label: $0.label) }
                )

                // Section 3: O que resolve?
                ZodiakTextBlock(
                    headingLarge: "feature.solutions_catalog.detail_what_solves",
                    bodyText: solution.whatItSolves
                )

                // Section 4: Resultado Esperado
                ZodiakTextBlock(
                    headingLarge: "feature.solutions_catalog.detail_expected_result",
                    bodyText: solution.expectedResult
                )

                // Section 5: Tecnologias (chips read-only)
                if !solution.integrations.isEmpty {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                        ZodiakDivider(hierarchy: .secondary, style: .thin)
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                            ZodiakText(
                                "feature.solutions_catalog.detail_integrations",
                                style: .title1
                            )
                            ZodiakFlowLayout(spacing: ZodiakSpacing.s4) {
                                ForEach(solution.integrations, id: \.self) { tech in
                                    ZodiakChip(verbatim: tech, isActive: false)
                                }
                            }
                        }
                    }
                }

                // Section 6: Pré-requisitos
                if !solution.prerequisites.isEmpty {
                    ZodiakList(
                        items: solution.prerequisites,
                        headline: "feature.solutions_catalog.detail_prerequisites",
                        variant: .unordered
                    )
                }

                // Section 7: Casos de Uso
                if !solution.useCases.isEmpty {
                    ZodiakList(
                        items: solution.useCases,
                        headline: "feature.solutions_catalog.detail_use_cases",
                        variant: .unordered
                    )
                }

                // Section 8: Como Começar?
                if !solution.steps.isEmpty {
                    ZodiakList(
                        items: solution.steps,
                        headline: "feature.solutions_catalog.detail_getting_started",
                        variant: .ordered
                    )
                }

                // Section 9: Responsáveis
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    ZodiakDivider(hierarchy: .secondary, style: .thin)
                    ZodiakText(
                        "feature.solutions_catalog.detail_responsible",
                        style: .title1
                    )
                    ZodiakAuthor(
                        name: solution.author,
                        role: solution.stack,
                        avatarInitials: String(solution.author.prefix(2)).uppercased()
                    )
                    ForEach(solution.owners.filter { $0 != solution.author }, id: \.self) { owner in
                        ZodiakAuthor(name: owner, role: solution.stack)
                    }
                }

                // Section 10: Soluções Relacionadas
                if !relatedSolutions.isEmpty {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                        ZodiakDivider(hierarchy: .secondary, style: .thin)
                        ZodiakText(
                            "feature.solutions_catalog.detail_related",
                            style: .title1
                        )
                        ZodiakHorizontalCardList(
                            items: relatedSolutions.map { rel in
                                ZodiakHorizontalCardItem(
                                    id: rel.id,
                                    title: rel.title,
                                    subtitleTags: rel.stack.components(separatedBy: " + "),
                                    description: rel.description,
                                    tag: rel.category.rawValue,
                                    author: rel.author,
                                    icon: rel.category.icon,
                                    onTap: { viewModel.select(rel) }
                                )
                            }
                        )
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("screen.28.solution_detail")
    }
}
