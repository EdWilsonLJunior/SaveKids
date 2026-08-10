import Combine
import SwiftUI

// MARK: - Activity 07: Person Manager

/// ViewModel da Atividade 07 — gerencia uma lista de pessoas com nome e idade.
final class PersonManagerViewModel: ObservableObject {
    /// Lista de pessoas cadastradas.
    @Published var persons: [Person] = []
    /// Nome digitado para adicionar uma nova pessoa.
    @Published var nameInput: String = ""
    /// Idade digitada (como string) para adicionar uma nova pessoa.
    @Published var ageInput: String = ""
    /// Mensagem de erro de validação; `nil` quando não há erro.
    @Published var errorMessage: LocalizedStringKey?

    /// Valida e adiciona uma nova pessoa à lista. Limpa os campos em caso de sucesso.
    func addPerson() {
        ZodiakLog.info(.viewModel, "PersonManagerViewModel.addPerson() started [trace=\(ZodiakTrace.short)]")
        errorMessage = nil

        do {
            try ValidationService.validateNotEmpty(nameInput, fieldName: "shared.label.name")
            guard let age: Int = Int(ageInput) else {
                throw ValidationError.invalidAge
            }
            _ = try ValidationService.validateAge(age)

            let person: Person = Person(name: nameInput, age: age)
            persons.append(person)
            ZodiakLog.info(.viewModel, "PersonManagerViewModel.addPerson() succeeded [trace=\(ZodiakTrace.short)]",
                           metrics: ["total_count": Double(persons.count)])
            nameInput = ""
            ageInput = ""
        } catch let error as ValidationError {
            ZodiakSessionMetrics.shared.trackValidationError()
            let errorDesc = String(describing: error)
            let msg = "PersonManagerViewModel validation failed error=\(errorDesc) [trace=\(ZodiakTrace.short)]"
            ZodiakLog.warning(.error, msg, metadata: ["error_type": errorDesc])
            errorMessage = error.localizedKey
        } catch {
            errorMessage = "feature.person_manager.add_error"
        }
    }

    /// Remove a pessoa especificada da lista, identificada pelo seu `id`.
    ///
    /// - Parameter person: Pessoa a ser removida.
    func removePerson(_ person: Person) {
        persons.removeAll { currentPerson in currentPerson.id == person.id }
        ZodiakLog.info(.viewModel, "PersonManagerViewModel.removePerson() [trace=\(ZodiakTrace.short)]",
                       metrics: ["remaining_count": Double(persons.count)])
    }
}
