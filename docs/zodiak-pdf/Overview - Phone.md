# Phone

Enter phone numbers with country-specific formatting and validation.

Figma component

Status

Open in Figma

Healthy

Anatomy

Light mode

Dark mode

1. Label: Should always be visible. Describes the expected input clearly and concisely.

2. Required indicator (optional): Indicates whether the field is required or optional.

3. Container: Holds all text field elements and reflects the interaction states.

4. Placeholder text (optional): Offers a hint or example. Disappears when the user begins typing. Use only when necessary, never as a replacement for a label

5. Icon (optional): Paired with error/help messages for clarity, icons are used to visually reinforce alerts

6. Helper text (optional): Provides additional guidance, such as formatting rules or validation feedback

7. Flag dropdown (optional): Displays the default country flag based on the user’s location (cookie settings). Users can open the dropdown to select a different country. When a new flag is chosen, the field updates to show the selected flag and automatically applies the corresponding country code to the phone number input.

## Variants

Light mode

Dark mode

Phone inputs come in three variants to support different international phone number entry needs. Choose the variant based on how users should select or view country information.

1. Default – enter a phone number using a predefined international format. Manual number entry only.

Displays placeholder text indicating international format.

2. Country selector (flag) – select a country from a list to automatically apply the correct dialing code.

Includes a country dropdown with flags. Selecting a country automatically populates the corresponding country calling code.

3. Country selector (abbreviation) – select a country using its abbreviation to apply the corresponding

dialing code. Uses a two-letter country abbreviation instead of a flag. Selecting a country automatically populates the corresponding country calling codes.

Scrolling

A maximum of five dropdown options can appear before the scroll feature appears.

Scroll bars may not always be enabled so we recommend showing 50% of the last option’s container height to indicate there is more to see within the menu. We recommend starting a scroll at the sixth option in the menu list, but this may vary based on your specific use case.

Country selector behavior Use the Country selector variants with dropdown menu when the user needs to select a country from a list.

By default, the dropdown displays placeholder text in the field when closed.

Clicking on a closed field opens a menu of options.

Countries are listed alphabetically by country name.

Selecting a country updates the country calling code automatically.

Changing the country code does not remove the entered national number but may re-validate it.

Related components

Similar components

Text input
Enter and edit text through an input area.

Multiselect
Select multiple values from a list of options.

Combobox

Dropdown

Select one value from a list of options using search.

Select one value from a list of options.
