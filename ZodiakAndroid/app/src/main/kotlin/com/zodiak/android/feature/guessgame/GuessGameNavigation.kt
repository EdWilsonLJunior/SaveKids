package com.zodiak.android.feature.guessgame

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object GuessGameRoute

fun NavGraphBuilder.guessGameScreen() {
    composable<GuessGameRoute> { GuessGameScreen() }
}
