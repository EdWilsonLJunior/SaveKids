> **Platform**: Android

# ⏳ ZodiakInputOutputTemplate — Input + Pinned Submit

iOS: Form with inputs at top, submit button pinned to bottom.

**Android pattern:**
```kotlin
// TODO: replace with ZodiakInputOutputTemplate when ported
Scaffold(
    bottomBar = {
        Surface(shadowElevation = 4.dp) {
            ZodiakButton(
                text = stringResource(R.string.feature_name_submit_action),
                onClick = viewModel::submit,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
            )
        }
    }
) { paddingValues ->
    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .padding(paddingValues)
            .padding(horizontal = 16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
        contentPadding = PaddingValues(vertical = 16.dp),
    ) {
        item { ZodiakFormContainer(title = ...) { /* inputs */ } }
        item { /* result section */ }
    }
}
```

---
