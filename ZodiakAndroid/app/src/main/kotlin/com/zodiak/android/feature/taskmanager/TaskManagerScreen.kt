package com.zodiak.android.feature.taskmanager

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.R
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.atoms.ZodiakTextField
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakFormContainer

@Composable
fun TaskManagerScreen(viewModel: TaskManagerViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakFormContainer(stringResource(R.string.taskmanager_form_title_add_task)) {
                    ZodiakInputField(state.taskTitle, viewModel::onTitleChange, stringResource(R.string.taskmanager_input_label_task))
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
                    ZodiakButton(stringResource(R.string.taskmanager_button_add), viewModel::addTask, Modifier.fillMaxWidth())
                }
            }

            if (state.tasks.isNotEmpty()) {
                item {
                    ZodiakTextField(
                        value = state.searchQuery,
                        onValueChange = viewModel::onSearchChange,
                        label = stringResource(R.string.taskmanager_input_label_search),
                        trailingIcon = { Icon(Icons.Default.Search, contentDescription = null) },
                    )
                }
            }

            if (state.filteredTasks.isEmpty() && state.tasks.isNotEmpty()) {
                item { ZodiakEmptyState(stringResource(R.string.taskmanager_empty_state_title_no_results), stringResource(R.string.taskmanager_empty_state_message_no_results)) }
            } else if (state.tasks.isEmpty()) {
                item { ZodiakEmptyState(stringResource(R.string.taskmanager_empty_state_title_empty), stringResource(R.string.taskmanager_empty_state_message_empty)) }
            }

            items(state.filteredTasks, key = { it.id }) { task ->
                ListItem(
                    headlineContent = {
                        Text(
                            task.title,
                            textDecoration = if (task.isCompleted) TextDecoration.LineThrough else null,
                        )
                    },
                    leadingContent = {
                        Checkbox(checked = task.isCompleted, onCheckedChange = { viewModel.toggleTask(task.id) })
                    },
                    trailingContent = {
                        IconButton(onClick = { viewModel.removeTask(task.id) }) {
                            Icon(Icons.Default.Delete, contentDescription = stringResource(R.string.taskmanager_content_desc_remove))
                        }
                    },
                )
                HorizontalDivider()
            }
        }
    }
}
