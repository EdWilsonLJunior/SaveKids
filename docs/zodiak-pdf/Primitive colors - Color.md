# Primitive colors

> Raw color values that form the foundation of the Zodiak palette. Use **semantic** tokens for product UI; primitives are exposed for documentation and exceptional cases.

**Related sections:** [Introduction](Introduction%20-%20Color.md) · [Semantic colors](Semantic%20colors%20-%20Color.md) · [Accessibility](Accessibility%20-%20Color.md)

> ⚠️ Primitive color tokens encapsulate raw hex codes and are **not designed to be applied directly**. Use semantic colors, which are defined based on context and purpose. If you ever need to reference a primitive token, consult the **Visual Identity Guidelines** to make sure it's applied correctly.

## Brand colors

Within these color tints, two swatches represent our **core brand identity**:

- `CapgeminiBlue-500` — primary brand color, also known as **Capgemini Blue**.
- `CapgeminiBlue-900` — secondary brand color, also known as **Capgemini Dark Blue**.

### CapgeminiBlue

| Tint | Token | Value |
| --- | --- | --- |
| Brand 6% | `CapgeminiBlue-Brand-6%` | `rgba(0, 88, 171, 0.06)` |
| 25 | `CapgeminiBlue-25` | `#fcfcfc` |
| 50 | `CapgeminiBlue-50` | `#eff0f4` |
| 100 | `CapgeminiBlue-100` | `#dfe1eb` |
| 200 | `CapgeminiBlue-200` | `#8ea6d5` |
| 300 | `CapgeminiBlue-300` | `#5685c6` |
| 400 | `CapgeminiBlue-400` | `#3573c0` |
| **500** *(primary)* | `CapgeminiBlue-500` | `#0058ab` |
| 600 | `CapgeminiBlue-600` | `#264f96` |
| 700 | `CapgeminiBlue-700` | `#1c4076` |
| 800 | `CapgeminiBlue-800` | `#1d365a` |
| **900** *(secondary)* | `CapgeminiBlue-900` | `#121a38` |
| 950 | `CapgeminiBlue-950` | `#070a16` |
| 1000 | `CapgeminiBlue-1000` | `#010204` |

## Brand accent colors

### Teal

| Tint | Token | Value |
| --- | --- | --- |
| 600 | `Teal-600` | `#00d5d0` |
| 900 | `Teal-900` | `#29656f` |

## Neutral

| Tint | Token | Value |
| --- | --- | --- |
| 50 | `Neutral-50` | `#f8fafc` |
| 100 | `Neutral-100` | `#f4f6f9` |
| 150 | `Neutral-150` | `#f1f4f7` |
| 200 | `Neutral-200` | `#e9edf3` |
| 250 | `Neutral-250` | `#e6e9ed` |
| 300 | `Neutral-300` | `#d9dde3` |
| 350 | `Neutral-350` | `#c7ccd3` |
| 400 | `Neutral-400` | `#a6acb5` |
| 450 | `Neutral-450` | `#888f9a` |
| 500 | `Neutral-500` | `#6e7480` |
| 550 | `Neutral-550` | `#595e6a` |
| 600 | `Neutral-600` | `#474c56` |
| 650 | `Neutral-650` | `#3c414a` |
| 700 | `Neutral-700` | `#343840` |
| 750 | `Neutral-750` | `#2e323a` |
| 800 | `Neutral-800` | `#272b33` |
| 850 | `Neutral-850` | `#21252d` |
| 900 | `Neutral-900` | `#1b1f27` |
| 950 | `Neutral-950` | `#171a22` |
| 1000 | `Neutral-1000` | `#12151d` |

## Basics

| Token | Value |
| --- | --- |
| Black 0% | `rgba(0, 0, 0, 0)` |
| Black 5% | `rgba(0, 0, 0, 0.05)` |
| Black 6% | `rgba(0, 0, 0, 0.06)` |
| Black 8% | `rgba(0, 0, 0, 0.08)` |
| Black 10% | `rgba(0, 0, 0, 0.1)` |
| Black 15% | `rgba(0, 0, 0, 0.15)` |
| Black 55% | `rgba(0, 0, 0, 0.55)` |
| Black 75% | `rgba(0, 0, 0, 0.75)` |
| Black | `#000000` |
| White 0% | `rgba(255, 255, 255, 0)` |
| White 5% | `rgba(255, 255, 255, 0.05)` |
| White 50% | `rgba(255, 255, 255, 0.5)` |
| White | `#ffffff` |
| Overlay color | `rgba(23, 26, 34, 0.4)` |

## Accent colors

These colors are **not part of Capgemini's core brand palette**. They were created specifically for digital interfaces to ensure proper contrast, accessibility, and clarity. Their purpose is **functional rather than expressive**: they communicate system states such as **success, warning, attention, and error** in a way that is universally recognizable.

For that reason, these state colors sit within the design system rather than the brand book. They serve a different function, operate under different constraints, and support the user interface instead of shaping brand expression. Although they contribute to the overall digital experience, they are not considered part of the brand's official color palette.

> The additional colors provided in Capgemini's brand book are intended primarily for **print and presentation materials**.

### Green (success)

| Tint | Value | Tint | Value |
| --- | --- | --- | --- |
| 50 | `#eff7f5` | 500 | `#57cf80` |
| 100 | `#e7f6eb` | 600 | `#4eb972` |
| 200 | `#cdedd5` | 700 | `#43a063` |
| 300 | `#afe3bd` | 800 | `#1e5631` |
| 400 | `#8ad9a2` | 900 | `#0f2e22` |

### Yellow (warning)

| Tint | Value | Tint | Value |
| --- | --- | --- | --- |
| 50 | `#fffcf5` | 500 | `#ffda80` |
| 100 | `#fff8eb` | 600 | `#e4c372` |
| 200 | `#fff1d5` | 700 | `#c6a963` |
| 300 | `#ffeabd` | 800 | `#a18a51` |
| 400 | `#ffe2a2` | 900 | `#726139` |

### Orange (attention)

| Tint | Value | Tint | Value |
| --- | --- | --- | --- |
| 50 | `#fffcfa` | 500 | `#f68f40` |
| 100 | `#ffe5d3` | 600 | `#f17817` |
| 200 | `#fecfad` | 700 | `#cc640f` |
| 300 | `#fcb988` | 800 | `#9f500d` |
| 400 | `#f9a464` | 900 | `#743c0b` |

### Red (error)

| Tint | Value | Tint | Value |
| --- | --- | --- | --- |
| 50 | `#fbf2f3` | 500 | `#f64059` |
| 100 | `#ffcaca` | 600 | `#dd1d46` |
| 200 | `#ffa7a9` | 700 | `#c00036` |
| 300 | `#ff848b` | 800 | `#9e0029` |
| 400 | `#ff6270` | 900 | `#5d051a` |
