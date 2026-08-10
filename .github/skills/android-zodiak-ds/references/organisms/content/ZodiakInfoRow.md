> **Platform**: Android

# ZodiakInfoRow ✅ Ported

```kotlin
@Composable
fun ZodiakInfoRow(
    label: String,
    value: String,
    modifier: Modifier = Modifier,
    valueColor: Color = Color.Unspecified,
)
```

iOS equivalent: `ZodiakInfoRow(.data)`

**When to use:** Key/value display row inside a results section. Label left, value right.

```kotlin
// ✅ Results section
ZodiakInfoRow(
    label = stringResource(R.string.feature_grades_average_label),
    value = "%.1f".format(uiState.average),
)
ZodiakInfoRow(
    label = stringResource(R.string.feature_grades_situation_label),
    value = stringResource(
        if (uiState.isPassing) R.string.shared_state_passed else R.string.shared_state_failed
    ),
    valueColor = if (uiState.isPassing) MaterialTheme.colorScheme.tertiary
                 else MaterialTheme.colorScheme.error,
)
```

---
