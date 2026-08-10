package com.zodiak.android.core.services

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test

class RandomServiceTest {

    @Test
    fun `generateSecret returns value between 1 and 100`() {
        repeat(20) {
            val secret = RandomService.generateSecret()
            assertTrue(secret in 1..100, "Expected $secret in 1..100")
        }
    }

    @Test
    fun `isCorrect returns true when guess equals secret`() {
        val service = RandomService
        val secret = service.generateSecret()
        assertTrue(service.isCorrect(secret, secret))
    }

    @Test
    fun `isCorrect returns false when guess differs from secret`() {
        val guess = 1
        val secret = 100
        assertFalse(RandomService.isCorrect(guess, secret))
    }

    @Test
    fun `getProximityHint returns correct label for exact match`() {
        val hint = RandomService.getProximityHint(50, 50)
        assertTrue(hint.contains("🎉") || hint.contains("Correto") || hint.contains("correto"))
    }
}
