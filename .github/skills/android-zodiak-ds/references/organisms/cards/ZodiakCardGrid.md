> **Platform**: Android

# ⏳ ZodiakCardGrid — Responsive Card Grid

iOS: Responsive grid of standard cards (2–9 cards, optional ShowMore).

**Android placeholder:**
```kotlin
// TODO: replace with ZodiakCardGrid when ported
LazyVerticalGrid(
    columns = GridCells.Adaptive(minSize = 160.dp),
    horizontalArrangement = Arrangement.spacedBy(16.dp),
    verticalArrangement = Arrangement.spacedBy(16.dp),
) {
    items(cards) { card ->
        Card(modifier = Modifier.fillMaxWidth()) {
            // card content
        }
    }
}
```

---
