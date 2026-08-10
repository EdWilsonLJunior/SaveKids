import SwiftUI

// MARK: - Download Button Gallery View
// Figma: "Download"

struct DownloadButtonGalleryView: View {
    @State private var showSkeleton = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.download_button",
                subtitle: "catalog.download_button.subtitle",
                figmaRef: "Download"
            )

            // MARK: Opção única
            gallerySectionCard(title: "catalog.section.opcao_unica_download_direto") {
                    Text("catalog.downloadbutton.desc_0")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakDownloadButton(
                            options: [.init(title: "catalog.download.item.pdf_title", icon: "doc.richtext", onTap: {})],
                            label: "catalog.download.label.pdf"
                        )
                        ZodiakDownloadButton(
                            options: [.init(title: "catalog.download.item.sheet_title", icon: "tablecells", onTap: {})],
                            label: "catalog.download.label.excel"
                        )
                    }
            }

            // MARK: Múltiplas opções
            gallerySectionCard(title: "catalog.section.multiplas_opcoes_abre_bottom_sheet") {
                    Text("catalog.downloadbutton.desc_1")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    ZodiakDownloadButton(
                        options: [
                            .init(
                                title: "catalog.spec.format_pdf",
                                subtitle: "catalog.download.item.pdf_report",
                                icon: "doc.richtext",
                                onTap: {}
                            ),
                            .init(
                                title: "catalog.spec.format_excel",
                                subtitle: "catalog.download.item.excel_data",
                                icon: "tablecells",
                                onTap: {}
                            ),
                            .init(
                                title: "catalog.spec.format_csv",
                                subtitle: "catalog.download.item.csv",
                                icon: "doc.plaintext",
                                onTap: {}
                            ),
                            .init(
                                title: "JSON",
                                subtitle: "catalog.download.item.json",
                                icon: "curlybraces",
                                onTap: {}
                            )
                        ],
                        label: "catalog.download.label.export"
                    )

                    ZodiakDownloadButton(
                        options: [
                            .init(
                                title: "catalog.download.item.hires",
                                subtitle: "PNG · 12 MB",
                                icon: "photo",
                                onTap: {}
                            ),
                            .init(
                                title: "catalog.download.item.web",
                                subtitle: "JPEG · 2.1 MB",
                                icon: "photo.badge.checkmark",
                                onTap: {}
                            ),
                            .init(
                                title: "catalog.download.item.thumb",
                                subtitle: "JPEG · 180 KB",
                                icon: "photo.badge.arrow.down",
                                onTap: {}
                            )
                        ],
                        label: "catalog.download.label.image"
                    )
            }

            // MARK: Desabilitado
            gallerySectionCard(title: "catalog.section.desabilitado") {
                    ZodiakDownloadButton(
                        options: [.init(title: "catalog.spec.format_pdf", onTap: {})],
                        label: "catalog.download.label.unavailable",
                        isEnabled: false
                    )
            }

            // MARK: Contextos de uso
            gallerySectionCard(title: "catalog.section.contextos_de_uso") {
                    usageRow(
                        "catalog.download.usage.reports_title",
                        "catalog.download.usage.reports_desc",
                        "chart.bar.doc.horizontal"
                    )

                    usageRow(
                        "catalog.download.usage.images_title",
                        "catalog.download.usage.images_desc",
                        "photo.on.rectangle"
                    )

                    usageRow("Documentos legais", "Contratos, anexos, termos", "doc.text")

                    usageRow("Dados exportados", "Exports de sistemas CRM/ERP", "arrow.down.doc")
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.forma",
                        value: "catalog.spec.val.pill_com_borda_actionprimary_secondary_s",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.icone_leading",
                        value: "catalog.spec.val.arrowdowncircle_16pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.chevron",
                        value: "catalog.spec.val.aparece_quando_optionscount_1",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.sheet",
                        value: "catalog.spec.val.presentationdetent_fraction045_medium",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.sheet_itens",
                        value: "catalog.spec.val.zodiakdownloadoption_title_subtitle_icon",
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

                ZodiakDownloadButton(
                    options: [ZodiakDownloadOption(title: "catalog.spec.format_pdf")],
                    label: "Download"
                )
                .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.component.download_button")
    }

    private func usageRow(_ title: String, _ desc: String, _ icon: String) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Image(systemName: icon).font(.system(size: 14)).foregroundColor(ZodiakColors.actionPrimary).frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizedStringKey(title))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(LocalizedStringKey(desc))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }
}

#Preview { NavigationStack { DownloadButtonGalleryView() } }
