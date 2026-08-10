package com.zodiak.android.feature.pixdiscount

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
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
fun PixDiscountScreen(viewModel: PixDiscountViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp).verticalScroll(rememberScrollState()),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            ZodiakFormContainer(stringResource(R.string.pixdiscount_form_title_pix)) {
                ZodiakInputField(state.amount, viewModel::onAmountChange, stringResource(R.string.pixdiscount_input_label_amount), keyboardType = KeyboardType.Decimal)
                Spacer(Modifier.height(12.dp))
                ZodiakInputField(state.discountPercent, viewModel::onDiscountChange, stringResource(R.string.pixdiscount_input_label_discount), keyboardType = KeyboardType.Decimal)
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
                Spacer(Modifier.height(16.dp))
                ZodiakButton(stringResource(R.string.pixdiscount_button_calculate), viewModel::calculate, Modifier.fillMaxWidth())
            }

            state.pixAmount?.let { pix ->
                ZodiakFormContainer(stringResource(R.string.pixdiscount_form_title_result)) {
                    ZodiakInfoRow(stringResource(R.string.pixdiscount_info_row_original_value), "R$ ${"%.2f".format(state.amount.toDoubleOrNull() ?: 0.0)}")
                    ZodiakInfoRow(stringResource(R.string.pixdiscount_info_row_discount), "${state.discountPercent}%")
                    HorizontalDivider(Modifier.padding(vertical = 4.dp))
                    ZodiakInfoRow(stringResource(R.string.pixdiscount_info_row_pix_value), "R$ ${"%.2f".format(pix)}", valueColor = MaterialTheme.colorScheme.primary)
                }
                ZodiakButton(stringResource(R.string.pixdiscount_button_clear), viewModel::reset, Modifier.fillMaxWidth())
            }
        }
    }
}
