> **Platform**: iOS

# ZodiakLoginForm — `Shared/DesignSystem/Organisms/LoginForm/ZodiakLoginForm.swift`

```swift
struct ZodiakAlternativeLogin: Identifiable {
    let id: UUID; let title: String; let icon: String; let action: () -> Void
    init(id: UUID = UUID(), title: String, icon: String, action: @escaping () -> Void)
}

struct ZodiakLoginConfig {
    var title: String = "shared.action.login"
    var showCreateAccount: Bool = true
    var createAccountAction: (() -> Void)?
    var forgotPasswordAction: (() -> Void)?
    var ssoLabel: String = "Entrar com SSO"
    var ssoAction: (() -> Void)?
    var alternativeLogins: [ZodiakAlternativeLogin] = []
    var progressiveAuth: Bool = false
    init(...)
}

ZodiakLoginForm(
    config: ZodiakLoginConfig,
    initialEmail: String = "",
    initialRememberMe: Bool = false,
    errorMessage: String? = nil,
    isLoading: Bool = false,
    onLogin: @escaping (_ email: String, _ password: String, _ rememberMe: Bool) -> Void
)
```

---
