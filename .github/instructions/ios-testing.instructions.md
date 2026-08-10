---
applyTo: "ZodiakiOS/**/*.swift"
---

# Testing Conventions — ZodiakiOS

## Framework

<rules>
Use **Swift Testing** exclusively. Do NOT use XCTest for new unit tests.
</rules>

```swift
import Testing
@testable import ZodiakiOS
```

---

## File and Suite Naming

| Item | Convention | Example |
|---|---|---|
| File | `<FeatureName>ViewModelTests.swift` | `CurrencyConverterViewModelTests.swift` |
| Suite | `@Suite("<FeatureName>ViewModel Tests")` | `@Suite("CurrencyConverterViewModel Tests")` |
| Struct | `struct <FeatureName>ViewModelTests { ... }` | `struct CurrencyConverterViewModelTests { ... }` |
| Test | `@Test("<verb phrase>")` — plain English | `@Test("submit with valid input produces result")` |

---

## Minimum Coverage per ViewModel

Every ViewModel test file MUST cover these 4 scenarios:

```swift
@Suite("FeatureNameViewModel Tests")
struct FeatureNameViewModelTests {

    // 1. Initial state
    @Test("initial state has empty inputs and no result")
    func initialStateIsEmpty() {
        let vm = FeatureNameViewModel()
        #expect(vm.inputProperty == nil || vm.inputProperty == "")
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
    }

    // 2. Happy path
    @Test("submit with valid input produces result")
    func submitWithValidInput() {
        let vm = FeatureNameViewModel()
        vm.inputProperty = <validValue>
        vm.submit()
        #expect(vm.result != nil)
        #expect(vm.errorMessage == nil)
    }

    // 3. Validation failure
    @Test("submit with invalid input sets errorMessage")
    func submitWithInvalidInput() {
        let vm = FeatureNameViewModel()
        vm.inputProperty = <invalidValue>
        vm.submit()
        #expect(vm.errorMessage != nil)
        #expect(vm.result == nil)
    }

    // 4. Reset clears all state
    @Test("reset clears all published properties")
    func resetClearsState() {
        let vm = FeatureNameViewModel()
        vm.inputProperty = <someValue>
        vm.submit()
        vm.reset()
        #expect(vm.inputProperty == nil || vm.inputProperty == "")
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
    }
}
```

---

## Assertion Macro

Always use `#expect(...)` — NOT `XCTAssert*`. For throwing code, use `#expect(throws:)`:

```swift
// ✅ Correct
#expect(vm.result != nil)
#expect(vm.errorMessage == nil)

// ✅ For throws
#expect(throws: ValidationError.self) { try vm.submitThrowing() }

// ❌ Never use
XCTAssertNotNil(vm.result)
XCTAssertNil(vm.errorMessage)
```

---

## Service Mocking

Services are free functions / static methods in `Services.swift` (not protocols). To test ViewModel logic in isolation:
- Pass edge-case inputs that exercise the service path you want to validate
- Do NOT mock `ValidationService` or `CalculationService` — test through the ViewModel

If a future service becomes injectable (via protocol), add a mock struct conforming to the protocol inside the test file:

```swift
struct MockRandomService: RandomServiceProtocol {
    func nextInt(in range: ClosedRange<Int>) -> Int { range.lowerBound }
}
```

---

## Edge Cases to Always Cover

<pitfalls>

For any ViewModel that accepts numeric input:
- Zero or negative value (expect `errorMessage != nil`)
- Non-integer decimal where only integers are valid (expect `errorMessage != nil`)
- Very large number at boundary of `Int`/`Double`

For any ViewModel that accepts string input:
- Empty string (expect `errorMessage != nil`)
- Whitespace-only string (expect `errorMessage != nil`)
- Non-ASCII / emoji characters where relevant

</pitfalls>

---

## File Location

```
ZodiakiOSTests/<FeatureName>ViewModelTests.swift
```

Service tests go in:

```
ZodiakiOSTests/<ServiceName>Tests.swift   // e.g. CalculationServiceTests.swift
```

---

## Rules

<rules>
- DO NOT add `@MainActor` to test structs unless testing `@MainActor`-isolated ViewModels
- DO NOT create shared `setUp`/`tearDown` helpers — each `@Test` should be self-contained
- DO keep test functions under 20 lines — extract helpers only if used 3+ times
- DO NOT import `SwiftUI` in test files unless the ViewModel uses `LocalizedStringKey` and you need to verify it
</rules>
