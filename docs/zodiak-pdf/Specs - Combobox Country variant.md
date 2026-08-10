# Combobox

Select one value from a list of options using search.

Properties

Property

BG Variant

Values

Default

Page Background | Surface
Smoke

Page Background

Open Variant

False | True

Size Variant

M | L

State Variant

Default | Hover | Active |
Filled | Error | No results
| Focus | Disabled

Country Variant

True | False

Country text Text

Text inserted Text

string

string

False

M

Default

False

Country

Text inserted

Boolean

true | false

undefined

Boolean

true | false

undefined

Show helper
text

Show helper
icon

Search Text

Helper text Text

Typed text Text

Error text Text

User typing| Text

string

string

string

string

string

Search

Helper Text

|

Error Text

Frankfurt

Frankfurt

Option selected Text

string

Country typed Text

string

United States

Country selected
text

Text

string

Search country Text

string

Albania

Search

States

Regular variant

Country variant

Default state

Hover state

Focus state

Active state

Filled state with open menu

Filled state

No results state

Error state

Disabled state

1. Default: The initial state before any interaction. Shows the label, magnify glass icon and search text.

Chevron icon indicates the combobox can be expanded.

2. Hover: Triggered when the user moves the pointer over the combobox field. Visual cue (e.g., subtle

background or border change) signals interactivity.

3. Focus: Activated when the user clicks into the field or navigates via keyboard. Highlights the field to

indicate readiness for input. The menu displays a list of options. Chevron icon flips upward to indicate expanded state. User can either enter in text or scroll to select an option.

4. Active: Appears when the field has been selected.

5. Filled (open menu): Displays the list of options. Chevron icon flips upward to indicate expanded state.

User can scroll or select an option.

6. Filled (closed menu): Occurs after the user selects an option. Selected value replaces search field text and icon. Field returns to default or focus styling, depending on interaction, and displays a close icon alongside the selected value.

7. Error: Indicates a validation issue (e.g., required field left empty). Shows error message and optional alert icon. The input is invalid due to an incorrect format, missing required data, or a system-level issue.
This state prevents submission until corrected and requires user action. Highlights the field to indicate readiness for input to correct the error.

8. Disabled: The field is inactive and cannot be interacted with. It does not respond to focus or input events.

## Size

Comboboxes come in two height sizes: medium and large. Supporting multiple sizes provides flexibility when designing layouts, but consistency is key: use the same size for all form components on a page. For example, if you choose a large combobox, apply the same size to text inputs, buttons, and other elements.
When in doubt, default to the medium size.

Size

## Usage

Medium

Large

Ideal for space-constrained layouts or long, complex forms.

Best for spacious layouts, simple forms, or standalone comboboxes.

Height

Target
height

Min
width

Max
width

40px

40px

270px

800px

48px

48px

270px

800px

Menu size

Size

Usage

Height

Target
height

Min
width

Max
width

Small

With medium dropdown
fields.

48px

48px

-

-

Large

With large dropdown fields.

56px

56px

180px

800px

Used components sizes

These are the sizes of components that are used in the dropdown and its menu.

Element

Medium

Large

Search icon

Chevron icon

Helper icon

Check icon

S

S

S

M

M

M

S

M

Flag

16×16px

24×24px

Typography

Element

Medium

Large

Label text

Search text

Helper text

heading-2xs-
300

heading-xs-
300

body-s-300

body-m-300

body-xs-300

body-xs-300

Dropdown item

body-s-300

body-m-300

Color

Combobox field colors

Menu colors

Menu shadow

The dropdown menu has a subtle shadow around it.

4px 0 70px 3px `rgba(0,0,0,0.03)`

Capgemini shadow

Menu item colors

Default

#171a22

Text Primary

#eff0f4

Border Secondary

#ffffff

Page Background

#f8fafc

#2e323a

#12151d

Hover

#171a22

Text Primary

#eff0f4

Border Secondary

#eff0f4

Surface Cloud Lite

Focus

#171a22

Text Primary

#2e323a

Action Focus onLite

#ffffff

Page Background

Selected

#171a22

Text Primary

#eff0f4

Border Secondary

#f8fafc

Surface Smoke Lite

#f8fafc

#2e323a

#21252d

#f8fafc

#ffffff

#12151d

#f8fafc

#2e323a

#272b33

Disabled

#a6acb5

Text Disabled

#eff0f4

Border Secondary

#ffffff

Page Background

#888f9a

#2e323a

#12151d
