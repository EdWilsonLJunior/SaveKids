# Specs — Arrow button (onPhoto)

> A directional, navigation-style button placed over photographic backgrounds where contrast cannot be guaranteed.

**Related sections:** [Overview](Overview%20-%20Arrow%20button.md) · [Guidelines](Guidelines%20-%20Arrow%20button.md) · [Specs onLite](Specs%20-%20Arrow%20button%20onlite.md) · [Specs onHeavy](Specs%20-%20Arrow%20button%20onHeavy.md)

## States

The arrow button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`. See [Button guidelines](Button%20guidelines.md).

## Color — onPhoto

The `onPhoto` variant relies on a translucent fill plus blur to remain legible over arbitrary imagery. See [Blurs](Blurs.md) for blur tokens.

| State | Background | Foreground (icon) | Token (background) |
| --- | --- | --- | --- |
| Default | `rgba(255,255,255,0.20)` + blur | `#ffffff` | `action-primary-default-onPhoto` / `text-inverse` |
| Hover | `rgba(255,255,255,0.30)` + blur | `#ffffff` | `action-primary-hover-onPhoto` |
| Focus | Default fill + `#ffffff` ring | `#ffffff` | `action-primary-default-onPhoto` + `action-focus-onPhoto` |
| Pressed | `rgba(255,255,255,0.40)` + blur | `#ffffff` | `action-primary-pressed-onPhoto` |
| Disabled | `rgba(255,255,255,0.10)` + blur | `rgba(255,255,255,0.40)` | `action-disabled-onPhoto` / `action-disabled-content-onPhoto` |
