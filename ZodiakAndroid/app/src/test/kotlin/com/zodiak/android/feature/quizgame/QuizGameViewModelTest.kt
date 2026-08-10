package com.zodiak.android.feature.quizgame

import app.cash.turbine.test
import com.zodiak.android.core.models.QuizTheme
import com.zodiak.android.core.testing.MainDispatcherExtension
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@ExtendWith(MainDispatcherExtension::class)
class QuizGameViewModelTest {

    private lateinit var viewModel: QuizGameViewModel

    @BeforeEach
    fun setup() {
        viewModel = QuizGameViewModel()
    }

    @Test
    fun `initial phase is ThemeSelection`() = runTest {
        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(QuizGamePhase.ThemeSelection, state.phase)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `selectTheme transitions to Playing phase`() = runTest {
        viewModel.selectTheme(QuizTheme.SWIFT)

        viewModel.uiState.test {
            val state = awaitItem()
            assertInstanceOf(QuizGamePhase.Playing::class.java, state.phase)
            assertEquals(0, (state.phase as QuizGamePhase.Playing).currentIndex)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `selectTheme loads 5 questions`() = runTest {
        viewModel.selectTheme(QuizTheme.FILMES)

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(5, state.questions.size)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `confirmAnswer advances to next question`() = runTest {
        viewModel.selectTheme(QuizTheme.HISTORIA)
        viewModel.selectOption(0)
        viewModel.confirmAnswer()

        viewModel.uiState.test {
            val state = awaitItem()
            val phase = state.phase as QuizGamePhase.Playing
            assertEquals(1, phase.currentIndex)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `answering all questions transitions to Results`() = runTest {
        viewModel.selectTheme(QuizTheme.GEOGRAFIA)
        repeat(5) {
            viewModel.selectOption(0)
            viewModel.confirmAnswer()
        }

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(QuizGamePhase.Results, state.phase)
            assertEquals(5, state.answers.size)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `restart resets to ThemeSelection`() = runTest {
        viewModel.selectTheme(QuizTheme.SWIFT)
        viewModel.restart()

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(QuizGamePhase.ThemeSelection, state.phase)
            assertTrue(state.answers.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }
}
