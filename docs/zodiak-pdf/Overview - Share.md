# Overview — Share

> Provide ways to share content.

**Related sections:** [Guidelines](Guidelines%20-%20Share.md) · [Specs](Specs%20-%20Share.md)

## About

The share component enables users to share content through multiple channels. Clicking the share button opens a menu that can contain options such as Email, LinkedIn, and copying the link to the content.

## Anatomy

### Share button

| # | Element | Description |
| --- | --- | --- |
| 1 | **Share icon** | Visual indicator for the share action. |
| 2 | **Share text** | Always displays the word "Share" in the site's language. |

### Share menu

| # | Element | Description |
| --- | --- | --- |
| 1 | **Share menu** | Displays the list of share options. |
| 2 | **Share menu item** | Each includes a relevant icon and label. |
| 3 | **Close button** | Allows the user to dismiss the menu. |

## Variants

The behavior and appearance of the menu will differ depending on the viewport.

## Behavior

### Desktop and tablet

Clicking the share button opens a floating menu with sharing options. The menu appears near the button and can be closed using the close button in the top-right corner of the menu, or by clicking outside of the menu.

### Mobile

When tapped, the share menu opens in a bottom drawer.

While open:
- The rest of the screen is dimmed and locked using the `overlay-page-overlay` token to maintain focus on the share options.

Close the drawer by:
- Tapping the close button in the top-right corner.
- Tapping the dimmed area outside the drawer.

## Related components

### Used within

| Component | Description |
| --- | --- |
| **Author** | Display the writer(s) of an article. |
| **Preamble** | Offers an intro to an article text. |

### Similar components

| Component | Description |
| --- | --- |
| **Download** | Open a list of downloadable assets. |
