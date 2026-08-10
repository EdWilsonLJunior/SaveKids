# Specs — Share

> Provide ways to share content.

**Related sections:** [Overview](Overview%20-%20Share.md) · [Guidelines](Guidelines%20-%20Share.md)

## Properties

| Property | Values | Default |
| --- | --- | --- |
| **Size Variant** | S \| L | L |
| **State Variant** | Default \| Hover \| Active \| Focus \| Disabled | Default |

## States

The share button and the share options in the mini menu each have five interaction states.

| # | State | Description |
| --- | --- | --- |
| 1 | **Default** | Normal state with no user interaction. |
| 2 | **Hover** | Cursor moves over the element — provides a visual cue of interactivity. |
| 3 | **Focus** | Element selected via keyboard navigation (e.g. `Tab`), ready for interaction. |
| 4 | **Active / Pressed** | Element is being pressed or tapped. |
| 5 | **Disabled** | Element is inactive and cannot be interacted with. |

> To learn more about each interaction state, visit the button guidelines.

## Typography

| Size | Share button label | Share menu item label |
| --- | --- | --- |
| **Small** | `heading-2xs-300` | `heading-2xs-300` |
| **Large** | `heading-xs-300` | `heading-2xs-300` |

## Size specs

### Share button size

The share button has a small and large size.

#### Small

| Element | Property | Description | Value/px | Token |
| --- | --- | --- | --- | --- |
| Share button | height | | 40 | — |
| | spacing | between icon and label | 8 | `spacing-2xs` |
| Icon | width, height | | 16 | — |

#### Large

| Element | Property | Description | Value/px | Token |
| --- | --- | --- | --- | --- |
| Share button | height | | 40 | — |
| | spacing | between icon and label | 4 | `spacing-3xs` |
| Icon | width, height | | 16 | — |

### Share menu size

The share menu has one size that adapts to the viewport.

#### Mobile

| Element | Property | Description | Value/px | Token |
| --- | --- | --- | --- | --- |
| Share menu | width | | 100% | — |
| | spacing | between menu items | 24 | `spacing-s` |
| | margin padding top | | 24 | `spacing-s` |
| | padding-bottom, padding-left, padding-right | | 16 | `spacing-xs` |
| | border | | 1 | `stroke-m` |
| Share menu item | height | | 40 | — |
| | spacing | between icon and label | 8 | `spacing-2xs` |
| Share menu item label | max height | | 35 | — |
| | max width | | 170 | — |
| Share icon | width, height | | 16 | — |
| Close button | width, height | | 40 | — |

#### Desktop and tablet

| Element | Property | Description | Value/px | Token |
| --- | --- | --- | --- | --- |
| Share component | spacing | between button and menu | 4 | `spacing-3xs` |
| Share menu | width | | 274 | — |
| | spacing | between menu items | 24 | `spacing-s` |
| | margin padding top | | 24 | `spacing-s` |
| | padding-bottom, padding-left, padding-right | | 16 | `spacing-xs` |
| | border | | 1 | `stroke-m` |
| Share menu item | height | | 40 | — |
| | spacing | between icon and label | 8 | `spacing-2xs` |
| Share menu item label | max height | | 35 | — |
| | max width | | 170 | — |
| Share icon | width, height | | 16 | — |
| Close button | width, height | | 40 | — |

## Colors

### Share button color / Share menu item color

| State | Share button color (Light / Dark) | Share menu item color (Light / Dark) | Token |
| --- | --- | --- | --- |
| **Default** | `#595e6a` / `#f1f4f7` | `#595e6a` / `#f1f4f7` | Text Secondary |
| **Hover** | `#171a22` / `#f8fafc` | `#171a22` / `#f8fafc` | Text Primary |
| **Focus** | `#171a22` / `#f8fafc` | `#171a22` / `#f8fafc` | Text Primary |
| | `#1d365a` / `#ffffff` | `#1d365a` / `#ffffff` | Action Primary Default onLite |
| | `#2e323a` / `#ffffff` | `#2e323a` / `#ffffff` | Action Focus onLite |
| **Pressed** | `#171a22` / `#f8fafc` | `#171a22` / `#f8fafc` | Text Primary |
| | `#1d365a` / `#ffffff` | `#1d365a` / `#ffffff` | Action Primary Default onLite |
| **Disabled** | `#a6acb5` / `#888f9a` | `#a6acb5` / `#888f9a` | Text Disabled |

### Page overlay color

| Color | Token |
| --- | --- |
| `rgba(23, 26, 34, 0.4)` | Page Overlay |

> The page overlay is applied on mobile when the share menu (bottom drawer) is open, to dim the background and maintain focus on the share options.
