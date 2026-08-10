import SwiftUI

struct BannerGalleryView: View {
    @State private var showSkeleton = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.banner",
                subtitle: "catalog.banner.subtitle",
                figmaRef: "catalog.component_name.banner"
            )

            // MARK: Variantes
            gallerySectionCard(title: "catalog.section.variantes") {
                    ZodiakBanner(message: "catalog.banner.msg.new_feature", variant: .brand)
                    ZodiakBanner(
                        message: "catalog.banner.msg.maintenance",
                        variant: .info
                    )
                    ZodiakBanner(message: "catalog.banner.msg.sync_success", variant: .success)
                    ZodiakBanner(
                        message: "catalog.banner.msg.subscription",
                        variant: .warning
                    )
                    ZodiakBanner(message: "catalog.banner.msg.auth_failed", variant: .error)
            }

            // MARK: Com CTA
            gallerySectionCard(title: "catalog.section.com_botao_de_acao_cta") {
                    ZodiakBanner(
                        message: "catalog.banner.msg.new_version",
                        variant: .info,
                        cta: ("catalog.banner.cta.changelog", {})
                    )
                    ZodiakBanner(
                        message: "catalog.banner.msg.pro_expiry",
                        variant: .warning,
                        cta: ("catalog.banner.cta.renew", {})
                    )
            }

            // MARK: Descartável
            gallerySectionCard(title: "catalog.section.descartavel_isdismissible") {
                    Text("catalog.banner.desc_0")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakBanner(
                        message: "catalog.banner.msg.cookies",
                        variant: .brand,
                        cta: ("catalog.banner.cta.accept", {}),
                        isDismissible: true
                    )
                    ZodiakBanner(
                        message: "catalog.banner.msg.required",
                        variant: .warning,
                        isDismissible: true
                    )
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.altura",
                        value: "catalog.spec.val.adaptativa_wraps_2_linhas",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.padding_h",
                        value: "catalog.spec.val.zodiakspacingxs_16pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.padding_v",
                        value: "catalog.spec.val.zodiakspacing_2xs_8pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.cta_borda",
                        value: "catalog.spec.val.whiteopacity05_radius_xs",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.transicao",
                        value: "catalog.spec.val.moveedge_top_opacity",
                        style: .spec()
                    )
            }

            gallerySectionCard(title: LocalizedStringKey("catalog.skeletonloader.section.loading_state")) {
                Toggle(isOn: $showSkeleton) {
                    Text("catalog.skeletonloader.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
                .tint(ZodiakColors.actionPrimary)

                ZodiakBanner(message: "catalog.banner.demo.brand", variant: .brand)
                    .zodiakSkeleton(active: showSkeleton)

                ZodiakBanner(message: "catalog.banner.demo.success", variant: .success)
                    .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.component_name.banner")
    }
}

#Preview { NavigationStack { BannerGalleryView() } }
