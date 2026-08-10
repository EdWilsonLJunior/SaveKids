import SwiftUI

struct ProgressIndicatorGalleryView: View {
    @State private var progress = 0.65
    @State private var isAnimating = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.progress_indicator",
                subtitle: "catalog.progress_indicator.subtitle",
                figmaRef: "Progress"
            )

            // MARK: Playground
            gallerySectionCard(title: LocalizedStringKey(String(
                format: String(localized: "shared.format.playground_percent"),
                Int(progress * 100)))) {
                    Slider(value: $progress, in: 0...1)
                        .tint(ZodiakColors.actionPrimary)

                    ZodiakProgressBar(progress: progress, showLabel: true)

                    HStack(spacing: ZodiakSpacing.s32) {
                        ZodiakProgressRing(progress: progress, size: 64, showLabel: true)
                        ZodiakProgressRing(
                            progress: progress,
                            size: 48,
                            color: ZodiakColors.actionWarning,
                            showLabel: false
                        )
                        ZodiakProgressRing(
                            progress: progress,
                            size: 80,
                            color: Color(red: 0.13, green: 0.72, blue: 0.49),
                            showLabel: true
                        )
                    }
                    .frame(maxWidth: .infinity)
            }

            // MARK: Cores
            gallerySectionCard(title: "catalog.section.variantes_de_cor") {
                    colorRow("Brand (default)", ZodiakColors.actionPrimary, progress: 0.75)
                    colorRow("catalog.spec.label_success", Color(red: 0.13, green: 0.72, blue: 0.49), progress: 0.92)
                    colorRow("Warning", Color(red: 0.95, green: 0.60, blue: 0.10), progress: 0.45)
                    colorRow("catalog.spec.label_error", ZodiakColors.actionWarning, progress: 0.25)
            }

            // MARK: Spinner indeterminado
            gallerySectionCard(title: "catalog.section.spinner_indeterminado") {
                    Text("catalog.progressindicator.desc_0")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                    HStack(spacing: ZodiakSpacing.s40) {
                        ZodiakSpinner(size: 20)
                        ZodiakSpinner(size: 32)
                        ZodiakSpinner(size: 48)
                        ZodiakSpinner(size: 24, color: ZodiakColors.actionWarning)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, ZodiakSpacing.s4)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.bar_height",
                        value: "catalog.spec.val.6pt_cornerradius_full",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.ring_strokestyle",
                        value: "catalog.spec.val.linecap_round",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.springresponse_05_dampingfraction_085",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.spinner",
                        value: "catalog.spec.val.linear_09s_repeatforever",
                        style: .spec()
                    )
            }

            // MARK: Accessibility
            gallerySectionCard(title: "Accessibility") {
                    ZodiakInfoRow(
                        "Bar / Ring label",
                        value: "\"Progress\" (shared.label.progress) + value \"NN%\"",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Spinner label",
                        value: "\"Loading\" (shared.state.loading)",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Trait",
                        value: "catalog.progress.spec.a11y_value",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Identifier",
                        value: "zodiak.progress.<bar|ring|spinner>",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.progress_indicator")
    }

    private func colorRow(_ name: String, _ color: Color, progress: Double) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(LocalizedStringKey(name))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
            ZodiakProgressBar(progress: progress, color: color, showLabel: true)
        }
    }
}

#Preview { NavigationStack { ProgressIndicatorGalleryView() } }
