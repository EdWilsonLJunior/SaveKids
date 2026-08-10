# Specs — Video preview button

> Pause or resume an auto-played video preview.

**Related sections:** [Overview](Overview%20-%20Video%20preview%20button.md) · [Button guidelines](Button%20guidelines.md)

## States

The Video preview button supports **four interaction states**: `default`, `hover`, `focus`, and `pressed`. See [Button guidelines](Button%20guidelines.md) for behavior details.

## Size

The button adapts to the viewport. Each size has a large padding to ensure easy interaction on touch devices.

| Viewport | Dimensions | Padding | Padding token | Target size |
| --- | --- | --- | --- | --- |
| **Mobile** | 38 × 38 px | 16 px | `spacing-xs` | 70 × 70 px |
| **Desktop small & Tablet** | 38 × 38 px | 24 px | `spacing-s` | 86 × 86 px |
| **Desktop** | 48 × 48 px | 32 px | `spacing-m` | 112 × 112 px |

## Stroke

| Viewport | Icon stroke | Progress circle | Focus ring |
| --- | --- | --- | --- |
| **Mobile** | 1 px | 1 px | 1 px |
| **Desktop small & Tablet** | 1 px | 1 px | 1 px |
| **Desktop** | 1.4 px | 1.4 px | 1.4 px |

> Don't change the predefined stroke weights of the button.

## Placement

The Video preview button must be placed at the **bottom-right corner** of the video frame. This ensures it does not obstruct the main content while remaining easily reachable, especially on touch devices.

## Color

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | `rgba(0,0,0,0.20)` + blur | `#ffffff` | `action-primary-default-onPhoto` / `text-inverse` |
| Hover | `rgba(0,0,0,0.30)` + blur | `#ffffff` | `action-primary-hover-onPhoto` |
| Focus | Default fill + `#ffffff` ring | `#ffffff` | `action-primary-default-onPhoto` + `action-focus-onPhoto` |
| Pressed | `rgba(0,0,0,0.40)` + blur | `#ffffff` | `action-primary-pressed-onPhoto` |

> Don't change the predefined colors of the Video preview button.
