package com.zodiak.android.feature.catalog

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import androidx.navigation.toRoute
import kotlinx.serialization.Serializable

@Serializable object CatalogRoute

@Serializable data class ColorTokenDetailRoute(val tokenId: String)

fun NavGraphBuilder.catalogScreen(
    onNavigateToToken: (String) -> Unit
) {
    composable<CatalogRoute> { CatalogScreen(onNavigateToToken = onNavigateToToken) }
}

fun NavGraphBuilder.colorTokenDetailScreen(
    onBack: () -> Unit
) {
    @OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)
    composable<ColorTokenDetailRoute> { backStackEntry ->
        val route = backStackEntry.toRoute<ColorTokenDetailRoute>()
        ColorTokenDetailScreen(
            tokenId = route.tokenId,
            onBack = onBack
        )
    }
}
