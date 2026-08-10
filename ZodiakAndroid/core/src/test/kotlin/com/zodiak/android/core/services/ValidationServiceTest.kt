package com.zodiak.android.core.services

import com.zodiak.android.core.models.ValidationError
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test

class ValidationServiceTest {

    @Test
    fun `validateNotEmpty passes for non-blank string`() {
        assertDoesNotThrow { ValidationService.validateNotEmpty("Kotlin", "Campo") }
    }

    @Test
    fun `validateNotEmpty throws EmptyField for blank string`() {
        val error = assertThrows(ValidationError.EmptyField::class.java) {
            ValidationService.validateNotEmpty("  ", "Nome")
        }
        assertEquals("Nome", error.fieldName)
    }

    @Test
    fun `validateGrade returns grade within 0-10`() {
        val result = ValidationService.validateGrade(7.5)
        assertEquals(7.5, result, 0.001)
    }

    @Test
    fun `validateGrade throws InvalidGrade for null`() {
        assertThrows(ValidationError.InvalidGrade::class.java) {
            ValidationService.validateGrade(null)
        }
    }

    @Test
    fun `validateGrade throws OutOfRange for grade above 10`() {
        assertThrows(ValidationError.OutOfRange::class.java) {
            ValidationService.validateGrade(10.1)
        }
    }

    @Test
    fun `validateGrade throws OutOfRange for negative grade`() {
        assertThrows(ValidationError.OutOfRange::class.java) {
            ValidationService.validateGrade(-1.0)
        }
    }

    @Test
    fun `validatePositiveNumber returns value for positive number`() {
        val result = ValidationService.validatePositiveNumber(42.5, "Preço")
        assertEquals(42.5, result, 0.001)
    }

    @Test
    fun `validatePositiveNumber throws InvalidNumber for null`() {
        assertThrows(ValidationError.InvalidNumber::class.java) {
            ValidationService.validatePositiveNumber(null, "Preço")
        }
    }

    @Test
    fun `validatePositiveNumber throws InvalidNumber for zero`() {
        assertThrows(ValidationError.InvalidNumber::class.java) {
            ValidationService.validatePositiveNumber(0.0, "Preço")
        }
    }

    @Test
    fun `validateAge returns age within valid range`() {
        val result = ValidationService.validateAge(25)
        assertEquals(25, result)
    }

    @Test
    fun `validateAge throws InvalidAge for null`() {
        assertThrows(ValidationError.InvalidAge::class.java) {
            ValidationService.validateAge(null)
        }
    }

    @Test
    fun `validateAge throws InvalidAge for zero`() {
        assertThrows(ValidationError.InvalidAge::class.java) {
            ValidationService.validateAge(0)
        }
    }

    @Test
    fun `validateAge throws InvalidAge for 150`() {
        assertThrows(ValidationError.InvalidAge::class.java) {
            ValidationService.validateAge(150)
        }
    }

    @Test
    fun `validateInRange passes for value within range`() {
        val result = ValidationService.validateInRange(50.0, 0.0, 100.0, "Desconto")
        assertEquals(50.0, result, 0.001)
    }

    @Test
    fun `validateInRange throws OutOfRange for value above max`() {
        assertThrows(ValidationError.OutOfRange::class.java) {
            ValidationService.validateInRange(101.0, 0.0, 100.0, "Desconto")
        }
    }
}
