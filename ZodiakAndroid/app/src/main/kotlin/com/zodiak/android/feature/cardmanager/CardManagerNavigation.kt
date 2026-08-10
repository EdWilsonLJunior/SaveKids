package com.zodiak.android.feature.cardmanager

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object CardManagerRoute

fun NavGraphBuilder.cardManagerScreen() {
    composable<CardManagerRoute> { CardManagerScreen() }
}
