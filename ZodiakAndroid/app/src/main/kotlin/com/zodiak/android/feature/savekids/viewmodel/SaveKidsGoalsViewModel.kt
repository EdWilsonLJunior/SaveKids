package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.GoalModel
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsGoalsUiState(
    val goals: List<GoalModel> = emptyList(),
    val goalName: String = "",
    val targetAmount: String = "",
    val isLoading: Boolean = true,
    val errorMessage: String? = null,
    val successMessage: String? = null,
)

@HiltViewModel
class SaveKidsGoalsViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(SaveKidsGoalsUiState())
    val uiState: StateFlow<SaveKidsGoalsUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            combine(repository.goals, repository.dashboard) { goals, _ -> goals }
                .collect { goals ->
                    _uiState.update { it.copy(goals = goals, isLoading = false) }
                }
        }
    }

    fun onGoalNameChange(value: String) = _uiState.update { it.copy(goalName = value, errorMessage = null, successMessage = null) }
    fun onTargetAmountChange(value: String) = _uiState.update { it.copy(targetAmount = value, errorMessage = null, successMessage = null) }

    fun createGoal() {
        viewModelScope.launch {
            val value = _uiState.value.targetAmount.replace(',', '.').toDoubleOrNull()
            if (value == null) {
                _uiState.update { it.copy(errorMessage = "Informe um valor de meta válido.") }
                return@launch
            }

            val result = repository.createGoal(_uiState.value.goalName, value)
            if (result.isSuccess) {
                _uiState.update {
                    it.copy(
                        goalName = "",
                        targetAmount = "",
                        successMessage = "Meta criada com sucesso.",
                        errorMessage = null,
                    )
                }
            } else {
                _uiState.update {
                    it.copy(errorMessage = result.exceptionOrNull()?.message ?: "Não foi possível criar meta.")
                }
            }
        }
    }

    fun clearMessages() = _uiState.update { it.copy(errorMessage = null, successMessage = null) }
}
