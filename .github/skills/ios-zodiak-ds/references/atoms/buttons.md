# Zodiak DS — Buttons API Reference

> Sources: `Shared/DesignSystem/Atoms/Button/` · `docs/zodiak-pdf/Button guidelines.md` · `docs/zodiak-pdf/Overview - Regular/Arrow/Icon/Menu/Warning/System/SystemWarning/VideoPreview button.md` · `docs/zodiak-pdf/Guidelines - Regular/Arrow/Warning/Menu button.md` · `docs/zodiak-pdf/Specs - Regular button.md` · `docs/zodiak-pdf/Specs - Arrow button onlite.md`

---

## Shared Button Rules

### Hierarchy (per page)
| Variant | Limit per screen |
|---|---|
| Primary | Max 1–2 |
| Secondary | Max ~4 |
| Tertiary | No limit |

<rules>
- Primary button always placed **left** (or above) secondary in a group.
- Spacing between buttons in a group: always `ZodiakSpacing.s16` (16pt).
- ⚠️ **Never place `ZodiakTertiaryButton` on photographic backgrounds** — fails accessibility contrast.
- Label: always **descriptive** — NEVER "Read more", "Click here", or vague verbs.
</rules>

### Sizes
| Size | Height | When to use |
|---|---|---|
| Small | 38pt | Limited space, compact layouts |
| Medium (default) | 48pt | Standard for all pages and components |
| Large | 56pt | Hero sections, prominent single CTA |
| Full-width | Matches S/M/L | Fixed-width panels, modals, mobile forms |

### Background Context
| Context | Use these styles |
|---|---|
| Light background (`onLite`) | Default — `ZodiakButton`, `.zodiakPrimaryButtonStyle` |
| Dark background (`onHeavy`) | `.zodiakPrimaryOnHeavyButtonStyle`, `.zodiakSecondaryOnHeavyButtonStyle` |
| Photo background (`onPhoto`) | `.zodiakPrimaryOnPhotoButtonStyle` — ⚠️ tertiary/text-only not allowed |

---


---

## View Modifier Styles (for custom `Button` wrappers)

```swift
.zodiakPrimaryButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium)
.zodiakSecondaryButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium)
.zodiakDangerButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium)
.zodiakSmallButtonStyle(isEnabled: Bool = true)
.zodiakPrimaryOnHeavyButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium)
.zodiakSecondaryOnHeavyButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium)
.zodiakPrimaryOnPhotoButtonStyle(isEnabled: Bool = true, size: ZodiakButtonSize = .medium)
```


---

## Components

| Component | File |
|---|---|
| `ZodiakButton` | [buttons/ZodiakButton.md](buttons/ZodiakButton.md) |
| `ZodiakIconButton` | [buttons/ZodiakIconButton.md](buttons/ZodiakIconButton.md) |
| `ZodiakNavButtons` | [buttons/ZodiakNavButtons.md](buttons/ZodiakNavButtons.md) |
| `ZodiakSystemButtons` | [buttons/ZodiakSystemButtons.md](buttons/ZodiakSystemButtons.md) |
| `ZodiakWarningButtons` | [buttons/ZodiakWarningButtons.md](buttons/ZodiakWarningButtons.md) |
| `ZodiakMediaButton` | [buttons/ZodiakMediaButton.md](buttons/ZodiakMediaButton.md) |
| `ZodiakVideoPreviewButton` | [buttons/ZodiakVideoPreviewButton.md](buttons/ZodiakVideoPreviewButton.md) |

