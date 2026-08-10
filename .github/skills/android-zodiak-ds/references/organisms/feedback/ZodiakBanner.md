> **Platform**: Android

# ⏳ ZodiakBanner — Global Messages

iOS: Full-width top banner for global messages.

**Android placeholder:**
```kotlin
// TODO: replace with ZodiakBanner when ported
val snackbarHostState = remember { SnackbarHostState() }
Scaffold(
    snackbarHost = { SnackbarHost(snackbarHostState) },
) { ... }
// Trigger:
LaunchedEffect(uiState.bannerMessage) {
    uiState.bannerMessage?.let { snackbarHostState.showSnackbar(it) }
}
```

---
