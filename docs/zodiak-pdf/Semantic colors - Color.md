# Semantic colors

> Tokens named for **purpose**, not appearance — built on top of [primitive colors](Primitive%20colors%20-%20Color.md) so the design adapts automatically across themes.

**Related sections:** [Introduction](Introduction%20-%20Color.md) · [Primitive colors](Primitive%20colors%20-%20Color.md) · [Accessibility](Accessibility%20-%20Color.md)

## Lite and heavy

Learn how `lite` and `heavy` colors — and their corresponding `onLite` and `onHeavy` components — work together to ensure visual clarity and accessibility across different backgrounds.

> 💡 In Figma, hover over the link icon in a color swatch to see which primitive token a semantic color references.

## Brand

| Token | Light mode | Dark mode |
| --- | --- | --- |
| `Capgemini Logo` | `#0058ab` | `#ffffff` |

## Surface

> Designed to define the background for surface areas of various components — these colors set the tone of a page. Used for backgrounds in pages, cards, form fields, and more.

| Token | Light mode | Dark mode |
| --- | --- | --- |
| `surface-page-background` | `#ffffff` | `#12151d` |
| `surface-cloud-lite` | `#eff0f4` | `#21252d` |
| `surface-caribbean-lite` | `#00d5d0` | `#29656f` |
| `surface-caribbean-lite-inverse` | `#29656f` | `#00d5d0` |
| `surface-smoke-lite` | `#f8fafc` | `#272b33` |
| `surface-fog-lite` | `#f8fafc` | `#1b1f27` |
| `surface-ink-heavy` | `#121a38` | `#121a38` |
| `surface-marine-heavy` | `#1c4076` | `#1d365a` |
| `surface-azur-heavy` | `#0058ab` | `#1d365a` |
| `surface-always-white` | `#ffffff` | `#ffffff` |
| `surface-always-black` | `#000000` | `#000000` |
| `surface-positive` | `#eff7f5` | `#0f2e22` |
| `surface-negative` | `#fbf2f3` | `#5d051a` |

### Surface decorative

> ⚠️ Use only for **small decorative surfaces, without text on top**. Text over these colors may not meet contrast requirements, which could harm legibility and accessibility. Decorative surfaces should serve as accents or visual highlights, not functional backgrounds for content.

| Token | Value |
| --- | --- |
| `surface-decorative-brand-blue` | `#0058ab` |
| `surface-decorative-brand-orange` | `#f9a464` |

## Content

> Designed for text — content colors ensure that copy is **legible and consistent** with the overall design.

| Token | Light mode | Dark mode |
| --- | --- | --- |
| `text-primary` | `#171a22` | `#f8fafc` |
| `text-secondary` | `#595e6a` | `#f1f4f7` |
| `text-inverse` | `#ffffff` | `#171a22` |
| `text-disabled` | `#a6acb5` | `#888f9a` |
| `text-always-white` | `#ffffff` | `#ffffff` |
| `text-always-black` | `#171a22` | `#171a22` |
| `text-link` | `#1d365a` | `#ffffff` |
| `text-link-hover` | `#121a38` | `#f4f6f9` |
| `text-link-pressed` | `#070a16` | `#e9edf3` |
| `text-link-inverse` | `#ffffff` | `#1d365a` |
| `text-negative-onLite` | `#9e0029` | `#ffa7a9` |
| `text-negative-onHeavy` | `#ffa7a9` | `#ffa7a9` |

## Action

> Action colors are used for **interactive components**. They provide visual feedback (e.g. a button changing color when pressed), indicating that the action was registered.

### Primary actions

| Token | onLite surface | onHeavy surface |
| --- | --- | --- |
| `action-primary-default-onLite` | `#1d365a` | `#ffffff` |
| `action-primary-hover-onLite` | `#121a38` | `#c7ccd3` |
| `action-primary-pressed-onLite` | `#070a16` | `#e9edf3` |
| `action-focus-onLite` | `#2e323a` | `#ffffff` |
| `action-disabled` | `#a6acb5` | `#3c414a` |
| `action-disabled-content` | `#d9dde3` | `#a6acb5` |
| `action-active` | `#3573c0` | `#3573c0` |

### Action — warning

> Warning action colors are used for actions that may have **significant consequences**, such as resetting or deleting something.

| Token | onLite surface | onHeavy surface |
| --- | --- | --- |
| `action-warning-content` | `#9e0029` | `#171a22` |
| `action-warning-primary-default` | `#f64059` | `#ffffff` |
| `action-warning-hover` | `#ff6270` | `#c7ccd3` |
| `action-warning-hover-outline` | `#f64059` | `#c7ccd3` |
| `action-warning-pressed` | `#f64059` | `#e9edf3` |
| `action-warning-pressed-outline` | `#dd1d46` | `#e9edf3` |
| `action-warning-secondary-default` | `#9e0029` | `#ff848b` |
| `action-warning-secondary-hover` | `#c00036` | `#ffa7a9` |

## Border

> Border colors define the **perimeters of elements**.

| Token | Light mode | Dark mode |
| --- | --- | --- |
| `border-primary` | `#c7ccd3` | `#3c414a` |
| `border-secondary` | `#eff0f4` | `#2e323a` |

## Overlay

> Overlays are used on image backgrounds to provide more clarity to the foreground.

| Token | Value |
| --- | --- |
| `page-overlay` | `rgba(23, 26, 34, 0.4)` |
| `hero-photographic` | `rgba(0, 0, 0, 0.55)` |

### Photo style — gradient

| Stop | Value |
| --- | --- |
| Photo Gradient 0% | `rgba(255, 255, 255, 0)` (`#00000000`) |
| Photo Gradient 100% | `#000000` |

> **Photo Overlay** — gradient to use on a photo for accessible text:
> `linear-gradient(#00000000 0%, #000000 75%)`
