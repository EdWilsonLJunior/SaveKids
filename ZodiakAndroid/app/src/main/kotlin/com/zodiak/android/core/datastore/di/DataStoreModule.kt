package com.zodiak.android.core.datastore.di

import android.content.Context
import com.zodiak.android.core.datastore.ZodiakPreferencesRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DataStoreModule {

    @Provides
    @Singleton
    fun provideZodiakPreferencesRepository(
        @ApplicationContext context: Context,
    ): ZodiakPreferencesRepository = ZodiakPreferencesRepository(context)
}
