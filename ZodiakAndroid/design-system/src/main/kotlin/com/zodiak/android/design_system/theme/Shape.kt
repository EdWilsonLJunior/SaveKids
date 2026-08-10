package com.zodiak.android.design_system.theme

import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Shapes
import androidx.compose.ui.unit.dp

val ZodiakShapes = Shapes(
    extraSmall = RoundedCornerShape(ZodiakRadii.xs),
    small      = RoundedCornerShape(8.dp),
    medium     = RoundedCornerShape(12.dp),
    large      = RoundedCornerShape(ZodiakRadii.s),
    extraLarge = RoundedCornerShape(ZodiakRadii.m),
)
