import Combine
import OSLog
import SwiftUI

// MARK: - Email Validation

/// Validates that a string matches a standard e-mail address format.
///
/// - Parameter email: The address to check.
/// - Returns: `true` when the address is syntactically valid.
private func isValidEmail(_ email: String) -> Bool {
    let pattern = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
    return email.range(of: pattern, options: .regularExpression) != nil
}

// MARK: - Activity 27: ContactsCRUD — Form ViewModel

/// Closure type for injecting a custom address-lookup strategy (primarily for testing).
typealias CEPLookupHandler = (_ cep: String) async throws -> ViaCEPResponse

/// ViewModel for the contact creation and editing form.
final class ContactFormViewModel: ObservableObject {
    // MARK: - Injected Dependencies
    private let cepLookup: CEPLookupHandler

    // MARK: - Form Fields

    /// Full name of the contact (required).
    @Published var name: String = ""
    /// E-mail address (required, must pass format check).
    @Published var email: String = ""
    /// Phone number (optional).
    @Published var phone: String = ""
    /// `true` when the user wants to store a birthday.
    @Published var hasBirthDate: Bool = false
    /// Selected birthday date (used only when `hasBirthDate` is `true`).
    @Published var birthDate: Date = Date()
    /// Brazilian postal code entered by the user.
    @Published var cep: String = ""
    /// Street name – auto-filled from ViaCEP.
    @Published var street: String = ""
    /// Street number.
    @Published var number: String = ""
    /// Neighbourhood – auto-filled from ViaCEP.
    @Published var neighborhood: String = ""
    /// City – auto-filled from ViaCEP.
    @Published var city: String = ""
    /// State abbreviation – auto-filled from ViaCEP.
    @Published var state: String = ""

    // MARK: - Validation State

    /// Non-nil when the name field has a validation error.
    @Published var nameError: LocalizedStringKey?
    /// Non-nil when the e-mail field has a validation error.
    @Published var emailError: LocalizedStringKey?

    // MARK: - CEP State

    /// `true` while the ViaCEP network request is in-flight.
    @Published var isLoadingCEP: Bool = false
    /// Non-nil when the CEP lookup failed or returned no address.
    @Published var cepError: LocalizedStringKey?

    // In-flight lookup task — cancelled before each new request to avoid races.
    private var cepTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    // Set during configure(with:) so the onChange-triggered lookup is suppressed on edit.
    private var suppressNextCEPLookup = false

    // MARK: - Init

    /// Creates a ``ContactFormViewModel``.
    ///
    /// - Parameter cepLookup: Async function used to resolve a CEP to an address.
    ///   Defaults to the live ``ViaCEPService``. Pass a mock in unit tests.
    init(cepLookup: @escaping CEPLookupHandler = { try await ViaCEPService.fetchAddress(cep: $0) }) {
        self.cepLookup = cepLookup
        $phone
            .map(Self.applyPhoneMask)
            .removeDuplicates()
            .sink { [weak self] masked in
                guard let self, self.phone != masked else { return }
                self.phone = masked
            }
            .store(in: &cancellables)
        $cep
            .map { Self.applyCEPMask($0) }
            .removeDuplicates()
            .sink { [weak self] masked in
                guard let self, self.cep != masked else { return }
                self.cep = masked
            }
            .store(in: &cancellables)
    }

    // MARK: - Configure from Existing Entry

    /// Populates all form fields from an existing ``ContactEntry``.
    ///
    /// - Parameter entry: The persisted contact to load.
    func configure(with entry: ContactEntry) {
        // Suppress the CEP lookup that SwiftUI's onChange fires after onAppear sets cep.
        suppressNextCEPLookup = !entry.cep.isEmpty
        name = entry.name
        email = entry.email
        phone = Self.applyPhoneMask(entry.phone)
        if let storedDate = entry.birthDate {
            hasBirthDate = true
            birthDate = storedDate
        }
        cep = entry.cep
        street = entry.street
        number = entry.number
        neighborhood = entry.neighborhood
        city = entry.city
        state = entry.state
    }

    // MARK: - CEP Auto-Fill

    /// Applies the Brazilian phone mask `(XX) XXXX-XXXX` / `(XX) XXXXX-XXXX`.
    nonisolated static func applyPhoneMask(_ input: String) -> String {
        var digits = input.filter(\.isNumber)
        if digits.count > 11 { digits = String(digits.prefix(11)) }
        guard !digits.isEmpty else { return "" }
        let d = Array(digits)
        let n = d.count
        if n <= 2 {
            return "(\(digits)"
        } else if n <= 6 {
            return "(\(d[0])\(d[1])) \(String(d[2...]))"
        } else if n <= 10 {
            return "(\(d[0])\(d[1])) \(String(d[2..<6]))-\(String(d[6...]))"
        } else {
            return "(\(d[0])\(d[1])) \(String(d[2..<7]))-\(String(d[7..<11]))"
        }
    }

    /// Applies the Brazilian ZIP code mask `XXXXX-XXX` (max 8 digits).
    nonisolated static func applyCEPMask(_ input: String, maxDigits: Int = 8) -> String {
        var digits = input.filter(\.isNumber)
        if digits.count > maxDigits {
            digits = String(digits.prefix(maxDigits))
        }
        guard !digits.isEmpty else { return "" }
        return digits.count <= 5 ? digits : "\(digits.prefix(5))-\(digits.dropFirst(5))"
    }

    /// Non-nil when the CEP field has between 1–7 digits (incomplete).
    var cepFormatError: LocalizedStringKey? {
        let digits = cep.filter(\.isNumber)
        guard !digits.isEmpty else { return nil }
        return digits.count < ContactsConstants.cepDigitCount ? "contacts.error.cep_invalid_format" : nil
    }

    /// Triggers a ViaCEP lookup when the current CEP has exactly 8 digits.
    ///
    /// Results are applied on the `@MainActor` to update published properties.
    func lookupCEPIfNeeded() {
        if suppressNextCEPLookup { suppressNextCEPLookup = false; return }
        let cleanCEP = cep.filter(\.isNumber)
        guard cleanCEP.count == ContactsConstants.cepDigitCount else { return }

        // Cancel any in-flight request before starting a new one.
        cepTask?.cancel()

        isLoadingCEP = true
        cepError = nil
        cepTask = Task { @MainActor in
            await ZodiakTrace.withNewTrace {
                ZodiakLog.info(.viewModel, "ContactFormViewModel.lookupCEP() started [trace=\(ZodiakTrace.short)]")
                do {
                    let response = try await self.cepLookup(cleanCEP)
                    self.applyAddress(from: response)
                    ZodiakLog.info(.viewModel, "ContactFormViewModel.lookupCEP() succeeded [trace=\(ZodiakTrace.short)]")
                } catch is CancellationError {
                    // Silently discard — a newer request superseded this one.
                } catch {
                    // CEP value is PII — routed to native Logger only, never to the bus.
                    // swiftlint:disable:next line_length
                    ZodiakLogger.viewModel.warning("lookupCEP() failed error=\(error.localizedDescription, privacy: .public) cep=\(cleanCEP, privacy: .private(mask: .hash)) trace=\(ZodiakTrace.short, privacy: .public)")
                    ZodiakSessionMetrics.shared.trackValidationError()
                    self.cepError = "contacts.error.cep_not_found"
                }
            }
            self.isLoadingCEP = false
        }
    }

    // MARK: - Per-Step Validation

    /// `true` when name is non-empty and e-mail is syntactically valid.
    /// Used by `ContactFormScreen` to gate the "Next" button on step 1.
    var isStep1Valid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        isValidEmail(email.trimmingCharacters(in: .whitespaces))
    }

    // MARK: - Validation

    /// Validates all required fields and populates error properties.
    ///
    /// - Returns: `true` when the form is valid and safe to save.
    @discardableResult
    func validate() -> Bool {
        nameError = nil
        emailError = nil
        var isValid = true

        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            nameError = "contacts.error.name_required"
            isValid = false
        }

        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        if trimmedEmail.isEmpty {
            emailError = "contacts.error.email_required"
            isValid = false
        } else if !isValidEmail(trimmedEmail) {
            emailError = "contacts.error.email_invalid"
            isValid = false
        }

        if !isValid {
            ZodiakSessionMetrics.shared.trackValidationError()
            ZodiakLog.warning(
                .error,
                "ContactFormViewModel.validate() failed [trace=\(ZodiakTrace.short)]",
                metadata: [
                    "has_name_error": nameError != nil ? "true" : "false",
                    "has_email_error": emailError != nil ? "true" : "false"
                ]
            )
        }

        return isValid
    }

    // MARK: - Persistence Helpers

    /// Writes current form values into an existing ``ContactEntry``.
    ///
    /// - Parameter entry: The managed object to update.
    func applyChanges(to entry: ContactEntry) {
        entry.name = name.trimmingCharacters(in: .whitespaces)
        entry.email = email.trimmingCharacters(in: .whitespaces)
        entry.phone = phone
        entry.birthDate = hasBirthDate ? birthDate : nil
        entry.cep = cep
        entry.street = street
        entry.number = number
        entry.neighborhood = neighborhood
        entry.city = city
        entry.state = state
    }

    /// Creates a new ``ContactEntry`` from current form values.
    ///
    /// - Returns: A new, unsaved ``ContactEntry``.
    func makeNewEntry() -> ContactEntry {
        ContactEntry(
            name: name.trimmingCharacters(in: .whitespaces),
            email: email.trimmingCharacters(in: .whitespaces),
            phone: phone,
            birthDate: hasBirthDate ? birthDate : nil,
            cep: cep,
            neighborhood: neighborhood,
            street: street,
            number: number,
            state: state,
            city: city
        )
    }

    /// Resets all form fields and clears all errors.
    func reset() {
        name = ""
        email = ""
        phone = ""
        hasBirthDate = false
        birthDate = Date()
        cep = ""
        street = ""
        number = ""
        neighborhood = ""
        city = ""
        state = ""
        nameError = nil
        emailError = nil
        cepError = nil
        isLoadingCEP = false
    }

    // MARK: - Private

    private func applyAddress(from response: ViaCEPResponse) {
        street = response.logradouro ?? street
        neighborhood = response.bairro ?? neighborhood
        city = response.localidade ?? city
        state = response.uf ?? state
    }
}
