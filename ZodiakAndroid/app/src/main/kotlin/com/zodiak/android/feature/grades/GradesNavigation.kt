package com.zodiak.android.feature.grades

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable
object GradesRoute

fun NavGraphBuilder.gradesScreen(onBack: () -> Unit = {}) {
    composable<GradesRoute> {
        GradesScreen(onBack = onBack)
    }
}
