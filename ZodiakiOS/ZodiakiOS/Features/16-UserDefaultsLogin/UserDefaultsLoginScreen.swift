import SwiftUI

// MARK: - UserDefaults Login Screen

struct UserDefaultsLoginScreen: View {
    @StateObject private var viewModel = UserDefaultsLoginViewModel()

    var body: some View {
        ZodiakAdaptiveTemplate(
            title: "feature.userdefaults_login.title",
            eyebrow: "feature.userdefaults_login.eyebrow",
            intro: "feature.userdefaults_login.intro"
        ) {
            Group {
                if viewModel.loginSucceeded {
                    successCard
                        .transition(.opacity.combined(with: .scale(0.96, anchor: .top)))
                } else {
                    loginForm
                        .transition(.opacity)
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.loginSucceeded)
        }
        .accessibilityIdentifier("screen.16.user_defaults_login")
    }

    // MARK: - Private

    private var loginForm: some View {
        ZodiakLoginForm(
            config: ZodiakLoginConfig(
                title: "feature.userdefaults_login.button.login",
                showCreateAccount: false
            ),
            initialEmail: viewModel.savedEmail,
            initialRememberMe: viewModel.rememberEmail,
            onLogin: viewModel.login
        )
    }

    private var successCard: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            ZodiakResultCard(
                title: "feature.userdefaults_login.success",
                value: viewModel.savedEmail.isEmpty
                    ? String(localized: "feature.userdefaults_login.email_not_saved")
                    : viewModel.savedEmail,
                subtitle: nil
            )
            ZodiakButtonSecondary(title: "shared.action.clear", action: viewModel.reset)
        }
    }
}

#Preview {
    UserDefaultsLoginScreen()
}
