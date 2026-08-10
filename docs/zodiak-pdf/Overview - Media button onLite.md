# Overview — Media button

> Control audio and video playback.

**Related sections:** [Specs (onLite)](Specs%20-%20Media%20button%20onLite.md) · [Specs (onHeavy & onPhoto)](Specs%20-%20Media%20button%20onHeavy%20and%20onPhoto.md) · [Specs (onPhoto)](Specs%20-%20Media%20button%20onPhoto.md)

| Figma | Status |
| --- | --- |
| [Open in Figma](#) | Healthy |

> *Also known as: Video button, Audio button, Play/Pause button.*

The Media button is a specialized icon button used to interact with audio and video content. It triggers actions such as:

- Play / Pause
- Mute / Unmute
- Speed adjustment
- Item switching (e.g. next episode or track)

Use the Media button in components related to **podcasts, video players, and audio players**.

> Use the **Media preview button** for video previews — it has a progress circle that visually indicates the remaining preview time.

## Anatomy

1. **Icon** — displays the action.
2. **Container**.

## Variants

Media buttons come in **three visual variants** to ensure optimal contrast across different backgrounds.

| Variant | Use when… |
| --- | --- |
| `onLite` | Placed on **light** backgrounds. |
| `onHeavy` | Placed on **dark or bold** backgrounds. |
| `onPhoto` | Placed over **video or image** content. |

## Available actions

| Action | Behavior |
| --- | --- |
| **Play** | Starts playing video or audio. |
| **Pause** | Pauses video or audio playback. |
| **Stop** | Stops playback completely. |
| **Skip back** | Skips to the previous track or section. |
| **Skip forward** | Skips to the next track or section. |
| **Speed** | Adjusts playback speed. |
| **Rewind** | Moves backward within the current track or video. |
| **Forward** | Moves forward within the current track or video. |
| **Shuffle** | Plays tracks in random order. |
| **Max volume** | Sets volume to the maximum level. |
| **Min volume** | Sets volume to the minimum level. |
| **Volume off** | Mutes all audio. |
| **Forward 15s** | Jumps forward by 15 seconds. |
| **Back 15s** | Jumps backward by 15 seconds. |
| **Close** | Closes the media player or preview. |

## Video previews

For auto-playing video previews, use the **Media preview button**. This variant has a larger target size and a progress circle that visually indicates the remaining preview time, helping users understand the duration at a glance.

## Hierarchy

The **Play, Pause and Stop** buttons are **primary** buttons — they are the most important media buttons. Other actions, like increasing volume, share the same styling as other tertiary buttons because they are less important, supplemental actions.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use the Media preview button for secondary actions, like pausing a video preview. | Don't use the Media button for video previews. |
| Use primary buttons for the most important action, like playing or pausing audio. Use tertiary buttons for supplementary actions. | Don't make supplementary actions, like skipping through audio, a primary action. |
| Use the primary buttons with filled icons for the most important actions on a video. | Don't use the secondary variant of the Play, Pause, and Stop buttons as the primary action on a video that is not a preview. |
