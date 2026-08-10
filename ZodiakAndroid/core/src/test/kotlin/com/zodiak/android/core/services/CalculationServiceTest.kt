package com.zodiak.android.core.services

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test

class CalculationServiceTest {

    @Test
    fun `calculateAverage returns correct mean`() {
        val result = CalculationService.calculateAverage(listOf(8.0, 7.0, 9.0))
        assertEquals(8.0, result, 0.001)
    }

    @Test
    fun `calculateAverage returns 0 for empty list`() {
        assertEquals(0.0, CalculationService.calculateAverage(emptyList()), 0.001)
    }

    @Test
    fun `generateMultiplicationTable returns 10 pairs for table of 3`() {
        val table = CalculationService.generateMultiplicationTable(3)
        assertEquals(10, table.size)
        assertEquals(Pair(1, 3), table[0])   // 1 × 3 = 3
        assertEquals(Pair(10, 30), table[9]) // 10 × 3 = 30
    }

    @Test
    fun `celsiusToFahrenheit converts 0C to 32F`() {
        assertEquals(32.0, CalculationService.celsiusToFahrenheit(0.0), 0.001)
    }

    @Test
    fun `celsiusToFahrenheit converts 100C to 212F`() {
        assertEquals(212.0, CalculationService.celsiusToFahrenheit(100.0), 0.001)
    }

    @Test
    fun `fahrenheitToCelsius converts 32F to 0C`() {
        assertEquals(0.0, CalculationService.fahrenheitToCelsius(32.0), 0.001)
    }

    @Test
    fun `fahrenheitToCelsius converts 212F to 100C`() {
        assertEquals(100.0, CalculationService.fahrenheitToCelsius(212.0), 0.001)
    }

    @Test
    fun `celsiusToFahrenheit and back is identity`() {
        val original = 37.0
        val converted = CalculationService.fahrenheitToCelsius(CalculationService.celsiusToFahrenheit(original))
        assertEquals(original, converted, 0.001)
    }
}
