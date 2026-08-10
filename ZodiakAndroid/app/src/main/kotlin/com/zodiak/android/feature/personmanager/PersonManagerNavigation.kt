package com.zodiak.android.feature.personmanager

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object PersonManagerRoute

fun NavGraphBuilder.personManagerScreen() {
    composable<PersonManagerRoute> { PersonManagerScreen() }
}
