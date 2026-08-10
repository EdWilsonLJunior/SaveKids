# Zodiak DS — Templates API Reference (Android)

> Templates are **not yet ported** to Android. Use `Scaffold` + `LazyColumn` manually.
> This file documents the iOS templates for reference so you can replicate the same UX pattern.

---

## Template Selection Guide (iOS reference)

| iOS Template | Purpose | Android equivalent |
|---|---|---|
| `ZodiakActivityTemplate` | Standard feature screen — scrollable content, optional eyebrow/intro | `Scaffold` + `LazyColumn` |
| `ZodiakListTemplate` | Feature screen that displays a list with built-in empty state | `Scaffold` + `LazyColumn` + `ZodiakEmptyState` |
| `ZodiakInputOutputTemplate` | Feature screen with inputs + pinned submit button at bottom | `Scaffold(bottomBar = { ZodiakButton(...) })` + `LazyColumn` |
| `ZodiakAdaptiveTemplate` | Same as ActivityTemplate but always centers content (iPad-first) | `Scaffold` + `Column(maxWidth = 600.dp)` |

<rules>
**Rule: ALWAYS provide a `Scaffold` as the screen root in `features/`. Never raw `Column` or `LazyColumn` without `Scaffold`.**
</rules>

---


---

## Components

| Component | File |
|---|---|
| `ZodiakActivityTemplate` | [templates/ZodiakActivityTemplate.md](templates/ZodiakActivityTemplate.md) |
| `ZodiakInputOutputTemplate` | [templates/ZodiakInputOutputTemplate.md](templates/ZodiakInputOutputTemplate.md) |
| `ZodiakListTemplate` | [templates/ZodiakListTemplate.md](templates/ZodiakListTemplate.md) |

