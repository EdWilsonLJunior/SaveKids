package com.zodiak.android.feature.productmanager

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object ProductManagerRoute

fun NavGraphBuilder.productManagerScreen() {
    composable<ProductManagerRoute> { ProductManagerScreen() }
}
