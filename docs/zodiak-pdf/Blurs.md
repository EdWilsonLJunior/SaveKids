# Blurs

> Soften backgrounds and draw focus to content.

Blur creates focus, hierarchy, and visual clarity by de-emphasizing background elements. It guides user attention, improves readability, and separates content layers without cluttering the interface.

Blurring is especially useful on photographic backgrounds when typography is added on top of the image.

## Style

To maintain design consistency, we provide a **single background-blur option**.

1. Photographic background must have a `page-overlay` fill applied.
2. `background-blur` effect and `blur-color` are applied to the container's fill.

### Color and effect

| Layer | Token | Color | Blur |
| --- | --- | --- | --- |
| Page Overlay | `page-overlay` | `rgba(23, 26, 34, 0.4)` | — |
| Background blur | `background-blur` | `rgba(255, 255, 255, 0.05)` | 30 px |
| Color blur | `color-blur` | `rgba(255, 255, 255, 0.05)` | 30 px |

> **Don't** use other colors than the given blur color.

## Content

To ensure legibility, **use white content on blurred backgrounds**.

### Text

| ✅ Do | ❌ Don't |
| --- | --- |
| Use light text on the blur to ensure readability. | Don't use dark text on blur. |

### Buttons

| ✅ Do | ❌ Don't |
| --- | --- |
| Use light buttons on blur. | Don't use dark buttons on blur. |

---

**Related:** [Borders](Borders.md) · [Shadows](Shadows.md)
