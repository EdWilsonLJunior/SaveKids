# Sizing

> Ensure consistent sizing of components.

Most Zodiak components have **predefined sizes that should not be changed**, but in certain cases these tokens can be used to define the width and height of a component. Size tokens are used whenever possible to ensure consistent sizing throughout the design.

## Primitives

These primitive tokens are based on an **8 pixel base unit**.

| Token | Value | Token | Value |
| --- | --- | --- | --- |
| `size-2xs` | 8 px | `size-3xl` | 128 px |
| `size-xs` | 16 px | `size-4xl` | 160 px |
| `size-s` | 24 px | `size-5xl` | 200 px |
| `size-m` | 32 px | `size-6xl` | 320 px |
| `size-l` | 48 px | `size-7xl` | 480 px |
| `size-xl` | 56 px | `size-8xl` | 640 px |
| `size-2xl` | 72 px | `size-9xl` | 720 px |
| | | `size-10xl` | 880 px |
| | | `size-11xl` | 960 px |
| | | `size-12xl` | 1040 px |

## Grid adjusted sizes

In addition to the primitive size tokens, we offer specific sizes that **adhere to the grid for desktop, tablet, and mobile layouts**. These tokens ensure that components fit seamlessly within the grid structure.

| Device | Fullbleed | Fullwidth | Split 2 | Split 3 | Split 4 |
| --- | --- | --- | --- | --- | --- |
| Desktop | 1920 px | 1296 px | 636 px | 416 px | 306 px |
| Desktop small | 1280 px | 1116 px | 546 px | 356 px | 261 px |
| Tablet | 768 px | 696 px | 336 px | 216 px | — |
| Mobile | 360 px | 312 px | 148 px | — | — |

## Applying sizes in Figma

When defining the width of a component in Figma, simply **apply a variable** instead of typing the value.

> *Example: applying size tokens in Figma.*

---

**Related:** [Spacing](Spacing.md) · [Layout grid](Overview%20-%20Layout%20grid.md)
