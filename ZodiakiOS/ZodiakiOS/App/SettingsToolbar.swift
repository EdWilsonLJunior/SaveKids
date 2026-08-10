import SwiftUI

// MARK: - Settings Toolbar
// Injects language picker and dark-mode toggle into the navigation bar.
// Safe to call on ANY view — silently no-ops when CatalogViewModel is absent
// (previews, isolated feature screens).
//
// Activate by propagating hasCatalogToolbar = true from the app root:
//
//     CatalogDetailRouter()
//         .environmentObject(catalog)
//         .environment(\.hasCatalogToolbar, true)

// MARK: - Environment Key

private struct CatalogToolbarPresenceKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    /// `true` when CatalogViewModel is guaranteed in the ancestor chain.
    /// Injected by MainTabView; defaults to `false` everywhere else.
    var hasCatalogToolbar: Bool {
        get { self[CatalogToolbarPresenceKey.self] }
        set { self[CatalogToolbarPresenceKey.self] = newValue }
    }
}

// MARK: - Modifier

private struct SettingsToolbarModifier: ViewModifier {
    /// Presence guard — read before accessing the EnvironmentObject below.
    @Environment(\.hasCatalogToolbar) private var isActive
    /// Only accessed when isActive == true (CatalogViewModel is guaranteed present).
    @EnvironmentObject private var catalog: CatalogViewModel
    @AppStorage("appLanguage") private var appLanguage: String = "system"

    func body(content: Content) -> some View {
        if isActive {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button("app.settings.follow_system") {
                                withAnimation(.easeInOut(duration: 0.3)) { appLanguage = "system" }
                            }
                            Button("app.settings.lang_pt_br") {
                                withAnimation(.easeInOut(duration: 0.3)) { appLanguage = "pt-BR" }
                            }
                            Button("app.settings.lang_en") {
                                withAnimation(.easeInOut(duration: 0.3)) { appLanguage = "en" }
                            }
                        } label: {
                            ZodiakIconView(.globe, size: .small, color: ZodiakColors.actionPrimary)
                                .accessibilityHidden(true)
                        }
                        .accessibilityLabel(Text("catalog.home.select_language"))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.35)) { catalog.isDarkMode.toggle() }
                        } label: {
                            ZodiakIconView(
                                catalog.isDarkMode ? .moon : .sun,
                                size: .small, color: ZodiakColors.actionPrimary
                            )
                            .accessibilityHidden(true)
                        }
                        .accessibilityLabel(
                            catalog.isDarkMode
                                ? Text("catalog.home.switch_light_theme")
                                : Text("catalog.home.switch_dark_theme")
                        )
                    }
                }
        } else {
            content
        }
    }
}

extension View {
    /// Adds language picker and dark-mode toggle to the navigation bar.
    /// No-ops silently when `hasCatalogToolbar` is not active in the environment.
    func settingsToolbar() -> some View {
        modifier(SettingsToolbarModifier())
    }
}
