package com.zodiak.android.feature.currencyconverter

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object CurrencyConverterRoute

fun NavGraphBuilder.currencyConverterScreen() {
    composable<CurrencyConverterRoute> { CurrencyConverterScreen() }
}
