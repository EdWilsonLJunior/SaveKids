package com.zodiak.android.feature.quizgame

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object QuizGameRoute

fun NavGraphBuilder.quizGameScreen() {
    composable<QuizGameRoute> { QuizGameScreen() }
}
