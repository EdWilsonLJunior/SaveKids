package com.zodiak.android.feature.temperatureconverter

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakChipGroup
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakInfoRow
import com.zodiak.android.R

@Composable
fun TemperatureScreen(viewModel: TemperatureViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()
    val directions = TempDirection.entries

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            ZodiakFormContainer(stringResource(R.string.temperatureconverter_form_title_converter)) {
                val chipCelsiusToF = stringResource(R.string.temperatureconverter_chip_celsius_to_f)
                val chipFahrenheitToC = stringResource(R.string.temperatureconverter_chip_fahrenheit_to_c)
                ZodiakChipGroup(
                    items = directions,
                    selectedItem = state.direction,
                    onSelect = viewModel::onDirectionChange,
                    label = { if (it == TempDirection.CELSIUS_TO_FAHRENHEIT) chipCelsiusToF else chipFahrenheitToC },
                )
                Spacer(Modifier.height(12.dp))
                val label = if (state.direction == TempDirection.CELSIUS_TO_FAHRENHEIT) stringResource(R.string.temperatureconverter_input_label_celsius) else stringResource(R.string.temperatureconverter_input_label_fahrenheit)
                ZodiakInputField(state.input, viewModel::onInputChange, label, keyboardType = KeyboardType.Decimal)
                Spacer(Modifier.height(12.dp))
                ZodiakButton(stringResource(R.string.temperatureconverter_button_convert), viewModel::convert, Modifier.fillMaxWidth())
            }

            state.result?.let { result ->
                ZodiakFormContainer(stringResource(R.string.temperatureconverter_form_title_result)) {
                    val (fromUnit, toUnit) = if (state.direction == TempDirection.CELSIUS_TO_FAHRENHEIT) "°C" to "°F" else "°F" to "°C"
                    ZodiakInfoRow(stringResource(R.string.temperatureconverter_info_row_input), "${state.input} $fromUnit")
                    ZodiakInfoRow(stringResource(R.string.temperatureconverter_info_row_result), "${"%.2f".format(result)} $toUnit", valueColor = MaterialTheme.colorScheme.primary)
                }
                ZodiakButton(stringResource(R.string.temperatureconverter_button_clear), viewModel::reset, Modifier.fillMaxWidth())
            }
        }
    }
}
