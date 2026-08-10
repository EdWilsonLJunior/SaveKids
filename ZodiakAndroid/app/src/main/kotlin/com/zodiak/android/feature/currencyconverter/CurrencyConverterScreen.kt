package com.zodiak.android.feature.currencyconverter

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.SwapVert
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.Currency
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakInfoRow
import com.zodiak.android.R

@Composable
fun CurrencyConverterScreen(viewModel: CurrencyConverterViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            ZodiakFormContainer(stringResource(R.string.currencyconverter_form_title_converter)) {
                ZodiakInputField(state.amountInput, viewModel::onAmountChange, stringResource(R.string.currencyconverter_input_label_amount), keyboardType = KeyboardType.Decimal)
                Spacer(Modifier.height(12.dp))

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                ) {
                    CurrencyDropdown(
                        label = stringResource(R.string.currencyconverter_dropdown_label_from),
                        selected = state.fromCurrency,
                        currencies = state.currencies,
                        onSelect = viewModel::onFromCurrencyChange,
                        modifier = Modifier.weight(1f),
                    )
                    IconButton(onClick = viewModel::swapCurrencies) {
                        Icon(Icons.Default.SwapVert, contentDescription = stringResource(R.string.currencyconverter_content_desc_swap))
                    }
                    CurrencyDropdown(
                        label = stringResource(R.string.currencyconverter_dropdown_label_to),
                        selected = state.toCurrency,
                        currencies = state.currencies,
                        onSelect = viewModel::onToCurrencyChange,
                        modifier = Modifier.weight(1f),
                    )
                }
                Spacer(Modifier.height(12.dp))
                ZodiakButton(stringResource(R.string.currencyconverter_button_convert), viewModel::convert, Modifier.fillMaxWidth())
            }

            state.result?.let { result ->
                ZodiakFormContainer(stringResource(R.string.currencyconverter_form_title_result)) {
                    ZodiakInfoRow(stringResource(R.string.currencyconverter_dropdown_label_from), "${state.fromCurrency.flag} ${state.amountInput} ${state.fromCurrency.code}")
                    ZodiakInfoRow(
                        stringResource(R.string.currencyconverter_dropdown_label_to),
                        "${state.toCurrency.flag} ${"%.4f".format(result)} ${state.toCurrency.code}",
                        valueColor = MaterialTheme.colorScheme.primary,
                    )
                }
                ZodiakButton(stringResource(R.string.currencyconverter_button_clear), viewModel::reset, Modifier.fillMaxWidth())
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun CurrencyDropdown(
    label: String,
    selected: Currency,
    currencies: List<Currency>,
    onSelect: (Currency) -> Unit,
    modifier: Modifier = Modifier,
) {
    var expanded by remember { mutableStateOf(false) }

    ExposedDropdownMenuBox(expanded = expanded, onExpandedChange = { expanded = it }, modifier = modifier) {
        OutlinedTextField(
            value = "${selected.flag} ${selected.code}",
            onValueChange = {},
            readOnly = true,
            label = { Text(label) },
            trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
            modifier = Modifier.menuAnchor(MenuAnchorType.PrimaryNotEditable).fillMaxWidth(),
        )
        ExposedDropdownMenu(expanded = expanded, onDismissRequest = { expanded = false }) {
            currencies.forEach { currency ->
                DropdownMenuItem(
                    text = { Text("${currency.flag} ${currency.code} — ${currency.name}") },
                    onClick = { onSelect(currency); expanded = false },
                )
            }
        }
    }
}
