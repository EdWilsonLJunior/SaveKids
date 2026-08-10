# Introduction — Color

> Distinguish our brand and reinforce a consistent visual identity.

**Related sections:** [Primitive colors](Primitive%20colors%20-%20Color.md) · [Semantic colors](Semantic%20colors%20-%20Color.md) · [Accessibility](Accessibility%20-%20Color.md)

> These colors are designed to be used for **digital products**. For marketing, presentations, or other purposes, check out the colors in Capgemini's brand book.

Color ensures consistency, accessibility, and brand cohesion across all digital products. We use color to create visual hierarchy and direct attention to the most important content.

In Zodiak we use **two types of color tokens**:

- **Primitive tokens** — the raw, base colors without inherent meaning. Ideally should not be used directly, only for elements that need to stand out.
- **Semantic tokens** — derived from primitive tokens, these assign an intended usage to each color.

## Primitive colors

Primitive colors are the foundation of our design system's color palette. They represent raw color values and don't have a specific meaning or usage on their own. Primitives can be used for elements that need to stand out, such as headers or key interactive elements.

These tokens are named based on their **appearance**, typically reflecting their color family and the intensity of the color. For example, `red-100` is a light red color while `red-900` is a much darker red.

## Semantic colors

Built from primitive tokens, semantic colors are named based on their **purpose**, not their appearance. Each semantic token name indicates its use, combining the component name with a functional descriptor.

For example: a component's background color. The raw hex code is first assigned to a primitive color token like `neutral-500`. This primitive token is then mapped to a semantic token like `surface-primary`, which is used for the component's background.

With this layered setup, adapting the design for dark mode is simple: the primitive color linked to `surface-primary` can shift from `neutral-500` to `neutral-400`, automatically updating all components that use `surface-primary`.

## Lite and heavy

> Not to be confused with **Light** and **Dark** modes.

The `lite` and `heavy` colors indicate **different tones of colors**:

- `heavy` colors are more bold and contrasting.
- `lite` colors offer a softer look.

We also use the terms `onLite` and `onHeavy` in our components to indicate whether they should be used on `lite` or `heavy` colors:

- Use `onLite` components with `lite` colors.
- Use `onHeavy` components with `heavy` colors.

This ensures sufficient contrast for accessibility.

> *Example: Lite and Heavy background colors in both Light and Dark mode.*

## Light and dark theme

Color tokens are **not tied to fixed values** and adapt based on the active theme. This ensures consistent contrast and accessibility across different environments.

> *Example: the semantic color token `action-primary-default-onlite` adapting its color for the light and dark theme.*

Applying a theme uses variable mode in Figma.

## Themes

Learn how theming works and how semantic tokens translate into specific values for properties such as color, spacing, and typography. See [design tokens](https://www.designtokens.org/) and the [Accessibility](Accessibility%20-%20Color.md) page for details.
