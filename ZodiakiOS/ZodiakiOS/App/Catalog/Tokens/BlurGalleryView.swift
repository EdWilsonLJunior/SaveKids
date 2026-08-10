import SwiftUI

// MARK: - Blur Gallery View

struct BlurGalleryView: View {
    @State private var selectedTab = 0
    @State private var contentBlurActive = false
    @State private var showContentBlurModal = false

    private let tabKeys = [
        "catalog.blur.tab.demo",
        "catalog.blur.tab.specs",
        "catalog.blur.tab.guidelines"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.blur",
                subtitle: "catalog.blur.token_count_desc",
                figmaRef: "Blurs"
            )
            ZodiakTabs(tabs: tabKeys, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  specsTab
            case 2:  guidelinesTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component.blur")
        .zodiakModal(isPresented: $showContentBlurModal, title: "catalog.blur.modal_demo_title") {
            ZodiakText("catalog.blur.modal_demo_body", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, ZodiakSpacing.s4)
        }
    }
}

// MARK: - Tab Sections

private extension BlurGalleryView {
    // MARK: Demo Tab
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.blur.section.background") {
            ZodiakText("catalog.blur.single_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakDivider()
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 240), spacing: ZodiakSpacing.s8)],
                spacing: ZodiakSpacing.s8
            ) {
                blurDemoItem(isDo: true)
                blurDemoItem(isDo: false)
            }
        }
        gallerySectionCard(title: "catalog.blur.section.content") {
            ZodiakText("catalog.blur.content_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakDivider()
            ZodiakSwitch(label: "catalog.blur.toggle_content_blur", isOn: $contentBlurActive)
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(label: "Item A", value: "R$ 120,00")
                ZodiakInfoRow(label: "Item B", value: "R$ 85,50")
            }
            .zodiakContentBlur(isActive: contentBlurActive)
            .animation(.easeInOut(duration: 0.25), value: contentBlurActive)
            ZodiakButtonPrimary(title: "catalog.blur.open_modal_action") {
                showContentBlurModal = true
            }
        }
    }

    // MARK: Specs Tab
    @ViewBuilder
    var specsTab: some View {
        gallerySectionCard(title: "catalog.blur.section.background") {
            ZodiakInfoRow(
                "catalog.blur.spec.radius",
                value: "catalog.blur.spec.val.radius",
                style: .spec()
            )
            ZodiakDivider()
            ZodiakInfoRow(
                "catalog.blur.spec.page_overlay",
                value: "catalog.blur.spec.val.page_overlay",
                style: .spec()
            )
            ZodiakDivider()
            ZodiakInfoRow(
                "catalog.blur.spec.color_blur",
                value: "catalog.blur.spec.val.color_blur",
                style: .spec()
            )
        }
        gallerySectionCard(title: "catalog.blur.section.content") {
            ZodiakInfoRow(
                "catalog.blur.spec.overlay_radius",
                value: "catalog.blur.spec.val.overlay_radius",
                style: .spec()
            )
            ZodiakDivider()
            ZodiakInfoRow(
                "catalog.blur.spec.overlay_modifier",
                value: "catalog.blur.spec.val.overlay_modifier",
                style: .spec()
            )
        }
    }

    // MARK: Guidelines Tab
    @ViewBuilder
    var guidelinesTab: some View {
        gallerySectionCard(title: "catalog.section.usage_contexts") {
            ZodiakAlert(title: "catalog.blur.rule_photographic_only", variant: .warning)
            ZodiakAlert(title: "catalog.blur.rule_light_content", variant: .warning)
            ZodiakDivider()
            ZodiakText("catalog.blur.usage_note", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Demo Card Helpers

private extension BlurGalleryView {
    func blurDemoItem(isDo: Bool) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            ZodiakChip(
                text: isDo ? "catalog.blur.do_label" : "catalog.blur.dont_label",
                isActive: isDo
            )
            blurDemoCard(isDo: isDo)
        }
    }

    func blurDemoCard(isDo: Bool) -> some View {
        ZStack {
            ZodiakGradients.brand
            ZodiakBlur.pageOverlay
            ZodiakText(
                isDo ? "catalog.blur.demo.white_content" : "catalog.blur.demo.dark_content",
                style: .body(color: isDo ? .inverse : .primary)
            )
            .frame(maxWidth: .infinity)
            .padding(ZodiakSpacing.s8)
            .zodiakBlurBackground()
            .cornerRadius(ZodiakRadii.s)
            .padding(ZodiakSpacing.s8)
        }
        .frame(height: 100)
        .cornerRadius(ZodiakRadii.s)
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                .stroke(
                    isDo ? ZodiakColors.textPositive : ZodiakColors.textNegative,
                    lineWidth: 1.5
                )
        )
    }
}

#Preview {
    NavigationStack {
        BlurGalleryView()
    }
}
