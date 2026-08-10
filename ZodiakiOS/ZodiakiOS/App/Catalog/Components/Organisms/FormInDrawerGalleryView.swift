import SwiftUI

// MARK: - Form In Drawer Gallery View
// Figma: "Form in drawer"

struct FormInDrawerGalleryView: View {
    @State private var isPresented = false
    @State private var drawerState = ZodiakFormDrawerState.idle
    @State private var errorPresented = false
    @State private var errorState = ZodiakFormDrawerState.error("catalog.formindrawer.error.send_failed")
    @State private var name = ""
    @State private var email = ""
    @State private var company = ""
    @State private var selectedDate: String?

    private let dates = [
        "catalog.formindrawer.date.mon",
        "catalog.formindrawer.date.tue",
        "catalog.formindrawer.date.wed",
        "catalog.formindrawer.date.thu"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.form_in_drawer",
                subtitle: "catalog.form_in_drawer.subtitle",
                figmaRef: "Form in drawer"
            )

            // MARK: Demo principal
            gallerySectionCard(title: "catalog.section.demo_agendar_reuniao") {
                Text("catalog.formindrawer.desc_0")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                ZodiakButtonPrimary(title: "shared.action.schedule_meeting", action: {
                    name = ""; email = ""; company = ""; selectedDate = nil
                    drawerState = .idle
                    isPresented = true
                })
            }

            // MARK: Estado de erro
            gallerySectionCard(title: "catalog.section.estado_de_erro") {
                Text("catalog.formindrawer.desc_1")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                ZodiakButtonSecondary(title: "catalog.spec.open_with_error", action: {
                    name = "João Silva"; email = "joao@empresa.com"; company = ""
                    drawerState = .error("catalog.formindrawer.error.send_failed")
                    isPresented = true
                })
            }

            // MARK: Sem compliance
            gallerySectionCard(title: "catalog.section.sem_checkbox_de_compliance") {
                ZodiakButtonTertiary(title: "catalog.spec.open_no_compliance", action: {
                    name = ""; email = ""
                    drawerState = .idle
                    isPresented = true
                })
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.componente",
                    value: "catalog.spec.val.zodiakformindrawercontent",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.title",
                    value: "catalog.spec.val.string_headline_do_drawer",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.introtext",
                    value: "catalog.spec.val.string_texto_introdutorio_opcional",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.imagesystemname",
                    value: "catalog.spec.val.string_icone_decorativo_no_header",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.submitlabel",
                    value: "catalog.spec.val.string_label_do_botao_de_submit",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.ispresented", value: "catalog.spec.val.bindingbool", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.state",
                    value: "catalog.spec.val.bindingzodiakformdrawerstate",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.requirescompliance",
                    value: "catalog.spec.val.bool_exibe_checkbox_gdpr_padrao_true",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.estados",
                    value: "catalog.spec.val.idle_submitting_success_errorstring",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.animacao",
                    value: "catalog.spec.val.spring_trailing_leading_overlay_fade",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.zodiak_ds",
                    value: "catalog.spec.val.utilities_form_in_drawer",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component_name.form_in_drawer")
        // Drawer overlay — attached to root ZStack to cover whole screen
        .overlay(alignment: .trailing) {
            ZodiakFormInDrawer(
                title: "shared.action.schedule_meeting",
                introText: "catalog.formindrawer.intro_text",
                imageSystemName: "calendar",
                submitLabel: "Agendar",
                isPresented: $isPresented,
                state: $drawerState,
                onSubmit: {
                    drawerState = .submitting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        drawerState = .success
                    }
                },
                content: {
                    ZodiakTextField(label: "Nome completo", placeholder: "Seu nome", text: $name, isRequired: true)
                    ZodiakTextField(
                        label: "E-mail corporativo",
                        placeholder: "nome@empresa.com",
                        text: $email,
                        keyboardType: .emailAddress,
                        isRequired: true
                    )
                    ZodiakTextField(label: "catalog.section.company", placeholder: "Nome da empresa", text: $company)
                    ZodiakDropdown(
                        label: "Data preferida",
                        selection: $selectedDate,
                        options: dates.map { (value: $0, label: $0) }
                    )
                }
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        FormInDrawerGalleryView()
    }
}
