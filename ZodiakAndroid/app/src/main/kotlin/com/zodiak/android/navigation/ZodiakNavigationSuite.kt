package com.zodiak.android.navigation

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Home
import androidx.compose.material.icons.outlined.Settings
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.adaptive.navigationsuite.NavigationSuiteScaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.NavDestination
import androidx.navigation.NavDestination.Companion.hasRoute
import androidx.navigation.NavDestination.Companion.hierarchy
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.zodiak.android.design_system.atoms.ZodiakIconSize
import com.zodiak.android.design_system.atoms.ZodiakIconView
import com.zodiak.android.feature.savekids.navigation.SaveKidsHomeRoute
import kotlinx.serialization.Serializable
import kotlin.reflect.KClass

// ─── Top-level destinations ──────────────────────

@Serializable object HomeRoute
@Serializable object SettingsRoute

sealed class TopLevelDestination(
    val route: Any,
    val routeClass: KClass<*>,
    val label: String,
    val icon: ImageVector,
) {
    data object Home : TopLevelDestination(SaveKidsHomeRoute, SaveKidsHomeRoute::class, "Início", Icons.Outlined.Home)
    data object Settings : TopLevelDestination(SettingsRoute, SettingsRoute::class, "Config.", Icons.Outlined.Settings)
}

private val TOP_LEVEL_DESTINATIONS = listOf(
    TopLevelDestination.Home,
    TopLevelDestination.Settings,
)

private fun NavDestination?.isTopLevelDestinationInHierarchy(destination: TopLevelDestination) =
    this?.hierarchy?.any { it.hasRoute(destination.routeClass) } == true

// ─── NavigationSuiteScaffold wrapper ─────────────

@Composable
fun ZodiakNavigationSuite() {
    val navController = rememberNavController()
    val backStackEntry by navController.currentBackStackEntryAsState()
    val currentDestination = backStackEntry?.destination

    NavigationSuiteScaffold(
        navigationSuiteItems = {
            TOP_LEVEL_DESTINATIONS.forEach { dest ->
                val selected = currentDestination.isTopLevelDestinationInHierarchy(dest)

                item(
                    selected = selected,
                    onClick  = {
                        navController.navigate(dest.route) {
                            popUpTo(navController.graph.findStartDestination().id) { saveState = true }
                            launchSingleTop = true
                            restoreState = true
                        }
                    },
                    icon     = {
                        ZodiakIconView(
                            imageVector = dest.icon,
                            contentDescription = dest.label,
                            size = ZodiakIconSize.DEFAULT,
                        )
                    },
                    label    = {
                        Text(
                            text = dest.label,
                            style = MaterialTheme.typography.labelSmall,
                        )
                    },
                )
            }
        },
    ) {
        ZodiakNavGraph(navController = navController)
    }
}
