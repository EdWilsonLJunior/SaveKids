# Specs — Tabs

> Allow users to switch between related views inside a single context.

**Related sections:** [Overview](Overview%20-%20Tabs.md) · [Guidelines](Guidelines%20-%20Tabs.md)

## States

Tabs support four interaction states: `default`, `hover`, `selected`, and `disabled`. A `focus` ring is overlaid on top of any state when navigating via keyboard.

## Anatomy

Each tab is composed of an optional **leading icon**, a **label**, and an optional **trailing badge**. The selected tab carries a 2 px accent underline aligned to the bottom of the tab strip.

## Size

| Size | Height | Padding (horizontal) | Label token |
| --- | --- | --- | --- |
| **Small** | 38 px | `spacing-s` (12 px) | `body-s-400` |
| **Medium** | 48 px | `spacing-m` (16 px) | `body-m-400` |
| **Large** | 56 px | `spacing-l` (24 px) | `body-l-400` |

## Color — onLite

| State | Background | Label | Underline | Token |
| --- | --- | --- | --- | --- |
| Default | transparent | `#595e6a` | none | `text-secondary` |
| Hover | `#e9edf3` | `#171a22` | none | `surface-hover-onLite` / `text-primary` |
| Selected | transparent | `#171a22` | `#1d365a` (2 px) | `text-primary` / `action-primary-default-onLite` |
| Focus | inherits state + `#2e323a` ring | inherits | inherits | `action-focus-onLite` |
| Disabled | transparent | `#a6acb5` | none | `text-disabled` / `action-disabled` |

## Color — onHeavy

| State | Background | Label | Underline | Token |
| --- | --- | --- | --- | --- |
| Default | transparent | `#c7ccd3` | none | `text-secondary-onHeavy` |
| Hover | `rgba(255,255,255,0.08)` | `#ffffff` | none | `surface-hover-onHeavy` / `text-inverse` |
| Selected | transparent | `#ffffff` | `#ffffff` (2 px) | `text-inverse` / `action-primary-default-onHeavy` |
| Focus | inherits state + `#ffffff` ring | inherits | inherits | `action-focus-onHeavy` |
| Disabled | transparent | `#3c414a` | none | `action-disabled-onHeavy` |
