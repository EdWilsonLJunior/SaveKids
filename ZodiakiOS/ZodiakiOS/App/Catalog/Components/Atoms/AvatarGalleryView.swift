import SwiftUI

struct AvatarGalleryView: View {
    @State private var showSkeleton = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.avatar",
                subtitle: "catalog.avatar.subtitle",
                figmaRef: "catalog.component_name.avatar"
            )

            // MARK: Tamanhos
            gallerySectionCard(title: "catalog.section.tamanhos") {
                    HStack(alignment: .bottom, spacing: ZodiakSpacing.s16) {
                        ForEach([ZodiakAvatarSize.xs, .s, .m, .l, .xl], id: \.diameter) { size in
                            VStack(spacing: ZodiakSpacing.s4) {
                                ZodiakAvatar(initials: "MR", size: size)
                                Text(sizeName(size))
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(ZodiakColors.textSecondary)
                            }
                        }
                    }
            }

            // MARK: Variantes de conteúdo
            gallerySectionCard(title: "catalog.section.variantes_de_conteudo") {
                    HStack(spacing: ZodiakSpacing.s16) {
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakAvatar(initials: "AB", size: .l)
                            Text("catalog.section.initials")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakAvatar(systemImage: "person.fill", size: .l)
                            Text("catalog.avatar.desc_0")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakAvatar(
                                systemImage: "building.2.fill",
                                size: .l,
                                backgroundColor: ZodiakColors.surfaceMarine.opacity(0.15)
                            )
                            Text("catalog.section.company")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }
            }

            // MARK: Status indicator
            gallerySectionCard(title: "catalog.section.status_indicator") {
                    HStack(spacing: ZodiakSpacing.s16) {
                        ForEach([
                            (ZodiakAvatarStatus.online, "catalog.avatar.status.online"),
                            (.away, "catalog.avatar.status.away"),
                            (.doNotDisturb, "catalog.avatar.status.dnd"),
                            (.offline, "catalog.avatar.status.offline")
                        ], id: \.1) { status, label in
                            VStack(spacing: ZodiakSpacing.s4) {
                                ZodiakAvatar(initials: "MR", size: .l, status: status)
                                ZodiakText(label, style: .caption())
                            }
                        }
                    }
            }

            // MARK: Avatar Group
            gallerySectionCard(title: "catalog.section.avatar_group") {
                    Text("catalog.avatar.desc_1")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)
                    ZodiakAvatarGroup(items: ["MR", "AB", "CD", "EF", "GH", "IJ"], max: 4, size: .m)
                    ZodiakAvatarGroup(items: ["MR", "AB", "CD"], max: 4, size: .s)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow("catalog.spec.lbl.xs", value: "catalog.spec.val.24pt_caption_9pt", style: .spec())

                    ZodiakInfoRow("catalog.spec.lbl.s", value: "catalog.spec.val.32pt_caption_12pt", style: .spec())

                    ZodiakInfoRow("catalog.spec.lbl.m", value: "catalog.spec.val.40pt_body_15pt", style: .spec())

                    ZodiakInfoRow("catalog.spec.lbl.l", value: "catalog.spec.val.56pt_title_20pt", style: .spec())

                    ZodiakInfoRow("catalog.spec.lbl.xl", value: "catalog.spec.val.72pt_large_26pt", style: .spec())

                    ZodiakInfoRow(
                        "catalog.spec.lbl.status_dot",
                        value: "catalog.spec.val.30_do_diametro_borda_surface_15pt",
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

                HStack(alignment: .bottom, spacing: ZodiakSpacing.s16) {
                    ForEach([ZodiakAvatarSize.xs, .s, .m, .l, .xl], id: \.diameter) { size in
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakAvatar(initials: "MR", size: size)
                                .zodiakSkeleton(active: showSkeleton)
                            Text(sizeName(size))
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }
                }
            }
        }
        .zodiakPage(title: "catalog.component_name.avatar")
    }

    private func sizeName(_ size: ZodiakAvatarSize) -> String {
        switch size {
        case .xs: return "XS"
        case .s:  return "S"
        case .m:  return "M"
        case .l:  return "L"
        case .xl: return "XL"
        }
    }
}

#Preview { NavigationStack { AvatarGalleryView() } }
