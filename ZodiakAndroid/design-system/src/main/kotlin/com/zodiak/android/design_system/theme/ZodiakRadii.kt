package com.zodiak.android.design_system.theme

import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/** Port of iOS ZodiakRadii tokens. */
object ZodiakRadii {
    val none: Dp = 0.dp
    val xs: Dp = 4.dp
    val s: Dp = 16.dp
    val m: Dp = 32.dp
    val l: Dp = 999.dp
    val full: Dp = l

    fun shape(radius: Dp): RoundedCornerShape = RoundedCornerShape(radius)
}
