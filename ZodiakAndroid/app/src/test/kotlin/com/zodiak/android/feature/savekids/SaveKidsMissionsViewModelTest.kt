package com.zodiak.android.feature.savekids

import com.zodiak.android.core.testing.MainDispatcherExtension
import com.zodiak.android.feature.savekids.model.HistoryEventType
import com.zodiak.android.feature.savekids.model.MissionStatus
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsMissionsViewModel
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

/**
 * Testes da camada ViewModel da stack de missoes.
 *
 * Cobre o contrato entre SaveKidsMissionsViewModel e o repositorio:
 * carga inicial da lista, conclusao de missao e mensagens de feedback.
 */
@ExtendWith(MainDispatcherExtension::class)
class SaveKidsMissionsViewModelTest {

    private lateinit var repository: FakeSaveKidsRepository

    @BeforeEach
    fun setup() {
        repository = FakeSaveKidsRepository()
    }

    @Test
    fun `CT-005 carga inicial expoe missoes e encerra loading`() = runTest {
        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()

        val state = vm.uiState.value
        assertFalse(state.isLoading)
        assertEquals(2, state.missions.size)
        assertTrue(state.missions.all { it.status == MissionStatus.AVAILABLE })
        assertNull(state.errorMessage)
    }

    @Test
    fun `CT-006 concluir missao marca status e emite mensagem de sucesso`() = runTest {
        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()

        vm.completeMission(1)
        advanceUntilIdle()

        val state = vm.uiState.value
        assertEquals("Missão concluída.", state.successMessage)
        assertNull(state.errorMessage)

        val concluida = state.missions.first { it.id == 1L }
        assertEquals(MissionStatus.COMPLETED, concluida.status)
    }

    @Test
    fun `CT-007 concluir missao nao afeta as demais missoes`() = runTest {
        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()

        vm.completeMission(1)
        advanceUntilIdle()

        val intocada = vm.uiState.value.missions.first { it.id == 2L }
        assertEquals(MissionStatus.AVAILABLE, intocada.status)
    }

    @Test
    fun `CT-008 concluir missao credita XP e dinheiro na carteira`() = runTest {
        val antes = repository.dashboardStateSnapshot()

        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()
        vm.completeMission(1)
        advanceUntilIdle()

        val missao = repository.missionsSnapshot().first { it.id == 1L }
        val depois = repository.dashboardStateSnapshot()

        assertEquals(antes.xp + missao.rewardXp, depois.xp)
        assertEquals(antes.balance + missao.rewardMoney, depois.balance)
        assertEquals(antes.completedMissions + 1, depois.completedMissions)
    }

    @Test
    fun `CT-009 concluir missao registra evento no historico`() = runTest {
        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()

        vm.completeMission(1)
        advanceUntilIdle()

        val evento = repository.historySnapshot().firstOrNull()
        assertNotNull(evento)
        assertEquals(HistoryEventType.MISSION_COMPLETED, evento?.type)
        assertEquals("Missão concluída", evento?.title)
        assertEquals("Guardar hoje", evento?.details)
        assertEquals(50, evento?.xpDelta)
        assertEquals(5.0, evento?.amount)
    }

    @Test
    fun `CT-010 concluir missao ja concluida retorna erro e nao credita XP novamente`() = runTest {
        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()

        vm.completeMission(1)
        advanceUntilIdle()
        val xpAposPrimeira = repository.dashboardStateSnapshot().xp

        vm.completeMission(1)
        advanceUntilIdle()

        assertEquals("Missão já concluída.", vm.uiState.value.errorMessage)
        assertEquals(xpAposPrimeira, repository.dashboardStateSnapshot().xp)
    }

    @Test
    fun `CT-011 concluir missao inexistente retorna erro`() = runTest {
        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()

        vm.completeMission(999)
        advanceUntilIdle()

        assertEquals("Missão não encontrada.", vm.uiState.value.errorMessage)
        assertTrue(repository.historySnapshot().isEmpty())
    }

    @Test
    fun `CT-012 clearMessages limpa sucesso e erro`() = runTest {
        val vm = SaveKidsMissionsViewModel(repository)
        advanceUntilIdle()

        vm.completeMission(1)
        advanceUntilIdle()
        vm.completeMission(1)
        advanceUntilIdle()

        vm.clearMessages()

        val state = vm.uiState.value
        assertNull(state.successMessage)
        assertNull(state.errorMessage)
    }
}
