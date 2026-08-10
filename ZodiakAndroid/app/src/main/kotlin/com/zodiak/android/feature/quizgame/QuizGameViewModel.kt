package com.zodiak.android.feature.quizgame

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Question
import com.zodiak.android.core.models.QuizAnswer
import com.zodiak.android.core.models.QuizTheme
import com.zodiak.android.core.services.QuizService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

private const val QUESTIONS_PER_GAME = 5

sealed class QuizGamePhase {
    object ThemeSelection : QuizGamePhase()
    data class Playing(val currentIndex: Int) : QuizGamePhase()
    object Results : QuizGamePhase()
}

data class QuizGameUiState(
    val selectedTheme: QuizTheme? = null,
    val questions: List<Question> = emptyList(),
    val answers: List<QuizAnswer> = emptyList(),
    val phase: QuizGamePhase = QuizGamePhase.ThemeSelection,
    val selectedOptionIndex: Int? = null,
) {
    val currentQuestion: Question? get() =
        if (phase is QuizGamePhase.Playing) questions.getOrNull(phase.currentIndex) else null
    val score: Int get() = answers.count { it.isCorrect }
}

@HiltViewModel
class QuizGameViewModel @Inject constructor() : ViewModel() {

    private val _uiState = MutableStateFlow(QuizGameUiState())
    val uiState: StateFlow<QuizGameUiState> = _uiState.asStateFlow()

    fun selectTheme(theme: QuizTheme) {
        val questions = QuizService.randomQuestions(QuizService.questions(theme), QUESTIONS_PER_GAME)
        _uiState.update { it.copy(selectedTheme = theme, questions = questions, phase = QuizGamePhase.Playing(0)) }
    }

    fun selectOption(index: Int) = _uiState.update { it.copy(selectedOptionIndex = index) }

    fun confirmAnswer() {
        val state = _uiState.value
        val question = state.currentQuestion ?: return
        val selected = state.selectedOptionIndex ?: return
        val isCorrect = QuizService.isCorrect(question, selected)
        val answer = QuizAnswer(question = question, selectedIndex = selected, isCorrect = isCorrect)
        val newAnswers = state.answers + answer
        val nextIndex = (state.phase as QuizGamePhase.Playing).currentIndex + 1
        val nextPhase = if (nextIndex >= state.questions.size) QuizGamePhase.Results
                        else QuizGamePhase.Playing(nextIndex)
        _uiState.update { it.copy(answers = newAnswers, phase = nextPhase, selectedOptionIndex = null) }
    }

    fun restart() = _uiState.update { QuizGameUiState() }
}
