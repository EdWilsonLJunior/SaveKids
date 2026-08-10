> **Platform**: Android

# ⏳ ZodiakModal — Critical Overlays

iOS: Modal overlay for critical decisions, required input, or permissions.

**Android placeholder:**
```kotlin
// TODO: replace with ZodiakModal when ported
// Use ZodiakAlert for simple confirmations
// Use ModalBottomSheet for complex forms
if (uiState.showModal) {
    AlertDialog(
        onDismissRequest = viewModel::dismissModal,
        title = { Text(title) },
        text = { Text(message) },
        confirmButton = { TextButton(onClick = onConfirm) { Text("OK") } },
    )
}
```

---
