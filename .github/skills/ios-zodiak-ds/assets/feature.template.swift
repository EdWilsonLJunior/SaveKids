// TEMPLATE: Zodiak Feature (Activity)
// Copy and replace all <Placeholder> values.
// Source of truth for DS components: ZodiakiOS/Shared/DesignSystem/
// Never copy UI patterns from other files in Features/ — use DS components directly.
//
// Replace:
//   <NN>          → zero-padded number, e.g. "12"
//   <Name>        → PascalCase name, e.g. "CurrencyConverter"
//   <name>        → camelCase/snake_case for localization, e.g. "currency_converter"
//   <Description> → brief description for inline comments

// ============================================================
// FILE 1: ZodiakiOS/Features/<NN>-<Name>/<Name>Constants.swift
// ============================================================

import Foundation

// MARK: - Constants
enum <Name>Constants {
    // Define feature-specific constants here.
    // Example:
    // static let minValue: Double = 0
    // static let maxValue: Double = 100
}

// ============================================================
// FILE 2: ZodiakiOS/Features/<NN>-<Name>/<Name>ViewModel.swift
// ============================================================

import Combine
import SwiftUI

// MARK: - Activity <NN>: <Name>
/// <Description>
final class <Name>ViewModel: ObservableObject {

    // MARK: - Input
    @Published var inputValue: String = ""

    // MARK: - Output
    @Published var result: String?
    @Published var errorMessage: LocalizedStringKey?

    // MARK: - Actions

    func submit() {
        clearErrors()
        // Validate via ValidationService if needed
        // Compute result
        // self.result = ...
    }

    func reset() {
        inputValue = ""
        result = nil
        clearErrors()
    }

    // MARK: - Private

    private func clearErrors() {
        errorMessage = nil
        result = nil
    }
}

// ============================================================
// FILE 3: ZodiakiOS/Features/<NN>-<Name>/<Name>Screen.swift
// ============================================================

import SwiftUI

// MARK: - <Name> Screen
struct <Name>Screen: View {
    @StateObject private var viewModel: <Name>ViewModel = <Name>ViewModel()

    var body: some View {
        // ZodiakActivityTemplate is ALWAYS the screen root.
        // It provides: background, ScrollView, heading, .dismissKeyboardOnTap()
        ZodiakActivityTemplate(
            title: "feature.<name>.short_title",
            eyebrow: "feature.<name>.eyebrow",
            intro: "feature.<name>.intro"
        ) {
            // Input form — use ZodiakFormWrapper for consistent spacing
            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "shared.label.name",
                    placeholder: "shared.placeholder.name",
                    text: $viewModel.inputValue,
                    errorMessage: viewModel.errorMessage
                )
            }

            // Primary action
            ZodiakButton(
                title: "feature.<name>.submit_action",
                action: viewModel.submit
            )

            // Result (shown only after successful submit)
            if let result = viewModel.result {
                ZodiakResultCard(
                    title: String(localized: "feature.<name>.result_label"),
                    value: result,
                    subtitle: ""
                )

                ZodiakSecondaryButton(
                    title: "shared.action.clear",
                    action: viewModel.reset
                )
            }
        }
    }
}

#Preview {
    <Name>Screen()
}

// ============================================================
// FILE 4: ZodiakiOSTests/<Name>ViewModelTests.swift
// ============================================================

import Testing
@testable import ZodiakiOS

@Suite("<Name>ViewModel Tests")
struct <Name>ViewModelTests {

    @Test("initial state is empty")
    func initialStateIsEmpty() {
        let vm = <Name>ViewModel()
        #expect(vm.inputValue == "")
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
    }

    @Test("submit with valid input produces result")
    func submitWithValidInput() {
        let vm = <Name>ViewModel()
        vm.inputValue = "valid value"
        vm.submit()
        #expect(vm.result != nil)
        #expect(vm.errorMessage == nil)
    }

    @Test("submit with invalid input sets error")
    func submitWithInvalidInput() {
        let vm = <Name>ViewModel()
        vm.inputValue = ""
        vm.submit()
        #expect(vm.errorMessage != nil)
    }

    @Test("reset clears all state")
    func resetClearsAllState() {
        let vm = <Name>ViewModel()
        vm.inputValue = "something"
        vm.reset()
        #expect(vm.inputValue == "")
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
    }
}

// ============================================================
// LOCALIZATION KEYS to add in Localizable.xcstrings
// (both en and pt-BR required)
// ============================================================
//
// feature.<name>.eyebrow        = "Atividade <NN>"
// feature.<name>.short_title    = "<Feature Title>"
// feature.<name>.intro          = "<Brief description of what this feature does>"
// feature.<name>.submit_action  = "<Button label>"
// feature.<name>.result_label   = "<Result label>"
