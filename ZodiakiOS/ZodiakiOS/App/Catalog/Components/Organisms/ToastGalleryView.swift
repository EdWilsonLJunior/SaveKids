import SwiftUI

struct ToastGalleryView: View {
    @State private var toast: ZodiakToastConfig?

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.toast",
                subtitle: "catalog.toast.subtitle",
                figmaRef: "Toast / Snackbar"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground_dispare_um_toast") {
                    Text("catalog.toast.desc_0")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakLayoutGrid(
                        horizontalSpacing: ZodiakSpacing.s8,
                        verticalSpacing: ZodiakSpacing.s8
                    ) {
                        toastButton("catalog.spec.label_info", .info, "Operação iniciada com sucesso.")
                        toastButton("shared.state.success_label", .success, "Alterações salvas com sucesso!")
                        toastButton("shared.state.warning_label", .warning, "Sua sessão expira em 5 minutos.")
                        toastButton("shared.state.error_label", .error, "Não foi possível conectar ao servidor.")
                    }
            }

            // MARK: Com ação
            gallerySectionCard(title: "catalog.section.toast_com_acao") {
                    Text("catalog.toast.desc_1")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakButtonPrimary(title: "catalog.spec.trigger_toast_action") {
                        toast = ZodiakToastConfig(
                            message: "Item removido da lista.",
                            variant: .info,
                            duration: 4.0,
                            action: ("Desfazer", { toast = nil })
                        )
                    }
            }

            // MARK: Como usar
            gallerySectionCard(title: "catalog.section.como_usar") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        Text("catalog.toast.desc_2")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textPrimary)
                        Text("catalog.toast.desc_3")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textPrimary)
                        Text("catalog.toast.desc_4")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textPrimary)
                    }
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surfaceSmoke)
                    .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.xs, style: .continuous))
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.fundo",
                        value: "catalog.spec.val.surfaceink_com_shadow",
                        style: .spec()
                    )

                    ZodiakInfoRow("catalog.spec.lbl.radius", value: "catalog.spec.val.zodiakradiim", style: .spec())

                    ZodiakInfoRow(
                        "catalog.spec.lbl.duracao",
                        value: "catalog.spec.val.30s_padrao_configuravel",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.entrada",
                        value: "catalog.spec.val.moveedge_bottom_opacity",
                        style: .spec()
                    )

                    ZodiakInfoRow("catalog.spec.lbl.dismiss", value: "catalog.spec.val.auto_botao", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.toast")
        .zodiakToast($toast)
    }

    private func toastButton(_ label: String, _ variant: ZodiakToastVariant, _ message: String) -> some View {
        ZodiakButtonSecondary(title: LocalizedStringKey(label)) {
            toast = ZodiakToastConfig(message: message, variant: variant)
        }
    }
}

#Preview { NavigationStack { ToastGalleryView() } }
