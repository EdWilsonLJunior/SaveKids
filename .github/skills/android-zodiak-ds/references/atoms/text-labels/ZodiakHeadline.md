> **Platform**: Android

# ZodiakHeadline ✅ Ported

```kotlin
@Composable
fun ZodiakHeadline(
    text: String,
    modifier: Modifier = Modifier,
    color: Color = Color.Unspecified,
)
```

Style: `MaterialTheme.typography.headlineSmall` (24sp SemiBold)
iOS equivalent: `ZodiakText(style: .headline)`

**When to use:** Primary result, hero value, or page-level title. Max 1 per screen.

```kotlin
// ✅ Hero result
ZodiakHeadline(text = uiState.result ?: "–")

// ✅ With semantic color (e.g., pass/fail)
ZodiakHeadline(
    text = if (grade.isPassing) "Aprovado" else "Reprovado",
    color = if (grade.isPassing) MaterialTheme.colorScheme.tertiary
            else MaterialTheme.colorScheme.error,
)
```

---
