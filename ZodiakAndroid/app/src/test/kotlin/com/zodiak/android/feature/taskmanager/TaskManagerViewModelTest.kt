package com.zodiak.android.feature.taskmanager

import app.cash.turbine.test
import com.zodiak.android.core.testing.MainDispatcherExtension
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@ExtendWith(MainDispatcherExtension::class)
class TaskManagerViewModelTest {

    private lateinit var viewModel: TaskManagerViewModel

    @BeforeEach
    fun setup() {
        viewModel = TaskManagerViewModel()
    }

    @Test
    fun `initial state has empty tasks`() = runTest {
        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.tasks.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `addTask adds task to list`() = runTest {
        viewModel.onTitleChange("Estudar Kotlin")
        viewModel.addTask()

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(1, state.tasks.size)
            assertEquals("Estudar Kotlin", state.tasks.first().title)
            assertFalse(state.tasks.first().isCompleted)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `addTask with blank title shows error`() = runTest {
        viewModel.onTitleChange("  ")
        viewModel.addTask()

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.tasks.isEmpty())
            assertNotNull(state.error)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `addTask clears input after success`() = runTest {
        viewModel.onTitleChange("Nova tarefa")
        viewModel.addTask()

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.taskTitle.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `toggleTask flips isCompleted`() = runTest {
        viewModel.onTitleChange("Tarefa X")
        viewModel.addTask()
        val taskId = viewModel.uiState.value.tasks.first().id
        viewModel.toggleTask(taskId)

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.tasks.first().isCompleted)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `removeTask removes correct task`() = runTest {
        viewModel.onTitleChange("A")
        viewModel.addTask()
        viewModel.onTitleChange("B")
        viewModel.addTask()
        val idToRemove = viewModel.uiState.value.tasks.first().id
        viewModel.removeTask(idToRemove)

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(1, state.tasks.size)
            assertNotEquals(idToRemove, state.tasks.first().id)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `searchQuery filters tasks`() = runTest {
        viewModel.onTitleChange("Estudar Kotlin")
        viewModel.addTask()
        viewModel.onTitleChange("Comprar pão")
        viewModel.addTask()
        viewModel.onSearchChange("kotlin")

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(1, state.filteredTasks.size)
            assertEquals("Estudar Kotlin", state.filteredTasks.first().title)
            cancelAndIgnoreRemainingEvents()
        }
    }
}
