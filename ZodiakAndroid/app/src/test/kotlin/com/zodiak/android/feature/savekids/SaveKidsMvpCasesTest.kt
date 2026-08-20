package com.zodiak.android.feature.savekids

import com.zodiak.android.core.testing.MainDispatcherExtension
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsGoalsViewModel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsLoginViewModel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsPiggyBankViewModel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsRewardsViewModel
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@ExtendWith(MainDispatcherExtension::class)
class SaveKidsMvpCasesTest {

    private lateinit var repository: FakeSaveKidsRepository

    @BeforeEach
    fun setup() {
        repository = FakeSaveKidsRepository()
    }

    @Test
    fun `CT-000 cadastro ativa fluxo de criacao e avanca para perfil`() = runTest {
        val vm = SaveKidsLoginViewModel(repository)

        vm.onToggleRegistration()
        vm.onFamilyNameChange("Família Silva")
        vm.onUsernameChange("teste")
        vm.onPasswordChange("teste")
        vm.registerAccount()
        advanceUntilIdle()

        assertTrue(vm.uiState.value.authStepDone)
        assertTrue(!vm.uiState.value.isRegistrationMode)
    }

    @Test
    fun `CT-001 login com sucesso`() = runTest {
        val vm = SaveKidsLoginViewModel(repository)

        vm.onUsernameChange("teste")
        vm.onPasswordChange("teste")
        vm.authenticate()

        vm.onChildNameChange("Luna")
        vm.onAvatarSelected(25)
        vm.saveProfile()
        advanceUntilIdle()

        assertTrue(vm.uiState.value.success)
    }

    @Test
    fun `CT-001-b sessao salva nao e removida ao iniciar o login`() = runTest {
        repository.login("teste", "teste")
        advanceUntilIdle()
        repository.completeProfile("Luna", 25)
        advanceUntilIdle()

        val vm = SaveKidsLoginViewModel(repository)
        advanceUntilIdle()

        assertTrue(repository.session.first().authenticated)
        assertTrue(repository.session.first().profileCompleted)
        assertTrue(vm.uiState.value.success)
    }

    @Test
    fun `CT-002 criar meta com progresso inicial zero`() = runTest {
        val vm = SaveKidsGoalsViewModel(repository)

        vm.onGoalNameChange("Bicicleta nova")
        vm.onTargetAmountChange("100")
        vm.createGoal()
        advanceUntilIdle()

        val created = repository.goalsSnapshot().first()
        assertEquals("Bicicleta nova", created.name)
        assertEquals(0.0, created.currentAmount)
    }

    @Test
    fun `CT-003 registrar economia atualiza saldo XP e historico`() = runTest {
        val initialBalance = repository.dashboardStateSnapshot().balance
        val initialXp = repository.dashboardStateSnapshot().xp

        val vm = SaveKidsPiggyBankViewModel(repository)
        vm.onAmountChange("10")
        vm.submitDeposit()
        assertTrue(vm.uiState.value.showDepositPixModal)
        
        vm.confirmDeposit()
        advanceUntilIdle()

        val updated = repository.dashboardStateSnapshot()
        assertEquals(initialBalance + 10.0, updated.balance)
        assertEquals(initialXp + 10, updated.xp)

        val latestHistory = repository.historySnapshot().firstOrNull()
        assertNotNull(latestHistory)
        assertEquals("Economia adicionada", latestHistory?.title)
    }

    @Test
    fun `CT-004 resgatar recompensa debita XP e marca resgatada`() = runTest {
        val vm = SaveKidsRewardsViewModel(repository)
        advanceUntilIdle()

        val beforeXp = repository.dashboardStateSnapshot().xp
        vm.redeemReward(1)
        advanceUntilIdle()

        val afterXp = repository.dashboardStateSnapshot().xp
        val reward = repository.rewardsSnapshot().first { it.id == 1L }

        assertEquals(beforeXp - 10, afterXp)
        assertTrue(reward.redeemed)
    }

    @Test
    fun `CT-005 completar missao com recompensa em dinheiro atualiza meta`() = runTest {
        // Setup: Criar uma meta
        repository.createGoal("Teste Meta", 100.0)
        advanceUntilIdle()

        // Setup: Verificar missao 1 tem rewardMoney = 5.0
        val mission = repository.missionsSnapshot().first { it.id == 1L }
        assertEquals(5.0, mission.rewardMoney)

        val vm = com.zodiak.android.feature.savekids.viewmodel.SaveKidsMissionsViewModel(repository)
        vm.completeMission(1)
        assertTrue(vm.uiState.value.isGoalSelectionOpen)
        
        val goalId = repository.goalsSnapshot().first().id
        vm.confirmGoalSelection(goalId)
        advanceUntilIdle()

        val goal = repository.goalsSnapshot().first()
        assertEquals(5.0, goal.currentAmount)
    }

    @Test
    fun `CT-006 realizar saque reduz saldo e XP`() = runTest {
        repository.addDeposit(50.0)
        advanceUntilIdle()
        
        val before = repository.dashboardStateSnapshot()
        
        repository.withdrawMoney(10.0)
        advanceUntilIdle()
        
        val after = repository.dashboardStateSnapshot()
        assertEquals(before.balance - 10.0, after.balance)
        assertEquals(before.xp - 10, after.xp)
    }

    @Test
    fun `CT-007 realizar saque reduz progresso da meta ativa`() = runTest {
        repository.createGoal("Meta", 100.0)
        repository.addDeposit(50.0)
        advanceUntilIdle()
        
        val goalBefore = repository.goalsSnapshot().first()
        assertEquals(50.0, goalBefore.currentAmount)
        
        repository.withdrawMoney(10.0)
        advanceUntilIdle()
        
        val goalAfter = repository.goalsSnapshot().first()
        assertEquals(40.0, goalAfter.currentAmount)
    }

    @Test
    fun `CT-009 tentativa de saque com cofrinho vazio exibe erro especifico`() = runTest {
        // Garantir saldo zero
        val balance = repository.dashboardStateSnapshot().balance
        if (balance > 0) {
            repository.withdrawMoney(balance)
        }
        advanceUntilIdle()
        
        val vm = SaveKidsPiggyBankViewModel(repository)
        vm.onWithdrawAmountChange("10")
        vm.requestWithdrawal()
        
        assertEquals("Não é possível realizar essa ação. Não há valor no cofrinho", vm.uiState.value.errorMessage)
    }
}
