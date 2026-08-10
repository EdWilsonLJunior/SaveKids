import Combine
import SwiftUI

// MARK: - Login State
enum LPLoginState: Equatable {
    case idle
    case loading
    case cpfError
    case passwordError
    case genericError
}

// MARK: - US-30.01 Login ViewModel
final class LPLoginViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.isAuthenticated) var isAuthenticated: Bool = false

    @Published var state: LPLoginState = .idle

    private var loginTask: Task<Void, Never>?

    var cpfDigits: String { "" }

    var isLoading: Bool { state == .loading }

    var errorMessage: String? {
        switch state {
        case .cpfError: return "lp.login.error_cpf"
        case .passwordError: return "lp.login.error_password"
        default: return nil
        }
    }

    /// Chamado pelo `ZodiakLoginForm` via `onLogin` — recebe os valores do formulário.
    func login(identifier: String, password: String) {
        let digits = identifier.filter(\.isNumber)
        guard digits.count == LPConstants.Validation.cpfLength else {
            state = .cpfError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "login", errorKey: "cpfError").emit()
            return
        }
        guard password.count >= LPConstants.Validation.minPasswordLength else {
            state = .passwordError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "login", errorKey: "passwordError").emit()
            return
        }
        state = .loading
        loginTask?.cancel()
        loginTask = Task { @MainActor in
            let span = ZodiakSpan(name: "lp_login", category: .viewModel)
            do {
                try await Task.sleep(for: .milliseconds(800))
                self.isAuthenticated = true
                self.state = .idle
                ZodiakLog.info(.lifecycle, "LP authentication state changed new_state=authenticated",
                               metadata: ["feature": "LoyaltyProgram", "new_state": "authenticated"])
                span.end(status: "ok", metadata: ["feature": "LoyaltyProgram"])
                LPAuditEvent.loginAttempt(success: true).emit()
            } catch {
                ZodiakLog.debug(.viewModel, "LP login task cancelled",
                                metadata: ["feature": "LoyaltyProgram"])
                span.end(status: "cancelled", metadata: ["feature": "LoyaltyProgram"])
            }
        }
    }

    func reset() {
        loginTask?.cancel()
        state = .idle
    }

    deinit { loginTask?.cancel() }
}
