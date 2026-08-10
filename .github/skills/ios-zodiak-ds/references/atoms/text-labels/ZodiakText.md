> **Platform**: iOS

# ZodiakText — `Shared/DesignSystem/Atoms/Text/ZodiakText.swift`

**Always use `ZodiakText` — never raw SwiftUI `Text` with manual fonts in feature screens.**

```swift
// Init 1: String literal treated as LocalizedStringKey (static UI strings / l10n keys)
ZodiakText(_ text: String, style: ZodiakTextStyle)

// Init 2: explicit LocalizedStringKey
ZodiakText(_ key: LocalizedStringKey, style: ZodiakTextStyle)

// Init 3: verbatim — no localization lookup (dynamic data: names, values, numbers)
ZodiakText(verbatim: String, style: ZodiakTextStyle)
```

## ZodiakTextStyle — complete enum

```swift
// Display headings (Ubuntu Light 300) — editorial/hero use
.headline6XL(weight: Font.Weight = .light)   // 128pt
.headline5XL(weight: Font.Weight = .light)   // 96pt
.headline4XL(weight: Font.Weight = .light)   // 72pt
.headline3XL(weight: Font.Weight = .light)   // 56pt
.headline2XL(weight: Font.Weight = .light)   // 48pt
.headlineXL(weight: Font.Weight = .light)    // 40pt

// Standard headings
.headline                                    // 32pt — page title
.title1                                      // 24pt — section title (Light)
.title2                                      // 18pt — subsection title (Regular)
.title3                                      // 16pt — small heading (Regular)
.subtitleSmall                               // 14pt — eyebrow/micro heading

// Body (Ubuntu Regular 400)
.bodyXL(bold: Bool = false, color: ZodiakTextColor = .primary)   // 24pt
.bodyLarge(bold: Bool = false, color: ZodiakTextColor = .primary) // 18pt
.body(bold: Bool = false, color: ZodiakTextColor = .primary)      // 16pt
.bodySmall(bold: Bool = false, color: ZodiakTextColor = .primary) // 14pt
.caption(bold: Bool = false, color: ZodiakTextColor = .secondary) // 12pt

// Italic (decorative only — not for headings or emphasis in paragraphs)
.italic(size: HeadingSize = .m, color: ZodiakTextColor = .primary)
```

## ZodiakTextColor enum
```swift
.primary    // ZodiakColors.textPrimary — main text
.secondary  // ZodiakColors.textSecondary — muted/supporting text
.disabled   // ZodiakColors.textDisabled
.negative   // ZodiakColors.textNegative — error text
.link       // ZodiakColors.textLink
.linkInverse
.inverse    // ZodiakColors.textInverse — text on dark/photo backgrounds
```

## Typography rules (from official Zodiak spec)

<rules>
- **Always left-align** text for optimal readability — never center body text.
- **Always sentence case** — NEVER title case.
- Italic is **decorative only** — never use to highlight text in paragraphs.
- Never modify font parameters outside of `ZodiakTextStyle` — do not detach tokens.
- Minimum 2 distinct `ZodiakTextStyle` values per screen — never use only `.body()`.
</rules>

## When to use verbatim init
```swift
// ✅ Dynamic data (user-entered, computed, numbers, names) → verbatim
ZodiakText(verbatim: "\(score)", style: .headline)
ZodiakText(verbatim: user.name, style: .title3)

// ✅ Static UI strings → localization key
ZodiakText("score.result.title", style: .title2)

// ✅ Format string with Int interpolation
//    Key in xcstrings: "feature.key %lld" (Int→%lld, String→%@)
ZodiakText("feature.multiplication.table_title \(tableNumber)", style: .title2)
```

---

## ⚠️ Common Pitfalls (confirmed production bugs)

### 1 — Interpolation without `verbatim:` silently fails localization

```swift
// ❌ "Tabuada do \(n)" creates a String, not LocalizedStringKey
//    lookup silently fails; no xcstrings key matches "Tabuada do 5"
ZodiakText("Tabuada do \(tableNumber)", style: .title2)

// ✅ verbatim for hardcoded dynamic content (no xcstrings key)
ZodiakText(verbatim: "Tabuada do \(tableNumber)", style: .title2)

// ✅ localized format string (add "feature.key %lld" to xcstrings)
ZodiakText("feature.multiplication.table_title \(tableNumber)", style: .title2)
```

### 2 — Ternary in `Text()` produces `String`, not `LocalizedStringKey`

`condition ? "key_a" : "key_b"` infers `String`. `Text(String)` is verbatim —
the raw key string appears on screen instead of its translated value.

```swift
// ❌ Displays "catalog.spec.symbol_min_size" literally in the UI
Text(isSymbol ? "catalog.spec.symbol_min_size" : "catalog.spec.wordmark_min_size")

// ✅ if/else — each literal is independently typed as LocalizedStringKey
if isSymbol {
    Text("catalog.spec.symbol_min_size")
} else {
    Text("catalog.spec.wordmark_min_size")
}
```

### 3 — `Text(LocalizedStringKey(variable))` with a runtime String

```swift
// ❌ Misleading: "Principal" is not in xcstrings → fallback to literal
//    Future translators have no path to translate it
Text(LocalizedStringKey(sectionTitle))

// ✅ Use verbatim when variable is dynamic/not a registered key
Text(verbatim: sectionTitle)

// ✅ Only valid when variable IS a registered key (e.g. enum rawValue in xcstrings)
Text(LocalizedStringKey(item.localizedKey))
```
