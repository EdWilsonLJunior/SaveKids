> **Platform**: Android

# ZodiakEmptyState ✅ Ported

```kotlin
@Composable
fun ZodiakEmptyState(
    title: String,
    message: String,
    modifier: Modifier = Modifier,
    icon: ImageVector = Icons.Outlined.SearchOff,
    actionLabel: String? = null,
    onAction: (() -> Unit)? = null,
)
```

iOS equivalent: `ZodiakEmptyState`

**When to use:** Empty list or no-results state. Optionally includes a primary action button.

```kotlin
// ✅ Empty task list with action
ZodiakEmptyState(
    title = stringResource(R.string.feature_taskmanager_empty_title),
    message = stringResource(R.string.feature_taskmanager_empty_message),
    icon = Icons.Outlined.CheckCircle,
    actionLabel = stringResource(R.string.feature_taskmanager_add_action),
    onAction = viewModel::showAddDialog,
)

// ✅ No search results
ZodiakEmptyState(
    title = stringResource(R.string.shared_state_no_results),
    message = stringResource(R.string.shared_state_no_results_message),
)
```

---
