# Specs — Media button (onLite)

> A button that initiates playback or media-related actions, intended for media surfaces.

**Related sections:** [Overview](Overview%20-%20Media%20button%20onLite.md) · [Button guidelines](Button%20guidelines.md) · [Specs onHeavy & onPhoto](Specs%20-%20Media%20button%20onHeavy%20and%20onPhoto.md)

## States

The media button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`.

## Size

| Size | Diameter | Icon size |
| --- | --- | --- |
| **Small** | 38 px | 16 px |
| **Medium** | 48 px | 20 px |
| **Large** | 56 px | 24 px |
| **XL** | 80 px | 32 px |

## Color — onLite

| State | Background | Icon | Token |
| --- | --- | --- | --- |
| Default | `#1d365a` | `#ffffff` | `action-primary-default-onLite` / `text-inverse` |
| Hover | `#121a38` | `#ffffff` | `action-primary-hover-onLite` |
| Focus | `#1d365a` + `#2e323a` ring | `#ffffff` | `action-primary-default-onLite` + `action-focus-onLite` |
| Pressed | `#070a16` | `#ffffff` | `action-primary-pressed-onLite` |
| Disabled | `#a6acb5` | `#d9dde3` | `action-disabled` / `action-disabled-content` |
