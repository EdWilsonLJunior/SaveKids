package com.zodiak.android.core.services

/**
 * Serviço de conversão de moedas — cálculo puro relativo ao USD.
 */
object CurrencyConverterService {

    /**
     * Converte [amount] da moeda com taxa [fromRate] para a moeda com taxa [toRate],
     * ambas relativas ao USD.
     */
    fun convert(amount: Double, fromRate: Double, toRate: Double): Double =
        (amount / fromRate) * toRate
}
