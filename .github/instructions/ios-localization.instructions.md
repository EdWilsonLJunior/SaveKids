---
applyTo: "ZodiakiOS/**/*.swift"
---

# Localization Conventions — ZodiakiOS

## Source of Truth
All localizable strings live in [`ZodiakiOS/Localizable.xcstrings`](../../ZodiakiOS/Localizable.xcstrings)
(String Catalog format, Xcode 15+). The legacy `.strings` files have been removed.
Languages: **English (`en`)** · **Portuguese Brazil (`pt-BR`)**.

---

## Key Naming Convention

Keys follow **dot-notation namespaces**: `<scope>.<context>.<name>`

| Namespace | Usage |
|-----------|-------|
| `app.tab.*` | Main tab bar labels |
| `app.settings.*` | Settings panel (language, theme) |
| `catalog.home.*` | Catalog home view (titles, tabs, search) |
| `catalog.component.*` | Component short descriptions and section names |
| `catalog.component_name.*` | Component sidebar item names |
| `catalog.composition_name.*` | Composition pattern names |
| `catalog.section.*` | Gallery section headers |
| `catalog.examples.*` | Real-world example descriptions |
| `catalog.spec.*` | Specification detail strings |
| `catalog.<component_name>.*` | Component-specific spec/hint strings |
| `feature.<feature_name>.*` | Feature screen strings (eyebrow, title, intro, labels, actions, errors) |
| `shared.action.*` | Reusable action button labels (Cancel, Save, …) |
| `shared.label.*` | Reusable field labels (Name, Email, …) |
| `shared.placeholder.*` | Reusable placeholder strings |
| `shared.validation.*` | Validation error messages |
| `shared.state.*` | Status/state indicators (Passed, Failed, Unavailable, …) |
| `shared.format.*` | Format strings containing `%@`, `%d`, `%.1f`, etc. |
| `shared.accessibility.*` | Accessibility-only labels (selected, on, off, …) |
| `shared.country.*` | Country names |
| `shared.rating.*` | Rating labels (Excellent, Poor, …) |
| `shared.nav.*` | Navigation labels |
| `shared.content.*` | Content-type labels |

### Key Examples
```
app.tab.overview
catalog.home.search_placeholder
feature.grades.title
feature.grades.calculate_action
shared.action.cancel
shared.format.age_years         ← "Idade: %d anos"
shared.accessibility.selected
```

---

## Adding a New String

<procedure>

### 1. Add to `Localizable.xcstrings`
Open the file in Xcode's String Catalog editor and add a new entry.
Always provide both `en` and `pt-BR` translations.

Or add directly in the JSON:
```json
"feature.my_feature.some_label" : {
  "extractionState" : "manual",
  "localizations" : {
    "en" : {
      "stringUnit" : { "state" : "translated", "value" : "English label" }
    },
    "pt-BR" : {
      "stringUnit" : { "state" : "translated", "value" : "Rótulo em português" }
    }
  }
}
```

### 2. Use in Swift

**Static label or title (in ZodiakText / ZodiakButton / ZodiakActivityTemplate):**
```swift
ZodiakText("feature.my_feature.some_label", style: .body())
ZodiakButton(title: "shared.action.save", ...)
```
These components call `LocalizedStringKey(text)` internally — the string is automatically localized.

**`ZodiakText` — `verbatim:` vs `LocalizedStringKey`:**

`ZodiakText` has two initializers — use the correct one based on content type:

| Content type | Correct initializer |
|---|---|
| Localization key (static string literal) | `ZodiakText("feature.key", style: ...)` |
| Runtime value / dynamic data | `ZodiakText(verbatim: someString, style: ...)` |
| Localization key with Int interpolation | `ZodiakText("feature.key \(someInt)", style: ...)` |

```swift
// ✅ Looks up "feature.my_feature.title" in xcstrings
ZodiakText("feature.my_feature.title", style: .title2)

// ✅ Shows user.name verbatim — not a localization key
ZodiakText(verbatim: user.name, style: .body())

// ✅ Format string: xcstrings key is "feature.my_feature.table_title %lld"
ZodiakText("feature.my_feature.table_title \(tableNumber)", style: .title2)

// ❌ Bug: "Prefix \(value)" with interpolation creates String type, falls back to verbatim
//    without verbatim: label, caller's intent is ambiguous and lookup silently fails
ZodiakText("Prefix \(dynamicValue)", style: .body())
```

For xcstrings format string entries (`Int` → `%lld`, `String` → `%@`):
```json
"feature.my_feature.table_title %lld" : {
  "extractionState" : "manual",
  "localizations" : {
    "en"    : { "stringUnit" : { "state" : "translated", "value" : "Table of %lld" } },
    "pt-BR" : { "stringUnit" : { "state" : "translated", "value" : "Tabuada do %lld" } }
  }
}
```

**Dynamic format string (non-ZodiakText):**
```swift
// Correct ✅ — resolve localization first, then format
String(
    format: String(localized: "shared.format.age_years", locale: locale),
    person.age)

// Wrong ❌ — does NOT localize, shows key literally
String(format: "shared.format.age_years", person.age)
```

**Direct localization lookup:**
```swift
Text("feature.my_feature.some_label")                       // SwiftUI auto-localizes
Text(LocalizedStringKey("shared.state.passed"))
String(localized: "app.settings.title", locale: locale)
```

**Accessibility labels:**
```swift
.accessibilityLabel(
    task.isCompleted
        ? Text("feature.task_manager.mark_pending")
        : Text("feature.task_manager.mark_done"))
```

</procedure>

---

## Common Localization Bugs

### Ternary produces `String`, not `LocalizedStringKey`

In Swift, `condition ? "key_a" : "key_b"` infers `String`. Passing a `String` to `Text()` calls
`Text<String>(content:)` (verbatim) — the raw key string is displayed, not its translated value.

```swift
// ❌ Bug: ternary = String → Text shows "catalog.spec.symbol_min_size" literally
Text(isSymbol ? "catalog.spec.symbol_min_size" : "catalog.spec.wordmark_min_size")

// ✅ Fix: if/else — each branch is a string literal typed as LocalizedStringKey
if isSymbol {
    Text("catalog.spec.symbol_min_size")
} else {
    Text("catalog.spec.wordmark_min_size")
}
```

Same rule applies to `ZodiakText` when using a runtime `String` condition result — use `if/else`.

### `Text(LocalizedStringKey(variable))` anti-pattern

When `variable` is a runtime `String` (not an enum rawValue), the lookup produces unpredictable
results — the string is treated as a key and silently falls back to itself.

```swift
// ❌ Misleading: "Principal" is not in xcstrings → falls back to itself
//    Future translators have no path to translate this string
Text(LocalizedStringKey(sectionTitle))

// ✅ Explicit verbatim — intent is clear: this is not a localization key
Text(verbatim: sectionTitle)

// ✅ Only valid when variable IS a localization key (e.g. enum rawValue registered in xcstrings)
Text(LocalizedStringKey(item.localizedKey))
```

---

## Do NOT use `#Preview` names as localization keys

<never>

`#Preview("Media Button")` labels are for Xcode Canvas only — keep them human-readable:
```swift
#Preview("Media Button") { ... }   // ✅ human-readable
#Preview("catalog.component_name.media_button") { ... }   // ❌ wrong
```

</never>

---

## Do NOT use enum raw values as localization keys

<never>

If a `LocalizedStringKey(item.rawValue)` pattern exists, the enum raw value IS the
localization key. Update the xcstrings entry when renaming those enum cases.

</never>

---

## Plural Rules

For strings with `%d`, add plural variations in the xcstrings editor:
```json
"shared.format.item_count" : {
  "localizations" : {
    "en" : {
      "variations" : {
        "plural" : {
          "one"   : { "stringUnit" : { "state" : "translated", "value" : "%d item" } },
          "other" : { "stringUnit" : { "state" : "translated", "value" : "%d items" } }
        }
      }
    }
  }
}
```

---

## Locale-based bundled JSON files

When a feature loads content from a bundled JSON file that needs to differ by language:

**File naming**: `<name>.<lang-tag>.json` — e.g. `solutions.pt-BR.json`, `solutions.en.json`.

**Loading pattern** (ViewModel `init` or static helper):
```swift
private static func loadItems() -> [Item] {
    let langCode = Locale.current.language.languageCode?.identifier ?? "en"
    let filename = langCode == "pt" ? "items.pt-BR" : "items.en"
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
          let data = try? Data(contentsOf: url) else { return [] }
    return (try? JSONDecoder().decode([Item].self, from: data)) ?? []
}
```

**⚠️ Pitfall**: `Locale.current.language.languageCode?.identifier` returns `"pt"` for `pt-BR` (not `"pt-BR"`). Always compare against the short code, not the full locale identifier.

**Xcode project**: The project uses `PBXFileSystemSynchronizedRootGroup` — any file added to a Features folder on disk is **automatically included in the bundle**. No manual Xcode project editing required.
