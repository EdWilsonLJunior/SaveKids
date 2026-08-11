package com.zodiak.android.feature.savekids

import com.zodiak.android.feature.savekids.data.local.datastore.SaveKidsSessionDataStore
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsFamilyDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsGoalDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsHistoryDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsHistoryEventEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsMissionDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsProfileDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsRewardDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsRewardEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsWalletDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsWalletEntity
import com.zodiak.android.feature.savekids.data.remote.retrofit.PokeApiService
import com.zodiak.android.feature.savekids.model.HistoryEventType
import com.zodiak.android.feature.savekids.repository.SaveKidsRepositoryImpl
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.every
import io.mockk.mockk
import io.mockk.slot
import kotlinx.coroutines.flow.emptyFlow
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

/**
 * Testes da regra de negocio real de resgate de recompensa
 * (SaveKidsRepositoryImpl.redeemReward), com os DAOs do Room mockados.
 *
 * O custo de resgate e fixo (10 XP) e independe do requiredXp da recompensa.
 */
class SaveKidsRewardsRepositoryTest {

    private val sessionDataStore: SaveKidsSessionDataStore = mockk(relaxed = true)
    private val profileDao: SaveKidsProfileDao = mockk(relaxed = true)
    private val walletDao: SaveKidsWalletDao = mockk(relaxed = true)
    private val goalDao: SaveKidsGoalDao = mockk(relaxed = true)
    private val missionDao: SaveKidsMissionDao = mockk(relaxed = true)
    private val rewardDao: SaveKidsRewardDao = mockk(relaxed = true)
    private val historyDao: SaveKidsHistoryDao = mockk(relaxed = true)
    private val familyDao: SaveKidsFamilyDao = mockk(relaxed = true)
    private val pokeApiService: PokeApiService = mockk(relaxed = true)

    private lateinit var repository: SaveKidsRepositoryImpl

    private val custoFixoDeResgate = 10

    private val recompensaDisponivel = SaveKidsRewardEntity(
        id = 1,
        title = "Passe de Evolução",
        description = "Mostra evolução avançada do avatar.",
        requiredXp = 150,
        active = true,
        redeemed = false,
    )

    @BeforeEach
    fun setup() {
        every { profileDao.observeProfile() } returns emptyFlow()
        every { walletDao.observeWallet() } returns emptyFlow()
        every { goalDao.observeGoals() } returns flowOf(emptyList())
        every { goalDao.observeTopGoals() } returns flowOf(emptyList())
        every { missionDao.observeMissions() } returns flowOf(emptyList())
        every { rewardDao.observeRewards() } returns flowOf(emptyList())
        every { historyDao.observeHistory() } returns flowOf(emptyList())
        every { familyDao.observeFamily() } returns flowOf(emptyList())

        repository = SaveKidsRepositoryImpl(
            sessionDataStore = sessionDataStore,
            profileDao = profileDao,
            walletDao = walletDao,
            goalDao = goalDao,
            missionDao = missionDao,
            rewardDao = rewardDao,
            historyDao = historyDao,
            familyDao = familyDao,
            pokeApiService = pokeApiService,
        )
    }

    private fun carteira(xp: Int, level: Int, balance: Double = 100.0) = SaveKidsWalletEntity(
        id = 1,
        balance = balance,
        xp = xp,
        level = level,
        updatedAt = 0L,
    )

    @Test
    fun `CT-031 resgatar recompensa persiste flag redeemed`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 200, level = 2)

        val resultado = repository.redeemReward(1)

        assertTrue(resultado.isSuccess)
        val recompensaSalva = slot<SaveKidsRewardEntity>()
        coVerify { rewardDao.update(capture(recompensaSalva)) }
        assertTrue(recompensaSalva.captured.redeemed)
        assertEquals(1L, recompensaSalva.captured.id)
    }

    @Test
    fun `CT-032 resgatar debita custo fixo de XP e nao o requiredXp`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 200, level = 2)

        repository.redeemReward(1)

        val carteiraSalva = slot<SaveKidsWalletEntity>()
        coVerify { walletDao.upsert(capture(carteiraSalva)) }
        // requiredXp e 150, mas o debito e sempre o custo fixo de 10 XP.
        assertEquals(200 - custoFixoDeResgate, carteiraSalva.captured.xp)
    }

    @Test
    fun `CT-033 resgatar nao altera o saldo em dinheiro`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 200, level = 2, balance = 145.0)

        repository.redeemReward(1)

        val carteiraSalva = slot<SaveKidsWalletEntity>()
        coVerify { walletDao.upsert(capture(carteiraSalva)) }
        assertEquals(145.0, carteiraSalva.captured.balance)
    }

    @Test
    fun `CT-034 resgatar pode rebaixar o nivel ao cair de faixa de XP`() = runTest {
        // 105 XP - 10 XP = 95 XP, voltando para abaixo dos 100 XP do nivel 2.
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel.copy(requiredXp = 90)
        coEvery { walletDao.getWallet() } returns carteira(xp = 105, level = 2)

        repository.redeemReward(1)

        val carteiraSalva = slot<SaveKidsWalletEntity>()
        coVerify { walletDao.upsert(capture(carteiraSalva)) }
        assertEquals(95, carteiraSalva.captured.xp)
        assertEquals(1, carteiraSalva.captured.level)
    }

    @Test
    fun `CT-035 resgatar registra evento no historico com XP negativo`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 200, level = 2)

        repository.redeemReward(1)

        val evento = slot<SaveKidsHistoryEventEntity>()
        coVerify { historyDao.insert(capture(evento)) }
        assertEquals(HistoryEventType.REWARD_REDEEMED, evento.captured.type)
        assertEquals("Recompensa resgatada", evento.captured.title)
        assertEquals("Passe de Evolução", evento.captured.details)
        assertEquals(-custoFixoDeResgate, evento.captured.xpDelta)
        assertEquals(0.0, evento.captured.amount)
    }

    @Test
    fun `CT-036 recompensa inexistente falha sem efeito colateral`() = runTest {
        coEvery { rewardDao.findById(99) } returns null

        val resultado = repository.redeemReward(99)

        assertTrue(resultado.isFailure)
        assertEquals("Recompensa não encontrada.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { rewardDao.update(any()) }
        coVerify(exactly = 0) { walletDao.upsert(any()) }
        coVerify(exactly = 0) { historyDao.insert(any()) }
    }

    @Test
    fun `CT-037 recompensa inativa falha mesmo com XP suficiente`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel.copy(active = false)
        coEvery { walletDao.getWallet() } returns carteira(xp = 500, level = 4)

        val resultado = repository.redeemReward(1)

        assertTrue(resultado.isFailure)
        assertEquals("Recompensa inativa.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { rewardDao.update(any()) }
        coVerify(exactly = 0) { walletDao.upsert(any()) }
    }

    @Test
    fun `CT-038 recompensa ja resgatada falha sem debitar XP novamente`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel.copy(redeemed = true)
        coEvery { walletDao.getWallet() } returns carteira(xp = 500, level = 4)

        val resultado = repository.redeemReward(1)

        assertTrue(resultado.isFailure)
        assertEquals("Recompensa já resgatada.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { rewardDao.update(any()) }
        coVerify(exactly = 0) { walletDao.upsert(any()) }
    }

    @Test
    fun `CT-039 XP abaixo do requiredXp falha sem consumir a recompensa`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 149, level = 2)

        val resultado = repository.redeemReward(1)

        assertTrue(resultado.isFailure)
        assertEquals("XP insuficiente para resgatar.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { rewardDao.update(any()) }
        coVerify(exactly = 0) { walletDao.upsert(any()) }
    }

    @Test
    fun `CT-040 XP suficiente para desbloquear mas abaixo do custo de resgate falha`() = runTest {
        // Regra pouco intuitiva: uma recompensa barata pode ser desbloqueada
        // sem que a carteira tenha os 10 XP necessarios para pagar o resgate.
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel.copy(requiredXp = 5)
        coEvery { walletDao.getWallet() } returns carteira(xp = 8, level = 1)

        val resultado = repository.redeemReward(1)

        assertTrue(resultado.isFailure)
        assertEquals("XP insuficiente para concluir o resgate.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { rewardDao.update(any()) }
    }

    @Test
    fun `CT-041 carteira nao inicializada falha sem consumir a recompensa`() = runTest {
        coEvery { rewardDao.findById(1) } returns recompensaDisponivel
        coEvery { walletDao.getWallet() } returns null

        val resultado = repository.redeemReward(1)

        assertTrue(resultado.isFailure)
        assertEquals("Carteira não inicializada.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { rewardDao.update(any()) }
        coVerify(exactly = 0) { historyDao.insert(any()) }
    }
}
