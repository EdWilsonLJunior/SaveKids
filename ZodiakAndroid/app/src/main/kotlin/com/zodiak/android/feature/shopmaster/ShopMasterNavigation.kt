package com.zodiak.android.feature.shopmaster

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object ShopMasterRoute

fun NavGraphBuilder.shopMasterScreen() {
    composable<ShopMasterRoute> { ShopMasterScreen() }
}
