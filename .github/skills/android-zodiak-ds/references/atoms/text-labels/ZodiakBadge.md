> **Platform**: Android

# ZodiakBadge ✅ Ported

```kotlin
enum class ZodiakBadgeVariant { SUCCESS, WARNING, ERROR, INFO, NEUTRAL }

@Composable
fun ZodiakBadge(
    text: String,
    variant: ZodiakBadgeVariant = ZodiakBadgeVariant.INFO,
    modifier: Modifier = Modifier,
)
```

iOS equivalent: `ZodiakSuccessBadge` / `ZodiakErrorBadge` / `ZodiakWarningBadge` / `ZodiakBadge`

**Variant color mapping:**

| Variant | Container | Content |
|---|---|---|
| `SUCCESS` | `tertiaryContainer` | `onTertiaryContainer` |
| `WARNING` | `secondaryContainer` | `onSecondaryContainer` |
| `ERROR` | `errorContainer` | `onErrorContainer` |
| `INFO` | `primaryContainer` | `onPrimaryContainer` |
| `NEUTRAL` | `surfaceVariant` | `onSurfaceVariant` |

<rules>
**When to use:** Semantic state feedback only — result of an operation. Never decorative.
</rules>

```kotlin
// ✅ Semantic feedback
ZodiakBadge(
    text = stringResource(R.string.shared_state_passed),
    variant = ZodiakBadgeVariant.SUCCESS,
)

// ❌ Decorative — do not use
ZodiakBadge("Novo!", variant = ZodiakBadgeVariant.SUCCESS)
```

---
