package com.zodiak.android.feature.cardmanager

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.CardTheme
import com.zodiak.android.core.models.CreditCard
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import java.util.Date
import java.util.UUID
import javax.inject.Inject

data class CardManagerUiState(
    val bankName: String = "",
    val brand: String = "",
    val lastDigits: String = "",
    val theme: CardTheme = CardTheme.OCEAN,
    val limit: String = "",
    val cards: List<CreditCard> = emptyList(),
    val selectedCard: CreditCard? = null,
    val error: ValidationError? = null,
)

@HiltViewModel
class CardManagerViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(CardManagerUiState())
    val uiState: StateFlow<CardManagerUiState> = _uiState.asStateFlow()

    fun onBankNameChange(v: String)   = _uiState.update { it.copy(bankName = v) }
    fun onBrandChange(v: String)      = _uiState.update { it.copy(brand = v) }
    fun onLastDigitsChange(v: String) = _uiState.update { it.copy(lastDigits = v.take(4)) }
    fun onThemeChange(t: CardTheme)   = _uiState.update { it.copy(theme = t) }
    fun onLimitChange(v: String)      = _uiState.update { it.copy(limit = v) }
    fun selectCard(card: CreditCard?) = _uiState.update { it.copy(selectedCard = card) }

    fun addCard() {
        try {
            ValidationService.validateNotEmpty(_uiState.value.bankName, "Banco")
            ValidationService.validateNotEmpty(_uiState.value.brand, "Bandeira")
            val limit = ValidationService.validatePositiveNumber(_uiState.value.limit.replace(",", ".").toDoubleOrNull(), "Limite")
            val card = CreditCard(
                bankName   = _uiState.value.bankName.trim(),
                brand      = _uiState.value.brand.trim(),
                lastDigits = _uiState.value.lastDigits,
                theme      = _uiState.value.theme,
                limit      = limit,
                dueDate    = Date(),
            )
            _uiState.update { it.copy(cards = it.cards + card, bankName = "", brand = "", lastDigits = "", limit = "") }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun removeCard(id: UUID) = _uiState.update { it.copy(cards = it.cards.filter { c -> c.id != id }) }
}
