package com.zodiak.android.feature.savekids.utils

import com.zodiak.android.feature.savekids.model.LevelInfo
import com.zodiak.android.feature.savekids.model.SaveKidsLevels

object GamificationRules {
    const val XP_PER_REAL = 1
    const val XP_CREATE_GOAL = 20
    const val XP_COMPLETE_MISSION = 50
    const val XP_COMPLETE_GOAL = 100

    fun levelForXp(xp: Int): LevelInfo {
        return SaveKidsLevels.lastOrNull { xp >= it.requiredXp } ?: SaveKidsLevels.first()
    }

    fun nextLevelXp(currentXp: Int): Int {
        val next = SaveKidsLevels.firstOrNull { it.requiredXp > currentXp }
        return next?.requiredXp ?: SaveKidsLevels.last().requiredXp
    }
}
