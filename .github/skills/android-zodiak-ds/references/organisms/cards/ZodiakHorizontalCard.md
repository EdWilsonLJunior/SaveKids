> **Platform**: Android

# ⏳ ZodiakHorizontalCard — Compact List Card

iOS: Card with image on left + text on right.

**Android placeholder:**
```kotlin
// TODO: replace with ZodiakHorizontalCard when ported
Card {
    Row(modifier = Modifier.padding(16.dp)) {
        AsyncImage(model = imageUrl, contentDescription = null, modifier = Modifier.size(72.dp))
        Spacer(Modifier.width(16.dp))
        Column {
            ZodiakTitle(text = title)
            ZodiakBody(text = subtitle)
        }
    }
}
```

---
