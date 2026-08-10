package com.zodiak.android.feature.themeswitch

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.core.datastore.ZodiakPreferencesRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class ThemeSwitchViewModel @Inject constructor(
    private val preferences: ZodiakPreferencesRepository,
) : ViewModel() {

    val isDarkMode = preferences.isDarkMode.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5_000),
        initialValue = false,
    )

    fun toggle(enabled: Boolean) {
        viewModelScope.launch { preferences.setDarkMode(enabled) }
    }
}
