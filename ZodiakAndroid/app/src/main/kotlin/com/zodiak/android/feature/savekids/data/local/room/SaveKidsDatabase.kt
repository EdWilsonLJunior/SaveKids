package com.zodiak.android.feature.savekids.data.local.room

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters

@Database(
    entities = [
        SaveKidsProfileEntity::class,
        SaveKidsWalletEntity::class,
        SaveKidsGoalEntity::class,
        SaveKidsMissionEntity::class,
        SaveKidsRewardEntity::class,
        SaveKidsHistoryEventEntity::class,
        SaveKidsFamilyMemberEntity::class,
    ],
    version = 1,
    exportSchema = false,
)
@TypeConverters(SaveKidsTypeConverters::class)
abstract class SaveKidsDatabase : RoomDatabase() {
    abstract fun profileDao(): SaveKidsProfileDao
    abstract fun walletDao(): SaveKidsWalletDao
    abstract fun goalDao(): SaveKidsGoalDao
    abstract fun missionDao(): SaveKidsMissionDao
    abstract fun rewardDao(): SaveKidsRewardDao
    abstract fun historyDao(): SaveKidsHistoryDao
    abstract fun familyDao(): SaveKidsFamilyDao
}
