# Specs — Regular button (onPhoto)

> Initiate an action or event when clicked — placed over photographic backgrounds.

**Related sections:** [Overview](Overview%20-%20Regular%20button.md) · [Guidelines](Guidelines%20-%20Regular%20button.md) · [Specs onLite](Specs%20-%20Regular%20button.md) · [Specs onHeavy](Specs%20-%20Regular%20button%20onheavy.md) · [Blurs](Blurs.md)

## States

The regular button supports the five standard interaction states. Sizes and placement rules are identical to the [onLite specs](Specs%20-%20Regular%20button.md#size).

The `onPhoto` variant uses translucent fills with blur to remain legible over arbitrary imagery.

## Color — onPhoto

### Primary

| State | Background | Foreground | Token |
| --- | --- | --- | --- |
| Default | `rgba(255,255,255,0.20)` + blur | `#ffffff` | `action-primary-default-onPhoto` / `text-inverse` |
| Hover | `rgba(255,255,255,0.30)` + blur | `#ffffff` | `action-primary-hover-onPhoto` |
| Focus | Default fill + `#ffffff` ring | `#ffffff` | `action-primary-default-onPhoto` + `action-focus-onPhoto` |
| Pressed | `rgba(255,255,255,0.40)` + blur | `#ffffff` | `action-primary-pressed-onPhoto` |
| Disabled | `rgba(255,255,255,0.10)` + blur | `rgba(255,255,255,0.40)` | `action-disabled-onPhoto` / `action-disabled-content-onPhoto` |

### Secondary (outlined)

| State | Border / fill | Foreground | Token |
| --- | --- | --- | --- |
| Default | `#ffffff` border, transparent fill | `#ffffff` | `action-primary-default-onPhoto` |
| Hover | `rgba(255,255,255,0.10)` + blur | `#ffffff` | `action-primary-hover-onPhoto` |
| Focus | `#ffffff` border + `#ffffff` ring | `#ffffff` | `action-focus-onPhoto` |
| Pressed | `rgba(255,255,255,0.20)` + blur | `#ffffff` | `action-primary-pressed-onPhoto` |
| Disabled | transparent | `rgba(255,255,255,0.40)` | `action-disabled-onPhoto` |

### Tertiary (text only)

| State | Underline / fg | Token |
| --- | --- | --- |
| Default | `#ffffff` | `action-primary-default-onPhoto` |
| Hover | `rgba(255,255,255,0.80)` | `action-primary-hover-onPhoto` |
| Focus | `#ffffff` + `#ffffff` ring | `action-focus-onPhoto` |
| Pressed | `rgba(255,255,255,0.60)` | `action-primary-pressed-onPhoto` |
| Disabled | `rgba(255,255,255,0.40)` | `action-disabled-onPhoto` |
