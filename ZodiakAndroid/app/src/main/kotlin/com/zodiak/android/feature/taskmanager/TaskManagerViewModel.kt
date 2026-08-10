package com.zodiak.android.feature.taskmanager

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Task
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import java.util.UUID
import javax.inject.Inject

data class TaskManagerUiState(
    val taskTitle: String = "",
    val searchQuery: String = "",
    val tasks: List<Task> = emptyList(),
    val error: ValidationError? = null,
) {
    val filteredTasks: List<Task> get() =
        if (searchQuery.isBlank()) tasks
        else tasks.filter { it.title.contains(searchQuery, ignoreCase = true) }
}

@HiltViewModel
class TaskManagerViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(TaskManagerUiState())
    val uiState: StateFlow<TaskManagerUiState> = _uiState.asStateFlow()

    fun onTitleChange(v: String) = _uiState.update { it.copy(taskTitle = v, error = null) }
    fun onSearchChange(v: String) = _uiState.update { it.copy(searchQuery = v) }

    fun addTask() {
        try {
            ValidationService.validateNotEmpty(_uiState.value.taskTitle, "Tarefa")
            val task = Task(title = _uiState.value.taskTitle.trim())
            _uiState.update { it.copy(tasks = it.tasks + task, taskTitle = "", error = null) }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun toggleTask(id: UUID) = _uiState.update { state ->
        state.copy(tasks = state.tasks.map { if (it.id == id) it.copy(isCompleted = !it.isCompleted) else it })
    }

    fun removeTask(id: UUID) = _uiState.update { it.copy(tasks = it.tasks.filter { t -> t.id != id }) }
}
