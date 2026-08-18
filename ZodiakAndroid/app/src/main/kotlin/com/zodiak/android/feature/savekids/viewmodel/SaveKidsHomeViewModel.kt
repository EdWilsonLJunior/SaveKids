package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.DashboardModel
import com.zodiak.android.feature.savekids.model.HistoryEventModel
import com.zodiak.android.feature.savekids.model.PokemonAvatarModel
import com.zodiak.android.feature.savekids.model.SaveKidsProfile
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsHomeUiState(
    val isLoading: Boolean = true,
    val isUpdatingProfile: Boolean = false,
    val profile: SaveKidsProfile? = null,
    val dashboard: DashboardModel? = null,
    val avatar: PokemonAvatarModel? = null,
    val recentEvents: List<HistoryEventModel> = emptyList(),
    val errorMessage: String? = null,
)

@HiltViewModel
class SaveKidsHomeViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(SaveKidsHomeUiState())
    val uiState: StateFlow<SaveKidsHomeUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            combine(repository.profile, repository.dashboard, repository.history) { profile, dashboard, history ->
                Triple(profile, dashboard, history)
            }.collect { state ->
                val profile = state.first
                val dashboard = state.second
                val history = state.third

                val currentAvatar = _uiState.value.avatar
                val shouldRefreshAvatar = profile != null && (currentAvatar == null || currentAvatar.currentXp != dashboard.xp)

                _uiState.update {
                    it.copy(
                        isLoading = false,
                        profile = profile,
                        dashboard = dashboard,
                        recentEvents = history.take(3),
                        errorMessage = null,
                    )
                }
                if (shouldRefreshAvatar) {
                    refreshAvatar()
                }
            }
        }
    }

    fun refreshAvatar() {
        viewModelScope.launch {
            val result = repository.refreshAvatar()
            if (result.isSuccess) {
                _uiState.update {
                    it.copy(
                        avatar = result.getOrNull(),
                        errorMessage = null,
                    )
                }
            } else {
                _uiState.update {
                    it.copy(
                        errorMessage = result.exceptionOrNull()?.message ?: "Não foi possível atualizar avatar.",
                    )
                }
            }
        }
    }

    fun updateProfile(name: String, avatarPokemonId: Int) {
        viewModelScope.launch {
            _uiState.update { it.copy(isUpdatingProfile = true, errorMessage = null) }
            val result = repository.updateProfile(name, avatarPokemonId)
            if (result.isSuccess) {
                _uiState.update { it.copy(isUpdatingProfile = false) }
                refreshAvatar()
            } else {
                _uiState.update {
                    it.copy(
                        isUpdatingProfile = false,
                        errorMessage = result.exceptionOrNull()?.message ?: "N\u00e3o foi poss\u00edvel atualizar o perfil.",
                    )
                }
            }
        }
    }

    fun dismissError() = _uiState.update { it.copy(errorMessage = null) }
}
