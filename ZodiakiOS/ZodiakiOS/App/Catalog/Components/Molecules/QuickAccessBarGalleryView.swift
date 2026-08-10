import SwiftUI

// MARK: - Quick Access Bar Gallery View
// Zodiak DS — Molecules > Quick Access Bar

struct QuickAccessBarGalleryView: View {
    @State private var appLanguage = "system"
    @State private var isDarkMode = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.quick_access_bar",
                subtitle: "catalog.quick_access_bar.subtitle",
                figmaRef: "Quick Access Bar"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground") {
                VStack(spacing: ZodiakSpacing.s16) {
                    Text("catalog.quick_access_bar.desc_0")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ZStack {
                        RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                            .fill(isDarkMode ? ZodiakColors.surfaceInk : ZodiakColors.surfaceSmoke)
                            .frame(height: 100)

                        ZodiakQuickAccessBar(
                            appLanguage: $appLanguage,
                            isDarkMode: $isDarkMode
                        )
                    }

                    HStack {
                        Text("catalog.quick_access_bar.lang_label")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        Spacer()
                        Text(appLanguage)
                            .font(ZodiakTypography.captionLarge.bold())
                            .foregroundColor(ZodiakColors.textPrimary)
                    }

                    HStack {
                        Text("catalog.quick_access_bar.theme_label")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        Spacer()
                        Text(isDarkMode ? "Dark" : "Light")
                            .font(ZodiakTypography.captionLarge.bold())
                            .foregroundColor(ZodiakColors.textPrimary)
                    }
                }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow("catalog.spec.lbl.fundo", value: ".ultraThinMaterial · Capsule", style: .spec())

                ZodiakInfoRow("Shadow", value: "rgba(0,0,0,0.10) · radius 12pt", style: .spec())

                ZodiakInfoRow("Idioma", value: "Menu: system / pt-BR / en", style: .spec())

                ZodiakInfoRow("Tema", value: "Toggle dark/light mode", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.quick_access_bar")
    }
}

#Preview { NavigationStack { QuickAccessBarGalleryView() } }
