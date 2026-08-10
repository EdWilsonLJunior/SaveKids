# Overview — Layout grid

> Ensure consistent alignment.

**Related sections:** [Text layout](Text%20layout%20-%20Layout%20grid.md)

Layout grids provide a structured framework that divides pages into columns, making it easy to arrange content consistently. This organization ensures alignment and maintains balance across the design. Grids enable responsive designs, ensuring content adapts to different screen sizes and devices.

This page describes the structure and behavior of our **fluid, responsive layout grid**, which adapts across all viewports while maintaining fixed margins and gutters.

Our layout grid uses **stretch-based (fluid) columns** that adapt to the available space. While columns expand and contract fluidly, margins and gutters remain fixed to maintain consistent alignment, spacing, and visual rhythm.

The grid ensures:

- Consistent spacing across all viewports.
- Flexible column behavior for scalable layouts.
- Predictable margins and gutters for stable alignment.

## Anatomy

The grid consists of **three elements**:

1. Column
2. Gutter
3. Margin

### Layout terms

| Term | Definition |
| --- | --- |
| **Column** | Vertical division of space in the grid. |
| **Margin** | Space outside the area of an element — in this case, on the left and right side of the grid. |
| **Gutter** | Space between columns. |
| **Viewport** | Visible section of the screen where content is displayed. |
| **Breakpoint** | Specific point at which the layout changes to fit different screen sizes. |

## Viewports

We provide layout grids for **five viewports**: Desktop large, Desktop small, Tablet large, Tablet, and Mobile.

| Viewport | Range | Columns | Column width | Margin | Gutter |
| --- | --- | --- | --- | --- | --- |
| Desktop large | 1920–2400 px | 12 | Stretch | 312 px | 32 px |
| Desktop small | 1280–1919 px | 12 | Stretch | 82 px | 24 px |
| Tablet large | 992–1279 px | 6 | Stretch | 56 px | 24 px |
| Tablet | 768–991 px | 6 | Stretch | 82 px | 24 px |
| Mobile | 320–767 px | 4 | Stretch | 24 px | 16 px |

> Always test your design across viewport sizes.

## Breakpoints

Breakpoints define the viewport widths at which the grid switches to a new layout configuration. Each breakpoint corresponds to a specific range with its own **fixed margins, fixed gutters, and column count**. Within these ranges, the layout remains fluid: columns stretch to fill the available space while margins and gutters stay constant.

## Fluid scaling behavior

### Column width

Within each viewport range, the column width scales automatically. Column width is calculated by distributing the remaining horizontal space after removing fixed margins and gutters.

### Gutters and margins

Both gutters and margins are **fixed size**. Margins are fixed for each viewport to maintain consistent alignment across screens. Gutters are fixed to maintain predictable spacing between columns.

## Using the fluid grid

To use the fluid grids effectively, ensure components scale within stretch-based column widths.

### Applying the grid in Figma

1. Create the outer frame and ensure **Auto Layout** has been applied to it.
2. Apply the fluid grid from the Layout guide for your viewport.
3. Use compositions sized for the correct viewport. When placing compositions inside the outer frame, make sure they match the intended viewport size (e.g. Desktop, Tablet, Mobile).
4. Set compositions to **fill the width** of the outer frame. You will be able to see the maximum and minimum width of the fluid component.
5. Your fluid composition is ready.
