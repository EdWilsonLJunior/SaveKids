package com.zodiak.android.feature.pixdiscount

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object PixDiscountRoute

fun NavGraphBuilder.pixDiscountScreen() {
    composable<PixDiscountRoute> { PixDiscountScreen() }
}
