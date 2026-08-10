package com.zodiak.android.feature.savekids.data.local.datastore

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.zodiak.android.feature.savekids.model.SaveKidsSession
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

private val Context.saveKidsDataStore: DataStore<Preferences> by preferencesDataStore(name = "savekids_session")

class SaveKidsSessionDataStore(private val context: Context) {

    private object Keys {
        val AUTHENTICATED = booleanPreferencesKey("authenticated")
        val PROFILE_COMPLETED = booleanPreferencesKey("profile_completed")
        val CHILD_NAME = stringPreferencesKey("child_name")
        val AVATAR_POKEMON_ID = intPreferencesKey("avatar_pokemon_id")
        val AVATAR_TEAM_NAME = stringPreferencesKey("avatar_team_name")
    }

    val session: Flow<SaveKidsSession> = context.saveKidsDataStore.data.map {
        SaveKidsSession(
            authenticated = it[Keys.AUTHENTICATED] ?: false,
            profileCompleted = it[Keys.PROFILE_COMPLETED] ?: false,
        )
    }

    suspend fun saveLoginState(authenticated: Boolean) {
        context.saveKidsDataStore.edit { prefs ->
            prefs[Keys.AUTHENTICATED] = authenticated
        }
    }

    suspend fun saveProfile(name: String, avatarPokemonId: Int, avatarTeamName: String) {
        context.saveKidsDataStore.edit { prefs ->
            prefs[Keys.CHILD_NAME] = name
            prefs[Keys.AVATAR_POKEMON_ID] = avatarPokemonId
            prefs[Keys.AVATAR_TEAM_NAME] = avatarTeamName
            prefs[Keys.PROFILE_COMPLETED] = true
        }
    }

    suspend fun clearSession() {
        context.saveKidsDataStore.edit { prefs ->
            prefs[Keys.AUTHENTICATED] = false
        }
    }
}
