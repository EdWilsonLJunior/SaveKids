package com.zodiak.android.feature.savekids

import com.zodiak.android.feature.savekids.data.local.datastore.SaveKidsSessionDataStore
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsFamilyDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsGoalDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsHistoryDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsHistoryEventEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsMissionDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsMissionEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsProfileDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsRewardDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsWalletDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsWalletEntity
import com.zodiak.android.feature.savekids.data.remote.retrofit.PokeApiService
import com.zodiak.android.feature.savekids.model.HistoryEventType
import com.zodiak.android.feature.savekids.model.MissionStatus
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
 * Testes da regra de negocio real de conclusao de missao
 * (SaveKidsRepositoryImpl.completeMission), com os DAOs do Room mockados.
 *
 * Diferente dos testes de ViewModel, que usam FakeSaveKidsRepository,
 * aqui a logica exercitada e a de producao.
 */
class SaveKidsMissionsRepositoryTest {

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

    private val missaoDisponivel = SaveKidsMissionEntity(
        id = 1,
        title = "Desafio em família",
        description = "Compare quem economizou mais na semana.",
        rewardXp = 58,
        rewardMoney = 15.0,
        status = MissionStatus.AVAILABLE,
    )

    @BeforeEach
    fun setup() {
        // Flows consumidos na construcao do repositorio.
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
    fun `CT-013 concluir missao persiste status COMPLETED`() = runTest {
        coEvery { missionDao.findById(1) } returns missaoDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 80, level = 1)

        val resultado = repository.completeMission(1)

        assertTrue(resultado.isSuccess)
        val missaoSalva = slot<SaveKidsMissionEntity>()
        coVerify { missionDao.update(capture(missaoSalva)) }
        assertEquals(MissionStatus.COMPLETED, missaoSalva.captured.status)
        assertEquals(1L, missaoSalva.captured.id)
    }

    @Test
    fun `CT-014 concluir missao credita XP e recompensa em dinheiro na carteira`() = runTest {
        coEvery { missionDao.findById(1) } returns missaoDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 80, level = 1, balance = 100.0)

        repository.completeMission(1)

        val carteiraSalva = slot<SaveKidsWalletEntity>()
        coVerify { walletDao.upsert(capture(carteiraSalva)) }
        assertEquals(80 + 58, carteiraSalva.captured.xp)
        assertEquals(100.0 + 15.0, carteiraSalva.captured.balance)
    }

    @Test
    fun `CT-015 concluir missao recalcula nivel ao cruzar faixa de XP`() = runTest {
        // 80 XP + 58 XP = 138 XP, cruzando o limite de 100 XP do nivel 2.
        coEvery { missionDao.findById(1) } returns missaoDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 80, level = 1)

        repository.completeMission(1)

        val carteiraSalva = slot<SaveKidsWalletEntity>()
        coVerify { walletDao.upsert(capture(carteiraSalva)) }
        assertEquals(2, carteiraSalva.captured.level)
    }

    @Test
    fun `CT-016 concluir missao mantem nivel quando XP nao cruza faixa`() = runTest {
        // 10 XP + 58 XP = 68 XP, ainda abaixo dos 100 XP do nivel 2.
        coEvery { missionDao.findById(1) } returns missaoDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 10, level = 1)

        repository.completeMission(1)

        val carteiraSalva = slot<SaveKidsWalletEntity>()
        coVerify { walletDao.upsert(capture(carteiraSalva)) }
        assertEquals(1, carteiraSalva.captured.level)
    }

    @Test
    fun `CT-017 concluir missao registra evento no historico`() = runTest {
        coEvery { missionDao.findById(1) } returns missaoDisponivel
        coEvery { walletDao.getWallet() } returns carteira(xp = 80, level = 1)

        repository.completeMission(1)

        val evento = slot<SaveKidsHistoryEventEntity>()
        coVerify { historyDao.insert(capture(evento)) }
        assertEquals(HistoryEventType.MISSION_COMPLETED, evento.captured.type)
        assertEquals("Missão concluída", evento.captured.title)
        assertEquals("Desafio em família", evento.captured.details)
        assertEquals(58, evento.captured.xpDelta)
        assertEquals(15.0, evento.captured.amount)
    }

    @Test
    fun `CT-018 concluir missao inexistente falha sem tocar carteira ou historico`() = runTest {
        coEvery { missionDao.findById(99) } returns null

        val resultado = repository.completeMission(99)

        assertTrue(resultado.isFailure)
        assertEquals("Missão não encontrada.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { missionDao.update(any()) }
        coVerify(exactly = 0) { walletDao.upsert(any()) }
        coVerify(exactly = 0) { historyDao.insert(any()) }
    }

    @Test
    fun `CT-020 carteira nao inicializada falha sem consumir a missao`() = runTest {
        coEvery { missionDao.findById(1) } returns missaoDisponivel
        coEvery { walletDao.getWallet() } returns null

        val resultado = repository.completeMission(1)

        assertTrue(resultado.isFailure)
        assertEquals("Carteira não inicializada.", resultado.exceptionOrNull()?.message)
        // A missao nao pode ficar concluida sem que a recompensa tenha sido paga.
        coVerify(exactly = 0) { missionDao.update(any()) }
        coVerify(exactly = 0) { historyDao.insert(any()) }
    }

    @Test
    fun `CT-019 concluir missao ja concluida falha sem creditar recompensa novamente`() = runTest {
        coEvery { missionDao.findById(1) } returns missaoDisponivel.copy(status = MissionStatus.COMPLETED)

        val resultado = repository.completeMission(1)

        assertTrue(resultado.isFailure)
        assertEquals("Missão já concluída.", resultado.exceptionOrNull()?.message)
        coVerify(exactly = 0) { missionDao.update(any()) }
        coVerify(exactly = 0) { walletDao.upsert(any()) }
        coVerify(exactly = 0) { historyDao.insert(any()) }
    }
}
