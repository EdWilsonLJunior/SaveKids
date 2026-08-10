package com.zodiak.android.design_system.theme

import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

// ─── ZodiakGrid ──────────────────────────────────────────────────────────────
// Zodiak DS — Layout grid tokens for Compose.
// Mirrors: iOS ZodiakGrid (not yet ported)
// Gap: G-007 — column/gutter spec missing
//
// Usage:
//   val grid = ZodiakGrid.forWindowWidth(windowWidthDp)
//   Modifier.padding(horizontal = grid.margin)
//
// Design reference: docs/zodiak-pdf/Overview - Layout grid.md

/**
 * Layout grid specification for a single breakpoint.
 *
 * @param columns  Number of content columns.
 * @param gutter   Space between adjacent columns.
 * @param margin   Horizontal padding from screen edge to the first/last column.
 */
data class ZodiakGridSpec(
    val columns: Int,
    val gutter: Dp,
    val margin: Dp,
)

/**
 * Zodiak DS layout grid tokens.
 *
 * Three breakpoints matching Material Design 3 window size classes:
 * - **Compact** (< 600dp) — 4 columns, phone portrait
 * - **Medium** (600–839dp) — 8 columns, phone landscape / small tablet
 * - **Expanded** (≥ 840dp) — 12 columns, tablet / large screen
 */
object ZodiakGrid {

    /** Phone portrait — < 600dp width */
    val compact = ZodiakGridSpec(
        columns = 4,
        gutter  = 8.dp,
        margin  = 16.dp,
    )

    /** Phone landscape / foldable / small tablet — 600–839dp */
    val medium = ZodiakGridSpec(
        columns = 8,
        gutter  = 16.dp,
        margin  = 24.dp,
    )

    /** Large tablet / desktop — ≥ 840dp */
    val expanded = ZodiakGridSpec(
        columns = 12,
        gutter  = 24.dp,
        margin  = 24.dp,
    )

    /**
     * Resolve the correct [ZodiakGridSpec] for a given window width.
     *
     * @param windowWidthDp Current window width in Dp (from `LocalConfiguration.current.screenWidthDp.dp`
     *                       or `WindowSizeClass`).
     */
    fun forWindowWidth(windowWidthDp: Dp): ZodiakGridSpec = when {
        windowWidthDp < 600.dp -> compact
        windowWidthDp < 840.dp -> medium
        else                   -> expanded
    }
}
