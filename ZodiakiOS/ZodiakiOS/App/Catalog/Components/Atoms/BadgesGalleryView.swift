import SwiftUI

// MARK: - Badges Gallery View

struct BadgesGalleryView: View {
    @State private var badgeText = "Status"
    @State private var showSkeleton = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.badges",
                subtitle: "catalog.badges.subtitle",
                figmaRef: nil
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground") {
            ZodiakFormWrapper {
                ZodiakTextField(
                    label: "Texto do badge",
                    placeholder: "Status",
                    text: $badgeText
                )
            }
            let label: LocalizedStringKey = badgeText.isEmpty
                ? "catalog.spec.badge_default"
                : LocalizedStringKey(badgeText)
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakSuccessBadge(text: label)
                ZodiakErrorBadge(text: label)
                ZodiakWarningBadge(text: label)
            }
            }
            variantsSection
            usageSection

            gallerySectionCard(title: LocalizedStringKey("catalog.skeletonloader.section.loading_state")) {
                Toggle(isOn: $showSkeleton) {
                    Text("catalog.skeletonloader.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
                .tint(ZodiakColors.actionPrimary)

                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakSuccessBadge(text: "shared.state.passed")
                        .zodiakSkeleton(active: showSkeleton)
                    ZodiakErrorBadge(text: "shared.state.failed")
                        .zodiakSkeleton(active: showSkeleton)
                    ZodiakWarningBadge(text: "shared.state.attention")
                        .zodiakSkeleton(active: showSkeleton)
                }
            }
        }
        .zodiakPage(title: "catalog.component_name.badges")
    }
    private var variantsSection: some View {
        gallerySectionCard(title: "catalog.section.variantes") {
            VStack(spacing: ZodiakSpacing.s8) {
                badgeCard(
                    name: "catalog.spec.label_success",
                    component: "ZodiakSuccessBadge",
                    usage: "catalog.badge.spec.success_usage",
                    badge: AnyView(ZodiakSuccessBadge(text: "shared.state.passed_decorated"))
                )
                badgeCard(
                    name: "catalog.spec.label_error",
                    component: "ZodiakErrorBadge",
                    usage: "catalog.badge.spec.error_usage",
                    badge: AnyView(ZodiakErrorBadge(text: "shared.state.failed_decorated"))
                )
                badgeCard(
                    name: "catalog.spec.label_warning",
                    component: "ZodiakWarningBadge",
                    usage: "catalog.badge.spec.warning_usage",
                    badge: AnyView(ZodiakWarningBadge(text: "catalog.spec.warning_badge"))
                )
                badgeCard(
                    name: "Generic",
                    component: "ZodiakBadge",
                    usage: "catalog.badge.spec.custom_usage",
                    badge: AnyView(HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakBadge(
                            text: "catalog.spec.color_azure",
                            backgroundColor: ZodiakColors.surfaceAzur,
                            foregroundColor: .white
                        )
                        ZodiakBadge(
                            text: "catalog.spec.color_marine",
                            backgroundColor: ZodiakColors.surfaceMarine,
                            foregroundColor: .white
                        )
                        ZodiakBadge(
                            text: "catalog.spec.color_ink",
                            backgroundColor: ZodiakColors.surfaceInk,
                            foregroundColor: .white
                        )
                    })
                )
            }
        }
    }

    private func badgeCard(name: String, component: String, usage: String, badge: AnyView) -> some View {
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
            badge
            Text(usage)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    private var usageSection: some View {
        gallerySectionCard(title: "catalog.section.combinacoes_de_uso") {
            VStack(spacing: ZodiakSpacing.s8) {
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakSuccessBadge(text: "shared.state.passed_decorated")
                    ZodiakErrorBadge(text: "shared.state.failed_decorated")
                    ZodiakWarningBadge(text: "catalog.spec.runoff_badge")
                }
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakBadge(
                        text: "shared.state.new_badge",
                        backgroundColor: ZodiakColors.brand,
                        foregroundColor: .white
                    )
                    ZodiakBadge(
                        text: "shared.state.in_progress",
                        backgroundColor: ZodiakColors.surfaceMarine,
                        foregroundColor: .white
                    )
                    ZodiakBadge(
                        text: "shared.state.completed",
                        backgroundColor: ZodiakColors.surfacePositive,
                        foregroundColor: ZodiakColors.textPrimary
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BadgesGalleryView()
    }
}
