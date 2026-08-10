> **Platform**: Android

# ZodiakCaption ✅ Ported

```kotlin
@Composable
fun ZodiakCaption(
    text: String,
    modifier: Modifier = Modifier,
    color: Color = Color.Unspecified,
)
```

Style: `MaterialTheme.typography.bodySmall` (12sp Normal)
iOS equivalent: `ZodiakText(style: .caption())`

**When to use:** Secondary metadata, timestamps, unit labels, spec keys.

```kotlin
// ✅ Muted caption
ZodiakCaption(
    text = stringResource(R.string.shared_format_age_years, person.age),
    color = MaterialTheme.colorScheme.onSurfaceVariant,
)
```

---
