# Color — Typography

> Use content color tokens so text remains readable across all themes.

**Related sections:** [Overview](Overview%20-%20Typography.md) · [Size](Size%20-%20Typography.md) · [Usage](Usage%20-%20Typography.md)

## Theme-aware text colors

By applying the correct color tokens, the system can automatically adjust text color based on the active theme. Designers and developers don't need to manually switch colors for light or dark mode.

## Standard text color tokens

On light backgrounds in light mode, and dark backgrounds in dark mode, apply the standard `text-primary` and `text-secondary` tokens.

| Token | Light mode | Dark mode |
| --- | --- | --- |
| `text-primary` | `#171a22` on `#f8fafc` | `#f8fafc` on `#171a22` |
| `text-secondary` | `#595e6a` on `#f8fafc` | `#f1f4f7` on `#171a22` |

## Text on dark surfaces

When text appears on dark surfaces in light mode (or light backgrounds in dark mode), use `text-inverse` to maintain contrast.

| Token | Foreground | Background |
| --- | --- | --- |
| `text-inverse` | `#ffffff` | `#171a22` |

## Links

For links we mirror the button states so users get clear visual feedback that their interaction is being registered. Each state has its own color.

| State | Token | Light mode | Dark mode |
| --- | --- | --- | --- |
| Default | `text-link` | `#1d365a` | `#ffffff` |
| Hover | `text-link-hover` | `#121a38` | `#f4f6f9` |
| Pressed | `text-link-pressed` | `#070a16` | `#e9edf3` |
| Focus | `action-focus-onlite` | `#2e323a` | `#ffffff` |
| Disabled | `text-disabled` | `#a6acb5` | `#888f9a` |

> Refer to the [Accessibility](Accessibility%20-%20Color.md) page for contrast requirements when picking text and background combinations.
