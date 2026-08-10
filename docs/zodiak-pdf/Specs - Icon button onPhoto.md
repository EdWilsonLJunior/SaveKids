# Specs — Icon button (onPhoto)

> A compact icon-only button placed over photographic backgrounds.

**Related sections:** [Overview](Overview%20-%20Icon%20button.md) · [Specs onLite](Specs%20-%20Icon%20button%20onLite.md) · [Specs onHeavy](Specs%20-%20Icon%20button%20onHeavy.md) · [Blurs](Blurs.md)

## Color — onPhoto

The `onPhoto` variant uses translucent fills with blur to remain legible over arbitrary imagery.

### Primary (filled)

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | `rgba(255,255,255,0.20)` + blur | `#ffffff` | `action-primary-default-onPhoto` / `text-inverse` |
| Hover | `rgba(255,255,255,0.30)` + blur | `#ffffff` | `action-primary-hover-onPhoto` |
| Focus | Default fill + `#ffffff` ring | `#ffffff` | `action-primary-default-onPhoto` + `action-focus-onPhoto` |
| Pressed | `rgba(255,255,255,0.40)` + blur | `#ffffff` | `action-primary-pressed-onPhoto` |
| Disabled | `rgba(255,255,255,0.10)` + blur | `rgba(255,255,255,0.40)` | `action-disabled-onPhoto` / `action-disabled-content-onPhoto` |

### Secondary / Tertiary (ghost)

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | transparent | `#ffffff` | `action-primary-default-onPhoto` |
| Hover | `rgba(255,255,255,0.10)` + blur | `#ffffff` | `surface-hover-onPhoto` |
| Focus | transparent + `#ffffff` ring | `#ffffff` | `action-focus-onPhoto` |
| Pressed | `rgba(255,255,255,0.20)` + blur | `#ffffff` | `surface-pressed-onPhoto` |
| Disabled | transparent | `rgba(255,255,255,0.40)` | `action-disabled-onPhoto` |
