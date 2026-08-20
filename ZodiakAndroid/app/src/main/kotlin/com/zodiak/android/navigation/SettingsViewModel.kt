package com.zodiak.android.navigation

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SettingsViewModel @Inject constructor(
    private val saveKidsRepository: SaveKidsRepository,
) : ViewModel() {

    fun logout(onDone: () -> Unit = {}) {
        viewModelScope.launch {
            saveKidsRepository.clearAuthentication()
            onDone()
        }
    }
}
