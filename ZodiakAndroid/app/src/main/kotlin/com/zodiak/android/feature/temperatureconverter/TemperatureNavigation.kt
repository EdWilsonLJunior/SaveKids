package com.zodiak.android.feature.temperatureconverter

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object TemperatureConverterRoute

fun NavGraphBuilder.temperatureConverterScreen() {
    composable<TemperatureConverterRoute> { TemperatureScreen() }
}
