package com.zodiak.android.feature.temperatureconverter

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.services.CalculationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

enum class TempDirection { CELSIUS_TO_FAHRENHEIT, FAHRENHEIT_TO_CELSIUS }

data class TemperatureUiState(
    val input: String = "",
    val direction: TempDirection = TempDirection.CELSIUS_TO_FAHRENHEIT,
    val result: Double? = null,
)

@HiltViewModel
class TemperatureViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(TemperatureUiState())
    val uiState: StateFlow<TemperatureUiState> = _uiState.asStateFlow()

    fun onInputChange(v: String) = _uiState.update { it.copy(input = v, result = null) }
    fun onDirectionChange(d: TempDirection) = _uiState.update { it.copy(direction = d, result = null) }

    fun convert() {
        val value = _uiState.value.input.replace(",", ".").toDoubleOrNull() ?: return
        val result = when (_uiState.value.direction) {
            TempDirection.CELSIUS_TO_FAHRENHEIT -> CalculationService.celsiusToFahrenheit(value)
            TempDirection.FAHRENHEIT_TO_CELSIUS -> CalculationService.fahrenheitToCelsius(value)
        }
        _uiState.update { it.copy(result = result) }
    }

    fun reset() = _uiState.update { TemperatureUiState() }
}
