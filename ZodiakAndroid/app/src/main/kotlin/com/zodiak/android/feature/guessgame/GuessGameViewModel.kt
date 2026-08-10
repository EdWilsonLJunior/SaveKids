package com.zodiak.android.feature.guessgame

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.services.RandomService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

data class GuessGameUiState(
    val guess: String = "",
    val hint: String = "",
    val attempts: Int = 0,
    val isWon: Boolean = false,
    val secret: Int = RandomService.generateSecret(),
)

@HiltViewModel
class GuessGameViewModel @Inject constructor() : ViewModel() {

    private val _uiState = MutableStateFlow(GuessGameUiState())
    val uiState: StateFlow<GuessGameUiState> = _uiState.asStateFlow()

    fun onGuessChange(v: String) = _uiState.update { it.copy(guess = v) }

    fun submitGuess() {
        val guess = _uiState.value.guess.toIntOrNull() ?: return
        if (guess < 1 || guess > 100) {
            _uiState.update { it.copy(hint = "Digite um número entre 1 e 100.") }
            return
        }
        val secret = _uiState.value.secret
        val hint = RandomService.getProximityHint(guess, secret)
        val isWon = RandomService.isCorrect(guess, secret)
        _uiState.update { it.copy(hint = hint, isWon = isWon, attempts = it.attempts + 1, guess = "") }
    }

    fun newGame() = _uiState.update { GuessGameUiState() }
}
