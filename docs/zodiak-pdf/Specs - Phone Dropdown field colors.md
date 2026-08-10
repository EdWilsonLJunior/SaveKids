# Phone

Enter phone numbers with country-specific formatting and validation.

Properties

Property

BG Variant

Values

Default

Page Background | Surface
Smoke

Page Background

Open Variant

True | False

Size Variant

M | L

Type Variant

State Variant

Default | Country Flag |
Country Abbreviation

Default | Hover | Active |
Error | Filled | Focus |
Disabled

False

M

Default

Default

Label text Text

string

Phone number

Show Helper
icon

Boolean

true | false

undefined

Filled PhoneNumber Text

string

555 555 5555

Text Text

string

Show icon Boolean

true | false

Show Helper
text

Boolean

true | false

Helper text Text

string

Error text Text

string

Filled phone
number L

Filled phone
number

Typed text L Text

Placeholder Text

Placeholder L Text

Text

string

Text

string

string

string

string

|

undefined

undefined

Enter phone number
in international
format.

Invalid format. Use
+country code.

4 7824912

4 7824912

|

PhoneNumber

PhoneNumber

States

Default states

Default

Hover

Active

Filled

Error

Focus

Disabled

1. Default: The initial state before any interaction. Shows the label, magnify glass icon and search text.

Chevron icon indicates the combobox can be expanded.

2. Hover: Triggered when the user moves the pointer over the combobox field. Visual cue (e.g., subtle

background or border change) signals interactivity.

3. Focus (menu shown): Activated when the user clicks into the field or navigates via keyboard. Highlights
the field to indicate readiness for input. The menu displays a list of options. Chevron icon flips upward to indicate expanded state. User can either enter in text or scroll to select an option.

4. Error: Indicates a validation issue (e.g., required field left empty). Shows error message and optional alert icon. The input is invalid due to an incorrect format, missing required data, or a system-level issue.
This state prevents submission until corrected and requires user action.

5. Open (menu shown): Displays the list of options. Chevron icon flips upward to indicate expanded state. User can scroll or select an option.

6. Open 1 selected (menu shown): Displays the list of options with one option selected. Chevron icon flips upward to indicate expanded state. User can scroll or select an option.

7. Filled: After an option is selected, the placeholder text is replaced by the chosen value. The field reverts to its default styling and displays a close (×) icon alongside the selected value.

8. Disabled: The field is inactive and cannot be interacted with. It does not respond to focus or input events.

Flag country selector states

Default

Hover

Active

Filled

Filled (open toggle true)

Error

Focus

Disabled

1. Default: The initial state before any interaction. Shows two sections, one for the flag dropdown and

the other to enter the phone number. Chevron icon indicates the flag dropdown can be expanded.

2. Hover: Triggered when the user moves the pointer over the phone field. Visual cue (e.g., subtle

background or border change) signals interactivity.

3. Active Activated when the user clicks into the phone number area or navigates to it via keyboard, with
the country menu still collapsed. The field shows focus styling and a text cursor, indicating the input is ready for entry while the country dropdown remains available.

4. Filled: After an option is selected, the placeholder text is replaced by the chosen value. The field reverts to its default styling and displays the phone number the user entered.

5. Filled (menu shown) The field contains a value and the country dropdown is expanded. The entered phone number remains visible while the menu shows available options.

6. Error: Indicates a validation issue (e.g., required field left empty). Shows error message and optional alert icon. The input is invalid due to an incorrect format, missing required data, or a system-level issue.
This state prevents submission until corrected and requires user action.

7. Focus: Activated when the user clicks into the field or navigates via keyboard. Highlights the field to indicate readiness for input.

8. Disabled: The field is inactive and cannot be interacted with. It does not respond to focus or input events.

Abbreviated country selector states

Default

Hover

Active

Filled

Filled (open toggle true)

Error

Focus

Disabled

1. Default: The initial state before any interaction. Shows two sections, one for the country abbreviation

dropdown with the generic globe icon and the other to enter the phone number. Chevron icon indicates the flag dropdown can be expanded.

2. Hover: Triggered when the user moves the pointer over the phone field. Visual cue (e.g., subtle

background or border change) signals interactivity.

3. Active Activated when the user clicks into the phone number area or navigates to it via keyboard, with

the country abbreviation menu still collapsed. The field shows focus styling and a text cursor, indicating the input is ready for entry while the country dropdown remains available.

4. Filled: After an option is selected, the placeholder icon is replaced by the chosen value. The field reverts to its default styling and displays the phone number the user entered.

5. Filled (menu shown) The field contains a value and the country abbreviation dropdown is expanded.

The entered phone number remains visible while the menu shows available options.

6. Error: Indicates a validation issue (e.g., required field left empty). Shows error message and optional alert icon. The input is invalid due to an incorrect format, missing required data, or a system-level issue.

This state prevents submission until corrected and requires user action.

7. Focus (menu shown): Activated when the user clicks into the field or navigates via keyboard. Highlights the field to indicate readiness for input. The menu displays a list of options. Chevron icon flips upward to indicate expanded state. User can either enter in text or scroll to select an option.

8. Disabled: The field is inactive and cannot be interacted with. It does not respond to focus or input events.

## Size

Phone inputs come in two height sizes: medium and large. Supporting multiple sizes provides flexibility when designing layouts, but consistency is key: use the same size for all form components on a page. For example, if you choose a large phone input, apply the same size to text inputs, buttons, and other elements. When in doubt, default to the medium size.

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

Size

## Usage

Medium

Large

Ideal for space-constrained layouts or long, complex forms.

Best for spacious layouts, simple forms, or standalone dropdowns (e.g., filters)

Dropdown menu size

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

These are the sizes of components that are used in the combobox and its menu.

Element

Medium

Large

Chevron icon

Helper icon

Check icon

S

S

M

M

S

M

Typography

Element

Medium

Large

Label text

heading-2xs-

heading-xs-

300

300

Placeholder text

body-s-300

body-m-300

Helper text

body-xs-300

body-xs-300

Dropdown item

body-s-300

body-m-300

Color

Dropdown field colors

Dropdown menu colors

Default

#171a22

Text Primary

#f8fafc

#1d365a

#ffffff

Action Primary Default onLite

#f8fafc

Surface Smoke Lite

Hover

#171a22

Text Primary

#272b33

#f8fafc

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

#f8fafc

Surface Smoke Lite

Error

#171a22

Text Primary

#272b33

#f8fafc

#9e0029

#ffa7a9

Text Negative onLite

#f8fafc

Surface Smoke Lite

Disabled

#a6acb5

Text Disabled

#a6acb5

Action Disabled

#f8fafc

Surface Smoke Lite

#272b33

#888f9a

#3c414a

#272b33
