package com.zodiak.android.feature.voting

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object VotingRoute

fun NavGraphBuilder.votingScreen() {
    composable<VotingRoute> { VotingScreen() }
}
