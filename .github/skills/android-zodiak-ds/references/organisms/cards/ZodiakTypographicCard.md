> **Platform**: Android

# ⏳ ZodiakTypographicCard — Text-only Card

iOS: Text-only card with optional icon/number — no image required.

**Android placeholder:**
```kotlin
// TODO: replace with ZodiakTypographicCard when ported
Card(
    modifier = Modifier.fillMaxWidth(),
    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surfaceVariant),
) {
    Column(modifier = Modifier.padding(16.dp)) {
        ZodiakTitle(text = title)
        Spacer(Modifier.height(8.dp))
        ZodiakBody(text = description)
    }
}
```

---
