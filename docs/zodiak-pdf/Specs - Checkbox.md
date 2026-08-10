# Checkbox

Collect multiple selections.

## States

Checkboxes communicate two types of states: selection states, which reflect the current value of the checkbox, and interaction states, which indicate how the user is engaging with the component.

Selection states

Selection states show whether a checkbox is selected, partially selected, or unselected.

Unselected

This state appears when the checkbox is enabled and no selection has been made.

Indeterminate

Displayed on a parent checkbox when only some child checkboxes are selected, this state visually communicates a partial selection within a group.

Selected

This state appears when the user has selected the checkbox, either directly or through a parent-level interaction.

Interaction states

Interaction states reflect how the user is currently engaging with the checkbox.

1. Default: Appears when the checkbox is enabled but not currently interacted with.

2. Hover: Triggers when the user’s pointer moves over the checkbox. This state provides a visual cue that

the element is interactive.

3. Focus: Indicates that the checkbox has been activated via keyboard navigation or mouse click. A visible

focus ring supports accessibility and confirms readiness for input.

4. Read-only: Displays a fixed value that users can view but not change. While still focusable for accessibility, it does not respond to clicks or taps.

5. Disabled: Represents an inactive checkbox that cannot be selected or focused. This state is used when the option is unavailable due to system rules or user permissions.

6. Error: Highlights a validation issue, such as a required checkbox being left unchecked.

## Size

Checkboxes are available in two sizes: small and large. Each size is designed to support different layout densities.

Small checkboxes are recommended for compact layouts such as inline form elements, data tables, and dense UI sections. This size helps conserve space without compromising functionality.

Large checkboxes are recommended for spacious desktop layouts, including filter panels, settings menus, and broader interface elements. The larger checkbox improves legibility, making it ideal for interfaces where checkboxes need to stand out or be easily tapped, especially on larger screens.

Size

## Usage

Small

Large

Used in compact layouts with limited space.

Used in spacious layouts where checkboxes need to stand out.

Dimensions

Target
height

18×18px

24px

24×24px

24px

Interaction

Checkboxes must support both mouse and keyboard input to ensure accessibility and consistent behavior across devices.

Mouse

Users can activate a checkbox by clicking either the box itself or its associated label.

Both the checkbox and label should respond to pointer events. When hovering over this region, the cursor must change to a pointer to indicate that the element is clickable.

Ensure that both the checkbox and label respond to pointer events. The cursor should change to a pointer, signaling that the element is clickable.

Keyboard

Users should be able to navigate to the checkbox using the Tab key. Once focused, the checkbox can be toggled using the Spacebar.

The focus state appears when the checkbox is selected via keyboard, confirming its active state and supporting accessibility standards.

Parent-child relationship

Checkboxes can be nested to reflect a parent-child relationship, allowing users to select either an entire set of options, or a specific subset.

Selecting the parent checkbox automatically selects all nested child checkboxes.

Deselecting the parent checkbox will automatically deselect all child checkboxes.

When a child checkbox is deselected and all other child checkboxes remain selected, the parent checkbox will switch from the default checked state to the undefined state.

When a child checkbox is selected, and at least one other child checkbox remains unselected, the parent checkbox will automatically enter the undefined state.

Checkbox groups

## Placement

Align checkbox lists to the left for and if needed, organize them into multiple columns.

Do

Don't

Place checkboxes next to each other in columns.

Don't place checkboxes horizontally in rows.

Checkbox lists should follow a logical order. Depending on context, this may mean ordering items from smallest to largest, simplest to most complex, or alphabetically. In some cases, ordering by relevance or popularity—such as listing languages by number of speakers—can help users find common options more efficiently.

Do

Arrange options in a meaningful order, such as from smallest to largest.

## Spacing

When grouped together, checkboxes should have the spacing-xs token (16px) applied as spacing between them, as well as between the group and its label. Always ensure there is consistent spacing between each checkbox in the group.
