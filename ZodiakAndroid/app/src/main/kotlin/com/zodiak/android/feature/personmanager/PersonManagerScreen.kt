package com.zodiak.android.feature.personmanager

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
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
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakFormContainer

@Composable
fun PersonManagerScreen(viewModel: PersonManagerViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakFormContainer(stringResource(R.string.personmanager_form_title_add_person)) {
                    ZodiakInputField(state.name, viewModel::onNameChange, stringResource(R.string.personmanager_input_label_name))
                    Spacer(Modifier.height(12.dp))
                    ZodiakInputField(state.age, viewModel::onAgeChange, stringResource(R.string.personmanager_input_label_age), keyboardType = KeyboardType.Number)
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
                    ZodiakButton(stringResource(R.string.personmanager_button_add), viewModel::addPerson, Modifier.fillMaxWidth())
                }
            }

            if (state.people.isEmpty()) {
                item { ZodiakEmptyState(stringResource(R.string.personmanager_empty_state_title), stringResource(R.string.personmanager_empty_state_message)) }
            } else {
                items(state.people, key = { it.id }) { person ->
                    ListItem(
                        headlineContent = { Text(person.name) },
                        supportingContent = { Text(stringResource(R.string.personmanager_label_age_years, person.age)) },
                        trailingContent = {
                            IconButton(onClick = { viewModel.removePerson(person.id) }) {
                                Icon(Icons.Default.Delete, contentDescription = stringResource(R.string.personmanager_content_desc_remove))
                            }
                        },
                    )
                    HorizontalDivider()
                }
            }
        }
    }
}
