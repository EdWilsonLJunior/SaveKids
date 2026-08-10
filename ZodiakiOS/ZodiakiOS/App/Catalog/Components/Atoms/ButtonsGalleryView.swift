import SwiftUI

// MARK: - Buttons Gallery View
// swiftlint:disable type_body_length
// Reason: catalog gallery with 8 tab sections — structural complexity

struct ButtonsGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = [
        "catalog.btn.tab.variants", "catalog.btn.tab.sizes",
        "catalog.btn.tab.icons", "Danger", "Warning",
        "onHeavy", "onPhoto", "catalog.btn.tab.states"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.buttons",
                subtitle: "catalog.buttons.subtitle",
                figmaRef: nil
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
                .padding(.top, ZodiakSpacing.s8)
            tabContent
        }
        .zodiakPage(title: "catalog.component.buttons")
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 0: variantsSection
        case 1: sizesSection
        case 2: iconSection
        case 3: dangerSection
        case 4: warningSection
        case 5: onHeavySection
        case 6: onPhotoSection
        default: statesSection
        }
    }

    // MARK: - Variants

    private var variantsSection: some View {
        gallerySectionCard(title: "catalog.section.variantes") {
            VStack(spacing: ZodiakSpacing.s8) {
                variantCard(
                    name: "catalog.spec.style_primary",
                    component: "ZodiakButton",
                    usage: "catalog.btn.spec.primary_usage"
                ) {
                    ZodiakButtonPrimary(title: "catalog.spec.button_primary", action: {})
                }
                variantCard(
                    name: "catalog.spec.style_secondary",
                    component: "ZodiakSecondaryButton",
                    usage: "catalog.btn.spec.secondary_usage"
                ) {
                    ZodiakButtonSecondary(title: "catalog.spec.button_secondary", action: {})
                }
                variantCard(
                    name: "Tertiary",
                    component: "ZodiakTertiaryButton",
                    usage: "catalog.btn.spec.tertiary_usage"
                ) {
                    ZodiakButtonTertiary(title: "catalog.spec.button_tertiary", action: {})
                }
                variantCard(
                    name: "Danger",
                    component: "ZodiakDangerButton",
                    usage: "catalog.btn.spec.danger_usage"
                ) {
                    ZodiakDangerButton(title: "catalog.spec.button_danger", action: {})
                }
                variantCard(
                    name: "catalog.spec.size_small",
                    component: "ZodiakSmallButton",
                    usage: "catalog.btn.spec.small_usage"
                ) {
                    ZodiakSmallButton(title: "catalog.spec.button_small", action: {})
                }
            }
        }
    }

    // MARK: - Sizes (Gap B)

    private var sizesSection: some View {
        gallerySectionCard(title: "catalog.section.tamanhos") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "catalog.btn.spec.sizes_value",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakButtonPrimary(title: "Small (38pt)", action: {}, size: .small)
                ZodiakButtonPrimary(title: "catalog.btn.demo.medium_default", action: {}, size: .medium)
                ZodiakButtonPrimary(title: "Large (56pt)", action: {}, size: .large)
                ZodiakButtonSecondary(title: "Secondary Large", action: {}, size: .large)
            }
        }
    }

    // MARK: - Icons (Gap C)

    private var iconSection: some View {
        gallerySectionCard(title: "catalog.section.icones") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "catalog.btn.spec.icon_rule",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakButtonPrimary(title: "Download", action: {}, icon: "arrow.down.circle", iconPlacement: .leading)
                ZodiakButtonPrimary(title: "Continuar", action: {}, icon: "chevron.right", iconPlacement: .trailing)
                ZodiakButtonSecondary(
                    title: "Compartilhar",
                    action: {},
                    icon: "square.and.arrow.up",
                    iconPlacement: .leading
                )
            }
        }
    }

    // MARK: - Danger + Confirmation (Gap E)

    private var dangerSection: some View {
        gallerySectionCard(title: "Warning / Danger") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "catalog.btn.spec.danger_spec",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakDangerButton(
                    title: "catalog.spec.button_danger",
                    action: {}
                )
                ZodiakDangerButton(
                    title: "Excluir conta",
                    action: {},
                    confirmationTitle: "Excluir conta?",
                    confirmationMessage: "catalog.btn.confirm.permanent"
                )
            }
        }
    }

    // MARK: - onHeavy (Gap A)

    private var warningSection: some View {
        gallerySectionCard(title: "Warning Button") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "catalog.btn.spec.warning_spec",
                style: .spec()
            )

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakWarningButton(
                    title: "Excluir dados",
                    action: {},
                    confirmationTitle: "Excluir dados?",
                    confirmationMessage: "catalog.btn.confirm.irreversible"
                )
                ZodiakWarningButton(title: "Primary (disabled)", action: {}, isEnabled: false)
                ZodiakWarningSecondaryButton(
                    title: "Warning Secondary",
                    action: {},
                    confirmationTitle: "Tem certeza?",
                    confirmationMessage: nil
                )
                ZodiakWarningSecondaryButton(
                    title: "Secondary (disabled)",
                    action: {},
                    isEnabled: false
                )
                ZodiakWarningTertiaryButton(title: "Warning Tertiary", action: {})
                ZodiakWarningTertiaryButton(title: "Tertiary (disabled)", action: {}, isEnabled: false)
            }
        }
    }

    private var onHeavySection: some View {
        gallerySectionCard(title: "catalog.section.on_heavy") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "Para fundos escuros: Hero, Banner, surfaceInk/surfaceMarine",
                style: .spec()
            )

            ZStack {
                RoundedRectangle(cornerRadius: ZodiakRadii.m)
                    .fill(ZodiakColors.surfaceInk)
                VStack(spacing: ZodiakSpacing.s8) {
                    ZodiakButtonPrimary(title: "Primary onHeavy", action: {})
                        .zodiakPrimaryOnHeavyButtonStyle()
                    ZodiakButtonSecondary(title: "Secondary onHeavy", action: {})
                        .zodiakSecondaryOnHeavyButtonStyle()
                }
                .padding(ZodiakSpacing.s16)
            }
        }
    }

    // MARK: - On Photo

    private var onPhotoSection: some View {
        gallerySectionCard(title: "On Photo") {
            ZodiakInfoRow(
                label: String(localized: "catalog.spec.lbl.descricao"),
                value: "catalog.btn.spec.on_photo_rule",
                style: .spec()
            )

            ZStack {
                LinearGradient(
                    colors: [
                        Color.purple.opacity(0.7),
                        Color.blue.opacity(0.5),
                        Color.black.opacity(0.6)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 200)
                .overlay(ZodiakColors.heroPhotographic)
                .cornerRadius(ZodiakRadii.m)
                VStack(spacing: ZodiakSpacing.s8) {
                    ZodiakText("Hero photographic background", style: .title3)
                        .foregroundColor(ZodiakColors.textAlwaysWhite)
                    ZodiakButtonPrimary(title: "Saiba mais", action: {})
                        .zodiakPrimaryOnPhotoButtonStyle()
                }
                .padding(ZodiakSpacing.s16)
            }
            ZodiakInfoRow(
                label: "Token",
                value: "ZodiakColors.actionPrimaryOnPhoto = rgba(0,0,0,0)",
                style: .spec()
            )
            ZodiakInfoRow(
                label: "Modifier",
                value: ".zodiakPrimaryOnPhotoButtonStyle(isEnabled:size:)",
                style: .spec()
            )
        }
    }

    // swiftlint:disable:next line_length
    private func variantCard<C: View>(name: String, component: String, usage: String, @ViewBuilder button: () -> C) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack(spacing: ZodiakSpacing.s8) {
                Text(LocalizedStringKey(name))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(component)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .padding(.horizontal, ZodiakSpacing.s8)
                    .padding(.vertical, 2)
                    .background(ZodiakColors.background)
                    .cornerRadius(ZodiakRadii.l)
            }
            button()
            Text(LocalizedStringKey(usage))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    // MARK: - States

    private var statesSection: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakButtonPrimary(title: "catalog.spec.style_normal", action: {}, isEnabled: true)
                ZodiakButtonPrimary(title: "catalog.section.disabled", action: {}, isEnabled: false)
                ZodiakButtonSecondary(title: "catalog.spec.normal_secondary", action: {}, isEnabled: true)
                ZodiakButtonSecondary(title: "catalog.spec.disabled_secondary", action: {}, isEnabled: false)
                ZodiakDangerButton(title: "catalog.spec.normal_danger", action: {}, isEnabled: true)
                ZodiakDangerButton(title: "catalog.spec.disabled_danger", action: {}, isEnabled: false)
            }
        }
    }
}
// swiftlint:enable type_body_length

#Preview {
    NavigationStack {
        ButtonsGalleryView()
    }
}
