import SwiftUI

struct TextLinkGalleryView: View {
    @Environment(\.openURL) private var openURL
    @State private var selectedTab = 0

    private let tabs = [
        "catalog.textlink.tab.variantes",
        "catalog.textlink.tab.inline",
        "catalog.textlink.tab.specs"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.text_link",
                subtitle: "catalog.text_link.subtitle",
                figmaRef: "Text Link"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
                .padding(.top, ZodiakSpacing.s8)
            tabContent
                .animation(.easeInOut(duration: 0.2), value: selectedTab)
        }
        .zodiakPage(title: "catalog.component_name.text_link")
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 0: variantesSection
        case 1: inlineSection
        default: specsSection
        }
    }

    // MARK: - Tab 0: Variantes

    private var variantesSection: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            gallerySectionCard(title: "catalog.section.variantes") {
                variantRow(apiParam: "(default)") {
                    ZodiakTextLink(label: "catalog.textlink.demo.internal_with_icon", action: {})
                }
                ZodiakDivider(hierarchy: .secondary)
                variantRow(apiParam: "isExternal: true") {
                    ZodiakTextLink(label: "catalog.textlink.demo.external", action: {}, isExternal: true)
                }
                ZodiakDivider(hierarchy: .secondary)
                variantRow(apiParam: "showIcon: false") {
                    ZodiakTextLink(label: "catalog.textlink.demo.no_icon", action: {}, showIcon: false)
                }
                ZodiakDivider(hierarchy: .secondary)
                variantRow(apiParam: "isEnabled: false") {
                    ZodiakTextLink(label: "catalog.textlink.demo.disabled", action: {}, isEnabled: false)
                }
            }

            gallerySectionCard(title: "catalog.section.tamanhos_tipograficos") {
                typographyRow(name: "catalog.textlink.spec.body_default", token: "ZodiakTypography.bodyMedium") {
                    ZodiakTextLink(
                        label: "catalog.textlink.demo.body_text",
                        action: {},
                        font: ZodiakTypography.bodyMedium
                    )
                }
                ZodiakDivider(hierarchy: .secondary)
                typographyRow(name: "Body Small", token: "ZodiakTypography.bodySmall") {
                    ZodiakTextLink(
                        label: "catalog.textlink.demo.body_small",
                        action: {},
                        font: ZodiakTypography.bodySmall
                    )
                }
                ZodiakDivider(hierarchy: .secondary)
                typographyRow(name: "Caption", token: "ZodiakTypography.captionLarge") {
                    ZodiakTextLink(
                        label: "catalog.textlink.demo.caption",
                        action: {},
                        font: ZodiakTypography.captionLarge
                    )
                }
            }
        }
    }

    // MARK: - Tab 1: Inline

    private var inlineSection: some View {
        gallerySectionCard(title: "catalog.section.uso_inline") {
            ZodiakNotice(
                title: "catalog.textlink.inline.disclaimer.title",
                message: "catalog.textlink.inline.disclaimer.body",
                category: .information,
                action: {
                    if let url = URL(string: "https://developer.apple.com/design/human-interface-guidelines/buttons") {
                        openURL(url)
                    }
                },
                actionLabel: "catalog.textlink.inline.hig_action"
            )
        }
    }

    // MARK: - Tab 2: Specs

    private var specsSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow("catalog.textlink.spec.active_color", value: "ZodiakColors.textLink", style: .spec())
            ZodiakInfoRow(
                "catalog.textlink.spec.inactive_color",
                value: "ZodiakColors.textDisabled",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.textlink.spec.underline",
                value: "catalog.textlink.spec.underline_value",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.textlink.spec.internal_icon",
                value: "chevron.right · 12pt medium",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.textlink.spec.external_icon",
                value: "arrow.up.right · 12pt medium",
                style: .spec()
            )
            ZodiakInfoRow(label: "Tracking", value: "ZodiakTypography.BodySize.m.tracking", style: .spec())
        }
    }

    // MARK: - Helpers

    @ViewBuilder
    private func variantRow<C: View>(
        apiParam: String,
        @ViewBuilder content: () -> C
    ) -> some View {
        HStack {
            ZodiakText(verbatim: apiParam, style: .caption(color: .secondary))
            Spacer()
            content()
        }
    }

    @ViewBuilder
    private func typographyRow<C: View>(
        name: LocalizedStringKey,
        token: String,
        @ViewBuilder content: () -> C
    ) -> some View {
        HStack(spacing: ZodiakSpacing.s16) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(name, style: .body(bold: true))
                ZodiakText(verbatim: token, style: .caption())
            }
            Spacer()
            content()
        }
    }
}

#Preview { NavigationStack { TextLinkGalleryView() } }
