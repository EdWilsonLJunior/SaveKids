# Specs — Icon button (onHeavy)

> A compact icon-only button placed on dark surfaces.

**Related sections:** [Overview](Overview%20-%20Icon%20button.md) · [Specs onLite](Specs%20-%20Icon%20button%20onLite.md) · [Specs onPhoto](Specs%20-%20Icon%20button%20onPhoto.md)

## Color — onHeavy

### Primary (filled)

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | `#ffffff` | `#171a22` | `action-primary-default-onHeavy` / `text-primary` |
| Hover | `#f4f6f9` | `#171a22` | `action-primary-hover-onHeavy` |
| Focus | `#ffffff` + `#ffffff` ring | `#171a22` | `action-primary-default-onHeavy` + `action-focus-onHeavy` |
| Pressed | `#e9edf3` | `#171a22` | `action-primary-pressed-onHeavy` |
| Disabled | `#3c414a` | `#888f9a` | `action-disabled-onHeavy` / `action-disabled-content-onHeavy` |

### Secondary / Tertiary (ghost)

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | transparent | `#ffffff` | `action-primary-default-onHeavy` |
| Hover | `rgba(255,255,255,0.08)` | `#ffffff` | `surface-hover-onHeavy` |
| Focus | transparent + `#ffffff` ring | `#ffffff` | `action-focus-onHeavy` |
| Pressed | `rgba(255,255,255,0.16)` | `#ffffff` | `surface-pressed-onHeavy` |
| Disabled | transparent | `#3c414a` | `action-disabled-onHeavy` |
