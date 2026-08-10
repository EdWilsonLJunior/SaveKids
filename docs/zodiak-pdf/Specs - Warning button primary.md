# Specs — Warning button (Primary)

> A high-emphasis button for in-context destructive actions (delete item, remove from list, etc.).

**Related sections:** [Overview](Overview%20-%20Warning%20button.md) · [Guidelines](Guidelines%20-%20Warning%20button.md) · [Specs Secondary](Specs%20-%20Warning%20button%20secundary.md) · [Specs Tertiary](Specs%20-%20Warning%20button%20tertiary.md)

## States

The warning button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`.

## Color — Primary

| State | Background | Foreground | Token |
| --- | --- | --- | --- |
| Default | `#b3261e` | `#ffffff` | `action-warning-default` / `text-inverse` |
| Hover | `#8c1d18` | `#ffffff` | `action-warning-hover` |
| Focus | `#b3261e` + `#2e323a` ring | `#ffffff` | `action-warning-default` + `action-focus-onLite` |
| Pressed | `#601410` | `#ffffff` | `action-warning-pressed` |
| Disabled | `#a6acb5` | `#d9dde3` | `action-disabled` / `action-disabled-content` |

> For destructive actions affecting the entire system (e.g., deleting an account), use the [System warning button](Specs%20-%20System%20warning%20button%20primary.md) instead.
