import SwiftData
import SwiftUI

// MARK: - Contact Form Screen

/// Form screen for creating and editing a contact.
/// Uses ZodiakInputWizard with 3 steps:
///   1. Dados pessoais (nome, e-mail, telefone)
///   2. Aniversário (toggle + datepicker)
///   3. Endereço (CEP auto-fill + logradouro)
struct ContactFormScreen: View {
    let contact: ContactEntry?

    @StateObject private var viewModel = ContactFormViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private var isEditing: Bool { contact != nil }

    // MARK: - Body

    var body: some View {
        ZodiakInputWizard(
            title: isEditing ? "contacts.form.edit_title" : "contacts.form.new_title",
            steps: [personalStep, birthdayStep, addressStep, reviewStep],
            onComplete: save,
            onCancel: { dismiss() },
            submitLabel: "contacts.action.save"
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ZodiakColors.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            if let contact {
                viewModel.configure(with: contact)
            }
        }
        .onChange(of: viewModel.cep) { _, newValue in
            let digits = newValue.filter(\.isNumber)
            if digits.count == ContactsConstants.cepDigitCount {
                viewModel.lookupCEPIfNeeded()
            }
        }
        .onChange(of: viewModel.email) { _, newValue in
            let lowered = newValue.lowercased()
            if lowered != newValue { viewModel.email = lowered }
        }
        .settingsToolbar()
        .accessibilityIdentifier("screen.27.contact_form")
    }

    // MARK: - Step 1: Dados Pessoais

    private var personalStep: ZodiakWizardStep {
        ZodiakWizardStep(
            title: "contacts.form.section.basic_info",
            subtitle: isEditing ? "contacts.form.edit_intro" : "contacts.form.new_intro",
            canProceed: viewModel.isStep1Valid
        ) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakLabelledField(
                    label: "contacts.label.name",
                    placeholder: "contacts.placeholder.name",
                    text: $viewModel.name,
                    isRequired: true,
                    errorMessage: viewModel.nameError
                )
                ZodiakLabelledField(
                    label: "contacts.label.email",
                    placeholder: "contacts.placeholder.email",
                    text: $viewModel.email,
                    keyboardType: .emailAddress,
                    isRequired: true,
                    errorMessage: viewModel.emailError
                )
                ZodiakLabelledField(
                    label: "contacts.label.phone",
                    placeholder: "contacts.placeholder.phone",
                    text: $viewModel.phone,
                    keyboardType: .phonePad
                )
            }
        }
    }

    // MARK: - Step 2: Aniversário

    private var birthdayStep: ZodiakWizardStep {
        ZodiakWizardStep(title: "contacts.form.birthday_toggle") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakSwitch(
                    label: "contacts.form.birthday_toggle",
                    isOn: $viewModel.hasBirthDate
                )
                if viewModel.hasBirthDate {
                    DatePicker(
                        selection: $viewModel.birthDate,
                        displayedComponents: .date
                    ) {
                        ZodiakText("contacts.label.birthday", style: .body(color: .secondary))
                    }
                    .datePickerStyle(.compact)
                    .tint(ZodiakColors.actionPrimary)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: viewModel.hasBirthDate)
        }
    }

    // MARK: - Step 3: Endereço

    private var addressStep: ZodiakWizardStep {
        ZodiakWizardStep(title: "contacts.form.section.address") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakLabelledField(
                    label: "contacts.label.cep",
                    placeholder: "contacts.placeholder.cep",
                    text: $viewModel.cep,
                    keyboardType: .numberPad,
                    errorMessage: viewModel.cepFormatError
                )
                if viewModel.isLoadingCEP {
                    HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakSpinner(size: 18)
                        ZodiakText("contacts.cep.loading", style: .bodySmall(color: .secondary))
                    }
                    .transition(.opacity)
                }
                if let cepError = viewModel.cepError {
                    ZodiakAlert(title: cepError, variant: .error, isDismissible: true) {
                        viewModel.cepError = nil
                    }
                    .transition(.opacity)
                }
                ZodiakLabelledField(
                    label: "contacts.label.street",
                    placeholder: "contacts.placeholder.street",
                    text: $viewModel.street,
                    isLoading: viewModel.isLoadingCEP
                )
                ZodiakLabelledField(
                    label: "contacts.label.number",
                    placeholder: "contacts.placeholder.number",
                    text: $viewModel.number
                )
                ZodiakLabelledField(
                    label: "contacts.label.neighborhood",
                    placeholder: "contacts.placeholder.neighborhood",
                    text: $viewModel.neighborhood,
                    isLoading: viewModel.isLoadingCEP
                )
                ZodiakLabelledField(
                    label: "contacts.label.city",
                    placeholder: "contacts.placeholder.city",
                    text: $viewModel.city,
                    isLoading: viewModel.isLoadingCEP
                )
                ZodiakLabelledField(
                    label: "contacts.label.state",
                    placeholder: "contacts.placeholder.state",
                    text: $viewModel.state,
                    isLoading: viewModel.isLoadingCEP
                )
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.isLoadingCEP)
            .animation(.easeInOut(duration: 0.2), value: viewModel.cepError == nil)
            .animation(.easeInOut(duration: 0.2), value: viewModel.cepFormatError == nil)
        }
    }

    // MARK: - Step 4: Revisão

    private var reviewStep: ZodiakWizardStep {
        ZodiakWizardStep(
            title: "contacts.form.section.review",
            subtitle: "contacts.form.review.intro"
        ) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(label: String(localized: "contacts.label.name"),
                              value: viewModel.name)
                ZodiakInfoRow(label: String(localized: "contacts.label.email"),
                              value: viewModel.email)
                if !viewModel.phone.isEmpty {
                    ZodiakInfoRow(label: String(localized: "contacts.label.phone"),
                                  value: viewModel.phone)
                }

                if viewModel.hasBirthDate {
                    ZodiakDivider(hierarchy: .secondary)
                    ZodiakInfoRow(
                        label: String(localized: "contacts.label.birthday"),
                        value: viewModel.birthDate.formatted(date: .long, time: .omitted)
                    )
                }

                if !viewModel.street.isEmpty || !viewModel.cep.isEmpty {
                    ZodiakDivider(hierarchy: .secondary)
                    if !viewModel.cep.isEmpty {
                        ZodiakInfoRow(label: String(localized: "contacts.label.cep"),
                                      value: viewModel.cep)
                    }
                    if !viewModel.street.isEmpty {
                        let streetLine = viewModel.number.isEmpty
                            ? viewModel.street
                            : "\(viewModel.street), \(viewModel.number)"
                        ZodiakInfoRow(label: String(localized: "contacts.label.street"),
                                      value: streetLine)
                    }
                    if !viewModel.neighborhood.isEmpty {
                        ZodiakInfoRow(label: String(localized: "contacts.label.neighborhood"),
                                      value: viewModel.neighborhood)
                    }
                    if !viewModel.city.isEmpty {
                        let cityLine = viewModel.state.isEmpty
                            ? viewModel.city
                            : "\(viewModel.city) - \(viewModel.state)"
                        ZodiakInfoRow(label: String(localized: "contacts.label.city"),
                                      value: cityLine)
                    }
                }
            }
        }
    }

    // MARK: - Save

    private func save() {
        guard viewModel.validate() else { return }
        if let existing = contact {
            viewModel.applyChanges(to: existing)
        } else {
            let entry = viewModel.makeNewEntry()
            modelContext.insert(entry)
        }
        dismiss()
    }
}

// MARK: - Preview

#Preview("New Contact") {
    NavigationStack {
        ContactFormScreen(contact: nil)
            .modelContainer(for: ContactEntry.self, inMemory: true)
    }
}
