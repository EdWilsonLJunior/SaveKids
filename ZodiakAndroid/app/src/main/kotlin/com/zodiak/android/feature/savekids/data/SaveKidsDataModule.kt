package com.zodiak.android.feature.savekids.data

import android.content.Context
import androidx.room.Room
import com.zodiak.android.feature.savekids.data.local.datastore.SaveKidsSessionDataStore
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsDatabase
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsFamilyDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsGoalDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsHistoryDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsMissionDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsProfileDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsRewardDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsWalletDao
import com.zodiak.android.feature.savekids.data.remote.retrofit.PokeApiService
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import com.zodiak.android.feature.savekids.repository.SaveKidsRepositoryImpl
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object SaveKidsDataModule {

    @Provides
    @Singleton
    fun provideSessionDataStore(@ApplicationContext context: Context): SaveKidsSessionDataStore {
        return SaveKidsSessionDataStore(context)
    }

    @Provides
    @Singleton
    fun provideSaveKidsDatabase(@ApplicationContext context: Context): SaveKidsDatabase {
        return Room.databaseBuilder(
            context,
            SaveKidsDatabase::class.java,
            "savekids.db",
        ).fallbackToDestructiveMigration().build()
    }

    @Provides fun provideProfileDao(db: SaveKidsDatabase): SaveKidsProfileDao = db.profileDao()
    @Provides fun provideWalletDao(db: SaveKidsDatabase): SaveKidsWalletDao = db.walletDao()
    @Provides fun provideGoalDao(db: SaveKidsDatabase): SaveKidsGoalDao = db.goalDao()
    @Provides fun provideMissionDao(db: SaveKidsDatabase): SaveKidsMissionDao = db.missionDao()
    @Provides fun provideRewardDao(db: SaveKidsDatabase): SaveKidsRewardDao = db.rewardDao()
    @Provides fun provideHistoryDao(db: SaveKidsDatabase): SaveKidsHistoryDao = db.historyDao()
    @Provides fun provideFamilyDao(db: SaveKidsDatabase): SaveKidsFamilyDao = db.familyDao()

    @Provides
    @Singleton
    fun provideOkHttpClient(): OkHttpClient {
        val logger = HttpLoggingInterceptor().apply { level = HttpLoggingInterceptor.Level.BASIC }
        return OkHttpClient.Builder().addInterceptor(logger).build()
    }

    @Provides
    @Singleton
    fun provideRetrofit(client: OkHttpClient): Retrofit {
        return Retrofit.Builder()
            .baseUrl("https://pokeapi.co/api/v2/")
            .addConverterFactory(GsonConverterFactory.create())
            .client(client)
            .build()
    }

    @Provides
    @Singleton
    fun providePokeApi(retrofit: Retrofit): PokeApiService {
        return retrofit.create(PokeApiService::class.java)
    }

    @Provides
    @Singleton
    fun provideSaveKidsRepository(
        sessionDataStore: SaveKidsSessionDataStore,
        profileDao: SaveKidsProfileDao,
        walletDao: SaveKidsWalletDao,
        goalDao: SaveKidsGoalDao,
        missionDao: SaveKidsMissionDao,
        rewardDao: SaveKidsRewardDao,
        historyDao: SaveKidsHistoryDao,
        familyDao: SaveKidsFamilyDao,
        pokeApiService: PokeApiService,
    ): SaveKidsRepository {
        return SaveKidsRepositoryImpl(
            sessionDataStore = sessionDataStore,
            profileDao = profileDao,
            walletDao = walletDao,
            goalDao = goalDao,
            missionDao = missionDao,
            rewardDao = rewardDao,
            historyDao = historyDao,
            familyDao = familyDao,
            pokeApiService = pokeApiService,
        )
    }
}
