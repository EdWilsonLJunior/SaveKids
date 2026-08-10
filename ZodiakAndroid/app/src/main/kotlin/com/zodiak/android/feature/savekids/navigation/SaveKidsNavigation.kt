package com.zodiak.android.feature.savekids.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import com.zodiak.android.feature.savekids.view.SaveKidsAvatarRankingScreen
import com.zodiak.android.feature.savekids.view.SaveKidsGoalsScreen
import com.zodiak.android.feature.savekids.view.SaveKidsHistoryScreen
import com.zodiak.android.feature.savekids.view.SaveKidsHomeScreen
import com.zodiak.android.feature.savekids.view.SaveKidsLoginScreen
import com.zodiak.android.feature.savekids.view.SaveKidsMissionsScreen
import com.zodiak.android.feature.savekids.view.SaveKidsPiggyBankScreen
import com.zodiak.android.feature.savekids.view.SaveKidsRewardsScreen

fun NavGraphBuilder.saveKidsScreens(navController: NavHostController) {
    composable<SaveKidsLoginRoute> {
        SaveKidsLoginScreen(
            onBack = { navController.popBackStack() },
            onGoToHome = {
                navController.navigate(SaveKidsHomeRoute) {
                    popUpTo(SaveKidsLoginRoute) { inclusive = true }
                    launchSingleTop = true
                }
            },
        )
    }
    composable<SaveKidsHomeRoute> {
        SaveKidsHomeScreen(
            onBack = { navController.popBackStack() },
            onNavigate = { navController.navigate(it) { launchSingleTop = true } },
        )
    }
    composable<SaveKidsPiggyBankRoute> {
        SaveKidsPiggyBankScreen(
            onBack = { navController.popBackStack() },
            onNavigate = { navController.navigate(it) { launchSingleTop = true } },
        )
    }
    composable<SaveKidsGoalsRoute> {
        SaveKidsGoalsScreen(
            onBack = { navController.popBackStack() },
            onNavigate = { navController.navigate(it) { launchSingleTop = true } },
        )
    }
    composable<SaveKidsMissionsRoute> {
        SaveKidsMissionsScreen(
            onBack = { navController.popBackStack() },
            onNavigate = { navController.navigate(it) { launchSingleTop = true } },
        )
    }
    composable<SaveKidsRewardsRoute> {
        SaveKidsRewardsScreen(
            onBack = { navController.popBackStack() },
            onNavigate = { navController.navigate(it) { launchSingleTop = true } },
        )
    }
    composable<SaveKidsHistoryRoute> {
        SaveKidsHistoryScreen(onBack = { navController.popBackStack() })
    }
    composable<SaveKidsAvatarRankingRoute> {
        SaveKidsAvatarRankingScreen(
            onBack = { navController.popBackStack() },
            onNavigate = { navController.navigate(it) { launchSingleTop = true } },
        )
    }
}
