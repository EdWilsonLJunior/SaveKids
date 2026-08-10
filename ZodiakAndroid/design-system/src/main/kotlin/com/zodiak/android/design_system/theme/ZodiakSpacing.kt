package com.zodiak.android.design_system.theme

import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/**
 * Port of iOS ZodiakSpacing tokens.
 * Base unit parity: 4pt (iOS) == 4dp (Android).
 */
object ZodiakSpacing {
    val s4: Dp = 4.dp
    val s8: Dp = 8.dp
    val s16: Dp = 16.dp
    val s24: Dp = 24.dp
    val s32: Dp = 32.dp
    val s40: Dp = 40.dp
    val s48: Dp = 48.dp
    val s56: Dp = 56.dp
    val s64: Dp = 64.dp
    val s72: Dp = 72.dp
    val s82: Dp = 82.dp
    val s96: Dp = 96.dp
    val s128: Dp = 128.dp
    val s176: Dp = 176.dp

    // Semantic aliases from iOS token file.
    val componentMin: Dp = s4
    val componentPad: Dp = s8
    val screenPad: Dp = s16
    val screenPadLarge: Dp = s32
    val buttonGap: Dp = s16
    val sectionGap: Dp = s24
    val itemGap: Dp = s8
    val formFieldGap: Dp = s16
    val inlineGap: Dp = s8
}
