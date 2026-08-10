import SwiftUI

// MARK: - System Warning Buttons Gallery View

struct SystemWarningButtonsGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = ["Primary", "Secondary", "Sizes", "States"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.system_warning_buttons",
                subtitle: "catalog.system_warning_buttons.subtitle",
                figmaRef: nil
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.descricao",
                value: "Compact · XS rounded rect · S(38px)/M(48px) · max 312px · for apps/systems only.",
                style: .spec()
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
                .padding(.top, ZodiakSpacing.s8)
            tabContent
        }
        .zodiakPage(title: "catalog.component.system_warning_buttons")
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 0: primarySection
        case 1: secondarySection
        case 2: sizesSection
        default: statesSection
        }
    }

    // MARK: - Primary

    private var primarySection: some View {
        gallerySectionCard(title: "Primary") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.componente"),
                value: "ZodiakSystemWarningButton",
                style: .spec()
            )

            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "actionWarningSecondary background · textInverse text · fixed icon",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakSystemWarningButton(
                    title: "Delete file",
                    action: {},
                    confirmationTitle: "Delete file?",
                    confirmationMessage: "This action cannot be undone."
                )
                ZodiakSystemWarningButton(
                    title: "Delete (Medium)",
                    action: {},
                    size: .medium,
                    confirmationTitle: "Delete?",
                    confirmationMessage: "This action cannot be undone."
                )
            }
        }
    }

    // MARK: - Secondary

    private var secondarySection: some View {
        gallerySectionCard(title: "Secondary") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.componente"),
                value: "ZodiakSystemWarningSecondaryButton",
                style: .spec()
            )

            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "actionWarningSecondary border · transparent background · fixed icon",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakSystemWarningSecondaryButton(
                    title: "Revoke access",
                    action: {},
                    confirmationTitle: "Revoke access?",
                    confirmationMessage: nil
                )
                ZodiakSystemWarningSecondaryButton(
                    title: "Revoke (Medium)",
                    action: {},
                    size: .medium,
                    confirmationTitle: "Revoke?",
                    confirmationMessage: nil
                )
            }
        }
    }

    // MARK: - Tamanhos

    private var sizesSection: some View {
        gallerySectionCard(title: "catalog.section.tamanhos") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "Small 38px (default) · Medium 48px · max 312px",
                style: .spec()
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(
                    label: "Primary",
                    value: "",
                    style: .spec()
                )
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakSystemWarningButton(title: "Small", action: {}, size: .small)
                    ZodiakSystemWarningButton(title: "Medium", action: {}, size: .medium)
                }

                ZodiakInfoRow(
                    label: "Secondary",
                    value: "",
                    style: .spec()
                )
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakSystemWarningSecondaryButton(title: "Small", action: {}, size: .small)
                    ZodiakSystemWarningSecondaryButton(title: "Medium", action: {}, size: .medium)
                }
            }
        }
    }

    // MARK: - Estados

    private var statesSection: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakSystemWarningButton(
                    title: "Primary enabled",
                    action: {},
                    confirmationTitle: "Confirm?",
                    confirmationMessage: nil
                )
                ZodiakSystemWarningButton(title: "Primary disabled", action: {}, isEnabled: false)
                ZodiakSystemWarningSecondaryButton(
                    title: "Secondary enabled",
                    action: {},
                    confirmationTitle: "Confirm?",
                    confirmationMessage: nil
                )
                ZodiakSystemWarningSecondaryButton(title: "Secondary disabled", action: {}, isEnabled: false)
            }
        }
    }
}

#Preview { NavigationStack { SystemWarningButtonsGalleryView() } }
