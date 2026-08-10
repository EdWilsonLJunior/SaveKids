> **Platform**: Android

# ZodiakInputField ✅ Ported

```kotlin
@Composable
fun ZodiakInputField(
    value: String,
    onValueChange: (String) -> Unit,
    label: String,
    modifier: Modifier = Modifier,
    placeholder: String? = null,
    errorMessage: String? = null,
    isPassword: Boolean = false,
    keyboardType: KeyboardType = KeyboardType.Text,
    imeAction: ImeAction = ImeAction.Next,
    singleLine: Boolean = true,
)
```

iOS equivalent: `ZodiakLabelledField`

**When to use:** Standard labeled text input for feature screens. Wraps `ZodiakTextField` with error state. Prefer over raw `ZodiakTextField` in all feature screens.

```kotlin
// ✅ Standard form field
ZodiakInputField(
    value = uiState.studentName,
    onValueChange = viewModel::onNameChange,
    label = stringResource(R.string.feature_grades_student_name_label),
    errorMessage = uiState.nameError?.let {
        stringResource(R.string.shared_validation_blank_field)
    },
    imeAction = ImeAction.Next,
)

// ✅ Numeric input
ZodiakInputField(
    value = uiState.grade,
    onValueChange = viewModel::onGradeChange,
    label = stringResource(R.string.feature_grades_grade_label),
    keyboardType = KeyboardType.Decimal,
    imeAction = ImeAction.Done,
)

// ✅ Password input
ZodiakInputField(
    value = uiState.password,
    onValueChange = viewModel::onPasswordChange,
    label = stringResource(R.string.shared_label_password),
    isPassword = true,
)
```

---
