import Foundation
import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ContactFormViewModel Tests

@Suite("ContactFormViewModel")
struct ContactFormViewModelTests {
    // MARK: - Initial State

    @Test("Estado inicial tem todos os campos vazios")
    func initialStateIsEmpty() {
        let vm = ContactFormViewModel()
        #expect(vm.name.isEmpty)
        #expect(vm.email.isEmpty)
        #expect(vm.phone.isEmpty)
        #expect(!vm.hasBirthDate)
        #expect(vm.cep.isEmpty)
        #expect(vm.nameError == nil)
        #expect(vm.emailError == nil)
        #expect(!vm.isLoadingCEP)
        #expect(vm.cepError == nil)
    }

    // MARK: - Validation: Name

    @Test("Validate com nome vazio define nameError e retorna false")
    func validateEmptyNameSetsError() {
        let vm = ContactFormViewModel()
        vm.email = "test@example.com"
        let valid = vm.validate()
        #expect(!valid)
        #expect(vm.nameError != nil)
        #expect(vm.emailError == nil)
    }

    @Test("Validate com nome só de espaços define nameError")
    func validateWhitespaceNameSetsError() {
        let vm = ContactFormViewModel()
        vm.name = "   "
        vm.email = "test@example.com"
        let valid = vm.validate()
        #expect(!valid)
        #expect(vm.nameError != nil)
    }

    // MARK: - Validation: Email

    @Test("Validate com email vazio define emailError e retorna false")
    func validateEmptyEmailSetsError() {
        let vm = ContactFormViewModel()
        vm.name = "Maria Silva"
        let valid = vm.validate()
        #expect(!valid)
        #expect(vm.emailError != nil)
        #expect(vm.nameError == nil)
    }

    @Test("Validate com email inválido define emailError")
    func validateInvalidEmailSetsError() {
        let vm = ContactFormViewModel()
        vm.name = "Maria Silva"
        vm.email = "not-an-email"
        let valid = vm.validate()
        #expect(!valid)
        #expect(vm.emailError != nil)
    }

    @Test("Validate com entradas válidas retorna true e limpa erros")
    func validateValidInputsReturnsTrue() {
        let vm = ContactFormViewModel()
        vm.name = "Maria Silva"
        vm.email = "maria@example.com"
        let valid = vm.validate()
        #expect(valid)
        #expect(vm.nameError == nil)
        #expect(vm.emailError == nil)
    }

    // MARK: - Reset

    @Test("Reset limpa todos os campos e erros")
    func resetClearsAllState() {
        let vm = ContactFormViewModel()
        vm.name = "Maria"
        vm.email = "maria@example.com"
        vm.phone = "11999999999"
        vm.cep = "01310100"
        vm.street = "Rua Augusta"
        vm.nameError = "contacts.error.name_required"
        vm.validate()
        vm.reset()
        #expect(vm.name.isEmpty)
        #expect(vm.email.isEmpty)
        #expect(vm.phone.isEmpty)
        #expect(vm.cep.isEmpty)
        #expect(vm.street.isEmpty)
        #expect(vm.nameError == nil)
        #expect(vm.emailError == nil)
        #expect(vm.cepError == nil)
        #expect(!vm.isLoadingCEP)
    }

    // MARK: - CEP Lookup

    @Test("CEP lookup com resposta válida preenche campos de endereço")
    func cepLookupFillsAddressFields() async {
        let mockResponse = ViaCEPResponse(
            logradouro: "Rua Augusta",
            bairro: "Consolação",
            localidade: "São Paulo",
            uf: "SP"
        )
        let vm = ContactFormViewModel(cepLookup: { _ in mockResponse })
        vm.cep = "01310100"
        vm.lookupCEPIfNeeded()
        try? await Task.sleep(for: .milliseconds(200))
        #expect(vm.street == "Rua Augusta")
        #expect(vm.neighborhood == "Consolação")
        #expect(vm.city == "São Paulo")
        #expect(vm.state == "SP")
        #expect(!vm.isLoadingCEP)
        #expect(vm.cepError == nil)
    }

    @Test("CEP lookup com erro define cepError")
    func cepLookupErrorSetsCepError() async {
        let vm = ContactFormViewModel(cepLookup: { _ in throw ViaCEPError.notFound })
        vm.cep = "99999999"
        vm.lookupCEPIfNeeded()
        try? await Task.sleep(for: .milliseconds(200))
        #expect(vm.cepError != nil)
        #expect(!vm.isLoadingCEP)
    }

    @Test("CEP com menos de 8 dígitos não dispara lookup")
    func shortCEPDoesNotTriggerLookup() async {
        var lookupCalled = false
        let vm = ContactFormViewModel(cepLookup: { _ in
            lookupCalled = true
            return ViaCEPResponse(logradouro: nil, bairro: nil, localidade: nil, uf: nil)
        })
        vm.cep = "0131"
        vm.lookupCEPIfNeeded()
        try? await Task.sleep(for: .milliseconds(100))
        #expect(!lookupCalled)
    }

    @Test("Configure com CEP existente suprime lookup automático")
    func configureWithExistingCEPSuppressesLookup() async {
        var lookupCalled = false
        let vm = ContactFormViewModel(cepLookup: { _ in
            lookupCalled = true
            return ViaCEPResponse(logradouro: "Rua X", bairro: nil, localidade: nil, uf: nil)
        })
        let entry = ContactEntry(
            name: "Ana", email: "ana@example.com",
            cep: "01310-100", street: "Rua Augusta"
        )
        vm.configure(with: entry)
        vm.lookupCEPIfNeeded()
        try? await Task.sleep(for: .milliseconds(100))
        #expect(!lookupCalled)
    }

    @Test("Após configure, novo CEP ainda dispara lookup")
    func afterConfigureNewCEPTriggersLookup() async {
        var lookupCalled = false
        let vm = ContactFormViewModel(cepLookup: { _ in
            lookupCalled = true
            return ViaCEPResponse(logradouro: "Rua X", bairro: nil, localidade: nil, uf: nil)
        })
        let entry = ContactEntry(name: "Ana", email: "ana@example.com", cep: "01310-100")
        vm.configure(with: entry)
        // First call is suppressed (configure flag consumed)
        vm.lookupCEPIfNeeded()
        // Simulate user typing a new CEP
        vm.cep = "04538-132"
        vm.lookupCEPIfNeeded()
        try? await Task.sleep(for: .milliseconds(200))
        #expect(lookupCalled)
    }
}
