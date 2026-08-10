---
description: "Create a new feature (activity) in ZodiakiOS. Use when adding a new screen/module to Features/. Creates Screen + ViewModel + Constants + localization keys + unit tests."
argument-hint: "Feature name (e.g. CurrencyConverter)"
agent: "agent"
tools: [read, edit, search, execute]
---

Create a new feature for: $input

## Step 1 — Determine folder number
Read `ZodiakiOS/Features/` to list existing folders.
The next number is the highest existing number + 1.
Feature folder format: `Features/NN-<Name>/` (zero-padded to 2 digits, e.g. `12-CurrencyConverter`).

## Step 2 — Read the DS templates
Before writing any code, read:
- `ZodiakiOS/Shared/DesignSystem/Templates/ZodiakActivityTemplate.swift` — the screen wrapper
- `ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakButton.swift` — button API

All UI components MUST come from `ZodiakiOS/Shared/DesignSystem/` ONLY.
DO NOT copy from `Features/` (usage examples) or `App/Catalog/` (being refined).

## Step 3 — Create `<Name>Constants.swift`

```swift
import Foundation

// MARK: - Constants
enum <Name>Constants {
    static let exampleValue: SomeType = ...
}
```

Rules:
- `enum` (not `struct` or `class`) with `static let` properties only
- No business logic — pure constants
- File location: `ZodiakiOS/Features/NN-<Name>/<Name>Constants.swift`

## Step 4 — Create `<Name>ViewModel.swift`

```swift
import Combine
import SwiftUI

// MARK: - Activity NN: <Name>
final class <Name>ViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var <inputProperty>: <Type> = <defaultValue>
    @Published var result: <ResultType>?
    @Published var errorMessage: LocalizedStringKey?

    // MARK: - Public Actions
    func submit() { ... }
    func reset() { ... }
}
```

Rules:
- `final class` + `ObservableObject` + `@Published` — no exceptions
- Business logic via Services (in `ZodiakiOS/Services/Services.swift`), not inline
- No SwiftUI view code inside ViewModel
- No `-> Void` on functions — just `func reset()`
- Use `LocalizedStringKey` for error messages, not plain `String`

## Step 5 — Create `<Name>Screen.swift`

```swift
import SwiftUI

// MARK: - <Name> Screen
struct <Name>Screen: View {
    @StateObject private var viewModel: <Name>ViewModel = <Name>ViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.<name>.short_title",
            eyebrow: "feature.<name>.eyebrow",
            intro: "feature.<name>.intro"
        ) {
            // Form inputs using DS Atoms/Molecules from Shared/DesignSystem/
            // Result display using DS components
            // Action button
        }
    }
}

#Preview {
    <Name>Screen()
}
```

Rules:
- `ZodiakActivityTemplate` is the mandatory screen wrapper
- No `NavigationStack`, `.navigationTitle`, or `.toolbar` — handled by the tab navigation
- No hardcoded colors — use `ZodiakColors.*`
- No hardcoded spacing — use `ZodiakSpacing.*`
- Keyboard dismissal: `.dismissKeyboardOnTap()` is already applied by `ZodiakActivityTemplate`
- For complex UI with many sub-views, create a `Components/` subfolder inside the feature folder

## Step 6 — Add localization keys
Add to `ZodiakiOS/Localizable.xcstrings`:

Keys to add (both `en` and `pt-BR` translations):
- `feature.<name>.eyebrow` — short category label (e.g. "Atividade 12")
- `feature.<name>.short_title` — screen title
- `feature.<name>.intro` — brief description shown below title
- `feature.<name>.<action>_action` — button labels
- `feature.<name>.<error>_error` — validation error messages (if any)

## Step 7 — Create `<Name>ViewModelTests.swift`

Follow the conventions in `.github/instructions/ios-testing.instructions.md`.

```swift
import Testing
@testable import ZodiakiOS

// MARK: - <Name>ViewModel Tests
@Suite("<Name>ViewModel Tests")
struct <Name>ViewModelTests {

    @Test("initial state has empty inputs and no result")
    func initialStateIsEmpty() {
        let vm = <Name>ViewModel()
        #expect(vm.<inputProperty> == nil || vm.<inputProperty> == "")
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
    }

    @Test("submit with valid input produces result")
    func submitWithValidInput() {
        let vm = <Name>ViewModel()
        vm.<inputProperty> = <validValue>
        vm.submit()
        #expect(vm.result != nil)
        #expect(vm.errorMessage == nil)
    }

    @Test("submit with invalid input sets errorMessage")
    func submitWithInvalidInput() {
        let vm = <Name>ViewModel()
        vm.<inputProperty> = <invalidValue>
        vm.submit()
        #expect(vm.errorMessage != nil)
        #expect(vm.result == nil)
    }

    @Test("reset clears all published properties")
    func resetClearsState() {
        let vm = <Name>ViewModel()
        vm.<inputProperty> = <someValue>
        vm.submit()
        vm.reset()
        #expect(vm.<inputProperty> == nil || vm.<inputProperty> == "")
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
    }
}
```

File location: `ZodiakiOSTests/<Name>ViewModelTests.swift`

## Step 8 — Lint
Run: `swiftlint lint --fix --config .swiftlint.yml ZodiakiOS/Features/NN-<Name>/`
Report any remaining violations that could not be auto-fixed.

## Step 9 — Integrate in MainTabView
Read `ZodiakiOS/App/MainTabView.swift` and add a new `TabItem` for the feature:
- Tab label key: `app.tab.<name>` (add to `Localizable.xcstrings` for both `en` and `pt-BR`)
- SF Symbol: choose the most semantically appropriate system icon
- Insert after the last existing tab

## Output
Return a summary with:
- All files created (with relative paths)
- All `Localizable.xcstrings` keys added (including the new tab key)
- SwiftLint result: N violations auto-fixed, M remaining (list remaining violations)
