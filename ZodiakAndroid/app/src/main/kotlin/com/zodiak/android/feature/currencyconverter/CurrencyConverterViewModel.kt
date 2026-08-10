package com.zodiak.android.feature.currencyconverter

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Currency
import com.zodiak.android.core.services.CurrencyConverterService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

private val CURRENCIES = listOf(
    Currency(code = "USD", name = "Dólar Americano",    symbol = "$",  flag = "🇺🇸", usdRate = 1.0),
    Currency(code = "BRL", name = "Real Brasileiro",    symbol = "R$", flag = "🇧🇷", usdRate = 5.70),
    Currency(code = "EUR", name = "Euro",               symbol = "€",  flag = "🇪🇺", usdRate = 0.92),
    Currency(code = "GBP", name = "Libra Esterlina",    symbol = "£",  flag = "🇬🇧", usdRate = 0.79),
    Currency(code = "JPY", name = "Iene Japonês",       symbol = "¥",  flag = "🇯🇵", usdRate = 149.0),
    Currency(code = "CAD", name = "Dólar Canadense",    symbol = "C$", flag = "🇨🇦", usdRate = 1.36),
    Currency(code = "AUD", name = "Dólar Australiano",  symbol = "A$", flag = "🇦🇺", usdRate = 1.53),
    Currency(code = "CHF", name = "Franco Suíço",       symbol = "Fr", flag = "🇨🇭", usdRate = 0.90),
)

data class CurrencyConverterUiState(
    val amountInput: String = "",
    val fromCurrency: Currency = CURRENCIES[0],
    val toCurrency: Currency = CURRENCIES[1],
    val result: Double? = null,
    val currencies: List<Currency> = CURRENCIES,
)

@HiltViewModel
class CurrencyConverterViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(CurrencyConverterUiState())
    val uiState: StateFlow<CurrencyConverterUiState> = _uiState.asStateFlow()

    fun onAmountChange(v: String) = _uiState.update { it.copy(amountInput = v, result = null) }
    fun onFromCurrencyChange(c: Currency) = _uiState.update { it.copy(fromCurrency = c, result = null) }
    fun onToCurrencyChange(c: Currency)   = _uiState.update { it.copy(toCurrency = c, result = null) }

    fun swapCurrencies() = _uiState.update { it.copy(fromCurrency = it.toCurrency, toCurrency = it.fromCurrency, result = null) }

    fun convert() {
        val amount = _uiState.value.amountInput.replace(",", ".").toDoubleOrNull() ?: return
        val result = CurrencyConverterService.convert(amount, _uiState.value.fromCurrency.usdRate, _uiState.value.toCurrency.usdRate)
        _uiState.update { it.copy(result = result) }
    }

    fun reset() = _uiState.update { CurrencyConverterUiState() }
}
