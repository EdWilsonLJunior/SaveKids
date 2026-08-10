> **Platform**: Android

# ZodiakChipGroup ✅ Ported

```kotlin
@Composable
fun <T> ZodiakChipGroup(
    items: List<T>,
    selectedItem: T,
    onSelect: (T) -> Unit,
    label: (T) -> String,
    modifier: Modifier = Modifier,
)
```

iOS equivalent: `ZodiakChipGroup` (single-select)

**When to use:** Single-select filter strip. Horizontally scrollable row of `FilterChip`.

```kotlin
// ✅ Quiz theme selector
ZodiakChipGroup(
    items = QuizTheme.entries,
    selectedItem = uiState.selectedTheme,
    onSelect = viewModel::onThemeSelect,
    label = { theme -> stringResource(theme.labelRes) },
)
```

---
