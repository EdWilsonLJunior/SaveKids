package com.zodiak.android.feature.palindrome

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.services.StringProcessingService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

data class PalindromeUiState(
    val input: String = "",
    val result: Boolean? = null,
)

@HiltViewModel
class PalindromeViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(PalindromeUiState())
    val uiState: StateFlow<PalindromeUiState> = _uiState.asStateFlow()

    fun onInputChange(v: String) = _uiState.update { it.copy(input = v, result = null) }

    fun check() {
        if (_uiState.value.input.isBlank()) return
        val result = StringProcessingService.isPalindrome(_uiState.value.input)
        _uiState.update { it.copy(result = result) }
    }

    fun reset() = _uiState.update { PalindromeUiState() }
}
