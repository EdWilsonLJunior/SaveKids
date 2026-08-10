# Zodiak DS — Cards API Reference

> Sources: `Shared/DesignSystem/Organisms/CardGrid/` · `Shared/DesignSystem/Organisms/CardVariants/` · `docs/zodiak-pdf/Overview - Card standard/typographic/with author.md` · `docs/zodiak-pdf/Guidelines - Card standard/typographic/with author.md`

---

## Card Selection Guide

| Use case | Component |
|---|---|
| Image + headline + link | `ZodiakTallCard` (tall) or `ZodiakCardGrid` item (standard) |
| Text-only, no image | `ZodiakTypographicCard` |
| Author attribution matters | `ZodiakAuthorCard` |
| Hidden content revealed on tap | `ZodiakRevealCard` |
| Compact image-left layout | `ZodiakHorizontalCard` |
| Key metrics / stats grid | `ZodiakShortFactsCard` |
| Large collection with pagination | `ZodiakCardGrid` + ShowMore |

### Card compositions (from Zodiak spec)
| Layout | Components | When |
|---|---|---|
| Standard grid | `ZodiakCardGrid` (up to 9 + ShowMore up to 18) | Larger collections |
| Horizontal grid | `ZodiakHorizontalCardList` | Avoids long vertical stacks |
| Tall grid | Exactly 3 `ZodiakTallCard` in a row | Visually prominent images |
| Typographic grid | `ZodiakTypographicCardGrid` (up to 9) | Text-focused content |
| Author grid | `ZodiakAuthorCardGrid` | Article listings with attribution |

### Shared card content rules

<rules>
- Eyebrow: 1–2 words, category indicator only — no full sentences, no promotional text.
- Button/action label: **always descriptive** — NEVER "Read more".
- Full card should be tappable — not just the button.
</rules>

---


---

## Components

| Component | File |
|---|---|
| `ZodiakCardGrid` | [cards/ZodiakCardGrid.md](cards/ZodiakCardGrid.md) |
| `ZodiakHorizontalCard` | [cards/ZodiakHorizontalCard.md](cards/ZodiakHorizontalCard.md) |
| `ZodiakTallCard` | [cards/ZodiakTallCard.md](cards/ZodiakTallCard.md) |
| `ZodiakRevealCard` | [cards/ZodiakRevealCard.md](cards/ZodiakRevealCard.md) |
| `ZodiakTypographicCard` | [cards/ZodiakTypographicCard.md](cards/ZodiakTypographicCard.md) |
| `ZodiakAuthorCard` | [cards/ZodiakAuthorCard.md](cards/ZodiakAuthorCard.md) |
| `ZodiakShortFactsCard` | [cards/ZodiakShortFactsCard.md](cards/ZodiakShortFactsCard.md) |

