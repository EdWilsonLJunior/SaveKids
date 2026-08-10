import SwiftUI

// MARK: - Zodiak Quick Access Bar
// Barra flutuante global com atalhos para idioma e tema.
// Usa .ultraThinMaterial para o efeito de vidro translúcido.

struct ZodiakQuickAccessBar: View {
    @Binding var appLanguage: String
    @Binding var isDarkMode: Bool

    private var themeIcon: ZodiakIcon { isDarkMode ? .moon : .sun }
    private var themeLabel: LocalizedStringKey {
        isDarkMode
            ? "catalog.home.switch_light_theme"
            : "catalog.home.switch_dark_theme"
    }

    var body: some View {
        HStack(spacing: 0) {
            // MARK: Language Menu
            Menu {
                Button("app.settings.follow_system") { appLanguage = "system" }
                Button("app.settings.lang_pt_br") { appLanguage = "pt-BR" }
                Button("app.settings.lang_en") { appLanguage = "en" }
            } label: {
                ZodiakIconView(.globe, size: .small, color: ZodiakColors.textPrimary)
                    .frame(width: 36, height: 36)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel(Text("catalog.home.select_language"))

            // MARK: Vertical Separator
            Rectangle()
                .fill(ZodiakColors.borderSecondary)
                .frame(width: 1, height: 16)

            // MARK: Theme Toggle
            Button {
                isDarkMode.toggle()
            } label: {
                ZodiakIconView(themeIcon, size: .small, color: ZodiakColors.textPrimary)
                    .frame(width: 36, height: 36)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel(themeLabel)
        }
        .background(.ultraThinMaterial, in: Capsule())
        .shadow(color: Color.black.opacity(0.10), radius: 12, x: 0, y: 4)
    }
}

// MARK: - Preview

#Preview("Quick Access Bar") {
    ZStack {
        ZodiakColors.background.ignoresSafeArea()
        ZodiakQuickAccessBar(
            appLanguage: .constant("system"),
            isDarkMode: .constant(false)
        )
    }
}
