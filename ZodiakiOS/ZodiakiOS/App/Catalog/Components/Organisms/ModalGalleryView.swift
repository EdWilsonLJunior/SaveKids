import SwiftUI

// MARK: - Modal Gallery View
// Figma: "catalog.component_name.modal" + "Form in drawer" (iOS: bottom sheet)

struct ModalGalleryView: View {
    @State private var showBasicModal = false
    @State private var showTitledModal = false
    @State private var showConfirmModal = false
    @State private var showBottomSheet = false
    @State private var bottomSheetTitle = ""

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.modal",
                subtitle: "catalog.modal.subtitle",
                figmaRef: "Modal, Form in drawer"
            )

            // MARK: Modal demos
            gallerySectionCard(title: "catalog.section.modal_overlay_centralizado") {
                    Text("catalog.modal.desc_0")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    VStack(spacing: ZodiakSpacing.s8) {
                        ZodiakButtonPrimary(
                            title: "catalog.spec.open_simple_modal",
                            action: { showBasicModal = true }
                        )
                        ZodiakButtonSecondary(
                            title: "catalog.spec.modal_with_title",
                            action: { showTitledModal = true }
                        )
                        ZodiakDangerButton(
                            title: "catalog.spec.modal_confirm",
                            action: { showConfirmModal = true }
                        )
                    }
            }

            // MARK: Bottom Sheet demos
            gallerySectionCard(title: "catalog.section.bottom_sheet_form_in_drawer") {
                    Text("catalog.modal.desc_1")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    ZodiakButtonPrimary(title: "catalog.spec.open_bottom_sheet", action: { showBottomSheet = true })
            }

            // MARK: Uso com ViewModifier
            gallerySectionCard(title: "catalog.section.api_viewmodifier") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        Text("catalog.modal.desc_2")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .monospaced()
                    }
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surfaceSmoke)
                    .cornerRadius(ZodiakRadii.xs)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.backdrop",
                        value: "catalog.spec.val.colorblackopacity05",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.card_radius",
                        value: "catalog.spec.val.zodiakradiim_32pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.padding_h",
                        value: "catalog.spec.val.zodiakspacingxs_16pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.springresponse_03_damping_08_scale_opaci",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.bottom_sheet",
                        value: "catalog.spec.val.presentationdetents_medium_large",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.fechar",
                        value: "catalog.spec.val.tap_backdrop_botao_x_drag_down",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.modal")
        // Basic modal
        .zodiakModal(isPresented: $showBasicModal, showCloseButton: true) {
            Text("catalog.modal.desc_3")
                .font(ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textSecondary)
        }
        // Titled modal
        .zodiakModal(isPresented: $showTitledModal, title: "catalog.modal.demo.info_title", showCloseButton: true) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                Text("catalog.modal.desc_4")
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakButtonPrimary(title: "shared.action.understood", action: { showTitledModal = false })
            }
        }
        // Confirm modal
        .zodiakModal(isPresented: $showConfirmModal, title: "catalog.modal.demo.delete_title", showCloseButton: false) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                Text("catalog.modal.desc_5")
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(ZodiakColors.textSecondary)
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakButtonSecondary(title: "shared.action.cancel", action: { showConfirmModal = false })
                    ZodiakDangerButton(title: "shared.action.delete", action: { showConfirmModal = false })
                }
            }
        }
        // Bottom sheet
        .background(
            ZodiakBottomSheet(
                isPresented: $showBottomSheet,
                title: "catalog.modal.demo.form_title",
                detents: [.medium, .large]
            ) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    ZodiakTextField(
                        label: "shared.label.name",
                        placeholder: "shared.placeholder.name",
                        text: $bottomSheetTitle)
                    ZodiakPasswordField(label: "Senha", placeholder: "shared.placeholder.password", text: .constant(""))
                    ZodiakPhoneInput(label: "Telefone", phoneNumber: .constant(""))
                    Spacer()
                    ZodiakButtonPrimary(title: "shared.action.save", action: { showBottomSheet = false })
                }
                .padding(ZodiakSpacing.s16)
            }
        )
    }
}

#Preview { NavigationStack { ModalGalleryView() } }
