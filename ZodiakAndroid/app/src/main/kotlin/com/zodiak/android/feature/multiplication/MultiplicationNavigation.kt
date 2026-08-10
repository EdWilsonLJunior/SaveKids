package com.zodiak.android.feature.multiplication

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object MultiplicationRoute

fun NavGraphBuilder.multiplicationScreen() {
    composable<MultiplicationRoute> { MultiplicationScreen() }
}
