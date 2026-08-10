# Zodiak DS — Card Organisms API Reference (Android)

> Card organisms are **not yet ported** to Android. Use M3 `Card` as placeholder.
> Add `// TODO: replace with ZodiakXxx when ported` comments.

---

## General Card placeholder pattern

When any card organism from iOS is needed:

```kotlin
// TODO: replace with ZodiakXxxCard when ported
Card(
    modifier = modifier,
    shape = MaterialTheme.shapes.large,
    colors = CardDefaults.cardColors(
        containerColor = MaterialTheme.colorScheme.surface,
    ),
    elevation = CardDefaults.cardElevation(defaultElevation = 2.dp),
) {
    // content
}
```


---

## Components

| Component | File |
|---|---|
| `ZodiakCardGrid` | [cards/ZodiakCardGrid.md](cards/ZodiakCardGrid.md) |
| `ZodiakHorizontalCard` | [cards/ZodiakHorizontalCard.md](cards/ZodiakHorizontalCard.md) |
| `ZodiakTypographicCard` | [cards/ZodiakTypographicCard.md](cards/ZodiakTypographicCard.md) |
| `ZodiakShortFactsCard` | [cards/ZodiakShortFactsCard.md](cards/ZodiakShortFactsCard.md) |

