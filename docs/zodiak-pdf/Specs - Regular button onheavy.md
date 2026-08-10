# Specs — Regular button (onHeavy)

> Initiate an action or event when clicked — placed on dark surfaces.

**Related sections:** [Overview](Overview%20-%20Regular%20button.md) · [Guidelines](Guidelines%20-%20Regular%20button.md) · [Specs onLite](Specs%20-%20Regular%20button.md) · [Specs onPhoto](Specs%20-%20Regular%20button%20onphoto.md)

## States

The regular button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`. See [Button guidelines](Button%20guidelines.md).

Sizes and placement rules are identical to the [onLite specs](Specs%20-%20Regular%20button.md#size). This page only documents color tokens.

## Color — onHeavy

### Primary

| State | Background | Foreground | Token |
| --- | --- | --- | --- |
| Default | `#ffffff` | `#171a22` | `action-primary-default-onHeavy` / `text-primary` |
| Hover | `#f4f6f9` | `#171a22` | `action-primary-hover-onHeavy` |
| Focus | `#ffffff` + `#ffffff` ring | `#171a22` | `action-primary-default-onHeavy` + `action-focus-onHeavy` |
| Pressed | `#e9edf3` | `#171a22` | `action-primary-pressed-onHeavy` |
| Disabled | `#3c414a` | `#888f9a` | `action-disabled-onHeavy` / `action-disabled-content-onHeavy` |

### Secondary (outlined)

| State | Border / fill | Foreground | Token |
| --- | --- | --- | --- |
| Default | `#ffffff` border, transparent fill | `#ffffff` | `action-primary-default-onHeavy` |
| Hover | `#f4f6f9` | `#f4f6f9` | `action-primary-hover-onHeavy` |
| Focus | `#ffffff` + `#ffffff` ring | `#ffffff` | `action-primary-default-onHeavy` + `action-focus-onHeavy` |
| Pressed | `#e9edf3` | `#e9edf3` | `action-primary-pressed-onHeavy` |
| Disabled | `#3c414a` | `#3c414a` | `action-disabled-onHeavy` |

### Tertiary (text only)

| State | Underline / fg | Token |
| --- | --- | --- |
| Default | `#ffffff` | `action-primary-default-onHeavy` |
| Hover | `#f4f6f9` | `action-primary-hover-onHeavy` |
| Focus | `#ffffff` + `#ffffff` ring | `action-focus-onHeavy` |
| Pressed | `#e9edf3` | `action-primary-pressed-onHeavy` |
| Disabled | `#3c414a` | `action-disabled-onHeavy` |
