# Specs — Arrow button (onLite)

> A directional, navigation-style button used to advance, return, or move between contextual surfaces.

**Related sections:** [Overview](Overview%20-%20Arrow%20button.md) · [Guidelines](Guidelines%20-%20Arrow%20button.md) · [Specs onHeavy](Specs%20-%20Arrow%20button%20onHeavy.md) · [Specs onPhoto](Specs%20-%20Arrow%20button%20onPhoto.md)

## States

The arrow button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`. See [Button guidelines](Button%20guidelines.md) for general state behavior.

## Size

| Size | Usage | Diameter | Icon size |
| --- | --- | --- | --- |
| **Small** | Compact lists, dense layouts. | 38 px | 16 px |
| **Medium** | Default for cards and content sections. | 48 px | 20 px |
| **Large** | Hero sections and prominent navigation. | 56 px | 24 px |

> The hit-target always matches or exceeds the visual diameter.

## Color — onLite

| State | Background | Foreground (icon) | Token (background) |
| --- | --- | --- | --- |
| Default | `#1d365a` | `#ffffff` | `action-primary-default-onLite` / `text-inverse` |
| Hover | `#121a38` | `#ffffff` | `action-primary-hover-onLite` |
| Focus | `#1d365a` + `#2e323a` ring | `#ffffff` | `action-primary-default-onLite` + `action-focus-onLite` |
| Pressed | `#070a16` | `#ffffff` | `action-primary-pressed-onLite` |
| Disabled | `#a6acb5` | `#d9dde3` | `action-disabled` / `action-disabled-content` |
