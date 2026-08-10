import SwiftUI

// MARK: - Radii Gallery View

struct RadiiGalleryView: View {
    @State private var previewRadius: CGFloat = ZodiakRadii.s

    private let radii: [(name: String, value: CGFloat, useCase: String)] = [
        ("xs", ZodiakRadii.xs, "catalog.radii.xs_desc"),
        ("s", ZodiakRadii.s, "catalog.radii.m_desc"),
        ("m", ZodiakRadii.m, "catalog.radii.xl_desc"),
        ("l", ZodiakRadii.l, "catalog.radii.pill_desc")
    ]

    private let radiiContexts: [(element: String, token: String, value: CGFloat)] = [
        ("catalog.radii.ctx.badge", "xs", ZodiakRadii.xs),
        ("catalog.radii.ctx.card", "s", ZodiakRadii.s),
        ("catalog.radii.ctx.modal", "m", ZodiakRadii.m),
        ("catalog.radii.ctx.button", "l", ZodiakRadii.l)
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.radii_shadows",
                subtitle: "catalog.radii.token_count_desc",
                figmaRef: "Radii"
            )
            gallerySectionCard(title: "catalog.radii.corner_radius") {
                ZodiakLayoutGrid(
                    horizontalSpacing: ZodiakSpacing.s8,
                    verticalSpacing: ZodiakSpacing.s8
                ) {
                    ForEach(radii, id: \.name) { token in
                        radiusCard(token)
                    }
                }
            }
            gallerySectionCard(title: "catalog.radii.in_context") {
                ZodiakLayoutGrid(
                    columns: 2,
                    horizontalSpacing: ZodiakSpacing.s8,
                    verticalSpacing: ZodiakSpacing.s8
                ) {
                    ForEach(radiiContexts, id: \.token) { ctx in
                        radiiContextCard(ctx)
                    }
                }
            }
            gallerySectionCard(title: "catalog.section.playground") {
                VStack(spacing: ZodiakSpacing.s8) {
                    HStack {
                        ZodiakText("catalog.radii.corner_radius", style: .body(color: .secondary))
                        Spacer()
                        Text(verbatim: "\(Int(previewRadius))pt")
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.actionPrimary)
                    }
                    Slider(value: $previewRadius, in: 0...64, step: 1)
                        .tint(ZodiakColors.actionPrimary)
                    RoundedRectangle(cornerRadius: previewRadius)
                        .fill(ZodiakColors.actionPrimary.opacity(0.12))
                        .overlay(
                            RoundedRectangle(cornerRadius: previewRadius)
                                .stroke(ZodiakColors.actionPrimary, lineWidth: 2)
                        )
                        .frame(height: 80)
                        .animation(.easeInOut(duration: 0.2), value: previewRadius)
                }
            }
        }
        .zodiakPage(title: "catalog.component.radii_shadows")
    }
}

// MARK: - RadiiGalleryView Helpers

private extension RadiiGalleryView {
    // MARK: - Radius Card

    func radiusCard(_ token: (name: String, value: CGFloat, useCase: String)) -> some View {
        VStack(spacing: ZodiakSpacing.s8) {
            RoundedRectangle(cornerRadius: min(token.value, 40))
                .fill(ZodiakColors.actionPrimary.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: min(token.value, 40))
                        .stroke(ZodiakColors.actionPrimary, lineWidth: 1.5)
                )
                .frame(height: 64)
            VStack(spacing: 2) {
                Text(verbatim: "ZodiakRadii.\(token.name)")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(LocalizedStringKey(token.useCase))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    // MARK: - Radii Context Card

    func radiiContextCard(
        _ ctx: (element: String, token: String, value: CGFloat)
    ) -> some View {
        VStack(spacing: ZodiakSpacing.s8) {
            ZStack {
                RoundedRectangle(cornerRadius: min(ctx.value, 26))
                    .fill(ZodiakColors.surfaceSmoke)
                    .overlay(
                        RoundedRectangle(cornerRadius: min(ctx.value, 26))
                            .stroke(ZodiakColors.borderPrimary, lineWidth: 1.5)
                    )
                Text(LocalizedStringKey(ctx.element))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
            .frame(height: 52)
            Text(verbatim: "ZodiakRadii.\(ctx.token)")
                .font(ZodiakTypography.bodySmall)
                .foregroundColor(ZodiakColors.actionPrimary)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    // MARK: - Shadow Static Card
}

#Preview {
    NavigationStack {
        RadiiGalleryView()
    }
}
