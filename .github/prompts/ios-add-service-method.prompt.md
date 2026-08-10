---
description: "Add a new method to Services.swift. Use when a feature needs business logic that doesn't yet exist as a service method. Creates the method, adds unit tests, and verifies ViewModel wiring."
argument-hint: "What does the method do? (e.g. 'calculate compound interest given principal, rate, and years')"
agent: "agent"
tools: [read, edit, search]
---

Add a new service method for: $input

## Step 1 — Read Services.swift
Read `ZodiakiOS/Services/Services.swift` in full to:
- Understand the current structure (free functions / static methods, no singleton)
- Find the most appropriate service enum to extend (e.g. `CalculationService`, `ValidationService`, `RandomService`, `StringProcessingService`)
- Identify existing patterns (naming, error handling, return types)

## Step 2 — Determine placement
Choose the correct service type:

| Service | Responsibility |
|---|---|
| `ValidationService` | Input validation, throws `ValidationError` |
| `CalculationService` | Pure math / transformation — no side effects |
| `RandomService` | Randomness, shuffle, pick |
| `StringProcessingService` | String inspection, palindrome, search |
| `QuizService` | Quiz data access |
| New service | Only if none of the above fit — add a new `enum <Domain>Service` |

## Step 3 — Add the method
Add a `static func` to the appropriate service enum:

```swift
// MARK: - <Domain>Service
extension <Domain>Service {
    /// <One-line description of what this method does.>
    static func <methodName>(<params>) <throws?> -> <ReturnType> {
        // implementation
    }
}
```

Rules:
- Static methods only — no stored properties on service enums
- If the method can fail with user-visible errors, `throws` and returns a `ValidationError`
- Pure functions: same input → same output; no global state
- No SwiftUI imports in Services.swift

## Step 4 — Add unit tests
Add tests in `ZodiakiOSTests/<ServiceName>Tests.swift` (or create the file if it doesn't exist):

```swift
import Testing
@testable import ZodiakiOS

// MARK: - <Method> Tests
extension <ServiceName>Tests {
    @Test("<method> with valid input returns expected result")
    func <methodName>ValidInput() throws {
        let result = try <ServiceName>.<methodName>(<validArgs>)
        #expect(result == <expectedValue>)
    }

    @Test("<method> with invalid input throws ValidationError")
    func <methodName>InvalidInput() {
        #expect(throws: ValidationError.self) {
            try <ServiceName>.<methodName>(<invalidArgs>)
        }
    }
}
```

## Step 5 — Wire to ViewModel
If a feature's ViewModel should call this new method, update the ViewModel's `submit()`:

```swift
func submit() {
    errorMessage = nil
    do {
        let value = try <ServiceName>.<methodName>(<vm.inputProperty>)
        self.result = value
    } catch let error as ValidationError {
        errorMessage = error.localizedKey
    } catch {
        errorMessage = "shared.error.unknown"
    }
}
```

## Step 6 — Run SwiftLint
```
swiftlint lint --fix --config .swiftlint.yml ZodiakiOS/Services/
```

## Output
- Method signature added (with service name and file path)
- Test cases added (with file path)
- ViewModel(s) updated (if applicable)
- SwiftLint result
