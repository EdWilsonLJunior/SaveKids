package com.zodiak.android.feature.pixdiscount

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

data class PixDiscountUiState(
    val amount: String = "",
    val discountPercent: String = "",
    val result: Double? = null,
    val pixAmount: Double? = null,
    val error: ValidationError? = null,
)

@HiltViewModel
class PixDiscountViewModel @Inject constructor() : ViewModel() {

    private val _uiState = MutableStateFlow(PixDiscountUiState())
    val uiState: StateFlow<PixDiscountUiState> = _uiState.asStateFlow()

    fun onAmountChange(v: String)  = _uiState.update { it.copy(amount = v, error = null) }
    fun onDiscountChange(v: String) = _uiState.update { it.copy(discountPercent = v, error = null) }

    fun calculate() {
        try {
            val amount   = ValidationService.validatePositiveNumber(_uiState.value.amount.replace(",", ".").toDoubleOrNull(), "Valor")
            val discount = ValidationService.validateInRange(
                _uiState.value.discountPercent.replace(",", ".").toDoubleOrNull(), 0.0, 100.0, "Desconto"
            )
            val pixAmount = amount * (1 - discount / 100)
            _uiState.update { it.copy(result = discount, pixAmount = pixAmount, error = null) }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun reset() = _uiState.update { PixDiscountUiState() }
}
