---
applyTo: "ZodiakAndroid/**/*.kt"
---

# Localization Conventions — ZodiakAndroid

## Source of Truth

Strings are distributed by module using the Android resource system.

| Type | File | Module |
|---|---|---|
| App name, tab labels, global navigation | `app/src/main/res/values/strings.xml` | `:app` |
| Reusable strings (actions, validation, labels) | `app/src/main/res/values/strings_shared.xml` | `:app` |
| Feature-specific strings | `features/feature-<name>/src/main/res/values/strings.xml` | `:features:feature-<name>` |

Each `values/strings.xml` (English — default) must have a mirror at `values-pt-BR/strings.xml` (Brazilian Portuguese).

Languages: **English (`values/`)** · **Portuguese Brazil (`values-pt-BR/`)**.

> **Current state:** most strings in the project are hardcoded in pt-BR directly in Composables. When editing or creating a screen, migrate that screen's strings to the corresponding module's `strings.xml`.

---

## Key Naming Convention

Resource names follow **snake_case** with namespace prefix: `<scope>_<context>_<name>`

| Prefix | Use | Module |
|---|---|---|
| `app_tab_*` | Main navigation labels | `:app` |
| `feature_<name>_*` | Strings specific to one feature | `feature-<name>` |
| `shared_action_*` | Reusable action labels (Cancel, Save, …) | `:app` |
| `shared_label_*` | Reusable field labels (Name, Email, …) | `:app` |
| `shared_placeholder_*` | Reusable placeholder hints | `:app` |
| `shared_validation_*` | Validation error messages | `:app` |
| `shared_state_*` | State indicators (Passed, Failed, …) | `:app` |
| `shared_format_*` | Format strings with `%s`, `%d`, `%.1f` | `:app` |
| `shared_accessibility_*` | Accessibility-only labels | `:app` |

### Key examples
```
app_tab_catalog
feature_grades_title
feature_grades_student_name_label
feature_grades_calculate_action
feature_taskmanager_empty_state
shared_action_cancel
shared_action_save
shared_validation_blank_field
shared_format_age_years           ← "Age: %d years" / "Idade: %d anos"
shared_state_passed               ← "Passed" / "Aprovado"
```

---

## Adding a New String

### 1. Create/edit the module's `strings.xml`

```xml
<!-- features/feature-grades/src/main/res/values/strings.xml -->
<resources>
    <string name="feature_grades_title">Grades</string>
    <string name="feature_grades_student_name_label">Student Name</string>
    <string name="feature_grades_calculate_action">Calculate</string>
</resources>
```

```xml
<!-- features/feature-grades/src/main/res/values-pt-BR/strings.xml -->
<resources>
    <string name="feature_grades_title">Notas</string>
    <string name="feature_grades_student_name_label">Nome do Aluno</string>
    <string name="feature_grades_calculate_action">Calcular</string>
</resources>
```

**Always provide both `values/` (en) and `values-pt-BR/` at the same time.**

### 2. Use in Compose

**Static label or title:**
```kotlin
// ✅ Correct
ZodiakFormContainer(title = stringResource(R.string.feature_grades_title)) {
    ZodiakInputField(
        label = stringResource(R.string.feature_grades_student_name_label),
        ...
    )
    ZodiakButton(
        text = stringResource(R.string.feature_grades_calculate_action),
        onClick = viewModel::submit,
    )
}
```

**Format string with argument:**
```kotlin
// values/strings.xml:       <string name="shared_format_age_years">Age: %d years</string>
// values-pt-BR/strings.xml: <string name="shared_format_age_years">Idade: %d anos</string>

// ✅ Correct — runtime locale is applied automatically
Text(stringResource(R.string.shared_format_age_years, person.age))
```

**Plurals:**
```xml
<!-- features/feature-taskmanager/src/main/res/values/plurals.xml -->
<resources>
    <plurals name="feature_taskmanager_task_count">
        <item quantity="one">%d task</item>
        <item quantity="other">%d tasks</item>
    </plurals>
</resources>
```
```kotlin
pluralStringResource(R.plurals.feature_taskmanager_task_count, count, count)
```

---

## ViewModel Rule

<rules>
ViewModels **never** resolve strings. Do not inject `Context` or call `stringResource()` in ViewModels.

Expose `ValidationError` (sealed class) and resolve text in the Compose layer:
</rules>

```kotlin
// ✅ ViewModel — exposes type, not string
_uiState.update { it.copy(error = ValidationError.BlankField("studentName")) }

// ✅ Screen — resolves string in the Composable
val errorText = when (val err = uiState.error) {
    is ValidationError.BlankField -> stringResource(R.string.shared_validation_blank_field)
    is ValidationError.InvalidRange -> stringResource(R.string.shared_validation_invalid_range)
    null -> null
}
```

---

## Common Pitfalls

<never>
```kotlin
// ❌ Hardcoded string — not localizable
ZodiakFormContainer(title = "Calcular Notas")

// ✅ Correct
ZodiakFormContainer(title = stringResource(R.string.feature_grades_title))

// ❌ String interpolation without R.string
Text("Idade: ${person.age} anos")

// ✅ Correct
Text(stringResource(R.string.shared_format_age_years, person.age))

// ❌ Emoji hardcoded as state indicator
ZodiakInfoRow(value = if (grade.isPassing) "✅ Aprovado" else "❌ Reprovado")

// ✅ Correct — localizable text; semantic icon via DS if needed
ZodiakInfoRow(
    value = stringResource(
        if (grade.isPassing) R.string.shared_state_passed else R.string.shared_state_failed
    )
)

// ❌ String resolved in ViewModel
_uiState.update { it.copy(errorText = "Campo obrigatório") }

// ✅ Correct — type in ViewModel, string in Composable
_uiState.update { it.copy(error = ValidationError.BlankField("name")) }
```

</never>
