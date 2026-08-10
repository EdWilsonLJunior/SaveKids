> **Platform**: Android

# ZodiakDestructiveButton — Delete / Danger ✅ Ported

```kotlin
@Composable
fun ZodiakDestructiveButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
)
```

**When to use:** Destructive actions (delete item, clear data). Uses `MaterialTheme.colorScheme.error` fill. Always follow with a confirmation dialog (`ZodiakAlert`).

```kotlin
// ✅ With confirmation
ZodiakDestructiveButton(
    text = stringResource(R.string.shared_action_delete),
    onClick = { uiState = uiState.copy(showDeleteDialog = true) },
)
if (uiState.showDeleteDialog) {
    ZodiakAlert(
        title = stringResource(R.string.shared_action_delete),
        message = stringResource(R.string.shared_validation_delete_confirm),
        onDismiss = { uiState = uiState.copy(showDeleteDialog = false) },
        onConfirm = viewModel::deleteItem,
        type = ZodiakAlertType.ERROR,
    )
}
```

---
