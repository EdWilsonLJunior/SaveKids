package com.zodiak.android.feature.savekids

import com.zodiak.android.core.testing.MainDispatcherExtension
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsHomeViewModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@OptIn(ExperimentalCoroutinesApi::class)
@ExtendWith(MainDispatcherExtension::class)
class SaveKidsHomeViewModelTest {

    private lateinit var repository: FakeSaveKidsRepository
    private lateinit var viewModel: SaveKidsHomeViewModel

    @BeforeEach
    fun setup() {
        repository = FakeSaveKidsRepository()
        viewModel = SaveKidsHomeViewModel(repository)
    }

    @Test
    fun `inicializacao carrega perfil e avatar`() = runTest {
        repository.completeProfile("Luna", 25)
        advanceUntilIdle()

        val state = viewModel.uiState.value
        assertEquals("Luna", state.profile?.childName)
        assertEquals("Pikachu", state.avatar?.currentStageName)
    }

    @Test
    fun `refreshAvatar e chamado quando XP muda`() = runTest {
        repository.completeProfile("Luna", 25)
        advanceUntilIdle()

        val initialXp = repository.dashboardStateSnapshot().xp
        assertEquals(initialXp, viewModel.uiState.value.avatar?.currentXp)

        // Adiciona deposito que aumenta XP
        repository.addDeposit(50.0)
        advanceUntilIdle()

        val updatedXp = repository.dashboardStateSnapshot().xp
        assertEquals(updatedXp, viewModel.uiState.value.avatar?.currentXp)
    }
}
