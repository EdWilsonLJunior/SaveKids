import SwiftUI

struct SkeletonLoaderGalleryView: View {
    @State private var showSkeleton = true
    @State private var isSimulating = false

    private let demoCards = ["catalog.spec.design_system", "catalog.spec.tag_ios_dev", "UX Research", "Performance"]
    private let demoAuthors = ["Ana Lima", "Bruno Costa", "Carla Souza", "Diego Faria", "Elena Rocha"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.skeleton_loader",
                subtitle: "catalog.skeleton_loader.subtitle",
                figmaRef: "Skeleton"
            )

            philosophySection
            demoControlSection
            listSection
            cardGridSection
            anyComponentSection
            primitivesSection
            specsSection
        }
        .zodiakPage(title: "catalog.component_name.skeleton_loader")
    }

    // MARK: - Philosophy & Native API

    private var philosophySection: some View {
        gallerySectionCard(title: LocalizedStringKey("catalog.skeletonloader.section.philosophy")) {
            ZodiakAlert(
                title: LocalizedStringKey("catalog.skeletonloader.philosophy_title"),
                message: LocalizedStringKey("catalog.skeletonloader.philosophy_body"),
                variant: .info
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                Text("catalog.skeletonloader.api_example_label")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)

                Text(verbatim: "ZodiakCard(item: item)\n    .zodiakSkeleton(active: isLoading)")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(ZodiakColors.textPrimary)
                    .padding(ZodiakSpacing.s8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ZodiakColors.surfaceSmoke)
                    .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.xs, style: .continuous))
            }
        }
    }

    // MARK: - Demo Controls

    private var demoControlSection: some View {
        gallerySectionCard(title: "catalog.section.demonstracao") {
            Toggle(isOn: $showSkeleton) {
                Text("catalog.skeletonloader.desc_0")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
            }
            .tint(ZodiakColors.actionPrimary)

            ZodiakButtonPrimary(
                title: isSimulating
                    ? LocalizedStringKey("catalog.skeletonloader.simulating")
                    : LocalizedStringKey("catalog.skeletonloader.simulate"),
                action: simulateLoading
            )
            .disabled(isSimulating)
        }
    }

    // MARK: - List Rows

    private var listSection: some View {
        gallerySectionCard(title: "catalog.section.lista_de_registros") {
            VStack(spacing: ZodiakSpacing.s4) {
                ForEach(Array(demoAuthors.enumerated()), id: \.offset) { index, name in
                    ZodiakAuthor(
                        name: name,
                        role: String(localized: "catalog.skeletonloader.desc_1"),
                        avatarInitials: String(name.prefix(2))
                    )
                    .zodiakSkeleton(active: showSkeleton)
                    if index < demoAuthors.count - 1 { ZodiakDivider(hierarchy: .secondary) }
                }
            }
        }
    }

    // MARK: - Card Grid

    private var cardGridSection: some View {
        gallerySectionCard(title: "catalog.section.grid_de_cards") {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: ZodiakSpacing.s8
            ) {
                ForEach(demoCards, id: \.self) { title in
                    ZodiakCard(item: ZodiakCardItem(
                        title: title,
                        subtitle: String(localized: "catalog.skeletonloader.desc_2"),
                        imageName: "star"
                    ))
                    .zodiakSkeleton(active: showSkeleton)
                }
            }
        }
    }

    // MARK: - Works on Any Component

    private var anyComponentSection: some View {
        gallerySectionCard(title: LocalizedStringKey("catalog.skeletonloader.section.any_component")) {
            Text("catalog.skeletonloader.any_component_desc")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakAvatar(initials: "AB", size: .l)
                    .zodiakSkeleton(active: showSkeleton)
                ZodiakAvatar(initials: "MR", size: .l)
                    .zodiakSkeleton(active: showSkeleton)
                ZodiakAvatar(systemImage: "person.fill", size: .l)
                    .zodiakSkeleton(active: showSkeleton)
            }

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakSuccessBadge(text: "catalog.spec.design_system")
                    .zodiakSkeleton(active: showSkeleton)
                ZodiakErrorBadge(text: "catalog.spec.tag_ios_dev")
                    .zodiakSkeleton(active: showSkeleton)
            }

            ZodiakAuthor(name: "Ana Lima", role: "Analista", avatarInitials: "AL")
                .zodiakSkeleton(active: showSkeleton)
        }
    }

    // MARK: - Primitives

    private var primitivesSection: some View {
        gallerySectionCard(title: "catalog.section.primitivos") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                Text(verbatim: "ZodiakSkeletonLine")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakSkeletonLine(height: 14)
                ZodiakSkeletonLine(width: 180, height: 11)
                ZodiakSkeletonLine(width: 120, height: 10)
            }

            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                Text(verbatim: "ZodiakSkeletonCircle")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakSkeletonCircle(diameter: 24)
                    ZodiakSkeletonCircle(diameter: 32)
                    ZodiakSkeletonCircle(diameter: 40)
                    ZodiakSkeletonCircle(diameter: 56)
                }
            }

            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                Text(verbatim: "ZodiakSkeletonRect")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakSkeletonRect(height: 80, cornerRadius: ZodiakRadii.s)
            }
        }
    }

    // MARK: - Specifications

    private var specsSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.api_publica",
                value: "catalog.spec.val.view_zodiakskeleton_active",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.mecanismo",
                value: "catalog.spec.val.redacted_placeholder_shimmer",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.animacao",
                value: "catalog.spec.val.lineargradient_branco_035_deslizando",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.duracao",
                value: "catalog.spec.val.14s_linear_repeatforever",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.cor_base",
                value: "catalog.spec.val.borderprimary",
                style: .spec()
            )

            ZodiakInfoRow(
                "catalog.spec.lbl.primitivos",
                value: "catalog.spec.val.line_circle_rect_para_layouts_customizados",
                style: .spec()
            )
        }
    }

    // MARK: - Actions

    private func simulateLoading() {
        isSimulating = true
        showSkeleton = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation { showSkeleton = false }
            isSimulating = false
        }
    }
}

#Preview { NavigationStack { SkeletonLoaderGalleryView() } }
