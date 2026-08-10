> **Platform**: Android

# ⏳ ZodiakToast — Ephemeral Messages

iOS: Ephemeral floating message via `.zodiakToast()` view modifier.

**Android placeholder:**
```kotlin
// TODO: replace with ZodiakToast when ported
val snackbarHostState = remember { SnackbarHostState() }
LaunchedEffect(uiState.toastMessage) {
    uiState.toastMessage?.let {
        snackbarHostState.showSnackbar(it, duration = SnackbarDuration.Short)
    }
}
```

---
