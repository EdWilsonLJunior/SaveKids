package com.zodiak.android.feature.grades

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Card
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.R
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.atoms.ZodiakBody
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakInfoRow

@Composable
fun GradesScreen(
    onBack: () -> Unit = {},
    viewModel: GradesViewModel = hiltViewModel(),
) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = 16.dp)
                .verticalScroll(rememberScrollState()),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            Spacer(Modifier.height(8.dp))

            ZodiakFormContainer(title = stringResource(R.string.grades_form_title_calculate)) {
                ZodiakInputField(
                    value = state.name,
                    onValueChange = viewModel::onNameChange,
                    label = stringResource(R.string.grades_input_label_student_name),
                    errorMessage = (state.error as? ValidationError.EmptyField)
                        ?.takeIf { it.fieldName == "Nome" }
                        ?.let { stringResource(R.string.shared_validation_empty_field, it.fieldName) },
                )
                Spacer(Modifier.height(12.dp))
                ZodiakInputField(
                    value = state.grade1,
                    onValueChange = viewModel::onGrade1Change,
                    label = stringResource(R.string.grades_input_label_grade1),
                    keyboardType = KeyboardType.Decimal,
                )
                Spacer(Modifier.height(12.dp))
                ZodiakInputField(
                    value = state.grade2,
                    onValueChange = viewModel::onGrade2Change,
                    label = stringResource(R.string.grades_input_label_grade2),
                    keyboardType = KeyboardType.Decimal,
                )
                Spacer(Modifier.height(12.dp))
                ZodiakInputField(
                    value = state.grade3,
                    onValueChange = viewModel::onGrade3Change,
                    label = stringResource(R.string.grades_input_label_grade3),
                    keyboardType = KeyboardType.Decimal,
                )

                state.error?.let { error ->
                    Spacer(Modifier.height(8.dp))
                    val msg = when (error) {
                        is ValidationError.EmptyField    -> stringResource(R.string.shared_validation_empty_field, error.fieldName)
                        is ValidationError.InvalidNumber -> stringResource(R.string.shared_validation_invalid_number, error.fieldName)
                        is ValidationError.OutOfRange    -> stringResource(R.string.shared_validation_out_of_range, error.fieldName, error.min, error.max)
                        ValidationError.InvalidAge       -> stringResource(R.string.shared_validation_invalid_age)
                        ValidationError.InvalidGrade     -> stringResource(R.string.shared_validation_invalid_grade)
                    }
                    Text(
                        text = msg,
                        color = MaterialTheme.colorScheme.error,
                        style = MaterialTheme.typography.bodySmall,
                    )
                }

                Spacer(Modifier.height(16.dp))
                ZodiakButton(
                    text = stringResource(R.string.grades_button_calculate),
                    onClick = viewModel::calculate,
                    modifier = Modifier.fillMaxWidth(),
                )
            }

            state.result?.let { grade ->
                ZodiakFormContainer(title = stringResource(R.string.grades_form_title_result)) {
                    ZodiakInfoRow(label = stringResource(R.string.grades_info_row_student), value = grade.name)
                    HorizontalDivider(modifier = Modifier.padding(vertical = 4.dp))
                    ZodiakInfoRow(label = stringResource(R.string.grades_input_label_grade1), value = "%.1f".format(grade.grade1))
                    ZodiakInfoRow(label = stringResource(R.string.grades_input_label_grade2), value = "%.1f".format(grade.grade2))
                    ZodiakInfoRow(label = stringResource(R.string.grades_input_label_grade3), value = "%.1f".format(grade.grade3))
                    HorizontalDivider(modifier = Modifier.padding(vertical = 4.dp))
                    ZodiakInfoRow(
                        label = stringResource(R.string.grades_info_row_average),
                        value = "%.2f".format(grade.average),
                        valueColor = if (grade.isPassing)
                            MaterialTheme.colorScheme.tertiary
                        else
                            MaterialTheme.colorScheme.error,
                    )
                    ZodiakInfoRow(
                        label = stringResource(R.string.grades_info_row_status),
                        value = if (grade.isPassing) stringResource(R.string.grades_status_passing) else stringResource(R.string.grades_status_failing),
                    )
                }

                ZodiakButton(
                    text = stringResource(R.string.grades_button_clear),
                    onClick = viewModel::reset,
                    modifier = Modifier.fillMaxWidth(),
                )
            }

            Spacer(Modifier.height(16.dp))
        }
    }
}
