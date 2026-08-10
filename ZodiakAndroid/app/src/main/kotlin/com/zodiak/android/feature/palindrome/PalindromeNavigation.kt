package com.zodiak.android.feature.palindrome

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object PalindromeRoute

fun NavGraphBuilder.palindromeScreen() {
    composable<PalindromeRoute> { PalindromeScreen() }
}
