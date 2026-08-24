package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.toRoute
import com.zodiak.android.feature.savekids.model.DashboardModel
import com.zodiak.android.feature.savekids.navigation.SaveKidsPiggyBankRoute
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
    val withdrawAmountText: String = "",
    val dashboard: DashboardModel? = null,
    val isLoading: Boolean = true,
    val errorMessage: String? = null,
    val successMessage: String? = null,
    val showPixModal: Boolean = false,
    val isProcessingWithdrawal: Boolean = false,
    val showDepositPixModal: Boolean = false,
    val isProcessingDeposit: Boolean = false,
    val targetGoalName: String? = null,
)

@HiltViewModel
class SaveKidsPiggyBankViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
    savedStateHandle: SavedStateHandle,
) : ViewModel() {

    private val route = savedStateHandle.toRoute<SaveKidsPiggyBankRoute>()
    private val goalId = route.goalId

    private val _uiState = MutableStateFlow(SaveKidsPiggyBankUiState())
    val uiState: StateFlow<SaveKidsPiggyBankUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            
            launch {
                repository.dashboard.collect { dashboard ->
                    _uiState.update { it.copy(isLoading = false, dashboard = dashboard) }
                }
            }

            if (goalId != null) {
                launch {
                    repository.goals.collect { goals ->
                        val goal = goals.firstOrNull { it.id == goalId }
                        _uiState.update { it.copy(targetGoalName = goal?.name) }
                    }
                }
            }
        }
    }

    fun onAmountChange(value: String) = _uiState.update { it.copy(amountText = value, errorMessage = null, successMessage = null) }

    fun onWithdrawAmountChange(value: String) = _uiState.update { 
        it.copy(withdrawAmountText = value, errorMessage = null, successMessage = null) 
    }

    fun applyQuickAmount(value: Int) = _uiState.update {
        it.copy(amountText = value.toString(), errorMessage = null, successMessage = null)
    }

    fun submitDeposit() {
        val amount = _uiState.value.amountText.replace(',', '.').toDoubleOrNull()
        if (amount == null || amount <= 0) {
            _uiState.update { it.copy(errorMessage = "Informe um valor válido para depósito.") }
            return
        }
        _uiState.update { it.copy(showDepositPixModal = true, errorMessage = null, successMessage = null) }
    }

    fun confirmDeposit() {
        viewModelScope.launch {
            _uiState.update { it.copy(isProcessingDeposit = true) }
            val amount = _uiState.value.amountText.replace(',', '.').toDoubleOrNull() ?: 0.0
            
            // Simular atraso de processamento do Pix
            kotlinx.coroutines.delay(1500)
            
            val result = repository.addDeposit(amount, goalId)
            if (result.isSuccess) {
                _uiState.update {
                    it.copy(
                        amountText = "",
                        successMessage = "Depósito de R$ ${"%.2f".format(amount)} registrado com sucesso!",
                        showDepositPixModal = false,
                        isProcessingDeposit = false,
                    )
                }
            } else {
                _uiState.update { 
                    it.copy(
                        errorMessage = result.exceptionOrNull()?.message ?: "Falha ao registrar depósito.",
                        showDepositPixModal = false,
                        isProcessingDeposit = false,
                    )
                }
            }
        }
    }

    fun dismissDepositPixModal() = _uiState.update { it.copy(showDepositPixModal = false) }

    fun requestWithdrawal() {
        val balance = _uiState.value.dashboard?.balance ?: 0.0
        if (balance <= 0) {
            _uiState.update { it.copy(errorMessage = "Não é possível realizar essa ação. Não há valor no cofrinho") }
            return
        }

        val amount = _uiState.value.withdrawAmountText.replace(',', '.').toDoubleOrNull()
        if (amount == null || amount <= 0) {
            _uiState.update { it.copy(errorMessage = "Informe um valor de saque válido.") }
            return
        }
        if (amount > balance) {
            _uiState.update { it.copy(errorMessage = "Saldo insuficiente para o saque.") }
            return
        }
        _uiState.update { it.copy(showPixModal = true, errorMessage = null, successMessage = null) }
    }

    fun confirmWithdrawal() {
        viewModelScope.launch {
            _uiState.update { it.copy(isProcessingWithdrawal = true) }
            val amount = _uiState.value.withdrawAmountText.replace(',', '.').toDoubleOrNull() ?: 0.0
            
            // Simular atraso de processamento do Pix
            kotlinx.coroutines.delay(1500)
            
            val result = repository.withdrawMoney(amount)
            if (result.isSuccess) {
                _uiState.update {
                    it.copy(
                        withdrawAmountText = "",
                        successMessage = "Saque de ${amount.toString()} via Pix realizado com sucesso!",
                        showPixModal = false,
                        isProcessingWithdrawal = false,
                    )
                }
            } else {
                _uiState.update {
                    it.copy(
                        errorMessage = result.exceptionOrNull()?.message ?: "Falha ao realizar saque.",
                        showPixModal = false,
                        isProcessingWithdrawal = false,
                    )
                }
            }
        }
    }

    fun dismissPixModal() = _uiState.update { it.copy(showPixModal = false) }

    fun clearMessages() = _uiState.update { it.copy(errorMessage = null, successMessage = null) }
}
