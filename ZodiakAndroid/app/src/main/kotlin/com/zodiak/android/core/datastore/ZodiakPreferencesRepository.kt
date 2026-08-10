package com.zodiak.android.core.datastore

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import javax.inject.Inject
import javax.inject.Singleton

private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "zodiak_prefs")

@Singleton
class ZodiakPreferencesRepository @Inject constructor(
    @ApplicationContext private val context: Context,
) {
    private object Keys {
        val DARK_MODE     = booleanPreferencesKey("dark_mode")
        val LANGUAGE_CODE = stringPreferencesKey("language_code")   // "system" | "en" | "pt-BR"
        val SAVED_EMAIL   = stringPreferencesKey("saved_email")
        val BOOK_PAGE     = stringPreferencesKey("book_page_index")
    }

    // ─── Dark mode ────────────────────────────────────────────────────────────

    val isDarkMode: Flow<Boolean> = context.dataStore.data.map { prefs ->
        prefs[Keys.DARK_MODE] ?: false
    }

    suspend fun setDarkMode(enabled: Boolean) {
        context.dataStore.edit { it[Keys.DARK_MODE] = enabled }
    }

    // ─── Language ─────────────────────────────────────────────────────────────

    val languageCode: Flow<String> = context.dataStore.data.map { prefs ->
        prefs[Keys.LANGUAGE_CODE] ?: "system"
    }

    suspend fun setLanguageCode(code: String) {
        context.dataStore.edit { it[Keys.LANGUAGE_CODE] = code }
    }

    // ─── Saved email (Feature 16 — UserDefaultsLogin) ─────────────────────────

    val savedEmail: Flow<String> = context.dataStore.data.map { prefs ->
        prefs[Keys.SAVED_EMAIL] ?: ""
    }

    suspend fun setSavedEmail(email: String) {
        context.dataStore.edit { it[Keys.SAVED_EMAIL] = email }
    }

    suspend fun clearSavedEmail() {
        context.dataStore.edit { it.remove(Keys.SAVED_EMAIL) }
    }

    // ─── Book page (Feature 17 — BookReader) ──────────────────────────────────

    val bookPageIndex: Flow<Int> = context.dataStore.data.map { prefs ->
        prefs[Keys.BOOK_PAGE]?.toIntOrNull() ?: 0
    }

    suspend fun setBookPageIndex(index: Int) {
        context.dataStore.edit { it[Keys.BOOK_PAGE] = index.toString() }
    }
}
