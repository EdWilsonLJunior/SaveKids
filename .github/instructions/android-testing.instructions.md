---
applyTo: "ZodiakAndroid/**/*.kt"
---

# Testing Conventions — ZodiakAndroid

## Framework

<rules>
Use **JUnit 5** exclusively. Do NOT use JUnit 4 (`org.junit.Test`) for new unit tests.
</rules>

```kotlin
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.extension.ExtendWith
import com.google.common.truth.Truth.assertThat
```

---

## Setup

Every ViewModel test file must extend with `MainDispatcherExtension`:

```kotlin
@ExtendWith(MainDispatcherExtension::class)
class FeatureNameViewModelTest {

    private lateinit var viewModel: FeatureNameViewModel

    @BeforeEach
    fun setUp() {
        viewModel = FeatureNameViewModel()
    }
}
```

`MainDispatcherExtension` is in `:core:testing` — it replaces `Dispatchers.Main` with `StandardTestDispatcher` so coroutine-based state changes are testable synchronously.

---

## File and Class Naming

| Item | Convention | Example |
|---|---|---|
| File | `<FeatureName>ViewModelTest.kt` | `CurrencyConverterViewModelTest.kt` |
| Class | `class <FeatureName>ViewModelTest` | `class CurrencyConverterViewModelTest` |
| Test method | backtick descriptive name, pt-BR or English | `` `submit with blank name shows error` `` |

---

## Minimum Coverage per ViewModel

Every ViewModel test class MUST cover these 4 scenarios:

```kotlin
@ExtendWith(MainDispatcherExtension::class)
class FeatureNameViewModelTest {

    private lateinit var viewModel: FeatureNameViewModel

    @BeforeEach
    fun setUp() {
        viewModel = FeatureNameViewModel()
    }

    // 1. Initial state
    @Test
    fun `initial state has empty inputs and no result`() {
        val state = viewModel.uiState.value
        assertThat(state.input).isEmpty()
        assertThat(state.result).isNull()
        assertThat(state.error).isNull()
    }

    // 2. Happy path
    @Test
    fun `submit with valid input produces result`() {
        viewModel.onInputChange(<validValue>)
        viewModel.submit()
        assertThat(viewModel.uiState.value.result).isNotNull()
        assertThat(viewModel.uiState.value.error).isNull()
    }

    // 3. Validation failure
    @Test
    fun `submit with invalid input sets error`() {
        viewModel.onInputChange(<invalidValue>)
        viewModel.submit()
        assertThat(viewModel.uiState.value.error).isNotNull()
        assertThat(viewModel.uiState.value.result).isNull()
    }

    // 4. Reset clears all state
    @Test
    fun `reset clears all state`() {
        viewModel.onInputChange(<someValue>)
        viewModel.submit()
        viewModel.reset()
        val state = viewModel.uiState.value
        assertThat(state.input).isEmpty()
        assertThat(state.result).isNull()
        assertThat(state.error).isNull()
    }
}
```

---

## StateFlow Testing with Turbine

For async state changes (ViewModels with `viewModelScope.launch`), use **Turbine**:

```kotlin
import app.cash.turbine.test
import kotlinx.coroutines.test.runTest

@Test
fun `submit emits loading then result`() = runTest {
    viewModel.uiState.test {
        val initial = awaitItem()
        assertThat(initial.isLoading).isFalse()

        viewModel.submit()

        val loading = awaitItem()
        assertThat(loading.isLoading).isTrue()

        val result = awaitItem()
        assertThat(result.result).isNotNull()
        assertThat(result.isLoading).isFalse()

        cancelAndIgnoreRemainingEvents()
    }
}
```

---

## Service Testing

Services in `core:services` are pure Kotlin `object` — test them directly without mocks:

```kotlin
class ValidationServiceTest {

    @Test
    fun `validateNonBlank with blank string throws BlankField`() {
        val exception = assertThrows<ValidationError.BlankField> {
            ValidationService.validateNonBlank("", "name")
        }
        assertThat(exception.field).isEqualTo("name")
    }

    @Test
    fun `validateNonBlank with valid string does not throw`() {
        // Should not throw
        ValidationService.validateNonBlank("João", "name")
    }
}
```

For ViewModels that depend on services: test through the ViewModel using valid/invalid inputs. Do NOT mock `core:services` objects — they are stateless and have no side effects.

---

## MockK Usage

Use MockK only for external dependencies (repositories, DataStore). Never mock service objects.

```kotlin
import io.mockk.mockk
import io.mockk.coEvery
import kotlinx.coroutines.flow.flowOf

@ExtendWith(MainDispatcherExtension::class)
class LoginViewModelTest {

    private val preferences: ZodiakPreferencesRepository = mockk(relaxed = true)
    private lateinit var viewModel: LoginViewModel

    @BeforeEach
    fun setUp() {
        coEvery { preferences.savedEmail } returns flowOf("")
        viewModel = LoginViewModel(preferences)
    }
}
```

---

## Edge Cases to Always Cover

<pitfalls>

For any ViewModel that accepts numeric input:
- Blank/empty string → `error != null`
- Negative value where only positive is valid → `error != null`
- Value at the boundary (min, max) → `result != null`

For list-based ViewModels (TaskManager, PersonManager, ProductManager):
- Add item → list size increases by 1
- Remove item → item no longer in list
- Add duplicate / blank → `error != null`

</pitfalls>
