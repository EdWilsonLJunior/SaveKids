import SwiftUI

// MARK: - Catalog Home View

struct CatalogHomeView: View {
    @EnvironmentObject private var catalog: CatalogViewModel
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.openURL) private var openURL

    private var stats: [(labelKey: String, value: String, icon: String)] {
        [
            ("catalog.home.semantic_colors", "37", "paintpalette"),
            ("catalog.home.primitive_ramps", "7", "circle.grid.3x3"),
            ("catalog.home.tab_components", "\(CatalogSection.components.items.count)", "puzzlepiece.extension"),
            ("catalog.home.typography_styles", "\(ZodiakTypography.allMainStyles.count)", "textformat"),
            ("catalog.home.spacing_tokens", "\(ZodiakSpacing.allTokens.count)", "ruler"),
            ("catalog.home.dark_mode_support", "100%", "moon.fill"),
            ("catalog.home.icons", "\(ZodiakIcon.allCases.count)", "sparkles"),
            ("catalog.home.flags", "\(ZodiakFlagCountry.allCases.count)", "flag.fill"),
            ("catalog.home.logos", "\(ZodiakLogoVariant.allCases.count)", "building.2"),
            ("catalog.section.compositions", "\(CatalogSection.compositions.items.count)", "rectangle.3.group"),
            ("catalog.home.tab_tokens", "\(CatalogSection.tokens.items.count)", "building.columns"),
            ("catalog.section.accessibility", "AA", "accessibility")
        ]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
                heroSection
                ZodiakDivider()
                statsSection
                ZodiakDivider()
                sectionsGrid
                ZodiakDivider()
                creditsSection
            }
            .padding(ZodiakSpacing.s16)
        }
        .background(ZodiakColors.background.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(ZodiakColors.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    // MARK: - Hero

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakLogoView(.spade)
                    .frame(height: 48)
                VStack(alignment: .leading, spacing: 2) {
                    ZodiakText("Zodiak", style: .headline)
                    ZodiakText("catalog.home.title", style: .body(color: .secondary))
                }
            }
            ZodiakText(
                "catalog.home.subtitle",
                style: .body()
            )
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    // MARK: - Stats

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakEyebrow(text: "app.tab.overview")
            ZodiakLayoutGrid(horizontalSpacing: ZodiakSpacing.s8,
                             verticalSpacing: ZodiakSpacing.s8) {
                ForEach(stats, id: \.labelKey) { stat in
                    statCard(stat)
                }
            }
        }
    }

    private func statCard(_ stat: (labelKey: String, value: String, icon: String)) -> some View {
        VStack(spacing: ZodiakSpacing.s4) {
            Image(systemName: stat.icon)
                .font(.system(size: 20))
                .foregroundStyle(ZodiakColors.brand)
            ZodiakText(verbatim: stat.value, style: .title2)
            ZodiakText(stat.labelKey, style: .caption())
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 90)
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("\(stat.value), \(Text(LocalizedStringKey(stat.labelKey)))"))
    }

    // MARK: - Sections Grid

    private var sectionsGrid: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakEyebrow(text: "catalog.home.sections")
            ForEach(CatalogSection.allCases) { section in
                Button {
                    navigate(to: section)
                } label: {
                    sectionCard(section)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Text(LocalizedStringKey(section.rawValue)))
                .accessibilityHint(Text(verbatim: sectionDescription(section)))
            }
        }
    }

    private func sectionCard(_ section: CatalogSection) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(systemName: section.icon)
                    .foregroundStyle(ZodiakColors.actionPrimary)
                    .font(.system(size: 18))
                ZodiakText(section.rawValue, style: .title3)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(ZodiakColors.textSecondary)
                    .font(.system(size: 14))
            }
            ZodiakText(sectionDescription(section), style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            if section != .examples && section != .compositions {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: ZodiakSpacing.s4) {
                        ForEach(section.items.prefix(4)) { item in
                            ZodiakBadge(
                                text: LocalizedStringKey(item.rawValue),
                                backgroundColor: ZodiakColors.background,
                                foregroundColor: ZodiakColors.textSecondary
                            )
                        }
                        if section.items.count > 4 {
                            ZodiakBadge(
                                text: "catalog.spec.overflow_badge",
                                backgroundColor: ZodiakColors.background,
                                foregroundColor: ZodiakColors.textSecondary
                            )
                        }
                    }
                }
            }
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    private func sectionDescription(_ section: CatalogSection) -> String {
        switch section {
        case .tokens:        return "catalog.home.tokens_desc"
        case .components:    return "catalog.home.components_desc"
        case .compositions:  return "catalog.home.compositions_desc"
        case .visualAssets:  return "catalog.home.visual_assets_desc"
        case .examples:      return "catalog.home.examples_desc"
        }
    }

    // MARK: - Navigation

    private func navigate(to section: CatalogSection) {
        switch section {
        case .tokens:
            catalog.selectedItem = .item(.colors)

        case .components:
            catalog.selectedItem = .item(.buttons)

        case .compositions:
            catalog.selectedItem = .item(.heroCompositions)

        case .visualAssets:
            catalog.selectedItem = .item(.icons)

        case .examples:
            catalog.selectedItem = .examples
        }
    }

    // MARK: - Credits

    private var creditsSection: some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            Image(systemName: "info.circle")
                .foregroundStyle(ZodiakColors.textSecondary)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText("Zodiak Design System — Capgemini", style: .caption())
                ZodiakTextLink(
                    label: "doc-zodiak.capgemini.com",
                    action: {
                        if let url = URL(string: "https://doc-zodiak.capgemini.com/latest/zodiak-design-system-DMOZ8U0e") {
                            openURL(url)
                        }
                    },
                    isExternal: true,
                    font: ZodiakTypography.captionLarge
                )
                ZodiakTextLink(
                    label: "Figma Design Library",
                    action: {
                        if let url = URL(string: "https://www.figma.com/design/GMwVFGRj6CM8j82jmkAJXB/Zodiak_designsystem") {
                            openURL(url)
                        }
                    },
                    isExternal: true,
                    font: ZodiakTypography.captionLarge
                )
            }
        }
        .padding(ZodiakSpacing.s8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    NavigationStack {
        CatalogHomeView()
            .environmentObject(CatalogViewModel())
    }
}
