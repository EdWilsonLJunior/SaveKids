# Specs — Media button (onHeavy and onPhoto)

> A media playback button placed on dark surfaces or photographic backgrounds.

**Related sections:** [Overview](Overview%20-%20Media%20button%20onLite.md) · [Specs onLite](Specs%20-%20Media%20button%20onLite.md) · [Specs onPhoto](Specs%20-%20Media%20button%20onPhoto.md) · [Blurs](Blurs.md)

## Color — onHeavy

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | `#ffffff` | `#171a22` | `action-primary-default-onHeavy` / `text-primary` |
| Hover | `#f4f6f9` | `#171a22` | `action-primary-hover-onHeavy` |
| Focus | `#ffffff` + `#ffffff` ring | `#171a22` | `action-primary-default-onHeavy` + `action-focus-onHeavy` |
| Pressed | `#e9edf3` | `#171a22` | `action-primary-pressed-onHeavy` |
| Disabled | `#3c414a` | `#888f9a` | `action-disabled-onHeavy` / `action-disabled-content-onHeavy` |

## Color — onPhoto

The `onPhoto` variant uses translucent fills with blur for legibility over arbitrary imagery.

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | `rgba(255,255,255,0.20)` + blur | `#ffffff` | `action-primary-default-onPhoto` / `text-inverse` |
| Hover | `rgba(255,255,255,0.30)` + blur | `#ffffff` | `action-primary-hover-onPhoto` |
| Focus | Default fill + `#ffffff` ring | `#ffffff` | `action-primary-default-onPhoto` + `action-focus-onPhoto` |
| Pressed | `rgba(255,255,255,0.40)` + blur | `#ffffff` | `action-primary-pressed-onPhoto` |
| Disabled | `rgba(255,255,255,0.10)` + blur | `rgba(255,255,255,0.40)` | `action-disabled-onPhoto` / `action-disabled-content-onPhoto` |
