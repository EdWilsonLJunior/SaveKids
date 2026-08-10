package com.zodiak.android.feature.login

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object LoginRoute

fun NavGraphBuilder.loginScreen() {
    composable<LoginRoute> { LoginScreen() }
}
