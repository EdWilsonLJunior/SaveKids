# Avatar

Represent a user, group, or brand.

## States

All variants support three interaction states: default, hover, and focus.

**Status indicators:**

1. **Available** — The user is online and available for interaction.
2. **Away** — The user is online but not currently active.
3. **Do not disturb** — The user is online but does not want to receive notifications or messages.
4. **Offline** — The user is not connected and cannot be reached.

## Size

The avatar comes in two sizes: small and medium.

| Size | Dimensions | Initials token |
|---|---|---|
| Small | 48×48 px | `heading-xs-400` / `heading-s-300` |
| Medium | 64×64 px | — |

### Interaction

Avatars are primarily static visual elements, but they can support interaction when needed. Common interactions include opening a user profile or displaying a dropdown menu with account options. Avatars should provide clear feedback when interactive, such as a focus ring or hover state, and must remain accessible by supporting keyboard navigation and screen reader labels.

### Character limit

Avatars with initials are limited to two characters.

## Color

### Avatar with Initials

Avatars with initials should use the following colors for the background:

| Token | Hex | Notes |
|---|---|---|
| Surface Ink Heavy | `#121a38` | — |
| Surface Marine Heavy | `#1c4076` | — |
| Surface Azur Heavy | `#0058ab` | — |

The color of the initials is `text-always-white` to ensure accessibility in both light and dark mode.

| Token | Hex |
|---|---|
| Text Always White | `#ffffff` |

> **Do:** Use the predefined colors for the avatars.
> **Don't:** Use other colors.

### Brand avatar

For avatars with the brand logo, always use the brand color for the background and `surface-always-white` for the spade.

| Token | Hex | Role |
|---|---|---|
| Brand (Blue 500) | `#0058ab` | Background |
| Surface Always White | `#ffffff` | Spade |

> **Do:** Use the default brand color for avatars with the brand logo.
> **Don't:** Use other colors for avatars with the spade.

### State color

#### Hover

| Element | Value | Token | Notes |
|---|---|---|---|
| Hover overlay | `rgba(0,0,0,0.15)` | `Overlay.black15` | Not affected by theme |
| Action color | — | `actionPrimaryOnPhoto` | Not affected by theme |

#### Focus

| Element | Light | Dark | Token |
|---|---|---|---|
| Focus ring | `#2e323a` | `#ffffff` | `Neutral.shade750` (light) / White (dark) → `actionFocusOnLite` |

### Status color

#### Available

| Element | Light | Dark | Token |
|---|---|---|---|
| Text | `#171a22` (Neutral 950) | `#f8fafc` (Neutral 50) | Text Primary |
| Background | `#eff7f5` (Green 50) | `#0f2e22` (Green 900) | Surface Positive |
| Ring / separator | `#ffffff` (White) | `#12151d` (Neutral 1000) | Page Background |

#### Away

| Element | Light | Dark | Token |
|---|---|---|---|
| Text | `#171a22` (Neutral 950) | `#f8fafc` (Neutral 50) | Text Primary |
| Background | `#fbf2f3` (Red 50) | `#5d051a` (Red 900) | Surface Negative |
| Ring / separator | `#ffffff` (White) | `#12151d` (Neutral 1000) | Page Background |

#### Do not disturb

| Element | Light | Dark | Token |
|---|---|---|---|
| Text | `#ffffff` (White) | `#171a22` (Neutral 950) | Text Inverse |
| Indicator | `#9e0029` (Red 800) | `#ffa7a9` (Red 200) | Text Negative onLite |
| Ring / separator | `#ffffff` (White) | `#12151d` (Neutral 1000) | Page Background |

#### Offline

| Element | Light | Dark | Token |
|---|---|---|---|
| Text | `#171a22` (Neutral 950) | `#f8fafc` (Neutral 50) | Text Primary |
| Background | `#eff0f4` (Capgemini Blue 50) | `#21252d` (Neutral 850) | Surface Cloud Lite |
| Ring / separator | `#ffffff` (White) | `#12151d` (Neutral 1000) | Page Background |

> **Do:** Use the default colors of the status.
> **Don't:** Change the colors of the status.
