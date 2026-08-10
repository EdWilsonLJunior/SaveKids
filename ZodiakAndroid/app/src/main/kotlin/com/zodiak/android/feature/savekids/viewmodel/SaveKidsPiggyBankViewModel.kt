package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.DashboardModel
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsPiggyBankUiState(
    val amountText: String = "",
    val dashboard: DashboardModel? = null,
    val isLoading: Boolean = true,
    val errorMessage: String? = null,
    val successMessage: String? = null,
)

@HiltViewModel
class SaveKidsPiggyBankViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(SaveKidsPiggyBankUiState())
    val uiState: StateFlow<SaveKidsPiggyBankUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            repository.dashboard.collect { dashboard ->
                _uiState.update { it.copy(isLoading = false, dashboard = dashboard) }
            }
        }
    }

    fun onAmountChange(value: String) = _uiState.update { it.copy(amountText = value, errorMessage = null, successMessage = null) }

    fun applyQuickAmount(value: Int) = _uiState.update {
        it.copy(amountText = value.toString(), errorMessage = null, successMessage = null)
    }

    fun submitDeposit() {
        viewModelScope.launch {
            val amount = _uiState.value.amountText.replace(',', '.').toDoubleOrNull()
            if (amount == null) {
                _uiState.update { it.copy(errorMessage = "Informe um valor válido.") }
                return@launch
            }
            val result = repository.addDeposit(amount)
            if (result.isSuccess) {
                _uiState.update {
                    it.copy(
                        amountText = "",
                        successMessage = "Depósito registrado com sucesso.",
                        errorMessage = null,
                    )
                }
            } else {
                _uiState.update { it.copy(errorMessage = result.exceptionOrNull()?.message ?: "Falha ao registrar depósito.") }
            }
        }
    }

    fun clearMessages() = _uiState.update { it.copy(errorMessage = null, successMessage = null) }
}
