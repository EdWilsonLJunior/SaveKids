package com.zodiak.android.design_system.theme

import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.Dp

// ─── ZodiakHitTarget ─────────────────────────────────────────────────────────
// Zodiak DS — Minimum interactive hit-target tokens.
// Mirrors: iOS ZodiakHitTarget (not yet ported)
// Gap: G-060 — centralized hit-target minimum missing
//
// Usage:
//   Modifier.minimumInteractiveComponentSize()          ← M3 built-in (recommended)
//   Modifier.zodiakHitTarget()                          ← explicit DS token
//   Modifier.zodiakHitTarget(ZodiakHitTarget.small)     ← compact contexts only
//
// References:
//   WCAG 2.5.5 — https://www.w3.org/WAI/WCAG22/Understanding/target-size-enhanced.html
//   Material Design 3 — https://m3.material.io/foundations/accessible-design/accessibility-basics
//   Android a11y — https://developer.android.com/guide/topics/ui/accessibility/principles#touch-targets

/**
 * Minimum touch target sizes enforced by the Zodiak Design System.
 *
 * - [default] 48 × 48 dp — WCAG 2.5.5 / MD3 required minimum for all interactive elements.
 * - [small]   40 × 40 dp — Compact contexts only (dense toolbars, chips in tight rows).
 *                          Do NOT use for primary CTAs or standalone icon buttons.
 * - [large]   56 × 56 dp — High-value actions (FAB-equivalent, primary navigation).
 */
object ZodiakHitTarget {
    /** Canonical minimum from iOS tokens (WCAG/HIG baseline). */
    val minimum: Dp = ZodiakSizing.HitTarget.minimum

    /** Comfortable target from iOS tokens (Material baseline). */
    val comfortable: Dp = ZodiakSizing.HitTarget.comfortable

    /** Backward-compatible alias for previous API. */
    val default: Dp = comfortable

    /** Compact contexts only. */
    val small: Dp = minimum

    /** High-emphasis interaction size. */
    val large: Dp = ZodiakSizing.Button.large
}

/**
 * Applies the standard Zodiak DS minimum hit target of [ZodiakHitTarget.default] (48 × 48 dp)
 * to both width and height.
 *
 * Prefer M3's `Modifier.minimumInteractiveComponentSize()` for components that already use
 * M3 primitives — this extension is for custom composables that bypass M3 internals.
 *
 * @param size Minimum dimension to apply. Defaults to [ZodiakHitTarget.default].
 */
fun Modifier.zodiakHitTarget(size: Dp = ZodiakHitTarget.default): Modifier =
    this.defaultMinSize(minWidth = size, minHeight = size)
