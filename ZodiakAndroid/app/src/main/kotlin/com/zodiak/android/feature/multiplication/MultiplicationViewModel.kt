package com.zodiak.android.feature.multiplication

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.CalculationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

data class MultiplicationUiState(
    val numberInput: String = "",
    val table: List<Pair<Int, Int>> = emptyList(),
    val error: ValidationError? = null,
)

@HiltViewModel
class MultiplicationViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(MultiplicationUiState())
    val uiState: StateFlow<MultiplicationUiState> = _uiState.asStateFlow()

    fun onNumberChange(v: String) = _uiState.update { it.copy(numberInput = v, error = null) }

    fun generate() {
        val number = _uiState.value.numberInput.toIntOrNull()
        if (number == null) {
            _uiState.update { it.copy(error = ValidationError.InvalidNumber("número")) }
            return
        }
        _uiState.update { it.copy(table = CalculationService.generateMultiplicationTable(number), error = null) }
    }

    fun reset() = _uiState.update { MultiplicationUiState() }
}
