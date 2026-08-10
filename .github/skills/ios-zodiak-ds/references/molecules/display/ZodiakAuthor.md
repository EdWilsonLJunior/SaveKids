> **Platform**: iOS

# ZodiakAuthor — `Shared/DesignSystem/Molecules/Author/ZodiakAuthor.swift`

```swift
ZodiakAuthor(
    name: String,
    role: String? = nil,
    date: String? = nil,
    avatarImage: Image? = nil,
    avatarInitials: String? = nil,
    onTap: (() -> Void)? = nil
)
```

## Variants (from Overview - Author.md)
| Variant | Use when |
|---|---|
| Single | One author — shows avatar + name + up to 2 extra attributes (date/time/role/company) |
| Multi-author | Multiple authors — when >3, last avatar indicates remaining count |
| Brand | No single author — use brand name (full brand name always visible) |

## When to use
- On article cards and article pages to provide attribution and build trust.
- `ZodiakAuthor` is included in `ZodiakAuthorCard` automatically — no need to compose manually for cards.
- If no specific author → use Standard card (`ZodiakTallCard` or `ZodiakTypographicCard`).

---
