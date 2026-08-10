import SwiftUI

struct NavButtonsGalleryView: View {
    @State private var isMenuOpen = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.nav_buttons",
                subtitle: "catalog.nav_buttons.subtitle",
                figmaRef: nil
            )

            // MARK: - ZodiakCircularArrowButton
            gallerySectionCard(title: "catalog.section.arrow_button_circular") {
                ZodiakInfoRow("Variantes", value: "primary · secondary · ghost", style: .spec())

                ZodiakInfoRow("Tamanhos", value: "small (36pt) · medium (48pt) · large (56pt)", style: .spec())

                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakCircularArrowButton(action: {}, size: .small, style: .primary)
                    ZodiakCircularArrowButton(action: {}, size: .medium, style: .primary)
                    ZodiakCircularArrowButton(action: {}, size: .large, style: .primary)
                }
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakCircularArrowButton(action: {}, size: .medium, style: .secondary)
                    ZodiakCircularArrowButton(action: {}, size: .medium, style: .ghost)
                    ZodiakCircularArrowButton(action: {}, size: .medium, style: .primary, isEnabled: false)
                }
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakCircularArrowButton(action: {}, direction: .left, style: .secondary)
                    ZodiakCircularArrowButton(action: {}, direction: .right, style: .secondary)
                    ZodiakCircularArrowButton(action: {}, direction: .up, style: .secondary)
                    ZodiakCircularArrowButton(action: {}, direction: .down, style: .secondary)
                }
            }

            // MARK: - ZodiakRoundCloseButton
            gallerySectionCard(title: "catalog.section.close_button") {
                ZodiakInfoRow("Uso", value: "Modais, sheets, banners", style: .spec())

                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakRoundCloseButton(action: {}, style: .ghost)
                    ZodiakRoundCloseButton(action: {}, style: .secondary)
                    ZodiakRoundCloseButton(action: {}, style: .primary)
                    ZodiakRoundCloseButton(action: {}, isEnabled: false)
                }
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakRoundCloseButton(action: {}, size: .small, style: .ghost)
                    ZodiakRoundCloseButton(action: {}, size: .medium, style: .ghost)
                    ZodiakRoundCloseButton(action: {}, size: .large, style: .ghost)
                }
            }

            // MARK: - ZodiakHamburgerButton
            gallerySectionCard(title: "catalog.section.hamburger_button") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.uso",
                    value: "catalog.navbtn.spec.usage_value",
                    style: .spec()
                )

                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakHamburgerButton(action: { isMenuOpen.toggle() }, isOpen: isMenuOpen)
                    ZodiakText(isMenuOpen ? "Menu aberto" : "Menu fechado", style: .caption())
                        .foregroundColor(ZodiakColors.textSecondary)
                }
                ZodiakHamburgerButton(action: {}, isEnabled: false)
            }

            // MARK: - Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow("Arrow — small", value: "catalog.navbtn.spec.small_value", style: .spec())

                ZodiakInfoRow("Arrow — medium", value: "catalog.navbtn.spec.medium_value", style: .spec())

                ZodiakInfoRow("Arrow — large", value: "catalog.navbtn.spec.large_value", style: .spec())

                ZodiakInfoRow("Primary fill", value: "actionPrimary", style: .spec())

                ZodiakInfoRow("Secondary border", value: "actionPrimary · 1.5pt", style: .spec())

                ZodiakInfoRow("Ghost", value: "sem fundo · sem borda", style: .spec())

                ZodiakInfoRow("Hamburguer", value: "catalog.navbtn.spec.hamburger_value", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.nav_buttons")
    }
}

#Preview { NavigationStack { NavButtonsGalleryView() } }
