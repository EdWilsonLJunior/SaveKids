package com.zodiak.android.feature.studentgrades

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object StudentGradesRoute

fun NavGraphBuilder.studentGradesScreen() {
    composable<StudentGradesRoute> { StudentGradesScreen() }
}
