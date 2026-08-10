---
description: "Add a new method to a core:services object. Use when a feature needs business logic that doesn't yet exist as a service method. Creates the method, adds unit tests, and verifies ViewModel wiring."
argument-hint: "What does the method do? (e.g. 'calculate compound interest given principal, rate, and years')"
agent: "agent"
tools: [read, edit, search]
---

Add a new service method for: $input

## Step 1 — Read core:services
Read all service files in `core/services/src/main/kotlin/com/zodiak/android/core/services/` to:
- Understand the current structure (Kotlin `object` with static methods, no singleton)
- Find the most appropriate service to extend
- Identify existing patterns (naming, error handling, return types)

## Step 2 — Determine placement

Choose the correct service:

| Service | Responsibility |
|---|---|
| `ValidationService` | Input validation — throws `ValidationError` for user-visible failures |
| `CalculationService` | Pure math / transformation — no side effects |
| `RandomService` | Randomness, shuffle, pick |
| `StringProcessingService` | String inspection, palindrome, search |
| `QuizService` | Quiz data access (static data) |
| New service | Only if none of the above fit — add a new `object <Domain>Service` |

## Step 3 — Add the method

Add a `fun` to the appropriate service `object`:

```kotlin
// ─── <Domain>Service ──────────────────────────────────────────────────────────

object <Domain>Service {

    // <one-line description of what this method does>
    fun <methodName>(<params>): <ReturnType> {
        // implementation
    }
}
```

Rules:
- Top-level `fun` in a Kotlin `object` — no stored properties, no state
- If the method can fail with user-visible errors, throw `ValidationError` (do not return nullable)
- Pure functions: same input → same output; no global state
- No Android imports (no Context, no resources) — services are pure Kotlin
- Follow `ValidationService.validateNonBlank` pattern for validation methods

```kotlin
// Example: validation method
fun validatePositiveNumber(input: String, field: String): Double {
    val value = input.toDoubleOrNull()
        ?: throw ValidationError.InvalidFormat(field)
    if (value <= 0) throw ValidationError.InvalidRange(field)
    return value
}

// Example: calculation method
fun computeAverage(grades: List<Double>): Double {
    require(grades.isNotEmpty())
    return grades.sum() / grades.size
}
```

## Step 4 — Add unit tests

Add tests in `core/services/src/test/kotlin/com/zodiak/android/core/services/<ServiceName>Test.kt` (create file if it doesn't exist):

```kotlin
class <ServiceName>Test {

    @Test
    fun `<methodName> with valid input returns expected result`() {
        val result = <ServiceName>.<methodName>(<validArgs>)
        assertThat(result).isEqualTo(<expectedValue>)
    }

    @Test
    fun `<methodName> with invalid input throws ValidationError`() {
        assertThrows<ValidationError> {
            <ServiceName>.<methodName>(<invalidArgs>)
        }
    }

    @Test
    fun `<methodName> at boundary values returns correct result`() {
        // test min/max boundary
    }
}
```

## Step 5 — Wire to ViewModel

If a feature's ViewModel should call this new method, update its `submit()`:

```kotlin
fun submit() {
    try {
        val result = <ServiceName>.<methodName>(_uiState.value.<inputField>)
        _uiState.update { it.copy(result = result, error = null) }
    } catch (e: ValidationError) {
        _uiState.update { it.copy(error = e, result = null) }
    }
}
```

## Step 6 — Summary
Report:
- File modified / created
- Method signature added
- Test cases added
- ViewModel(s) updated
