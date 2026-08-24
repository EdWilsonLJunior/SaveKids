package com.zodiak.android.feature.savekids.repository

import com.zodiak.android.feature.savekids.model.DashboardModel
import com.zodiak.android.feature.savekids.model.FamilyMemberModel
import com.zodiak.android.feature.savekids.model.GoalModel
import com.zodiak.android.feature.savekids.model.HistoryEventModel
import com.zodiak.android.feature.savekids.model.MissionModel
import com.zodiak.android.feature.savekids.model.PokemonAvatarModel
import com.zodiak.android.feature.savekids.model.RewardModel
import com.zodiak.android.feature.savekids.model.SaveKidsProfile
import com.zodiak.android.feature.savekids.model.SaveKidsSession
import kotlinx.coroutines.flow.Flow

interface SaveKidsRepository {
    val session: Flow<SaveKidsSession>
    val profile: Flow<SaveKidsProfile?>
    val dashboard: Flow<DashboardModel>
    val goals: Flow<List<GoalModel>>
    val missions: Flow<List<MissionModel>>
    val rewards: Flow<List<RewardModel>>
    val history: Flow<List<HistoryEventModel>>
    val family: Flow<List<FamilyMemberModel>>

    suspend fun ensureSeedData()
    suspend fun clearAuthentication()
    suspend fun login(username: String, password: String): Result<Unit>
    suspend fun completeProfile(name: String, avatarPokemonId: Int): Result<Unit>
    suspend fun updateProfile(name: String, avatarPokemonId: Int): Result<Unit>
    suspend fun addDeposit(amount: Double, goalId: Long? = null): Result<Unit>
    suspend fun createGoal(name: String, targetAmount: Double): Result<Unit>
    suspend fun completeMission(id: Long, targetGoalId: Long? = null): Result<Unit>
    suspend fun redeemReward(id: Long): Result<Unit>
    suspend fun refreshAvatar(): Result<PokemonAvatarModel>
    suspend fun withdrawMoney(amount: Double): Result<Unit>
}
