import SwiftUI

// MARK: - Accordion Gallery View

struct AccordionGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = [
        "catalog.tab.demo",
        "catalog.tab.variants",
        "catalog.tab.specs"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.accordion",
                subtitle: "catalog.accordion.subtitle",
                figmaRef: "catalog.component_name.accordion"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component_name.accordion")
    }
}

// MARK: - Demo Tab

private extension AccordionGalleryView {
    @ViewBuilder
    var demoTab: some View {
        PlaygroundSection()
        NotificationsSection()
        FAQSection()
    }
}

// MARK: - Variants Tab

private extension AccordionGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        BasicExampleSection()
        WithIconSection()
    }
}

// MARK: - Specs Tab

private extension AccordionGalleryView {
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.radius",
                value: "catalog.spec.val.zodiakradiis_16pt",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.chevron",
                value: "catalog.spec.val.13pt_semibold_180_rotation",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.animacao",
                value: "catalog.spec.val.springresponse_03_dampingfraction_085",
                style: .spec()
            )

            ZodiakInfoRow("catalog.spec.lbl.borda", value: "catalog.spec.val.borderprimary_1pt", style: .spec())

            ZodiakInfoRow(
                "catalog.spec.lbl.transition",
                value: "catalog.spec.val.opacity_moveedge_top",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.starts_expanded",
                value: "Bool — default false",
                style: .spec()
            )
        }
    }
}

// MARK: - Playground Section

private struct PlaygroundSection: View {
    @State private var showIcon = true
    @State private var showSubtitle = false
    @State private var startsExpanded = false

    var body: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                ZodiakSwitch(label: "catalog.accordion.playground.show_icon", isOn: $showIcon)
                ZodiakDivider(hierarchy: .secondary)
                ZodiakSwitch(label: "catalog.accordion.playground.show_subtitle", isOn: $showSubtitle)
                ZodiakDivider(hierarchy: .secondary)
                ZodiakSwitch(label: "catalog.accordion.playground.starts_expanded", isOn: $startsExpanded)
            }
            ZodiakDivider()
            ZodiakText("catalog.accordion.playground.preview_title", style: .caption())
            ZodiakAccordion(
                title: "catalog.component_name.accordion",
                subtitle: showSubtitle ? "Zodiak DS · v2.0" : nil,
                leadingIcon: showIcon ? "square.stack.3d.up" : nil,
                initiallyExpanded: startsExpanded
            ) {
                ZodiakText("catalog.accordion.about_desc", style: .body(color: .secondary))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .id(startsExpanded)
        }
    }
}

// MARK: - Notifications Section

private struct NotificationsSection: View {
    @State private var push = true
    @State private var email = false
    @State private var alerts = true

    var body: some View {
        gallerySectionCard(title: "catalog.accordion.rich_content.title") {
            ZodiakText("catalog.accordion.rich_content.desc", style: .caption())

            ZodiakAccordion(
                title: "catalog.accordion.notifications.title",
                subtitle: activeCount,
                leadingIcon: "bell.badge",
                initiallyExpanded: true
            ) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    ZodiakSwitch(label: "catalog.switch.demo.push_notifications", isOn: $push)
                    ZodiakDivider(hierarchy: .secondary)
                    ZodiakSwitch(label: "catalog.switch.demo.email_notifications", isOn: $email)
                    ZodiakDivider(hierarchy: .secondary)
                    ZodiakSwitch(label: "catalog.switch.demo.security_alerts", isOn: $alerts)
                }
            }
        }
    }

    private var activeCount: String {
        let count = [push, email, alerts].filter { $0 }.count
        return String(format: NSLocalizedString("catalog.accordion.active_count", comment: ""), count)
    }
}

// MARK: - FAQ Section

private struct FAQSection: View {
    var body: some View {
        gallerySectionCard(title: "catalog.accordion.faq.title") {
            ZodiakText("catalog.accordion.faq.desc", style: .caption())

            ZodiakAccordionGroup(items: [
                (title: LocalizedStringKey("catalog.accordion.faq.q1"), content: {
                    AnyView(
                        ZodiakText("catalog.accordion.faq.a1", style: .body(color: .secondary))
                            .fixedSize(horizontal: false, vertical: true)
                    )
                }),
                (title: LocalizedStringKey("catalog.accordion.faq.q2"), content: {
                    AnyView(
                        ZodiakText("catalog.accordion.faq.a2", style: .body(color: .secondary))
                            .fixedSize(horizontal: false, vertical: true)
                    )
                }),
                (title: LocalizedStringKey("catalog.accordion.faq.q3"), content: {
                    AnyView(
                        ZodiakText("catalog.accordion.faq.a3", style: .body(color: .secondary))
                            .fixedSize(horizontal: false, vertical: true)
                    )
                })
            ])
        }
    }
}

// MARK: - Basic Example Section

private struct BasicExampleSection: View {
    var body: some View {
        gallerySectionCard(title: "catalog.section.exemplo_basico") {
            ZodiakText("catalog.accordion.expand_hint", style: .caption())

            ZodiakAccordion(title: "catalog.accordion.basic.q1_title") {
                ZodiakText("catalog.accordion.about_desc", style: .body(color: .secondary))
                    .fixedSize(horizontal: false, vertical: true)
            }

            ZodiakAccordion(title: "catalog.accordion.token_hint_title", initiallyExpanded: true) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText("catalog.accordion.token_hint_1", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                    ZodiakText("catalog.accordion.token_hint_2", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                    ZodiakText("catalog.accordion.token_hint_3", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

// MARK: - With Icon Section

private struct WithIconSection: View {
    private let typographyStyles: [(name: String, token: String)] = [
        ("Headline", "ZodiakTypography.titleLarge"),
        ("Title 1", "ZodiakTypography.titleMedium"),
        ("Title 2", "ZodiakTypography.titleSmall"),
        ("Title 3", "ZodiakTypography.labelLarge"),
        ("Body", "ZodiakTypography.bodyMedium"),
        ("Caption", "ZodiakTypography.captionLarge")
    ]

    var body: some View {
        gallerySectionCard(title: "catalog.section.com_icone_e_subtitulo") {
            ZodiakAccordion(
                title: "catalog.component.typography",
                subtitle: NSLocalizedString("catalog.accordion.styles_subtitle", comment: ""),
                leadingIcon: "textformat"
            ) {
                VStack(spacing: 0) {
                    ForEach(typographyStyles, id: \.name) { style in
                        ZodiakInfoRow(label: style.name, value: style.token, style: .data)
                        if style.name != typographyStyles.last?.name {
                        }
                    }
                }
            }

            ZodiakAccordion(
                title: "catalog.component.spacing",
                subtitle: NSLocalizedString("catalog.accordion.spacing_subtitle", comment: ""),
                leadingIcon: "ruler"
            ) {
                ZodiakText("catalog.accordion.desc_6", style: .body(color: .secondary))
                    .fixedSize(horizontal: false, vertical: true)
            }

            ZodiakAccordion(
                title: "catalog.section.accessibility",
                subtitle: "WCAG 2.1 AA",
                leadingIcon: "figure.and.child.holdinghands"
            ) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText("catalog.accordion.desc_7", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                    ZodiakText("catalog.accordion.desc_8", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                    ZodiakText("catalog.accordion.desc_9", style: .body(color: .secondary))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

#Preview { NavigationStack { AccordionGalleryView() } }
