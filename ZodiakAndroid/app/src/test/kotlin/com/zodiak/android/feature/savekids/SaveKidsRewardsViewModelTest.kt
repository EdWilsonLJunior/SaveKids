package com.zodiak.android.feature.savekids

import com.zodiak.android.core.testing.MainDispatcherExtension
import com.zodiak.android.feature.savekids.model.HistoryEventType
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsRewardsViewModel
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
 * Testes da camada ViewModel da stack de recompensas.
 *
 * O ViewModel combina dois flows (rewards + dashboard) porque o XP atual
 * nao faz parte de RewardModel; esses testes cobrem esse acoplamento.
 */
@ExtendWith(MainDispatcherExtension::class)
class SaveKidsRewardsViewModelTest {

    private lateinit var repository: FakeSaveKidsRepository

    @BeforeEach
    fun setup() {
        repository = FakeSaveKidsRepository()
    }

    @Test
    fun `CT-021 carga inicial expoe recompensas e XP atual`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        val state = vm.uiState.value
        assertFalse(state.isLoading)
        assertEquals(3, state.rewards.size)
        assertEquals(repository.dashboardStateSnapshot().xp, state.currentXp)
        assertNull(state.errorMessage)
    }

    @Test
    fun `CT-022 resgatar recompensa marca redeemed e emite mensagem de sucesso`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        vm.redeemReward(1)
        advanceUntilIdle()

        val state = vm.uiState.value
        assertEquals("Recompensa resgatada com sucesso.", state.successMessage)
        assertNull(state.errorMessage)
        assertTrue(state.rewards.first { it.id == 1L }.redeemed)
    }

    @Test
    fun `CT-023 resgate reflete o novo XP no estado da tela`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()
        val xpAntes = vm.uiState.value.currentXp

        vm.redeemReward(1)
        advanceUntilIdle()

        assertEquals(xpAntes - 10, vm.uiState.value.currentXp)
    }

    @Test
    fun `CT-024 resgatar nao afeta as demais recompensas`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        vm.redeemReward(1)
        advanceUntilIdle()

        val intocada = vm.uiState.value.rewards.first { it.id == 2L }
        assertFalse(intocada.redeemed)
    }

    @Test
    fun `CT-025 resgatar registra evento no historico`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        vm.redeemReward(1)
        advanceUntilIdle()

        val evento = repository.historySnapshot().firstOrNull()
        assertNotNull(evento)
        assertEquals(HistoryEventType.REWARD_REDEEMED, evento?.type)
        assertEquals("Cartão comemorativo", evento?.details)
        assertEquals(-10, evento?.xpDelta)
    }

    @Test
    fun `CT-026 resgatar recompensa ja resgatada retorna erro`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        vm.redeemReward(1)
        advanceUntilIdle()
        val xpAposPrimeiro = vm.uiState.value.currentXp

        vm.redeemReward(1)
        advanceUntilIdle()

        assertEquals("Recompensa já resgatada.", vm.uiState.value.errorMessage)
        assertEquals(xpAposPrimeiro, vm.uiState.value.currentXp)
    }

    @Test
    fun `CT-027 resgatar sem XP suficiente retorna erro`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        // Recompensa 2 exige 240 XP e a carteira inicial tem 120 XP.
        vm.redeemReward(2)
        advanceUntilIdle()

        assertEquals("XP insuficiente para resgatar.", vm.uiState.value.errorMessage)
        assertFalse(vm.uiState.value.rewards.first { it.id == 2L }.redeemed)
    }

    @Test
    fun `CT-028 recompensa inativa e exibida mas falha ao resgatar`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        // A recompensa 3 esta inativa, porem exige apenas 30 XP. A tela mostra o
        // botao de resgate porque so compara currentXp com requiredXp, ignorando
        // o campo active. O erro so aparece depois do clique.
        val inativa = vm.uiState.value.rewards.first { it.id == 3L }
        assertFalse(inativa.active)
        assertTrue(vm.uiState.value.currentXp >= inativa.requiredXp)

        vm.redeemReward(3)
        advanceUntilIdle()

        assertEquals("Recompensa inativa.", vm.uiState.value.errorMessage)
        assertFalse(vm.uiState.value.rewards.first { it.id == 3L }.redeemed)
    }

    @Test
    fun `CT-029 resgatar recompensa inexistente retorna erro`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        vm.redeemReward(999)
        advanceUntilIdle()

        assertEquals("Recompensa não encontrada.", vm.uiState.value.errorMessage)
        assertTrue(repository.historySnapshot().isEmpty())
    }

    @Test
    fun `CT-030 clearMessages limpa sucesso e erro`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        vm.redeemReward(1)
        advanceUntilIdle()
        vm.redeemReward(1)
        advanceUntilIdle()

        vm.clearMessages()

        val state = vm.uiState.value
        assertNull(state.successMessage)
        assertNull(state.errorMessage)
    }
}
