import SwiftUI

// MARK: - Alert Gallery View

struct AlertGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = [
        "catalog.tab.demo",
        "catalog.tab.variants",
        "catalog.tab.specs",
        "catalog.tab.guidelines"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.alert",
                subtitle: "catalog.alert.subtitle",
                figmaRef: "catalog.component_name.alert"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            case 3:  guidelinesTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component_name.alert")
    }
}

// MARK: - Demo Tab

private extension AlertGalleryView {
    @ViewBuilder
    var demoTab: some View {
        PlaygroundSection()
        DismissibleSection()
    }
}

// MARK: - Variants Tab

private extension AlertGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        AllVariantsSection()
        TitleOnlySection()
    }
}

// MARK: - Specs Tab

private extension AlertGalleryView {
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.radius",
                value: "catalog.spec.val.zodiakradiis_16pt",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.padding",
                value: "catalog.spec.val.12pt_horizontal_e_vertical",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.icone",
                value: "catalog.spec.val.18pt_cor_da_variante",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.dismiss",
                value: "catalog.spec.val.xmark_12pt_semibold",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.transition",
                value: "catalog.spec.val.opacity_moveedge_top",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.alert.variant.info",
                value: "surfaceAzur 10% · actionPrimary",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.alert.variant.success",
                value: "surfacePositive · textPositive",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.alert.variant.warning",
                value: "surfaceWarningTint · actionWarningTint",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.alert.variant.error",
                value: "surfaceNegative · actionWarning",
                style: .spec()
            )
        }
    }
}

// MARK: - Guidelines Tab

private extension AlertGalleryView {
    @ViewBuilder
    var guidelinesTab: some View {
        gallerySectionCard(title: "catalog.alert.guidelines.do_title") {
            ZodiakAlert(
                title: "shared.state.operation_success",
                message: "catalog.toast.changes_saved",
                variant: .success
            )
            ZodiakDivider(hierarchy: .secondary)
            guidelineRow(icon: "checkmark.circle.fill", color: ZodiakColors.textPositive,
                         key: "catalog.alert.guidelines.do_1")
            guidelineRow(icon: "checkmark.circle.fill", color: ZodiakColors.textPositive,
                         key: "catalog.alert.guidelines.do_2")
        }
        gallerySectionCard(title: "catalog.alert.guidelines.dont_title") {
            ZodiakAlert(
                title: "catalog.alert.guidelines.dont_example_title",
                message: "catalog.alert.guidelines.dont_example_msg",
                variant: .error
            )
            ZodiakDivider(hierarchy: .secondary)
            guidelineRow(icon: "xmark.circle.fill", color: ZodiakColors.textNegative,
                         key: "catalog.alert.guidelines.dont_1")
            guidelineRow(icon: "xmark.circle.fill", color: ZodiakColors.textNegative,
                         key: "catalog.alert.guidelines.dont_2")
        }
    }

    func guidelineRow(icon: String, color: Color, key: LocalizedStringKey) -> some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.body)
            ZodiakText(key, style: .caption())
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Playground Section

private struct PlaygroundSection: View {
    @State private var variant: ZodiakAlertVariant = .info
    @State private var isDismissible = false
    @State private var showMessage = true
    @State private var alertID = UUID()

    private let variants: [ZodiakAlertVariant] = [.info, .success, .warning, .error]

    var body: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakText("catalog.alert.playground.variant_label", style: .caption())
                HStack(spacing: ZodiakSpacing.s4) {
                    ForEach(variants, id: \.self) { v in
                        ZodiakChip(verbatim: variantLabel(v), isActive: variant == v) {
                            variant = v
                            alertID = UUID()
                        }
                    }
                }
            }
            ZodiakDivider(hierarchy: .secondary)
            ZodiakSwitch(label: "catalog.alert.playground.dismissible_label", isOn: $isDismissible)
                .onChange(of: isDismissible) { alertID = UUID() }
            ZodiakSwitch(label: "catalog.alert.playground.message_label", isOn: $showMessage)
                .onChange(of: showMessage) { alertID = UUID() }
            ZodiakDivider()
            ZodiakText("catalog.accordion.playground.preview_title", style: .caption())
            ZodiakAlert(
                title: variantTitleKey(variant),
                message: showMessage ? variantMessageKey(variant) : nil,
                variant: variant,
                isDismissible: isDismissible
            )
            .id(alertID)
            if isDismissible {
                ZodiakButtonSecondary(title: "catalog.alert.playground.reset") {
                    alertID = UUID()
                }
            }
        }
    }

    private func variantLabel(_ v: ZodiakAlertVariant) -> String {
        switch v {
        case .info:    return ".info"
        case .success: return ".success"
        case .warning: return ".warning"
        case .error:   return ".error"
        }
    }

    private func variantTitleKey(_ v: ZodiakAlertVariant) -> LocalizedStringKey {
        switch v {
        case .info:    return "shared.state.info_label"
        case .success: return "shared.state.operation_success"
        case .warning: return "shared.state.attention"
        case .error:   return "shared.state.process_error"
        }
    }

    private func variantMessageKey(_ v: ZodiakAlertVariant) -> LocalizedStringKey {
        switch v {
        case .info:    return "catalog.spec.info_alert_desc"
        case .success: return "catalog.toast.changes_saved"
        case .warning: return "catalog.spec.irreversible_warning"
        case .error:   return "shared.state.save_failed"
        }
    }
}

// MARK: - Dismissible Section

private struct DismissibleSection: View {
    @State private var infoID = UUID()
    @State private var warningID = UUID()

    var body: some View {
        gallerySectionCard(title: "catalog.section.descartavel_isdismissible") {
            ZodiakText("catalog.alert.desc_0", style: .caption())

            ZodiakAlert(
                title: "catalog.toast.new_available",
                message: "catalog.toast.version_update",
                variant: .info,
                isDismissible: true
            )
            .id(infoID)
            ZodiakAlert(
                title: "shared.state.session_expiring",
                variant: .warning,
                isDismissible: true
            )
            .id(warningID)
            ZodiakButtonSecondary(title: "catalog.alert.playground.reset") {
                infoID = UUID()
                warningID = UUID()
            }
        }
    }
}

// MARK: - All Variants Section

private struct AllVariantsSection: View {
    var body: some View {
        gallerySectionCard(title: "catalog.section.variantes") {
            ZodiakAlert(
                title: "shared.state.info_label",
                message: "catalog.spec.info_alert_desc",
                variant: .info
            )
            ZodiakAlert(
                title: "shared.state.operation_success",
                message: "catalog.toast.changes_saved",
                variant: .success
            )
            ZodiakAlert(
                title: "shared.state.attention",
                message: "catalog.spec.irreversible_warning",
                variant: .warning
            )
            ZodiakAlert(
                title: "shared.state.process_error",
                message: "shared.state.save_failed",
                variant: .error
            )
        }
    }
}

// MARK: - Title Only Section

private struct TitleOnlySection: View {
    var body: some View {
        gallerySectionCard(title: "catalog.section.titulo_apenas") {
            ZodiakText("catalog.alert.title_only_desc", style: .caption())
            ZodiakAlert(title: "shared.state.registration_success", variant: .success)
            ZodiakAlert(title: "shared.validation.form_has_errors", variant: .error)
            ZodiakAlert(title: "shared.state.session_expiring", variant: .warning)
            ZodiakAlert(title: "shared.state.info_label", variant: .info)
        }
    }
}

#Preview { NavigationStack { AlertGalleryView() } }
