import SwiftUI

// MARK: - Switch Gallery View

struct SwitchGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = [
        "catalog.switch.tab.demo",
        "catalog.switch.tab.variants",
        "catalog.switch.tab.specs",
        "catalog.switch.tab.guidelines"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.toggle",
                subtitle: "catalog.switch.subtitle",
                figmaRef: "Switch"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            case 3:  guidelinesTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component_name.toggle")
    }
}

// MARK: - Demo Tab

private extension SwitchGalleryView {
    @ViewBuilder
    var demoTab: some View {
        PlaygroundSection()
        StatesSection()
        GroupSection()
    }
}

// MARK: - Variants Tab

private extension SwitchGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        LabelPlacementSection()
        StatesSection()
    }
}

// MARK: - Specs Tab

private extension SwitchGalleryView {
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.switch.spec.official_name",
                value: "catalog.switch.spec.also_known_as",
                style: .spec()
            )

            ZodiakInfoRow("Small", value: "40×32px · touch target 40×40px", style: .spec())

            ZodiakInfoRow("Large", value: "56×32px · touch target 56×56px", style: .spec())

            ZodiakInfoRow(
                "catalog.switch.spec.color_on",
                value: "actionPrimary (light) · actionActive (dark)",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.section.variantes",
                value: "catalog.switch.spec.variants_list",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.switch.spec.group_spacing",
                value: "ZodiakSpacing.s16 — 16pt vertical",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.switch.spec.label_placement",
                value: ".leading · .trailing · .hidden",
                style: .spec()
            )

            ZodiakInfoRow("isEnabled", value: "Bool — default true", style: .spec())
        }
    }
}

// MARK: - Guidelines Tab

private extension SwitchGalleryView {
    @ViewBuilder
    var guidelinesTab: some View {
        gallerySectionCard(title: "catalog.switch.guideline.title") {
            ZodiakText("catalog.switch.guideline.desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
        }
        gallerySectionCard(title: "catalog.switch.guideline.do") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                ZodiakSwitch(label: "catalog.switch.demo.push_notifications", isOn: .constant(true))
                ZodiakSwitch(label: "catalog.switch.demo.email_notifications", isOn: .constant(false))
            }

            guidelineRow(icon: "checkmark.circle.fill", color: ZodiakColors.textPositive,
                         key: "catalog.switch.guideline.do_1")
            guidelineRow(icon: "checkmark.circle.fill", color: ZodiakColors.textPositive,
                         key: "catalog.switch.guideline.do_2")
            guidelineRow(icon: "checkmark.circle.fill", color: ZodiakColors.textPositive,
                         key: "catalog.switch.guideline.do_3")
        }
        gallerySectionCard(title: "catalog.switch.guideline.dont") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                ZodiakSwitch(label: "catalog.switch.demo.silent_mode", isOn: .constant(false), isEnabled: false)
                ZodiakSwitch(label: "catalog.switch.demo.auto_sync", isOn: .constant(false), isEnabled: false)
            }

            guidelineRow(icon: "xmark.circle.fill", color: ZodiakColors.textNegative,
                         key: "catalog.switch.guideline.dont_1")
            guidelineRow(icon: "xmark.circle.fill", color: ZodiakColors.textNegative,
                         key: "catalog.switch.guideline.dont_2")
            guidelineRow(icon: "xmark.circle.fill", color: ZodiakColors.textNegative,
                         key: "catalog.switch.guideline.dont_3")
        }
    }

    func guidelineRow(icon: String, color: Color, key: String) -> some View {
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
    @State private var isOn = true
    @State private var isEnabled = true
    @State private var placement: ZodiakSwitchLabelPlacement = .leading

    var body: some View {
        gallerySectionCard(title: "catalog.switch.playground.title") {
            ZodiakSwitch(
                label: "catalog.switch.demo.push_notifications",
                isOn: $isOn,
                isEnabled: isEnabled,
                labelPlacement: placement
            )

            ZodiakInfoRow(
                label: "catalog.switch.playground.state",
                value: isOn ? "ON" : "OFF",
                style: .spec()
            )
            ZodiakInfoRow(
                label: "catalog.switch.playground.label_placement",
                value: placementLabel,
                style: .spec()
            )
            ZodiakInfoRow(
                label: "isEnabled",
                value: isEnabled ? "true" : "false",
                style: .spec()
            )

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakChip(verbatim: ".leading", isActive: placement == .leading) { placement = .leading }
                ZodiakChip(verbatim: ".trailing", isActive: placement == .trailing) { placement = .trailing }
                ZodiakChip(verbatim: ".hidden", isActive: placement == .hidden) { placement = .hidden }
            }
            ZodiakSwitch(label: "isEnabled", isOn: $isEnabled)
        }
    }

    private var placementLabel: String {
        switch placement {
        case .leading:  return ".leading"
        case .trailing: return ".trailing"
        case .hidden:   return ".hidden"
        }
    }
}

// MARK: - States Section

private struct StatesSection: View {
    var body: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            ZodiakInfoRow(
                "catalog.switch.spec.state_on",
                value: "actionPrimary (light) · actionActive (dark)",
                style: .spec()
            )
            ZodiakSwitch(label: "catalog.switch.demo.push_notifications", isOn: .constant(true))

            ZodiakInfoRow(
                "catalog.switch.spec.state_off",
                value: "catalog.switch.spec.state_off_value",
                style: .spec()
            )
            ZodiakSwitch(label: "catalog.switch.demo.silent_mode", isOn: .constant(false))

            ZodiakInfoRow(
                "catalog.switch.spec.state_disabled_on",
                value: "actionPrimary · opacity 0.3",
                style: .spec()
            )
            ZodiakSwitch(label: "catalog.switch.demo.auto_sync", isOn: .constant(true), isEnabled: false)

            ZodiakInfoRow(
                "catalog.switch.spec.state_disabled_off",
                value: "borderSecondary · opacity 0.3",
                style: .spec()
            )
            ZodiakSwitch(label: "catalog.switch.demo.background_location", isOn: .constant(false), isEnabled: false)
        }
    }
}

// MARK: - Label Placement Section

private struct LabelPlacementSection: View {
    @State private var leading = true
    @State private var trailing = false
    @State private var hidden = true

    var body: some View {
        gallerySectionCard(title: "catalog.switch.spec.label_placement") {
            ZodiakInfoRow("catalog.switch.spec.label_leading", value: ".leading (default)", style: .spec())
            ZodiakSwitch(label: "catalog.switch.demo.marketing_emails", isOn: $leading)

            ZodiakInfoRow("catalog.switch.spec.label_trailing", value: ".trailing", style: .spec())
            ZodiakSwitch(
                label: "feature.theme_toggle.enable_dark",
                isOn: $trailing,
                labelPlacement: .trailing
            )

            ZodiakInfoRow(
                "catalog.switch.spec.label_hidden",
                value: "catalog.switch.spec.label_hidden_note",
                style: .spec()
            )
            ZodiakSwitch(
                label: "catalog.switch.demo.airplane_mode",
                isOn: $hidden,
                labelPlacement: .hidden
            )
        }
    }
}

// MARK: - Group Section

private struct GroupSection: View {
    @State private var push = true
    @State private var email = false
    @State private var weekly = false
    @State private var alerts = true
    @State private var location = false
    @State private var sync = true

    var body: some View {
        gallerySectionCard(title: "catalog.section.grupo") {
            ZodiakInfoRow(
                "catalog.switch.spec.spacing",
                value: "ZodiakSpacing.s16 — 16pt vertical",
                style: .spec()
            )
            VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                ZodiakSwitch(label: "catalog.switch.demo.push_notifications_short", isOn: $push)
                ZodiakSwitch(label: "catalog.switch.demo.email_notifications", isOn: $email)
                ZodiakSwitch(label: "catalog.switch.demo.weekly_summary", isOn: $weekly)
                ZodiakSwitch(label: "catalog.switch.demo.security_alerts", isOn: $alerts)
                ZodiakSwitch(label: "catalog.switch.demo.background_location", isOn: $location)
                ZodiakSwitch(label: "catalog.switch.demo.auto_sync", isOn: $sync)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SwitchGalleryView()
    }
}
