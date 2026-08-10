# Radio

Choose a single option from a set.

## States

1. Default: Appears when the radio button is enabled but not currently interacted with.

2. Hover: Triggers when the user’s pointer moves over the radio button. This state provides a visual cue

that the element is interactive.

3. Focus: Indicates that the radio button has been activated via keyboard navigation or mouse click. A

visible focus ring supports accessibility and confirms readiness for input.

4. Read-only: Displays a fixed value that users can view but not change. While still focusable for accessibility, it does not respond to clicks or taps.

5. Disabled: Represents an inactive radio button that cannot be selected or focused. This state is used when the option is unavailable due to system rules or user permissions.

6. Error: Highlights a validation issue, such as a required radio button being left unchecked.

## Size

Radio buttons are available in two sizes: small and large. Each size supports different layout needs and interaction contexts.

Small radio buttons are suited for compact interfaces such as filter groups, or mobile layouts. They are ideal for dense UI sections where multiple options are presented in a limited area.

Large radio buttons are recommended for spacious layouts, like preference panels and selection cards.
The increased size helps users identify and select options more easily, especially on touch devices or larger screens.

Size

## Usage

Dimensions

Small

Used in compact layouts with limited space.

18×18px

Large

Used in spacious layouts where options need emphasis.

24×24px

Target
height

24px

24px

Interaction

Mouse

Users can activate a radio button by clicking either the box itself or its associated label.

Both the radio button and label should respond to pointer events. When hovering over this region, the cursor must change to a pointer to indicate that the element is clickable.

Both the radio button and label should respond to mouse events.

Keyboard

Users should be able to navigate to the radio button using the Tab key. Once focused, it can be toggled using the Spacebar.

The focus state appears when the radio button is selected via keyboard, confirming its active state.

Radio button groups

## Placement

Groups of radio buttons and their labels should be left-aligned in vertical columns.

Do

Don't

Order groups of radio buttons vertically.

Don't place radio buttons horizontally in rows.

Radio button options should follow a logical and predictable order. Depending on context, this may mean arranging items by relevance, frequency of use, or a natural progression—such as beginner to advanced.

Do

Arrange radio boxes in a logical order.

## Spacing

When grouped together, radios should have the spacing-xs token (16px) applied as spacing between them, as well as between the group and its label. Always ensure there is consistent spacing between each radio button in the group.
