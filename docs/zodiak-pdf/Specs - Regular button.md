# Specs — Regular button (onLite)

> Initiate an action or event when clicked.

**Related sections:** [Overview](Overview%20-%20Regular%20button.md) · [Guidelines](Guidelines%20-%20Regular%20button.md) · [Specs onHeavy](Specs%20-%20Regular%20button%20onheavy.md) · [Specs onPhoto](Specs%20-%20Regular%20button%20onphoto.md)

## States

All button variants support **five distinct interaction states**: `default`, `hover`, `pressed`, `focus`, and `disabled`. To learn more about each interaction state, see the [Button guidelines](Button%20guidelines.md).

This page covers the **`onLite`** variant. See `onHeavy` and `onPhoto` for buttons placed on dark or photographic backgrounds.

## Size

Buttons come in **three sizes** — small, medium, and large. The width adapts to the content inside, and each size can be made **full-width**.

> If the text exceeds the maximum width, it should be **truncated and shown with an ellipsis**.

| Size | Usage | Height | Target height | Max width | Icon size |
| --- | --- | --- | --- | --- | --- |
| **Small** | Where there is limited space. | 38 px | 38 px | 800 px | S |
| **Medium** | Default button for components and pages. | 48 px | 48 px | 800 px | M |
| **Large** | In larger components such as heroes, or for specific use cases. | 56 px | 56 px | 800 px | M |
| **Full-width** | Within a fixed-width panel or container. | Matches S/M/L | Matches S/M/L | 100 % of container width | Matches S/M/L |

## Placement

When arranging buttons, always consider their hierarchy and align them according to typical reading patterns. **Primary buttons should always be placed before secondary buttons.**

| ✅ Do | ❌ Don't |
| --- | --- |
| Place the primary button on the left to align it with typical reading patterns. | Don't place two primary buttons side by side. |
| Place the primary button above the secondary button to emphasize the main action. | Don't place a secondary button to the left of the primary button. |

## Spacing

In both horizontal and vertical arrangements, buttons should have the **`spacing-xs` token (16 px)** applied as spacing between them. Always ensure consistent spacing between each button in the group.

## Color — onLite

### Primary

| State | Background | Foreground | Token (background) |
| --- | --- | --- | --- |
| Default | `#1d365a` | `#ffffff` | `action-primary-default-onLite` / `text-inverse` |
| Hover | `#121a38` | `#ffffff` | `action-primary-hover-onLite` / `text-inverse` |
| Focus | `#1d365a` | `#ffffff` | `action-primary-default-onLite` + `action-focus-onLite` ring `#2e323a` |
| Pressed | `#070a16` | `#ffffff` | `action-primary-pressed-onLite` / `text-inverse` |
| Disabled | `#a6acb5` | `#d9dde3` | `action-disabled` / `action-disabled-content` |

### Secondary (outlined)

| State | Border / fill | Foreground | Token |
| --- | --- | --- | --- |
| Default | `#1d365a` border, transparent fill | `#1d365a` | `action-primary-default-onLite` |
| Hover | `#121a38` | `#121a38` | `action-primary-hover-onLite` |
| Focus | `#1d365a` + `#2e323a` ring | `#1d365a` | `action-primary-default-onLite` + `action-focus-onLite` |
| Pressed | `#070a16` | `#070a16` | `action-primary-pressed-onLite` |
| Disabled | `#a6acb5` | `#a6acb5` | `action-disabled` |

### Tertiary (text only, with underline)

| State | Underline / fg | Token |
| --- | --- | --- |
| Default | `#1d365a` | `action-primary-default-onLite` |
| Hover | `#121a38` | `action-primary-hover-onLite` |
| Focus | `#1d365a` + `#2e323a` ring | `action-primary-default-onLite` + `action-focus-onLite` |
| Pressed | `#1d365a` | `action-primary-default-onLite` |
| Disabled | `#a6acb5` | `action-disabled` |

> Refer to the original PDF for exact pixel-perfect token mapping and visual swatches.
