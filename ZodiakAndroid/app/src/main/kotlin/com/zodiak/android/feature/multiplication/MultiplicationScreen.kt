package com.zodiak.android.feature.multiplication

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.R
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakInfoRow

@Composable
fun MultiplicationScreen(viewModel: MultiplicationViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakFormContainer(stringResource(R.string.multiplication_form_title_table)) {
                    ZodiakInputField(state.numberInput, viewModel::onNumberChange, stringResource(R.string.multiplication_input_label_number), keyboardType = KeyboardType.Number)
                    state.error?.let { error ->
                        val msg = when (error) {
                            is ValidationError.EmptyField    -> stringResource(R.string.shared_validation_empty_field, error.fieldName)
                            is ValidationError.InvalidNumber -> stringResource(R.string.shared_validation_invalid_number, error.fieldName)
                            is ValidationError.OutOfRange    -> stringResource(R.string.shared_validation_out_of_range, error.fieldName, error.min, error.max)
                            ValidationError.InvalidAge       -> stringResource(R.string.shared_validation_invalid_age)
                            ValidationError.InvalidGrade     -> stringResource(R.string.shared_validation_invalid_grade)
                        }
                        Text(msg, color = MaterialTheme.colorScheme.error, style = MaterialTheme.typography.bodySmall)
                    }
                    Spacer(Modifier.height(12.dp))
                    ZodiakButton(stringResource(R.string.multiplication_button_generate), viewModel::generate, Modifier.fillMaxWidth())
                }
            }

            if (state.table.isNotEmpty()) {
                item {
                    Card(modifier = Modifier.fillMaxWidth()) {
                        Column(Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                            state.table.forEach { (multiplier, result) ->
                                ZodiakInfoRow(
                                    label = "${state.numberInput} × $multiplier",
                                    value = "= $result",
                                )
                            }
                        }
                    }
                }
                item {
                    ZodiakButton(stringResource(R.string.multiplication_button_clear), viewModel::reset, Modifier.fillMaxWidth())
                }
            }
        }
    }
}
