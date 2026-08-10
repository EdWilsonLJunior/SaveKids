package com.zodiak.android.core.services

/**
 * Cálculos matemáticos e conversões — stateless object.
 */
object CalculationService {

    fun calculateAverage(grades: List<Double>): Double =
        if (grades.isEmpty()) 0.0 else grades.sum() / grades.size

    fun generateMultiplicationTable(number: Int): List<Pair<Int, Int>> =
        (1..10).map { multiplier -> multiplier to number * multiplier }

    fun celsiusToFahrenheit(celsius: Double): Double = (celsius * 9.0 / 5.0) + 32.0

    fun fahrenheitToCelsius(fahrenheit: Double): Double = (fahrenheit - 32.0) * 5.0 / 9.0
}
