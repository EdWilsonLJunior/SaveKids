package com.zodiak.android.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.zodiak.android.feature.savekids.navigation.SaveKidsLoginRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsScreens
import com.zodiak.android.feature.themeswitch.themeSwitchScreen

@Composable
fun ZodiakNavGraph(navController: NavHostController) {
    NavHost(navController = navController, startDestination = SaveKidsLoginRoute) {
        composable<SettingsRoute> { SettingsScreen(navController) }
        themeSwitchScreen()
        saveKidsScreens(navController)
    }
}
