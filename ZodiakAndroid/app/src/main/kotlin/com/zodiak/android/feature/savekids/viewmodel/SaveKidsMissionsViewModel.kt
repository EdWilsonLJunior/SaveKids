package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.MissionModel
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsMissionsUiState(
    val missions: List<MissionModel> = emptyList(),
    val isLoading: Boolean = true,
    val errorMessage: String? = null,
    val successMessage: String? = null,
)

@HiltViewModel
class SaveKidsMissionsViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(SaveKidsMissionsUiState())
    val uiState: StateFlow<SaveKidsMissionsUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            repository.missions.collect { missions ->
                _uiState.update { it.copy(isLoading = false, missions = missions) }
            }
        }
    }

    fun completeMission(id: Long) {
        viewModelScope.launch {
            val result = repository.completeMission(id)
            if (result.isSuccess) {
                _uiState.update { it.copy(successMessage = "Missão concluída.", errorMessage = null) }
            } else {
                _uiState.update { it.copy(errorMessage = result.exceptionOrNull()?.message ?: "Falha ao concluir missão.") }
            }
        }
    }

    fun clearMessages() = _uiState.update { it.copy(errorMessage = null, successMessage = null) }
}
