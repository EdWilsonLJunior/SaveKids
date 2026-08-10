# Chips

Compactly represent selectable filters or inputs.

Overview

Specs

Guidelines

Figma component

Status

Anatomy

Light mode

Dark mode

Open in Figma

Healthy

1. Container

2. Label

3. Icon (optional)

## Variants

All variants of the chips are available with and without an icon.

Chips for selection

Selection chips are used to narrow results. They feature a check icon and toggle on/off.

Icon

False

Selected

False

Icon

False

Selected

True

Icon

Selected

True

True

Chips for input

Icon

True

Selected

False

Input chips represent user-provided input. They feature a “remove” icon and disappear when deselected.
These chips are also available with an avatar.

Icon

False

Selected

False

Icon

False

Selected

True

Icon

True

Selected

False

Icon

Selected

True

True

Icon

Avatar

True

True

Selected

False

Layout

Icon

Avatar

Selected

True

True

True

Chips are displayed in horizontal groups containing a maximum of 15 chips. When the total width of a chip group exceeds the screen’s available width, the chips wrap to the next line and continue on multiple lines as needed.

This is especially important for selection chips in smaller viewports, like tablet and mobile.

Example of chips wrapped onto multiple lines on tablet

## Behavior

Chips for selection

Depending on context, selection chips can be used for single selection or multiple selections.

When clicking a selection chip, its status will change. A selected chip will have the selected tick arrow at the end of the chip to indicate it is selected.

Behavior of the chips on click.

Single-selection chips

Also known as choice chips, single-selection chips allow only one chip to be active at a time. When another chip is clicked, the previously selected chip is automatically deselected, and the newly selected chip becomes active. This interaction pattern is particularly effective for large data sets, where limiting the selection to a single option helps maintain clarity.

Example of single selection chips.

Multiple-selection chips

Multiple chips may be selected simultaneously. When an additional chip is clicked, it is automatically selected and added to the current selection. To deselect a chip, the user must click the selected chip again, after which it will revert to its unselected state.

Example of multiple selected chips.

Chips for input

Input chips can be used to display and confirm selected filters or user inputs that should remain visible within the interface. Clicking an active chip with a close icon removes the chip and clears the associated selection.

In the below example only one chip is selected, displaying only the relevant cards from the category “Our people”.

Example of a single selected input chip.

In the following example two chips are selected and the grid below only displays the relevant cards from the two selected categories.

Example of two selected input chips.

Related components

Includes

Icons

Visually represent actions, categories and objects.

Avatar

Represent a user, group, or brand.

Similar components

Tabs
Organize content into sections within the same view.
