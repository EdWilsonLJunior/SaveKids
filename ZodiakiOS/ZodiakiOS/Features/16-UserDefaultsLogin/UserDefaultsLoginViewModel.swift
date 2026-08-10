import Combine
import SwiftUI

// MARK: - Activity 16: UserDefaults Login

/// ViewModel da Atividade 16 — login com persistência de e-mail via AppStorage.
final class UserDefaultsLoginViewModel: ObservableObject {
    @AppStorage(UserDefaultsLoginConstants.appStorageKeyEmail) var savedEmail: String = ""
    @AppStorage(UserDefaultsLoginConstants.appStorageKeyRemember) var rememberEmail: Bool = false

    @Published var loginSucceeded: Bool = false

    /// Processa o login e persiste (ou limpa) o e-mail conforme o estado de `rememberMe`.
    func login(email: String, password: String, rememberMe: Bool) {
        if rememberMe {
            savedEmail = email
            rememberEmail = true
        } else {
            savedEmail = ""
            rememberEmail = false
        }
        loginSucceeded = true
    }

    func reset() {
        loginSucceeded = false
    }
}
