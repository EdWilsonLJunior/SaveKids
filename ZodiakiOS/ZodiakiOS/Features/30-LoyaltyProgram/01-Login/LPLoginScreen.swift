import SwiftUI

// MARK: - US-30.01 Login Screen
struct LPLoginScreen: View {
    @StateObject private var viewModel = LPLoginViewModel()

    private var loginConfig: ZodiakLoginConfig {
        ZodiakLoginConfig(
            title: "lp.login.action_enter",
            showCreateAccount: false,
            identifierField: .cpf
        )
    }

    var body: some View {
        ZodiakActivityTemplate(title: String(localized: "lp.login.title")) {
            if viewModel.state == .genericError {
                ZodiakNotificationBanner(
                    title: String(localized: "lp.login.error_generic_title"),
                    message: String(localized: "lp.login.error_generic"),
                    variant: .warning,
                    isDismissible: true
                )
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            ZodiakLoginForm(
                config: loginConfig,
                onLogin: { identifier, password, _ in
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    viewModel.login(identifier: identifier, password: password)
                },
                errorMessage: viewModel.errorMessage,
                isLoading: viewModel.isLoading
            )
        }
        .navigationTitle(String(localized: "lp.login.title"))
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.state)
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP login screen appeared", metadata: ["feature": "LoyaltyProgram"])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPLogin")
        }
        .onChange(of: viewModel.state) { _, newState in
            switch newState {
            case .cpfError, .passwordError, .genericError:
                UINotificationFeedbackGenerator().notificationOccurred(.error)

            default:
                break
            }
        }
    }
}
