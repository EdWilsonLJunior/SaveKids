> **Platform**: Android

# ZodiakOutlinedButton — Secondary ✅ Ported

```kotlin
@Composable
fun ZodiakOutlinedButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
)
```

**When to use:** Secondary action — outlined, 48dp. Max ~4 per screen. Use for Reset, Cancel, Back actions.

```kotlin
// ✅ Reset after result is shown
if (uiState.result != null) {
    ZodiakOutlinedButton(
        text = stringResource(R.string.shared_action_reset),
        onClick = viewModel::reset,
        modifier = Modifier.fillMaxWidth(),
    )
}
```

---
