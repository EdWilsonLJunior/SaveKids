# Specs — Icon button (onLite)

> A compact, square button containing a single glyph used for tertiary actions or toolbars.

**Related sections:** [Overview](Overview%20-%20Icon%20button.md) · [Button guidelines](Button%20guidelines.md) · [Specs onHeavy](Specs%20-%20Icon%20button%20onHeavy.md) · [Specs onPhoto](Specs%20-%20Icon%20button%20onPhoto.md)

## States

The icon button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`.

## Size

| Size | Diameter / square | Icon size |
| --- | --- | --- |
| **Small** | 38 × 38 px | 16 px |
| **Medium** | 48 × 48 px | 20 px |
| **Large** | 56 × 56 px | 24 px |

## Variants

The icon button has two visual variants: **filled** (Primary) and **ghost** (Secondary / Tertiary).

## Color — onLite

### Primary (filled)

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | `#1d365a` | `#ffffff` | `action-primary-default-onLite` / `text-inverse` |
| Hover | `#121a38` | `#ffffff` | `action-primary-hover-onLite` |
| Focus | `#1d365a` + `#2e323a` ring | `#ffffff` | `action-primary-default-onLite` + `action-focus-onLite` |
| Pressed | `#070a16` | `#ffffff` | `action-primary-pressed-onLite` |
| Disabled | `#a6acb5` | `#d9dde3` | `action-disabled` / `action-disabled-content` |

### Secondary / Tertiary (ghost)

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | transparent | `#1d365a` | `action-primary-default-onLite` |
| Hover | `#e9edf3` | `#121a38` | `surface-hover-onLite` / `action-primary-hover-onLite` |
| Focus | transparent + `#2e323a` ring | `#1d365a` | `action-focus-onLite` |
| Pressed | `#d9dde3` | `#070a16` | `surface-pressed-onLite` / `action-primary-pressed-onLite` |
| Disabled | transparent | `#a6acb5` | `action-disabled` |
