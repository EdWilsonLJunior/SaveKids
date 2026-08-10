---
description: "Create a new feature module in ZodiakAndroid. Use when adding a new screen/feature. Creates the Gradle module + ViewModel + Screen + Navigation + strings + unit tests."
argument-hint: "Feature name (e.g. CurrencyConverter)"
agent: "agent"
tools: [read, edit, search, execute]
---

Create a new feature for: $input

## Step 1 — Read the project structure
Read `features/` to list existing feature modules. The new module will follow the same naming pattern: `feature-<lowercasename>`.

Read one existing feature module (e.g. `features/feature-grades/`) to understand the full file structure:
- `build.gradle.kts`
- `src/main/kotlin/.../FeatureNameViewModel.kt`
- `src/main/kotlin/.../FeatureNameScreen.kt`
- `src/main/kotlin/.../FeatureNameNavigation.kt`
- `src/test/kotlin/.../FeatureNameViewModelTest.kt`

Also read `build-logic/src/main/kotlin/zodiak.android.feature.gradle.kts` to understand what the convention plugin provides.

## Step 2 — Create the Gradle module

Create `features/feature-<name>/build.gradle.kts`:
```kotlin
plugins {
    alias(libs.plugins.zodiak.android.feature)
}
```

Create `features/feature-<name>/src/main/AndroidManifest.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest />
```

Add the module to `settings.gradle.kts` under the features section:
```kotlin
include(":features:feature-<name>")
```

## Step 3 — Create `<Name>Navigation.kt`

```kotlin
package com.zodiak.android.feature.<name>

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable
object <Name>Route

fun NavGraphBuilder.<name>Screen() {
    composable<<Name>Route> { <Name>Screen() }
}
```

## Step 4 — Create `<Name>UiState` + `<Name>ViewModel.kt`

```kotlin
package com.zodiak.android.feature.<name>

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

// ─── UiState ──────────────────────────────────────────────────────────────────

data class <Name>UiState(
    val <inputField>: String = "",
    val result: <ResultType>? = null,
    val error: ValidationError? = null,
)

// ─── ViewModel ────────────────────────────────────────────────────────────────

@HiltViewModel
class <Name>ViewModel @Inject constructor() : ViewModel() {

    private val _uiState = MutableStateFlow(<Name>UiState())
    val uiState: StateFlow<<Name>UiState> = _uiState.asStateFlow()

    fun on<Field>Change(value: String) {
        _uiState.update { it.copy(<inputField> = value, error = null) }
    }

    fun submit() {
        try {
            val result = <ServiceName>.<method>(_uiState.value.<inputField>)
            _uiState.update { it.copy(result = result, error = null) }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun reset() {
        _uiState.update { <Name>UiState() }
    }
}
```

Rules:
- `@HiltViewModel` + `@Inject constructor()` — no exceptions
- `_uiState.update { it.copy(...) }` is the only mutation mechanism
- Business logic via `core:services` (object Kotlin), not inline in ViewModel
- Never resolve strings or access resources in ViewModel
- `reset()` must restore to the initial `<Name>UiState()` value

## Step 5 — Create `<Name>Screen.kt`

```kotlin
package com.zodiak.android.feature.<name>

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.*
import com.zodiak.android.design_system.molecules.*
import com.zodiak.android.design_system.organisms.*

// ─── Screen ───────────────────────────────────────────────────────────────────

@Composable
fun <Name>Screen(
    viewModel: <Name>ViewModel = hiltViewModel(),
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()

    <Name>Content(
        uiState = uiState,
        onInputChange = viewModel::on<Field>Change,
        onSubmit = viewModel::submit,
        onReset = viewModel::reset,
    )
}

@Composable
private fun <Name>Content(
    uiState: <Name>UiState,
    onInputChange: (String) -> Unit,
    onSubmit: () -> Unit,
    onReset: () -> Unit,
) {
    Scaffold { paddingValues ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakFormContainer(
                    title = stringResource(R.string.feature_<name>_title),
                ) {
                    ZodiakInputField(
                        value = uiState.<inputField>,
                        onValueChange = onInputChange,
                        label = stringResource(R.string.feature_<name>_<field>_label),
                        errorMessage = uiState.error?.let {
                            stringResource(R.string.shared_validation_blank_field)
                        },
                    )
                    Spacer(Modifier.height(16.dp))
                    ZodiakButton(
                        text = stringResource(R.string.feature_<name>_submit_action),
                        onClick = onSubmit,
                        modifier = Modifier.fillMaxWidth(),
                    )
                }
            }

            uiState.result?.let { result ->
                item {
                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        ZodiakInfoRow(
                            label = stringResource(R.string.shared_label_result),
                            value = result.toString(),
                        )
                        ZodiakOutlinedButton(
                            text = stringResource(R.string.shared_action_reset),
                            onClick = onReset,
                            modifier = Modifier.fillMaxWidth(),
                        )
                    }
                }
            }
        }
    }
}
```

Rules:
- `Scaffold` is the mandatory screen root — never raw `Column` or `LazyColumn`
- No hardcoded colors — use `MaterialTheme.colorScheme.*`
- No hardcoded strings — use `stringResource(R.string.*)`
- No hardcoded spacing outside the 4dp grid
- Visual quality: hero result uses `ZodiakHeadline`, metadata uses `ZodiakCaption`
- Add `AnimatedVisibility` to the result section for entrance animation

## Step 6 — Add localization strings

Create `features/feature-<name>/src/main/res/values/strings.xml`:
```xml
<resources>
    <string name="feature_<name>_title">Feature Title</string>
    <string name="feature_<name>_<field>_label">Field Label</string>
    <string name="feature_<name>_submit_action">Submit</string>
</resources>
```

Create `features/feature-<name>/src/main/res/values-pt-BR/strings.xml`:
```xml
<resources>
    <string name="feature_<name>_title">Título da Feature</string>
    <string name="feature_<name>_<field>_label">Rótulo do Campo</string>
    <string name="feature_<name>_submit_action">Enviar</string>
</resources>
```

Both `values/` (en) and `values-pt-BR/` are required for every key.

## Step 7 — Create `<Name>ViewModelTest.kt`

Follow `.github/instructions/android-testing.instructions.md`. The test must cover:
- Initial state
- Happy path (submit with valid input → result != null)
- Validation failure (submit with invalid input → error != null)
- Reset clears all state

## Step 8 — Register in NavGraph

Read `app/src/main/kotlin/com/zodiak/android/navigation/ZodiakNavGraph.kt` and add:
```kotlin
import com.zodiak.android.feature.<name>.<name>Screen

// Inside NavHost block:
<name>Screen()
```

Also read `app/src/main/kotlin/com/zodiak/android/navigation/ZodiakNavigationSuite.kt` and add a nav item for the new feature.

## Step 9 — Summary
Return a summary listing:
- All files created (with paths)
- All string keys added
- Any validation issues
