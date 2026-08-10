package com.zodiak.android.feature.studentgrades

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.expandVertically
import androidx.compose.animation.fadeIn
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.Student
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.R
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakInfoRow

@Composable
fun StudentGradesScreen(viewModel: StudentGradesViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    state.selectedStudent?.let { student ->
        StudentDetailDialog(student = student, onDismiss = { viewModel.selectStudent(null) })
    }

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakFormContainer(stringResource(R.string.studentgrades_form_title_student_data)) {
                    ZodiakInputField(state.name, viewModel::onNameChange, stringResource(R.string.studentgrades_input_label_name))
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.absences, viewModel::onAbsencesChange, stringResource(R.string.studentgrades_input_label_absences), keyboardType = KeyboardType.Number)
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.address, viewModel::onAddressChange, stringResource(R.string.studentgrades_input_label_address))
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.phone, viewModel::onPhoneChange, stringResource(R.string.studentgrades_input_label_phone), keyboardType = KeyboardType.Phone)
                    Spacer(Modifier.height(16.dp))

                    Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        ZodiakInputField(state.subjectName, viewModel::onSubjectNameChange, stringResource(R.string.studentgrades_input_label_subject), modifier = Modifier.weight(2f))
                        ZodiakInputField(state.subjectGrade, viewModel::onSubjectGradeChange, stringResource(R.string.studentgrades_input_label_grade), modifier = Modifier.weight(1f), keyboardType = KeyboardType.Decimal)
                    }
                    Spacer(Modifier.height(8.dp))
                    ZodiakButton(stringResource(R.string.studentgrades_button_add_subject), viewModel::addSubject, Modifier.fillMaxWidth())

                    if (state.subjects.isNotEmpty()) {
                        Spacer(Modifier.height(8.dp))
                        state.subjects.forEach { s -> ZodiakInfoRow(s.name, "%.1f".format(s.grade)) }
                    }

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
                    if (state.noSubjectsError) {
                        Text(
                            text = stringResource(R.string.shared_validation_no_subjects),
                            color = MaterialTheme.colorScheme.error,
                            style = MaterialTheme.typography.bodySmall,
                        )
                    }
                    Spacer(Modifier.height(12.dp))
                    ZodiakButton(stringResource(R.string.studentgrades_button_add_student), viewModel::addStudent, Modifier.fillMaxWidth())
                }
            }

            items(state.students, key = { it.id }) { student ->
                AnimatedVisibility(visible = true, enter = fadeIn() + expandVertically()) {
                    Column {
                        ListItem(
                            headlineContent = { Text(student.name) },
                            supportingContent = { Text(stringResource(R.string.studentgrades_label_avg_absences, student.average, student.absences)) },
                            leadingContent = { Icon(Icons.Default.Person, contentDescription = null) },
                            trailingContent = {
                                IconButton(onClick = { viewModel.removeStudent(student.id) }) {
                                    Icon(Icons.Default.Delete, contentDescription = stringResource(R.string.studentgrades_content_desc_remove))
                                }
                            },
                            modifier = Modifier.fillMaxWidth(),
                        )
                        HorizontalDivider()
                    }
                }
            }
        }
    }
}

@Composable
private fun StudentDetailDialog(student: Student, onDismiss: () -> Unit) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(student.name) },
        text = {
            Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
                ZodiakInfoRow(stringResource(R.string.studentgrades_info_row_average), "%.2f".format(student.average))
                ZodiakInfoRow(stringResource(R.string.studentgrades_info_row_status), if (student.isPassing) stringResource(R.string.studentgrades_status_passing) else stringResource(R.string.studentgrades_status_failing))
                ZodiakInfoRow(stringResource(R.string.studentgrades_input_label_absences), "${student.absences}")
                if (student.hasCriticalAbsences) Text(stringResource(R.string.studentgrades_text_critical_absences), color = MaterialTheme.colorScheme.error)
                HorizontalDivider(Modifier.padding(vertical = 8.dp))
                student.subjects.forEach { s -> ZodiakInfoRow(s.name, "%.1f".format(s.grade)) }
            }
        },
        confirmButton = { TextButton(onClick = onDismiss) { Text(stringResource(R.string.studentgrades_button_close)) } },
    )
}
