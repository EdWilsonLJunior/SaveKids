package com.zodiak.android.feature.savekids.navigation

import kotlinx.serialization.Serializable

@Serializable object SaveKidsLoginRoute
@Serializable object SaveKidsHomeRoute
@Serializable object SaveKidsPiggyBankRoute
@Serializable object SaveKidsGoalsRoute
@Serializable object SaveKidsMissionsRoute
@Serializable object SaveKidsRewardsRoute
@Serializable object SaveKidsHistoryRoute
@Serializable object SaveKidsAvatarRankingRoute

data class SaveKidsTabItem(
    val label: String,
    val route: Any,
)

val saveKidsTabs = listOf(
    SaveKidsTabItem("Visão geral", SaveKidsHomeRoute),
    SaveKidsTabItem("Missões", SaveKidsMissionsRoute),
    SaveKidsTabItem("Metas", SaveKidsGoalsRoute),
    SaveKidsTabItem("Família", SaveKidsAvatarRankingRoute),
    SaveKidsTabItem("Recompensas", SaveKidsRewardsRoute),
)
