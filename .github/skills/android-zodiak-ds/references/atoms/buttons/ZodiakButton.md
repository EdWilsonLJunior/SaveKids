> **Platform**: Android

# ZodiakButton — Primary CTA ✅ Ported

```kotlin
@Composable
fun ZodiakButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    contentPadding: PaddingValues = ButtonDefaults.ContentPadding,
)
```

**When to use:** Primary call-to-action. Filled background, 48dp height. Max 1–2 per screen.

```kotlin
// ✅ Correct
ZodiakButton(
    text = stringResource(R.string.feature_grades_calculate_action),
    onClick = viewModel::submit,
    modifier = Modifier.fillMaxWidth(),
)

// ✅ Disabled state
ZodiakButton(
    text = stringResource(R.string.shared_action_save),
    onClick = viewModel::save,
    enabled = uiState.isFormValid,
)
```

---
