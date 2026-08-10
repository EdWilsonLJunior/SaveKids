> **Platform**: iOS

# Typographic Organisms — `Shared/DesignSystem/Organisms/Typographic/`

```swift
// Pull quote
ZodiakQuote(quote: String, author: String? = nil, role: String? = nil, onHeavy: Bool = false)

// Text content section (1 or 2 columns, optional headings)
enum ZodiakTextBlockAlignment { case center, leading, twoColumn }
ZodiakTextBlock(
    headingLarge: String? = nil,
    bodyText: String,
    headingSmall: String? = nil,
    alignment: ZodiakTextBlockAlignment = .leading
)

// Article intro (eyebrow + title + summary)
ZodiakPreamble(
    eyebrow: String? = nil,
    title: String,
    summary: String,
    background: Color = .clear,
    onHeavy: Bool = false
)

// Key figures grid
struct ZodiakKeyFigureItem: Identifiable {
    let id = UUID(); let value: String; let label: String; var detail: String?
}
ZodiakKeyFigures(items: [ZodiakKeyFigureItem], columns: Int = 2, onHeavy: Bool = false)

// Section header with optional tabs/filter
enum ZodiakHeadlineSectionStyle { case plain, plainWithIntro, middleAligned, withFilter }
ZodiakHeadlineSection(...)  // check ZodiakHeadlineSection.swift for full API
```

---
