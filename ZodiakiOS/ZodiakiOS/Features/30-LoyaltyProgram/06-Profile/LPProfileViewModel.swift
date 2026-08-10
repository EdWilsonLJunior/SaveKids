import Combine
import SwiftUI

// MARK: - Profile State
enum LPProfileState: Equatable {
    case idle
    case dirty
    case saving
    case success
    case emailError
    case nameError
}

// MARK: - US-30.06 Profile ViewModel
final class LPProfileViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.isAuthenticated) private var isAuthenticated: Bool = false
    @AppStorage(LPConstants.Storage.points) private var points: Int = LPConstants.Defaults.initialPoints
    @AppStorage(LPConstants.Storage.statement) private var statementData: Data = Data()
    @AppStorage(LPConstants.Storage.profile) var profileData: Data = Data()

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var emailNotifications: Bool = true
    @Published var pushNotifications: Bool = true
    @Published var state: LPProfileState = .idle
    @Published var showDiscardModal: Bool = false

    private var savedName: String = ""
    private var savedEmail: String = ""
    private var savedEmailNotif: Bool = true
    private var savedPushNotif: Bool = true
    private let processingDelay: Duration

    init(processingDelay: Duration = .milliseconds(300)) {
        self.processingDelay = processingDelay
        loadProfile()
    }

    func loadProfile() {
        guard let profile = try? JSONDecoder().decode(LPProfile.self, from: profileData) else {
            return
        }
        name = profile.name
        email = profile.email
        emailNotifications = profile.emailNotifications
        pushNotifications = profile.pushNotifications
        savedName = profile.name
        savedEmail = profile.email
        savedEmailNotif = profile.emailNotifications
        savedPushNotif = profile.pushNotifications
    }

    var hasChanges: Bool {
        name != savedName || email != savedEmail
            || emailNotifications != savedEmailNotif
            || pushNotifications != savedPushNotif
    }

    func save() async {
        guard validateName() else { return }
        guard validateEmail() else { return }
        state = .saving

        // Determine changed fields before persisting (names only — never values)
        var changedFields: [String] = []
        if name != savedName { changedFields.append("name") }
        if email != savedEmail { changedFields.append("email") }
        if emailNotifications != savedEmailNotif { changedFields.append("email_notifications") }
        if pushNotifications != savedPushNotif { changedFields.append("push_notifications") }

        // Simula persistência assíncrona (em produção: chamada de rede/banco)
        try? await Task.sleep(for: processingDelay)
        let profile = LPProfile(
            name: name,
            email: email,
            emailNotifications: emailNotifications,
            pushNotifications: pushNotifications
        )
        if let encoded = try? JSONEncoder().encode(profile) {
            profileData = encoded
        }
        savedName = name
        savedEmail = email
        savedEmailNotif = emailNotifications
        savedPushNotif = pushNotifications
        state = .success

        LPAuditEvent.profileSaved(fieldsChanged: changedFields).emit()
    }

    func requestDiscard() {
        if hasChanges {
            showDiscardModal = true
        }
    }

    func confirmDiscard() {
        name = savedName
        email = savedEmail
        emailNotifications = savedEmailNotif
        pushNotifications = savedPushNotif
        state = .idle
        showDiscardModal = false
    }

    func reset() {
        state = .idle
        showDiscardModal = false
    }

    private func validateName() -> Bool {
        if name.trimmingCharacters(in: .whitespaces).count < 2 {
            state = .nameError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "profile_save", errorKey: "nameError").emit()
            return false
        }
        return true
    }

    private func validateEmail() -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let valid = email.range(of: emailRegex, options: .regularExpression) != nil
        if !valid {
            state = .emailError
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "profile_save", errorKey: "emailError").emit()
            return false
        }
        return true
    }

    var nameError: LocalizedStringKey? {
        state == .nameError ? LocalizedStringKey("lp.profile.error_name") : nil
    }

    var emailError: LocalizedStringKey? {
        state == .emailError ? LocalizedStringKey("lp.profile.error_email") : nil
    }

    var isSaving: Bool { state == .saving }

    // MARK: - Logout

    func logout() {
        LPAuditEvent.sessionEnded.emit()
        points = LPConstants.Defaults.initialPoints
        statementData = Data()
        profileData = Data()
        isAuthenticated = false
    }
}
