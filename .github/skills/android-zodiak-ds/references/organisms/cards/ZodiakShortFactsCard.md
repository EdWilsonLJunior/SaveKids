> **Platform**: Android

# ⏳ ZodiakShortFactsCard — Key Metrics Grid

iOS: Grid of icon + value + label facts (key metrics, stats).

**Android placeholder:**
```kotlin
// TODO: replace with ZodiakShortFactsCard when ported
Card {
    LazyVerticalGrid(columns = GridCells.Fixed(2)) {
        items(facts) { fact ->
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Icon(fact.icon, contentDescription = null)
                ZodiakHeadline(text = fact.value)
                ZodiakCaption(text = fact.label)
            }
        }
    }
}
```

---
