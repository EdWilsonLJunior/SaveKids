package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.RewardModel
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsRewardsUiState(
    val rewards: List<RewardModel> = emptyList(),
    val currentXp: Int = 0,
    val isLoading: Boolean = true,
    val errorMessage: String? = null,
    val successMessage: String? = null,
    val rewardToRedeem: RewardModel? = null,
    val showDevolutionWarning: Boolean = false,
    val showSaveMoreWarning: Boolean = false,
)

@HiltViewModel
class SaveKidsRewardsViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(SaveKidsRewardsUiState())
    val uiState: StateFlow<SaveKidsRewardsUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            combine(repository.rewards, repository.dashboard) { rewards, dashboard ->
                rewards to dashboard.xp
            }.collect { (rewards, xp) ->
                _uiState.update {
                    it.copy(
                        isLoading = false,
                        rewards = rewards,
                        currentXp = xp,
                    )
                }
            }
        }
    }

    fun onRedeemClicked(reward: RewardModel) {
        val xpAfter = uiState.value.currentXp - reward.requiredXp
        val currentStage = getStage(uiState.value.currentXp)
        val nextStage = getStage(xpAfter)

        _uiState.update { it.copy(rewardToRedeem = reward) }

        if (currentStage > nextStage) {
            _uiState.update { it.copy(showDevolutionWarning = true) }
        } else {
            _uiState.update { it.copy(showSaveMoreWarning = true) }
        }
    }

    private fun getStage(xp: Int): Int = when {
        xp >= 500 -> 2
        xp >= 100 -> 1
        else -> 0
    }

    fun dismissWarning() {
        _uiState.update { it.copy(rewardToRedeem = null, showDevolutionWarning = false, showSaveMoreWarning = false) }
    }

    fun confirmRedeem() {
        val reward = uiState.value.rewardToRedeem ?: return
        dismissWarning()
        redeemReward(reward.id)
    }

    private fun redeemReward(id: Long) {
        viewModelScope.launch {
            val result = repository.redeemReward(id)
            if (result.isSuccess) {
                _uiState.update { it.copy(successMessage = "Recompensa resgatada com sucesso.", errorMessage = null) }
            } else {
                _uiState.update { it.copy(errorMessage = result.exceptionOrNull()?.message ?: "Falha no resgate.") }
            }
        }
    }

    fun clearMessages() = _uiState.update { it.copy(errorMessage = null, successMessage = null) }
}
