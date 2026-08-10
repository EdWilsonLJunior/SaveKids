package com.zodiak.android.core.services

import com.zodiak.android.core.models.QuizTheme
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.EnumSource

class QuizServiceTest {

    @ParameterizedTest
    @EnumSource(QuizTheme::class)
    fun `questions returns 8 questions per theme`(theme: QuizTheme) {
        val questions = QuizService.questions(theme)
        assertEquals(8, questions.size, "Theme $theme should have 8 questions")
    }

    @Test
    fun `randomQuestions returns requested count`() {
        val allQuestions = QuizService.questions(QuizTheme.SWIFT)
        val random = QuizService.randomQuestions(allQuestions, 5)
        assertEquals(5, random.size)
    }

    @Test
    fun `randomQuestions does not return more than available`() {
        val allQuestions = QuizService.questions(QuizTheme.FILMES)
        val random = QuizService.randomQuestions(allQuestions, 100)
        assertEquals(allQuestions.size, random.size)
    }

    @Test
    fun `isCorrect returns true for correct answer`() {
        val question = QuizService.questions(QuizTheme.HISTORIA).first()
        assertTrue(QuizService.isCorrect(question, question.correctIndex))
    }

    @Test
    fun `isCorrect returns false for wrong answer`() {
        val question = QuizService.questions(QuizTheme.GEOGRAFIA).first()
        val wrongIndex = if (question.correctIndex == 0) 1 else 0
        assertFalse(QuizService.isCorrect(question, wrongIndex))
    }

    @Test
    fun `all questions have at least 2 options`() {
        QuizTheme.entries.forEach { theme ->
            QuizService.questions(theme).forEach { q ->
                assertTrue(q.options.size >= 2, "Question '${q.text}' has fewer than 2 options")
                assertTrue(q.correctIndex in q.options.indices, "correctIndex out of bounds for '${q.text}'")
            }
        }
    }
}
