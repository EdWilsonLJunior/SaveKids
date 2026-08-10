import SwiftUI

// MARK: - Warning Buttons Gallery View

struct WarningButtonsGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = ["Primary", "Secondary", "Tertiary"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.warning_buttons",
                subtitle: "catalog.warning_buttons.subtitle",
                figmaRef: nil
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.descricao",
                value: "catalog.warnbtn.spec.desc",
                style: .spec()
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
                .padding(.top, ZodiakSpacing.s8)
            tabContent
        }
        .zodiakPage(title: "catalog.component.warning_buttons")
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 0: primarySection
        case 1: secondarySection
        default: tertiarySection
        }
    }

    // MARK: - Primary

    private var primarySection: some View {
        gallerySectionCard(title: "Primary") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.componente"),
                value: "ZodiakWarningButton",
                style: .spec()
            )

            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "Fundo actionWarningSecondary · texto textInverse · pill",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakWarningButton(
                    title: "Excluir conta",
                    action: {},
                    size: .small,
                    confirmationTitle: "Excluir conta?",
                    confirmationMessage: "catalog.btn.confirm.irreversible"
                )
                ZodiakWarningButton(
                    title: "Excluir conta (Medium)",
                    action: {},
                    size: .medium,
                    confirmationTitle: "Excluir conta?",
                    confirmationMessage: "catalog.btn.confirm.irreversible"
                )
                ZodiakWarningButton(
                    title: "Excluir conta (Large)",
                    action: {},
                    size: .large,
                    confirmationTitle: "Excluir conta?",
                    confirmationMessage: "catalog.btn.confirm.irreversible"
                )
                ZodiakWarningButton(title: "Disabled", action: {}, isEnabled: false)
            }
        }
    }

    // MARK: - Secondary

    private var secondarySection: some View {
        gallerySectionCard(title: "Secondary") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.componente"),
                value: "ZodiakWarningSecondaryButton",
                style: .spec()
            )

            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "Borda actionWarningSecondary · fundo transparente · pill",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakWarningSecondaryButton(
                    title: "Cancelar contrato",
                    action: {},
                    size: .medium,
                    confirmationTitle: "Cancelar contrato?",
                    confirmationMessage: nil
                )
                ZodiakWarningSecondaryButton(
                    title: "Cancelar contrato (Large)",
                    action: {},
                    size: .large
                )
                ZodiakWarningSecondaryButton(title: "Disabled", action: {}, isEnabled: false)
            }
        }
    }

    // MARK: - Tertiary

    private var tertiarySection: some View {
        gallerySectionCard(title: "Tertiary") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.componente"),
                value: "ZodiakWarningTertiaryButton",
                style: .spec()
            )

            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "catalog.warnbtn.spec.link_desc",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakWarningTertiaryButton(
                    title: "catalog.warnbtn.demo.revoke",
                    action: {},
                    confirmationTitle: "catalog.warnbtn.demo.revoke_confirm",
                    confirmationMessage: nil
                )
                ZodiakWarningTertiaryButton(title: "Disabled", action: {}, isEnabled: false)
            }
        }
    }
}

#Preview { NavigationStack { WarningButtonsGalleryView() } }
