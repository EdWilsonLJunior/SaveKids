> **Platform**: Android

# ⏳ ZodiakListTemplate — List with Empty State

iOS: Feature screen with a list and automatic empty state handling.

**Android pattern:**
```kotlin
// TODO: replace with ZodiakListTemplate when ported
Scaffold(
    floatingActionButton = {
        FloatingActionButton(onClick = viewModel::showAddDialog) {
            Icon(Icons.Default.Add, contentDescription = null)
        }
    }
) { paddingValues ->
    if (uiState.items.isEmpty()) {
        ZodiakEmptyState(
            title = stringResource(R.string.feature_name_empty_title),
            message = stringResource(R.string.feature_name_empty_message),
            modifier = Modifier.padding(paddingValues),
        )
    } else {
        LazyColumn(
            modifier = Modifier.padding(paddingValues),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp),
        ) {
            items(uiState.items, key = { it.id }) { item ->
                // item row
            }
        }
    }
}
```
