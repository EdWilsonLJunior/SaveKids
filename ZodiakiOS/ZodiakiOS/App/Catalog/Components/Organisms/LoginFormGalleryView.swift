import SwiftUI

// MARK: - Login Form Gallery View
// Figma: "Login form"

struct LoginFormGalleryView: View {
    @State private var loginError: String?
    @State private var isLoading = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.login_form",
                subtitle: "catalog.login_form.subtitle",
                figmaRef: "Login form"
            )

            // MARK: Completo
            gallerySectionCard(title: "catalog.section.login_completo") {
                Text("catalog.loginform.desc_0")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                ZodiakLoginForm(
                    config: ZodiakLoginConfig(
                        showCreateAccount: true,
                        createAccountAction: {},
                        forgotPasswordAction: {},
                        ssoAction: {},
                        alternativeLogins: [
                            .init(title: "Continuar com Google", icon: "globe", action: {}),
                            .init(title: "Continuar com Apple", icon: "apple.logo", action: {}),
                            .init(title: "Continuar com Microsoft", icon: "square.grid.2x2", action: {}),
                            .init(title: "Continuar com GitHub", icon: "terminal", action: {})
                        ]
                    ),
                    onLogin: { _, _, _ in
                        isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isLoading = false
                            loginError = String(localized: "catalog.login.error.invalid_credentials")
                        }
                    },
                    errorMessage: loginError,
                    isLoading: isLoading
                )
            }

            // MARK: Simples (sem alternativas)
            gallerySectionCard(title: "catalog.section.login_simples") {
                Text("catalog.loginform.desc_1")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                ZodiakLoginForm(
                    config: ZodiakLoginConfig(
                        showCreateAccount: false,
                        forgotPasswordAction: {}
                    ),
                    onLogin: { _, _, _ in }
                )
            }

            // MARK: Auth progressiva
            gallerySectionCard(title: "catalog.section.auth_progressiva") {
                Text("catalog.loginform.desc_2")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                ZodiakLoginForm(
                    config: ZodiakLoginConfig(
                        showCreateAccount: true,
                        createAccountAction: {},
                        forgotPasswordAction: {},
                        progressiveAuth: true
                    ),
                    onLogin: { _, _, _ in }
                )
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow("catalog.spec.lbl.componente", value: "catalog.spec.val.zodiakloginform", style: .spec())

                ZodiakInfoRow("catalog.spec.lbl.config", value: "catalog.spec.val.zodiakloginconfig", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.onlogin",
                    value: "catalog.spec.val.email_password_rememberme_void",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.errormessage",
                    value: "catalog.spec.val.string_zodiakalert_inline",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.isloading",
                    value: "catalog.spec.val.bool_desabilita_cta_label_entrando",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.progressiveauth",
                    value: "catalog.spec.val.bool_exibe_apenas_email_ate_confirmacao",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.ssoaction",
                    value: "catalog.spec.val.void_nil_oculta_secao_sso",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.show_more_1",
                    value: "catalog.spec.val.ativo_quando_alternativeloginscount_3",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.zodiak_ds",
                    value: "catalog.spec.val.utilities_login_form",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component_name.login_form")
    }
}

#Preview {
    NavigationStack {
        LoginFormGalleryView()
    }
}
