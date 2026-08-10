package com.zodiak.android.design_system.atoms

import androidx.compose.foundation.layout.size
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

// ─── ZodiakProgressIndicator ──────────────────────────────────────────────────
// Zodiak Design System – Atoms layer
// Wraps MD3 LinearProgressIndicator and CircularProgressIndicator.
//
// Usage — determinate:
//   ZodiakLinearProgressIndicator(progress = 0.6f)
//   ZodiakCircularProgressIndicator(progress = 0.6f)
//
// Usage — indeterminate (loading):
//   ZodiakLinearProgressIndicator()
//   ZodiakCircularProgressIndicator()
//
// Gap reference: G-020

/**
 * Horizontal progress bar.
 *
 * @param progress `null` = indeterminate animation; `0f..1f` = determinate fill.
 * @param modifier Applied to the underlying [LinearProgressIndicator].
 */
@Composable
fun ZodiakLinearProgressIndicator(
    modifier: Modifier = Modifier,
    progress: Float? = null,
) {
    if (progress != null) {
        LinearProgressIndicator(
            progress = { progress.coerceIn(0f, 1f) },
            modifier = modifier,
        )
    } else {
        LinearProgressIndicator(modifier = modifier)
    }
}

// ─── Circular ─────────────────────────────────────────────────────────────────

/** Predefined circular indicator sizes aligned to the 4dp spacing grid. */
enum class ZodiakCircularProgressSize(val dp: Dp) {
    /** 24 dp — inline next to text or inside a button. */
    SMALL(24.dp),

    /** 40 dp — standalone loading state (default). */
    DEFAULT(40.dp),

    /** 56 dp — full-screen / hero loading state. */
    LARGE(56.dp),
}

/**
 * Circular progress indicator.
 *
 * @param modifier Applied to the underlying [CircularProgressIndicator] plus size.
 * @param progress `null` = indeterminate animation; `0f..1f` = determinate arc.
 * @param size     One of the predefined [ZodiakCircularProgressSize] tokens.
 */
@Composable
fun ZodiakCircularProgressIndicator(
    modifier: Modifier = Modifier,
    progress: Float? = null,
    size: ZodiakCircularProgressSize = ZodiakCircularProgressSize.DEFAULT,
) {
    val sizedModifier = modifier.size(size.dp)
    if (progress != null) {
        CircularProgressIndicator(
            progress = { progress.coerceIn(0f, 1f) },
            modifier = sizedModifier,
        )
    } else {
        CircularProgressIndicator(modifier = sizedModifier)
    }
}
