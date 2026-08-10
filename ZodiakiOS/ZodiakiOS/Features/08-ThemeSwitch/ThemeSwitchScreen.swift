import SwiftUI

// MARK: - Theme Toggle Screen
struct ThemeSwitchScreen: View {
    @StateObject private var viewModel: ThemeSwitchViewModel = ThemeSwitchViewModel()
    @State private var selectedTab: Int = 0
    @Environment(\.horizontalSizeClass) private var sizeClass

    private var hPadding: CGFloat { sizeClass == .regular ? ZodiakSpacing.s32 : ZodiakSpacing.s16 }

    var body: some View {
        ZStack {
            ZodiakColors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header + toggle
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakHeadlineSection(
                        title: "feature.theme_toggle.short_title",
                        eyebrow: "feature.theme_toggle.eyebrow",
                        intro: "feature.theme_toggle.intro",
                        style: .plainWithIntro
                    )
                    ZodiakFormWrapper {
                        ZodiakSwitch(
                            label: "feature.theme_toggle.enable_dark",
                            isOn: $viewModel.isDarkMode
                        )
                    }
                }
                .padding(hPadding)

                // Zodiak Tabs
                ZodiakTabContainer(
                    tabs: ["feature.theme_toggle.colors_section", "catalog.home.tab_components"],
                    selectedIndex: $selectedTab,
                    size: .medium
                ) { index in
                    ScrollView {
                        if index == 0 {
                            ThemeColorsTab()
                                .padding(ZodiakSpacing.s16)
                        } else {
                            ThemeComponentsTab()
                                .padding(ZodiakSpacing.s16)
                        }
                    }
                }
            }
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        .accessibilityIdentifier("screen.08.theme_switch")
    }
}

// MARK: - Tab: Cores
private struct ThemeColorsTab: View {
    private let swatches: [(label: String, color: Color)] = [
        ("Primária", ZodiakColors.actionPrimary),
        ("Marca", ZodiakColors.brand),
        ("catalog.section.background", ZodiakColors.background),
        ("Superfície", ZodiakColors.surface),
        ("shared.state.success_label", ZodiakColors.surfacePositive),
        ("shared.state.error_label", ZodiakColors.surfaceNegative),
        ("shared.state.warning_label", ZodiakColors.actionWarning),
        ("catalog.spec.color_marine", ZodiakColors.surfaceMarine),
        ("catalog.spec.color_azure", ZodiakColors.surfaceAzur)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ForEach(swatches, id: \.label) { swatch in
                HStack(spacing: ZodiakSpacing.s8) {
                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                        .fill(swatch.color)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                    ZodiakText(swatch.label, style: .body(color: .secondary))
                        .frame(width: 90, alignment: .leading)
                }
            }
        }
    }
}

// MARK: - Tab: Componentes
private struct ThemeComponentsTab: View {
    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            ZodiakText("catalog.component.buttons", style: .title3)
            ZodiakButtonPrimary(title: "catalog.spec.button_primary", action: {})
            ZodiakButtonSecondary(title: "catalog.spec.button_secondary", action: {})
            ZodiakDangerButton(title: "catalog.spec.button_danger", action: {})
            ZodiakSmallButton(title: "catalog.spec.button_small_alt", action: {})

            ZodiakText("catalog.component_name.badges", style: .title3)
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakSuccessBadge(text: "shared.state.success_label")
                ZodiakErrorBadge(text: "shared.state.error_label")
                ZodiakWarningBadge(text: "shared.state.warning_label")
            }

            ZodiakText("catalog.component.typography", style: .title3)
            ZodiakText("Headline", style: .headline)
            ZodiakText("Title 1", style: .title1)
            ZodiakText("Title 2", style: .title2)
            ZodiakText("Title 3", style: .title3)
            ZodiakText("Body — texto de corpo padrão", style: .body())
            ZodiakText("Secondary — texto secundário", style: .body(color: .secondary))
            ZodiakText("Caption — texto auxiliar", style: .caption())
        }
    }
}

#Preview {
    ThemeSwitchScreen()
}
