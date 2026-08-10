# Dropdown

Select one value from a list of options.

Figma component

Status

Open in Figma

Healthy

Dropdown menus present a list of predefined options that a user can choose from. They allow the user to select one option from a set while keeping the interface compact.

Use a dropdown as the default choice when screen space is limited and the option list is moderate in size.
If users need to select multiple options, use a Multiselect. If the option list is large or requires search, use a

Combobox instead.

Anatomy

Closed dropdown

Light mode

Dark mode

1. Label: Should always be visible. It informs the user what to expect in the list of dropdown options.

2. Required indicator (optional): Indicates whether the field is required or optional.

3. Container: Holds all text field elements and reflects the interaction states.

4. Placeholder text (optional): Persists when the dropdown is open or closed. Placeholder text is optional to display in the dropdown field if no option has been selected yet from the list. Do not put important information in placeholder text because the text disappears once an option is selected from the list.

5. Helper text and icon (optional): Provides additional guidance, such as formatting rules or validation feedback.

6. Chevron: Signals that the dropdown menu can be expanded or collapsed. It rotates 180 degrees when the menu is toggled.

Opened dropdown

Light mode

Dark mode

1. Selected label: The placeholder text changes to display the label of the option that is selected.

2. Selected option: Changes color and has a checkmark to display the option that is currently being

selected.

3. Dropdown menu: A list of options to choose from. Appears when the dropdown container is clicked

and contains all available options. Present the options alphabetically or numerically for easy scanning.

## Variants

The Dropdown is available in a single variant. Two related components, Multiselect and Combobox, support different selection behaviors and use cases:

Dropdown: Allows users to select one option from a predefined list.

Multiselect: Allows users to select multiple options from a predefined list, typically using checkboxes.
The list may optionally support filtering when many options are available.

Combobox: Combines an input field with a dropdown to allow users to search and filter a large list and select one option. It may also support entering a custom value, depending on configuration.

Scrolling

A maximum of five dropdown options can appear before the scroll feature appears.

Scroll bars may not always be enabled so we recommend showing 50% of the last option’s container height to indicate there is more to see within the menu. We recommend starting a scroll at the sixth option in the menu list, but this may vary based on your specific use case.

## Behavior

Use a dropdown when the user needs to select one option from a list of predefined options. Dropdowns are the optimal default option to provide alternative choices. They are also a good choice when screen space is limited.

By default, the dropdown displays placeholder text in the field when closed.

Clicking on a closed field opens a menu of options.

Selecting an option from the menu closes it and the selected option text replaces the placeholder text in the field and also remains as an option in place if the menu is open.

Related components

Similar components

Text input

Enter and edit text through an input area.

Multiselect
