package com.zodiak.android.design_system.theme

import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/**
 * Port of iOS ZodiakSizing tokens.
 * Use for component dimensions, not spacing.
 */
object ZodiakSizing {
    val twoXSmall: Dp = 8.dp
    val xs: Dp = 16.dp
    val s: Dp = 24.dp
    val m: Dp = 32.dp
    val l: Dp = 48.dp
    val xl: Dp = 56.dp
    val twoXLarge: Dp = 72.dp
    val threeXLarge: Dp = 128.dp
    val fourXLarge: Dp = 160.dp
    val fiveXLarge: Dp = 200.dp
    val sixXLarge: Dp = 320.dp
    val sevenXLarge: Dp = 480.dp
    val eightXLarge: Dp = 640.dp
    val nineXLarge: Dp = 720.dp
    val tenXLarge: Dp = 880.dp
    val elevenXLarge: Dp = 960.dp
    val twelveXLarge: Dp = 1040.dp

    object Icon {
        val xs: Dp = 16.dp
        val sm: Dp = 20.dp
        val md: Dp = 24.dp
        val lg: Dp = 32.dp
        val xl: Dp = 40.dp
    }

    object Avatar {
        val xs: Dp = 24.dp
        val sm: Dp = 32.dp
        val md: Dp = 40.dp
        val lg: Dp = 56.dp
        val xl: Dp = 72.dp
        val xxl: Dp = 120.dp
    }

    object HitTarget {
        val minimum: Dp = 44.dp
        val comfortable: Dp = 48.dp
    }

    object Button {
        val small: Dp = 38.dp
        val medium: Dp = 48.dp
        val large: Dp = 56.dp
    }

    val fieldHeight: Dp = 48.dp
    val chipHeight: Dp = 32.dp
    val dividerThickness: Dp = 1.dp
    val cardMaxWidth: Dp = 480.dp
    val contentMaxWidth: Dp = 1024.dp
}
