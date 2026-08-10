package com.zodiak.android.feature.savekids.data.local.room

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import kotlinx.coroutines.flow.Flow

@Dao
interface SaveKidsProfileDao {
    @Query("SELECT * FROM savekids_profile WHERE id = 1")
    fun observeProfile(): Flow<SaveKidsProfileEntity?>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsert(profile: SaveKidsProfileEntity)
}

@Dao
interface SaveKidsWalletDao {
    @Query("SELECT * FROM savekids_wallet WHERE id = 1")
    fun observeWallet(): Flow<SaveKidsWalletEntity?>

    @Query("SELECT * FROM savekids_wallet WHERE id = 1")
    suspend fun getWallet(): SaveKidsWalletEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsert(wallet: SaveKidsWalletEntity)
}

@Dao
interface SaveKidsGoalDao {
    @Query("SELECT * FROM savekids_goals ORDER BY completed ASC, id DESC")
    fun observeGoals(): Flow<List<SaveKidsGoalEntity>>

    @Query("SELECT * FROM savekids_goals ORDER BY completed ASC, id DESC LIMIT 3")
    fun observeTopGoals(): Flow<List<SaveKidsGoalEntity>>

    @Insert
    suspend fun insert(goal: SaveKidsGoalEntity): Long

    @Update
    suspend fun update(goal: SaveKidsGoalEntity)

    @Query("SELECT * FROM savekids_goals WHERE id = :id")
    suspend fun findById(id: Long): SaveKidsGoalEntity?
}

@Dao
interface SaveKidsMissionDao {
    @Query("SELECT * FROM savekids_missions ORDER BY id ASC")
    fun observeMissions(): Flow<List<SaveKidsMissionEntity>>

    @Query("SELECT * FROM savekids_missions ORDER BY id ASC")
    suspend fun getMissions(): List<SaveKidsMissionEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(missions: List<SaveKidsMissionEntity>)

    @Update
    suspend fun update(mission: SaveKidsMissionEntity)

    @Query("SELECT * FROM savekids_missions WHERE id = :id")
    suspend fun findById(id: Long): SaveKidsMissionEntity?
}

@Dao
interface SaveKidsRewardDao {
    @Query("SELECT * FROM savekids_rewards ORDER BY id ASC")
    fun observeRewards(): Flow<List<SaveKidsRewardEntity>>

    @Query("SELECT * FROM savekids_rewards ORDER BY id ASC")
    suspend fun getRewards(): List<SaveKidsRewardEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(rewards: List<SaveKidsRewardEntity>)

    @Update
    suspend fun update(reward: SaveKidsRewardEntity)

    @Query("SELECT * FROM savekids_rewards WHERE id = :id")
    suspend fun findById(id: Long): SaveKidsRewardEntity?
}

@Dao
interface SaveKidsHistoryDao {
    @Query("SELECT * FROM savekids_history ORDER BY createdAt DESC")
    fun observeHistory(): Flow<List<SaveKidsHistoryEventEntity>>

    @Insert
    suspend fun insert(event: SaveKidsHistoryEventEntity)
}

@Dao
interface SaveKidsFamilyDao {
    @Query("SELECT * FROM savekids_family ORDER BY savings DESC")
    fun observeFamily(): Flow<List<SaveKidsFamilyMemberEntity>>

    @Query("SELECT * FROM savekids_family")
    suspend fun getFamily(): List<SaveKidsFamilyMemberEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(items: List<SaveKidsFamilyMemberEntity>)
}
