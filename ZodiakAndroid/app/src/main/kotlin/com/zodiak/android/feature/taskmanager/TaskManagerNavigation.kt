package com.zodiak.android.feature.taskmanager

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object TaskManagerRoute

fun NavGraphBuilder.taskManagerScreen() {
    composable<TaskManagerRoute> { TaskManagerScreen() }
}
