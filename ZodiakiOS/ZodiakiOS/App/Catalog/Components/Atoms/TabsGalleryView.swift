import SwiftUI

// MARK: - Tabs Gallery View

struct TabsGalleryView: View {
    @State private var selectedSmall = 0
    @State private var selectedMedium = 0
    @State private var selectedContainer = 0
    @State private var selectedWithDisabled = 0

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.tabs",
                subtitle: "catalog.tabs.subtitle",
                figmaRef: nil
            )
            specsSection
            smallSection
            mediumSection
            containerSection
            disabledSection
        }
        .zodiakPage(title: "catalog.component_name.tabs")
    }

    // MARK: - Specs

    private var specsSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow("Tamanhos", value: "Small (S) • Medium (L)", style: .spec())

            ZodiakInfoRow("Small — tipografia", value: "heading-2xs 14pt — light/regular", style: .spec())

            ZodiakInfoRow("Medium — tipografia", value: "heading-xs 16pt — light/regular", style: .spec())

            ZodiakInfoRow("catalog.tabs.spec.spacing_label", value: "2px (spacing-hairline)", style: .spec())

            ZodiakInfoRow("catalog.tabs.spec.max_label", value: "7", style: .spec())

            ZodiakInfoRow("Indicador ativo", value: "2px — Action Active #3573c0", style: .spec())

            ZodiakInfoRow("Focus ring", value: "1px — Action Focus onLite #2e323a", style: .spec())
        }
    }

    private var smallSection: some View {
        gallerySectionCard(title: "catalog.section.small_14pt") {
            ZodiakText(
                "catalog.tabs.small_desc",
                style: .body(color: .secondary)
            )
                .fixedSize(horizontal: false, vertical: true)
            ZodiakTabs(
                tabs: ["app.tab.overview", "Specs", "Guidelines"],
                selectedIndex: $selectedSmall,
                size: .small
            )
        }
    }

    private var mediumSection: some View {
        gallerySectionCard(title: "catalog.section.medium_14pt") {
            ZodiakText(
                "catalog.tabs.medium_desc",
                style: .body(color: .secondary)
            )
                .fixedSize(horizontal: false, vertical: true)
            ZodiakTabs(
                tabs: ["Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5"],
                selectedIndex: $selectedMedium,
                size: .medium
            )
            tabContent(for: selectedMedium, tabs: ["Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5"])
        }
    }

    private func tabContent(for index: Int, tabs: [String]) -> some View {
        VStack {
            ZodiakText("catalog.tabs.content_info", style: .body(color: .secondary))
        }
        .frame(maxWidth: .infinity)
        .padding(ZodiakSpacing.s16)
    }

    private var containerSection: some View {
        gallerySectionCard(title: "catalog.section.tabcontainer") {
            ZodiakText("catalog.tabs.container_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakTabContainer(
                tabs: [
                    "feature.theme_toggle.colors_section",
                    "catalog.home.tab_components",
                    "catalog.section.examples"
                ],
                selectedIndex: $selectedContainer,
                size: .small
            ) { index in
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    switch index {
                    case 0:
                        ZodiakText("catalog.color.gallery_desc", style: .body())
                        HStack(spacing: ZodiakSpacing.s8) {
                            ForEach(
                                // swiftlint:disable:next line_length
                                [ZodiakColors.brand, ZodiakColors.brandOrange, ZodiakColors.surfacePositive, ZodiakColors.surfaceNegative],
                                id: \.self
                            ) { color in
                                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                    .fill(color)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 32)
                            }
                        }

                    case 1:
                        ZodiakText("catalog.component_list.desc", style: .body())
                        ForEach(["ZodiakButton", "ZodiakTextField", "ZodiakBadge"], id: \.self) { name in
                            ZodiakText(verbatim: "→ \(name)", style: .body(color: .secondary))
                        }

                    default:
                        ZodiakText(verbatim: "10 exemplos de uso real do DS.", style: .body())
                    }
                }
                .padding(ZodiakSpacing.s16)
            }
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
        }
    }

    // MARK: - Disabled com disabledIndices (T5)

    private var disabledSection: some View {
        gallerySectionCard(title: "catalog.section.tab_desabilitada") {
            ZodiakText("catalog.tabs.disabled_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakInfoRow(
                "API",
                value: "disabledIndices: Set<Int>",
                style: .spec()
            )

            // Via parâmetro integrado em ZodiakTabs
            ZodiakTabs(
                tabs: ["Ativa", "Desabilitada", "Ativa"],
                selectedIndex: $selectedWithDisabled,
                disabledIndices: [1]
            )

            // Via ZodiakDisabledTabItem standalone
            ZodiakText("Standalone ZodiakDisabledTabItem:", style: .body(color: .secondary))
                .font(ZodiakTypography.captionLarge)
            HStack(spacing: 2) {
                ZodiakDisabledTabItem(label: "catalog.tabs.demo.coming_soon", size: .small)
                ZodiakDisabledTabItem(label: "Bloqueado", size: .small)
            }
        }
    }
}

// MARK: - Safe subscript

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

#Preview {
    NavigationStack {
        TabsGalleryView()
    }
}
