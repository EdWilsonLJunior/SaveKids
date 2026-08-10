package com.zodiak.android.feature.savekids.data.local.room

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.zodiak.android.feature.savekids.model.HistoryEventType
import com.zodiak.android.feature.savekids.model.MissionStatus

@Entity(tableName = "savekids_profile")
data class SaveKidsProfileEntity(
    @PrimaryKey val id: Int = 1,
    val childName: String,
    val avatarPokemonId: Int,
    val avatarTeamName: String,
)

@Entity(tableName = "savekids_wallet")
data class SaveKidsWalletEntity(
    @PrimaryKey val id: Int = 1,
    val balance: Double,
    val xp: Int,
    val level: Int,
    val updatedAt: Long,
)

@Entity(tableName = "savekids_goals")
data class SaveKidsGoalEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val name: String,
    val targetAmount: Double,
    val currentAmount: Double,
    val completed: Boolean,
)

@Entity(tableName = "savekids_missions")
data class SaveKidsMissionEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val title: String,
    val description: String,
    val rewardXp: Int,
    val rewardMoney: Double,
    val status: MissionStatus,
)

@Entity(tableName = "savekids_rewards")
data class SaveKidsRewardEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val title: String,
    val description: String,
    val requiredXp: Int,
    val active: Boolean,
    val redeemed: Boolean,
)

@Entity(tableName = "savekids_history")
data class SaveKidsHistoryEventEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val title: String,
    val details: String,
    val type: HistoryEventType,
    val amount: Double,
    val xpDelta: Int,
    val createdAt: Long,
)

@Entity(tableName = "savekids_family")
data class SaveKidsFamilyMemberEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val name: String,
    val role: String,
    val savings: Double,
    val xp: Int,
    val streakDays: Int,
    val highlighted: Boolean,
)
