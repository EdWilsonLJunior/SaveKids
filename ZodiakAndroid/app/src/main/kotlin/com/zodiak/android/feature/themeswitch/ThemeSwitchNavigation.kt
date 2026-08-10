package com.zodiak.android.feature.themeswitch

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object ThemeSwitchRoute

fun NavGraphBuilder.themeSwitchScreen() {
    composable<ThemeSwitchRoute> { ThemeSwitchScreen() }
}
