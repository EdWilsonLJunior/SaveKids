import SwiftUI

// MARK: - Notification Banner Gallery View
// Zodiak DS — Organisms > Notification Banner

struct NotificationBannerGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.notification_banner",
                subtitle: "catalog.notification_banner.subtitle",
                figmaRef: "Notification"
            )
            variantsSection
            dismissSection
            specsSection
        }
        .zodiakPage(title: "catalog.component_name.notification_banner")
    }

    private var variantsSection: some View {
        gallerySectionCard(title: "catalog.section.variantes") {
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakNotificationBanner(
                    title: "catalog.notifbanner.title.info",
                    message: "catalog.notifbanner.msg.info",
                    variant: .information,
                    actionLabel: "catalog.notifbanner.action.update",
                    action: {},
                    isDismissible: false
                )
                ZodiakNotificationBanner(
                    title: "catalog.notifbanner.title.positive",
                    message: "catalog.notifbanner.msg.positive",
                    variant: .positive,
                    isDismissible: false
                )
                ZodiakNotificationBanner(
                    title: "catalog.notifbanner.title.warning",
                    message: "catalog.notifbanner.msg.warning",
                    variant: .warning,
                    isDismissible: false
                )
            }
        }
    }

    private var dismissSection: some View {
        gallerySectionCard(title: "catalog.section.descartavel") {
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakNotificationBanner(
                    title: "catalog.notifbanner.title.dismissible",
                    message: "catalog.notifbanner.msg.dismissible",
                    variant: .information,
                    isDismissible: true
                )
                ZodiakNotificationBanner(
                    title: "catalog.notifbanner.title.with_action",
                    message: "catalog.notifbanner.msg.with_action",
                    variant: .positive,
                    actionLabel: "catalog.notifbanner.action.details",
                    action: {},
                    isDismissible: true
                )
            }
        }
    }

    private var specsSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.variantes",
                value: "Information · Positive · Warning",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.radius", value: "ZodiakRadii.s", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.side_bar_color", value: "4pt · variant accent", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.dismiss", value: "Optional · isDismissible", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.action", value: "ZodiakTextLink · caption", style: .spec())
        }
    }
}

#Preview { NavigationStack { NotificationBannerGalleryView() } }
