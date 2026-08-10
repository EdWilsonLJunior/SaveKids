package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.FamilyMemberModel
import com.zodiak.android.feature.savekids.model.PokemonAvatarModel
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsAvatarRankingUiState(
    val avatar: PokemonAvatarModel? = null,
    val family: List<FamilyMemberModel> = emptyList(),
    val isLoading: Boolean = true,
    val errorMessage: String? = null,
)

@HiltViewModel
class SaveKidsAvatarRankingViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(SaveKidsAvatarRankingUiState())
    val uiState: StateFlow<SaveKidsAvatarRankingUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            combine(repository.family, repository.dashboard) { family, _ -> family }
                .collect { family ->
                    _uiState.update { it.copy(family = family, isLoading = false) }
                }
        }
        refreshAvatar()
    }

    fun refreshAvatar() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, errorMessage = null) }
            val result = repository.refreshAvatar()
            if (result.isSuccess) {
                _uiState.update { it.copy(avatar = result.getOrNull(), isLoading = false) }
            } else {
                _uiState.update {
                    it.copy(
                        isLoading = false,
                        errorMessage = result.exceptionOrNull()?.message ?: "Falha ao carregar avatar.",
                    )
                }
            }
        }
    }

    fun clearError() = _uiState.update { it.copy(errorMessage = null) }
}
