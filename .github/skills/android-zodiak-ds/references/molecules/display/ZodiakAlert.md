> **Platform**: Android

# ZodiakAlert ✅ Ported

```kotlin
enum class ZodiakAlertType { INFO, SUCCESS, WARNING, ERROR }

@Composable
fun ZodiakAlert(
    title: String,
    message: String,
    onDismiss: () -> Unit,
    type: ZodiakAlertType = ZodiakAlertType.INFO,
    confirmLabel: String = "OK",
    dismissLabel: String? = null,
    onConfirm: (() -> Unit)? = null,
    icon: ImageVector? = null,
)
```

iOS equivalent: `ZodiakAlert(title:variant:)` — but **important difference**:

<context>
- **iOS**: inline status banner inside a form
- **Android**: `AlertDialog` — a modal overlay
</context>

**When to use:** Modal dialogs — confirmations, errors that require acknowledgment, destructive action confirmation. Control visibility via a boolean in `UiState`.

```kotlin
// ✅ Error dialog
if (uiState.showErrorDialog) {
    ZodiakAlert(
        title = stringResource(R.string.shared_action_error),
        message = uiState.errorMessage,
        onDismiss = viewModel::dismissError,
        type = ZodiakAlertType.ERROR,
    )
}

// ✅ Confirmation before destructive action
if (uiState.showDeleteConfirm) {
    ZodiakAlert(
        title = stringResource(R.string.shared_action_delete),
        message = stringResource(R.string.shared_validation_delete_confirm),
        onDismiss = { viewModel.setDeleteConfirm(false) },
        confirmLabel = stringResource(R.string.shared_action_delete),
        dismissLabel = stringResource(R.string.shared_action_cancel),
        onConfirm = viewModel::confirmDelete,
        type = ZodiakAlertType.ERROR,
    )
}
```

**Anti-pattern:**
```kotlin
// ❌ Inline conditional — blocks UI and dialog flickers with recomposition
if (error != null) ZodiakAlert(title = "Erro", message = error!!, onDismiss = {})

// ✅ Always controlled by UiState boolean
if (uiState.showDialog) ZodiakAlert(..., onDismiss = viewModel::dismissDialog)
```

---
