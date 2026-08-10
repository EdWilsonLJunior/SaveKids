# Overview — Video preview button

> Pause or resume an auto-played video preview.

**Related sections:** [Specs](Specs%20-%20Video%20preview%20button.md) · [Button guidelines](Button%20guidelines.md) · [Media button](Overview%20-%20Media%20button%20onLite.md)

> Also known as: **Play/Pause button**, **Auto-play button**, **Media preview button**.

## When to use

Some components include video previews that **start playing automatically** when they come into view. For these auto-played videos, use the **Video preview button** to let users pause or resume the preview.

> For regular (non-preview) videos, use the [Media button](Overview%20-%20Media%20button%20onLite.md) instead.

## Anatomy

| # | Element | Description |
| --- | --- | --- |
| 1 | **Button fill** | Semi-transparent `action-primary-default-onPhoto` fill applied in all states to ensure accessibility on any video. |
| 2 | **Icon** | Displays the current video state — Play or Pause. |
| 3 | **Progress circle** *(optional)* | Shows the remaining time for the video preview. May be omitted if technical constraints prevent its implementation. |
| 4 | **Container** | An oversized container creates a large, accessible tap/click target area. |

## Variants

| Variant | When shown | Description |
| --- | --- | --- |
| **Pause** | Video is auto-playing (default) | Allows users to pause the video preview. |
| **Play** | Video is paused | Allows users to resume the preview. |

## Hierarchy

Playing or pausing a preview is considered a **secondary action**. The Video preview button therefore uses the same visual style as other secondary buttons and is **always placed at the bottom-right corner** of the video.

This keeps the primary action (e.g., play the full video) more prominent.

| ✅ Do | ❌ Don't |
| --- | --- |
| Always use the Video preview button as a **secondary** control for playing or pausing a video preview. | Don't make playing or pausing a preview a primary action. |

## Behavior

1. By default, the **Pause** variant is displayed — the video is currently playing.
2. When clicked, the video **pauses** and the button switches to the **Play** variant. The progress circle stops animating.
3. Clicking **Play** resumes the preview and returns to the **Pause** variant. The progress circle continues from where it left off.
