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

Default

#171a22

Text Primary

#595e6a

Text Secondary

#f8fafc

#f1f4f7

#1d365a

#ffffff

Action Primary Default onLite

#272b33

#f8fafc

Surface Smoke Lite

Hover

#171a22

Text Primary

#595e6a

Text Secondary

#f8fafc

#f1f4f7

#1d365a

#ffffff

Action Primary Default onLite

#eff0f4

Surface Cloud Lite

Focus

#171a22

Text Primary

#21252d

#f8fafc

#1d365a

#ffffff

Action Primary Default onLite

#c7ccd3

Border Primary

#f8fafc

Surface Smoke Lite

Active

#171a22

Text Primary

#3c414a

#272b33

#f8fafc

#1d365a

#ffffff

Action Primary Default onLite

#f8fafc

Surface Smoke Lite

Filled

#171a22

Text Primary

#272b33

#f8fafc

#1d365a

#ffffff

Action Primary Default onLite

#c7ccd3

Border Primary

#f8fafc

Surface Smoke Lite

No results

#171a22

Text Primary

#3c414a

#272b33

#f8fafc

#1d365a

#ffffff

Action Primary Default onLite

#c7ccd3

Border Primary

#eff0f4

Border Secondary

#3c414a

#2e323a

#f8fafc

#272b33

Surface Smoke Lite

#ffffff

Page Background

Error

#171a22

Text Primary

#12151d

#f8fafc

#9e0029

#ffa7a9

Text Negative onLite

#c7ccd3

Border Primary

#f8fafc

Surface Smoke Lite

Disabled

#a6acb5

Text Disabled

#a6acb5

Action Disabled

#f8fafc

Surface Smoke Lite

#3c414a

#272b33

#888f9a

#3c414a

#272b33
