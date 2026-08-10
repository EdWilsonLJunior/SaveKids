# Guidelines — Regular button

> Initiate an action or event when clicked.

**Related sections:** [Overview](Overview%20-%20Regular%20button.md) · [Specs](Specs%20-%20Regular%20button.md) · [Specs onHeavy](Specs%20-%20Regular%20button%20onheavy.md) · [Specs onPhoto](Specs%20-%20Regular%20button%20onphoto.md)

## Content

### Labels

Button labels are crucial for **clearly communicating the action performed**. They should be straightforward, predictable, and descriptive to ensure accessibility for all users, including those with screen readers.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use a descriptive button text. | Don't use vague labels like *"Read more"*. |

### Icons

Icons are **optional** for all regular buttons. They can be either on the **left (leading)** or **right (trailing)** side of the text. For buttons without a label, use the **Icon button** component instead.

| Icon position | Variant |
| --- | --- |
| None | Button regular, icon false |
| Left | Button regular, icon left |
| Right | Button regular, icon right |

Icons can enhance button usability by providing visual cues that help users quickly understand the button's purpose. They are particularly useful when the icon is universally recognized and clearly conveys the action (e.g. a trash can for delete).

**Avoid using icons when:**

- They are not instantly recognizable — unclear icons increase cognitive load.
- They are used as links to other pages on the same site — text labels alone are clearer for navigation.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use an icon if the button directs to a specific action. | Don't use an arrow if the button is linked to a regular page. |

## Accessibility

### Photographic backgrounds

For photographic backgrounds, **light primary and secondary buttons must be used**. Tertiary buttons are **not allowed** on photographic backgrounds as they are not accessible. When using secondary buttons, make sure the image has an overlay applied to ensure accessibility.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use light buttons on photographic backgrounds. | Don't use dark buttons on photographic backgrounds. |
| Use a secondary button on a photographic background **with a dark image overlay**. | — |
