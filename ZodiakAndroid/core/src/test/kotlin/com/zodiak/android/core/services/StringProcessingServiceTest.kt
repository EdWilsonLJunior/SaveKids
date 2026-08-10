package com.zodiak.android.core.services

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test

class StringProcessingServiceTest {

    @Test
    fun `isPalindrome returns true for 'arara'`() {
        assertTrue(StringProcessingService.isPalindrome("arara"))
    }

    @Test
    fun `isPalindrome returns true for 'Ana' ignoring case`() {
        assertTrue(StringProcessingService.isPalindrome("Ana"))
    }

    @Test
    fun `isPalindrome returns true for 'racecar'`() {
        assertTrue(StringProcessingService.isPalindrome("racecar"))
    }

    @Test
    fun `isPalindrome returns false for 'kotlin'`() {
        assertFalse(StringProcessingService.isPalindrome("kotlin"))
    }

    @Test
    fun `isPalindrome returns true for single character`() {
        assertTrue(StringProcessingService.isPalindrome("a"))
    }

    @Test
    fun `isPalindrome returns true for empty string`() {
        assertTrue(StringProcessingService.isPalindrome(""))
    }

    @Test
    fun `normalize lowercases and removes diacritics`() {
        val result = StringProcessingService.normalize("Ação")
        assertEquals("acao", result)
    }

    @Test
    fun `normalize handles plain ASCII`() {
        val result = StringProcessingService.normalize("HELLO")
        assertEquals("hello", result)
    }
}
