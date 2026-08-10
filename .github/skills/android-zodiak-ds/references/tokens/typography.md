# Zodiak DS — Typography (`MaterialTheme.typography`)

> **Source**: `design-system/src/main/kotlin/com/zodiak/android/design_system/theme/`
> Last synced: 2026-05-13

---

## Scale

| Token | Size | Weight | Zodiak iOS mapping | DS Atom |
|---|---|---|---|---|
| `headlineLarge` | 32sp | SemiBold | `ZodiakTextStyle.headline` | — (rarely used) |
| `headlineMedium` | 28sp | SemiBold | — | — |
| `headlineSmall` | 24sp | SemiBold | `ZodiakTextStyle.headline` | `ZodiakHeadline` |
| `titleLarge` | 22sp | SemiBold | — | — |
| `titleMedium` | 16sp | Medium | `ZodiakTextStyle.title2` | `ZodiakTitle` |
| `titleSmall` | 14sp | Medium | `ZodiakTextStyle.title3` | `ZodiakTitle` |
| `bodyLarge` | 16sp | Normal | `ZodiakTextStyle.body()` | `ZodiakBody` |
| `bodyMedium` | 14sp | Normal | `ZodiakTextStyle.body()` | `ZodiakBody` |
| `bodySmall` | 12sp | Normal | `ZodiakTextStyle.caption()` | `ZodiakCaption` |
| `labelLarge` | 14sp | Medium | button label | `ZodiakLabel` |
| `labelMedium` | 12sp | Medium | — | `ZodiakLabel` |
| `labelSmall` | 11sp | Medium | — | (badge text, internal) |

---

## Usage — always via DS Atoms

<rules>

```kotlin
ZodiakHeadline(text = result)           // headlineSmall — hero value
ZodiakTitle(text = sectionTitle)        // titleMedium — section header
ZodiakBody(text = description)          // bodyMedium — body text
ZodiakLabel(text = fieldLabel)          // labelMedium — field label
ZodiakCaption(text = metadata)          // bodySmall — metadata/spec
```

</rules>
