# Specs — Arrow button (onHeavy)

> A directional, navigation-style button used to advance, return, or move between contextual surfaces — placed on dark surfaces.

**Related sections:** [Overview](Overview%20-%20Arrow%20button.md) · [Guidelines](Guidelines%20-%20Arrow%20button.md) · [Specs onLite](Specs%20-%20Arrow%20button%20onlite.md) · [Specs onPhoto](Specs%20-%20Arrow%20button%20onPhoto.md)

## States

The arrow button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`. See [Button guidelines](Button%20guidelines.md).

## Color — onHeavy

| State | Background | Foreground (icon) | Token (background) |
| --- | --- | --- | --- |
| Default | `#ffffff` | `#171a22` | `action-primary-default-onHeavy` / `text-primary` |
| Hover | `#f4f6f9` | `#171a22` | `action-primary-hover-onHeavy` |
| Focus | `#ffffff` + `#ffffff` ring | `#171a22` | `action-primary-default-onHeavy` + `action-focus-onHeavy` |
| Pressed | `#e9edf3` | `#171a22` | `action-primary-pressed-onHeavy` |
| Disabled | `#3c414a` | `#888f9a` | `action-disabled-onHeavy` / `action-disabled-content-onHeavy` |
