> **Platform**: iOS

# ZodiakEyebrow — `Shared/DesignSystem/Atoms/Eyebrow/ZodiakEyebrow.swift`

```swift
enum ZodiakEyebrowSize { case small /*14pt*/, medium /*16pt*/ }
enum ZodiakEyebrowBackground { case onLite, onHeavy }

ZodiakEyebrow(
    text: String,
    size: ZodiakEyebrowSize = .medium,
    background: ZodiakEyebrowBackground = .onLite
)
```

## When to use
- Short category/topic label **above a headline** (e.g., "News", "Case study", "Feature").
- Typically 1–2 words — avoid full sentences or promotional language.

## When NOT to use

<never>
- ❌ Never as a standalone text element outside of a headline context.
- ❌ Never as a clickable link or interactive element — it is static.
- ❌ Never for long descriptive text.
</never>

---
