import SwiftUI

// MARK: - Notice Gallery View
// Zodiak DS — Molecules > Notice

struct NoticeGalleryView: View {
    @State private var selectedTab = 0

    private let tabs = [
        "catalog.gallery.tab.demo",
        "catalog.gallery.tab.variants",
        "catalog.gallery.tab.specs"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.notice",
                subtitle: "catalog.notice.subtitle",
                figmaRef: "Notice"
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
                .padding(.top, ZodiakSpacing.s8)
            tabContent
        }
        .zodiakPage(title: "catalog.component_name.notice")
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 0: demoTab
        case 1: variantsTab
        default: specsTab
        }
    }
}

// MARK: - Demo Tab

private extension NoticeGalleryView {
    var demoTab: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            playgroundSection
            dismissDemoSection
        }
    }

    var playgroundSection: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakNotice(
                title: "catalog.notice.title.info",
                message: "catalog.notice.msg.info",
                category: .information,
                isDismissible: false,
                action: {},
                actionLabel: "catalog.notice.action.docs"
            )
            ZodiakNotice(
                title: "catalog.notice.title.success",
                message: "catalog.notice.msg.success",
                category: .success,
                isDismissible: false
            )
            ZodiakNotice(
                title: "catalog.notice.title.attention",
                message: "catalog.notice.msg.warning",
                category: .warning,
                isDismissible: false
            )
        }
    }

    var dismissDemoSection: some View {
        gallerySectionCard(title: "catalog.section.with_action") {
            ZodiakText("catalog.notice.desc_dismiss", style: .caption())
            ZodiakNotice(
                title: "catalog.notice.title.info",
                message: "catalog.notice.msg.info",
                category: .information,
                isDismissible: true,
                action: {},
                actionLabel: "catalog.notice.action.docs"
            )
            ZodiakNotice(
                title: "catalog.notice.title.attention",
                message: "catalog.notice.msg.warning",
                category: .warning,
                isDismissible: true
            )
        }
    }
}

// MARK: - Variants Tab

private extension NoticeGalleryView {
    var variantsTab: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            informationSection
            successSection
            warningSection
        }
    }

    var informationSection: some View {
        gallerySectionCard(title: "catalog.section.information") {
            ZodiakNotice(
                title: "catalog.notice.title.info",
                message: "catalog.notice.msg.info",
                category: .information,
                isDismissible: false
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakNotice(
                title: "catalog.notice.title.info",
                message: "catalog.notice.msg.info",
                category: .information,
                isDismissible: false,
                action: {},
                actionLabel: "catalog.notice.action.docs"
            )
        }
    }

    var successSection: some View {
        gallerySectionCard(title: "catalog.section.success") {
            ZodiakNotice(
                title: "catalog.notice.title.success",
                message: "catalog.notice.msg.success",
                category: .success,
                isDismissible: false
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakNotice(
                title: "catalog.notice.title.success",
                message: nil,
                category: .success,
                isDismissible: true
            )
        }
    }

    var warningSection: some View {
        gallerySectionCard(title: "catalog.section.warning") {
            ZodiakNotice(
                title: "catalog.notice.title.attention",
                message: "catalog.notice.msg.warning",
                category: .warning,
                isDismissible: false
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakNotice(
                title: "catalog.notice.title.attention",
                message: nil,
                category: .warning,
                isDismissible: true
            )
        }
    }
}

// MARK: - Specs Tab

private extension NoticeGalleryView {
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.variantes",
                value: "Warning · Success · Information",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.radius", value: "ZodiakRadii.xs (4pt)", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.side_bar", value: "4pt · borderColor", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.dismiss", value: "Optional · isDismissible", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.action", value: "ZodiakTextLink · caption", style: .spec())
        }
    }
}

#Preview { NavigationStack { NoticeGalleryView() } }
