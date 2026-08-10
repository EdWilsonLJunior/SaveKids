import SwiftUI

// MARK: - Zodiak Login Form
// Figma: "Login form" — standalone login form.
// Supports: email + password, SSO button, alternative logins with show-more, progressive auth.

public struct ZodiakAlternativeLogin: Identifiable {
    public let id: UUID
    public let title: String
    public let icon: String
    public let action: () -> Void

    public init(id: UUID = UUID(), title: String, icon: String, action: @escaping () -> Void) {
        self.id = id
        self.title = title
        self.icon = icon
        self.action = action
    }
}

// MARK: - Identifier Field Variant

/// Define qual campo identificador o formulário usa como primeiro campo.
public enum ZodiakLoginIdentifierField: Equatable {
    /// Campo de e-mail (padrão): teclado `.emailAddress`.
    case email
    /// Campo de CPF: teclado `.numberPad`, máscara XXX.XXX.XXX-XX aplicada automaticamente.
    case cpf
}

/// Configuração do formulário de login: título, ações e opções de acesso.
public struct ZodiakLoginConfig {
    /// Título exibido no topo do formulário.
    public var title: String = "shared.action.login"
    /// Exibe o link \"Criar conta\" quando `true`.
    public var showCreateAccount: Bool = true
    /// Ação executada ao tocar em \"Criar conta\".
    public var createAccountAction: (() -> Void)?
    /// Ação executada ao tocar em \"Esqueci a senha\".
    public var forgotPasswordAction: (() -> Void)?
    /// Rótulo do botão de login SSO.
    public var ssoLabel: String = "Entrar com SSO"
    /// Ação executada ao tocar no botão SSO; `nil` oculta o botão.
    public var ssoAction: (() -> Void)?
    /// Lista de opções alternativas de login (ex.: Google, Apple).
    public var alternativeLogins: [ZodiakAlternativeLogin] = []
    /// Progressive auth: show only email first, then password on confirmation.
    public var progressiveAuth: Bool = false
    /// Campo identificador primário: `.email` (padrão) ou `.cpf` (com máscara automática).
    public var identifierField: ZodiakLoginIdentifierField = .email

    /// Cria uma configuração de login com os valores padrão ou personalizados.
    public init(
        title: String = "shared.action.login",
        showCreateAccount: Bool = true,
        createAccountAction: (() -> Void)? = nil,
        forgotPasswordAction: (() -> Void)? = nil,
        ssoLabel: String = "Entrar com SSO",
        ssoAction: (() -> Void)? = nil,
        alternativeLogins: [ZodiakAlternativeLogin] = [],
        progressiveAuth: Bool = false,
        identifierField: ZodiakLoginIdentifierField = .email
    ) {
        self.title = title
        self.showCreateAccount = showCreateAccount
        self.createAccountAction = createAccountAction
        self.forgotPasswordAction = forgotPasswordAction
        self.ssoLabel = ssoLabel
        self.ssoAction = ssoAction
        self.alternativeLogins = alternativeLogins
        self.progressiveAuth = progressiveAuth
        self.identifierField = identifierField
    }
}

private enum LoginStep { case email, password }

public struct ZodiakLoginForm: View {
    let config: ZodiakLoginConfig
    let onLogin: (_ email: String, _ password: String, _ rememberMe: Bool) -> Void
    var errorMessage: String?
    var isLoading: Bool = false

    private let initialEmail: String
    private let initialRememberMe: Bool

    @State private var email: String
    @State private var password = ""
    @State private var rememberMe: Bool
    @State private var step: LoginStep = .email
    @State private var showAllAlternatives = false

    private let maxVisibleAlternatives = 3

    public init(
        config: ZodiakLoginConfig,
        initialEmail: String = "",
        initialRememberMe: Bool = false,
        onLogin: @escaping (_ email: String, _ password: String, _ rememberMe: Bool) -> Void,
        errorMessage: String? = nil,
        isLoading: Bool = false
    ) {
        self.config = config
        self.initialEmail = initialEmail
        self.initialRememberMe = initialRememberMe
        self.onLogin = onLogin
        self.errorMessage = errorMessage
        self.isLoading = isLoading
        self._email = State(initialValue: initialEmail)
        self._rememberMe = State(initialValue: initialRememberMe)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
            // Title row + create account link
            HStack(alignment: .firstTextBaseline) {
                Text(LocalizedStringKey(config.title))
                    .font(ZodiakTypography.titleMedium)
                    .foregroundColor(ZodiakColors.textPrimary)
                Spacer()
                if config.showCreateAccount, let action = config.createAccountAction {
                    ZodiakTextLink(label: "Criar conta", action: action, showIcon: false)
                }
            }

            // Error banner
            if let msg = errorMessage {
                ZodiakAlert(
                    title: "shared.state.login_failed",
                    message: LocalizedStringKey(msg),
                    variant: .error
                )
            }

            // Identifier field (email or CPF, driven by config.identifierField)
            switch config.identifierField {
            case .email:
                ZodiakTextField(
                    label: "E-mail",
                    placeholder: "seu@email.com",
                    text: $email,
                    keyboardType: .emailAddress,
                    isRequired: true
                )

            case .cpf:
                ZodiakTextField(
                    label: "CPF",
                    placeholder: "000.000.000-00",
                    text: $email,
                    keyboardType: .numberPad,
                    isRequired: true
                )
                .onChange(of: email) { _, newValue in
                    let digits = newValue.filter(\.isNumber)
                    let limited = String(digits.prefix(11))
                    let masked = Self.maskCPF(limited)
                    if masked != newValue { email = masked }
                }
            }

            // Password field — shown immediately or after email step in progressive auth
            if !config.progressiveAuth || step == .password {
                ZodiakPasswordField(
                    label: "Senha",
                    placeholder: "Sua senha",
                    text: $password,
                    isRequired: true
                )

                HStack {
                    ZodiakCheckbox(
                        label: "Lembrar-me",
                        isChecked: $rememberMe,
                        size: .large
                    )
                    Spacer()
                    if let action = config.forgotPasswordAction {
                        ZodiakTextLink(
                            label: "Esqueceu a senha?",
                            action: action,
                            showIcon: false,
                            font: ZodiakTypography.bodySmall
                        )
                    }
                }
            }

            // Primary CTA
            ZodiakButtonPrimary(
                title: isLoading
                    ? "shared.state.logging_in"
                    : LocalizedStringKey(config.title),
                action: handlePrimaryAction,
                isEnabled: !isLoading && isIdentifierValid
                    && (!isPasswordStepRequired || !password.isEmpty)
            )

            // SSO
            if let ssoAction = config.ssoAction {
                ZodiakButtonSecondary(title: LocalizedStringKey(config.ssoLabel), action: ssoAction)
            }

            // Divider + alternative logins
            if !config.alternativeLogins.isEmpty {
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakDivider(hierarchy: .secondary)
                    Text("shared.label.or")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .fixedSize()
                    ZodiakDivider(hierarchy: .secondary)
                }

                let visible = showAllAlternatives
                    ? config.alternativeLogins
                    : Array(config.alternativeLogins.prefix(maxVisibleAlternatives))

                ForEach(visible) { alt in
                    alternativeButton(alt)
                }

                if config.alternativeLogins.count > maxVisibleAlternatives && !showAllAlternatives {
                    Button {
                        withAnimation { showAllAlternatives = true }
                    } label: {
                        HStack(spacing: ZodiakSpacing.s4) {
                            Text("shared.action.more_options")
                                .font(ZodiakTypography.bodySmall)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(ZodiakColors.actionPrimary)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    // MARK: - Private

    private var isPasswordStepRequired: Bool {
        !config.progressiveAuth || step == .password
    }

    private var isIdentifierValid: Bool {
        switch config.identifierField {
        case .email: return !email.trimmingCharacters(in: .whitespaces).isEmpty
        case .cpf: return email.filter(\.isNumber).count == 11
        }
    }

    private static func maskCPF(_ digits: String) -> String {
        var result = ""
        for (i, char) in digits.enumerated() {
            if i == 3 || i == 6 { result += "." }
            if i == 9 { result += "-" }
            result.append(char)
        }
        return result
    }

    private func handlePrimaryAction() {
        if config.progressiveAuth && step == .email {
            withAnimation { step = .password }
        } else {
            onLogin(email, password, rememberMe)
        }
    }

    private func alternativeButton(_ alt: ZodiakAlternativeLogin) -> some View {
        Button(action: alt.action) {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(systemName: alt.icon)
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: 20)
                Text(LocalizedStringKey(alt.title))
                    .font(ZodiakTypography.bodySmall)
            }
            .foregroundColor(ZodiakColors.actionPrimary)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, ZodiakSpacing.s16)
            .frame(height: ZodiakSizing.textFieldHeight)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.xs)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                    .stroke(ZodiakColors.borderPrimary, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text(LocalizedStringKey(alt.title)))
    }
}

// MARK: - Preview

#Preview("Login Form — completo") {
    ScrollView {
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
            onLogin: { _, _, _ in }
        )
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
