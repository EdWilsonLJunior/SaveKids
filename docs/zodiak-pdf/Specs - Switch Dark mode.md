# Switch

Offers a binary choice.

Overview

Specs

Guidelines

States

Light mode

Dark mode

1. Default: Appears when the switch is enabled but not currently interacted with.

2. Hover: Triggers when the user’s pointer moves over the switch. This state provides a visual cue that

the element is interactive.

3. Keyboard focus: Appears when the button is selected via keyboard navigation (e.g. using the Tab

key), indicating it is ready for interaction.

4. Pressed: Activates when the switch is being pressed or tapped.

5. Disabled. Represents an inactive switch that cannot be selected or focused. This state is used when the option is unavailable due to system rules or user permissions.

## Size

Switches are available in two sizes: small and large.

Small switches are suited for compact interfaces such as filter groups, or mobile layouts. They are ideal for dense UI sections where multiple options are presented in a limited area.

Large switches are recommended for spacious layouts, like preference panels and selection cards. The increased size helps users identify and select options more easily, especially on touch devices or larger screens.

Size

Usage

Dimensions

Target
height

Small

Used in compact layouts with limited space.

40×32px

40×40px

Large

Used in spacious layouts where options need emphasis.

56×32px

56×32px

Interaction

Users can activate a switch by clicking either the switch itself or its associated label.

Both the switch and label should respond to pointer events. When hovering over this region, the cursor must change to a pointer to indicate that the element is clickable.

Switch groups

## Placement

The switch may be used in groups of several switches or in conjunction with other input items.

Align lists of switches to the left for and if needed, organize them into multiple columns.

Don't

Do

Don't place switches horizontally in rows.

Place switches next to each other in columns.

## Spacing

When grouped together, switches should have the spacing-xs token (16px) applied as spacing between them. Always ensure there is consistent spacing between each switch in the group.

Color

Do

Don't

Use the default styling.

Don't change the styling of the switch.
