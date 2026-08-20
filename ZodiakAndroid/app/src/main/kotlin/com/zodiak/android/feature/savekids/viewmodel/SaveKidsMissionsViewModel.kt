package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.GoalModel
import com.zodiak.android.feature.savekids.model.MissionModel
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsMissionsUiState(
    val missions: List<MissionModel> = emptyList(),
    val goals: List<GoalModel> = emptyList(),
    val isLoading: Boolean = true,
    val errorMessage: String? = null,
    val successMessage: String? = null,
    val isGoalSelectionOpen: Boolean = false,
    val selectedMissionId: Long? = null,
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
            combine(repository.missions, repository.goals) { missions, goals ->
                missions to goals
            }.collect { (missions, goals) ->
                _uiState.update { it.copy(isLoading = false, missions = missions, goals = goals) }
            }
        }
    }

    fun completeMission(id: Long) {
        val mission = _uiState.value.missions.firstOrNull { it.id == id } ?: return
        if (mission.rewardMoney > 0) {
            _uiState.update { it.copy(isGoalSelectionOpen = true, selectedMissionId = id) }
        } else {
            performMissionCompletion(id)
        }
    }

    fun confirmGoalSelection(goalId: Long) {
        val missionId = _uiState.value.selectedMissionId ?: return
        _uiState.update { it.copy(isGoalSelectionOpen = false, selectedMissionId = null) }
        performMissionCompletion(missionId, goalId)
    }

    fun dismissGoalSelection() {
        _uiState.update { it.copy(isGoalSelectionOpen = false, selectedMissionId = null) }
    }

    private fun performMissionCompletion(missionId: Long, goalId: Long? = null) {
        viewModelScope.launch {
            val result = repository.completeMission(missionId, goalId)
            if (result.isSuccess) {
                _uiState.update { it.copy(successMessage = "Missão concluída.", errorMessage = null) }
            } else {
                _uiState.update { it.copy(errorMessage = result.exceptionOrNull()?.message ?: "Falha ao concluir missão.") }
            }
        }
    }

    fun clearMessages() = _uiState.update { it.copy(errorMessage = null, successMessage = null) }
}
