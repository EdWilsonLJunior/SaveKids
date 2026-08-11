package com.zodiak.android.feature.savekids

import com.zodiak.android.feature.savekids.model.DashboardModel
import com.zodiak.android.feature.savekids.model.FamilyMemberModel
import com.zodiak.android.feature.savekids.model.GoalModel
import com.zodiak.android.feature.savekids.model.HistoryEventModel
import com.zodiak.android.feature.savekids.model.HistoryEventType
import com.zodiak.android.feature.savekids.model.MissionModel
import com.zodiak.android.feature.savekids.model.MissionStatus
import com.zodiak.android.feature.savekids.model.PokemonAvatarModel
import com.zodiak.android.feature.savekids.model.RewardModel
import com.zodiak.android.feature.savekids.model.SaveKidsProfile
import com.zodiak.android.feature.savekids.model.SaveKidsSession
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow

class FakeSaveKidsRepository : SaveKidsRepository {

    private val sessionState = MutableStateFlow(SaveKidsSession())
    private val profileState = MutableStateFlow<SaveKidsProfile?>(null)
    private val dashboardState = MutableStateFlow(
        DashboardModel(
            balance = 20.0,
            xp = 120,
            level = 2,
            levelTitle = "Aprendiz Econômico",
            topGoals = emptyList(),
            completedMissions = 0,
            totalMissions = 2,
            redeemedRewards = 0,
            totalRewards = 3,
        )
    )
    private val goalsState = MutableStateFlow<List<GoalModel>>(emptyList())
    private val missionsState = MutableStateFlow(
        listOf(
            MissionModel(
                id = 1,
                title = "Guardar hoje",
                description = "Guardar R$ 5",
                rewardXp = 50,
                rewardMoney = 5.0,
                status = MissionStatus.AVAILABLE,
            ),
            MissionModel(
                id = 2,
                title = "Caça ao desperdício",
                description = "Encontre algo sendo desperdiçado em casa",
                rewardXp = 30,
                rewardMoney = 0.0,
                status = MissionStatus.AVAILABLE,
            ),
        )
    )
    private val rewardsState = MutableStateFlow(
        listOf(
            RewardModel(
                id = 1,
                title = "Cartão comemorativo",
                description = "Prêmio por consistência",
                requiredXp = 90,
                active = true,
                redeemed = false,
            ),
            RewardModel(
                id = 2,
                title = "Troféu da Família",
                description = "Exige mais XP do que a carteira inicial possui",
                requiredXp = 240,
                active = true,
                redeemed = false,
            ),
            RewardModel(
                id = 3,
                title = "Selo desativado",
                description = "Recompensa fora de circulação",
                requiredXp = 30,
                active = false,
                redeemed = false,
            ),
        )
    )
    private val historyState = MutableStateFlow<List<HistoryEventModel>>(emptyList())
    private val familyState = MutableStateFlow<List<FamilyMemberModel>>(emptyList())

    override val session: Flow<SaveKidsSession> = sessionState.asStateFlow()
    override val profile: Flow<SaveKidsProfile?> = profileState.asStateFlow()
    override val dashboard: Flow<DashboardModel> = dashboardState.asStateFlow()
    override val goals: Flow<List<GoalModel>> = goalsState.asStateFlow()
    override val missions: Flow<List<MissionModel>> = missionsState.asStateFlow()
    override val rewards: Flow<List<RewardModel>> = rewardsState.asStateFlow()
    override val history: Flow<List<HistoryEventModel>> = historyState.asStateFlow()
    override val family: Flow<List<FamilyMemberModel>> = familyState.asStateFlow()

    private var nextGoalId = 1L

    fun dashboardStateSnapshot(): DashboardModel = dashboardState.value
    fun goalsSnapshot(): List<GoalModel> = goalsState.value
    fun historySnapshot(): List<HistoryEventModel> = historyState.value
    fun rewardsSnapshot(): List<RewardModel> = rewardsState.value
    fun missionsSnapshot(): List<MissionModel> = missionsState.value

    override suspend fun ensureSeedData() = Unit

    override suspend fun clearAuthentication() {
        sessionState.value = SaveKidsSession()
    }

    override suspend fun login(username: String, password: String): Result<Unit> {
        if (username.lowercase() == "teste" && password.lowercase() == "teste") {
            sessionState.value = SaveKidsSession(authenticated = true, profileCompleted = false)
            return Result.success(Unit)
        }
        return Result.failure(IllegalArgumentException("Use teste/teste para entrar."))
    }

    override suspend fun completeProfile(name: String, avatarPokemonId: Int): Result<Unit> {
        val clean = name.trim()
        if (clean.length !in 3..30) {
            return Result.failure(IllegalArgumentException("Informe um nome válido entre 3 e 30 caracteres."))
        }
        profileState.value = SaveKidsProfile(clean, avatarPokemonId, "Time Pikachu")
        sessionState.value = SaveKidsSession(authenticated = true, profileCompleted = true)
        pushHistory("Login realizado", "Perfil criado", HistoryEventType.LOGIN, 0.0, 0)
        return Result.success(Unit)
    }

    override suspend fun addDeposit(amount: Double): Result<Unit> {
        if (amount <= 0.0 || amount > 10000.0) {
            return Result.failure(IllegalArgumentException("O valor deve ser maior que zero e até R$ 10.000."))
        }
        val current = dashboardState.value
        val gainedXp = amount.toInt()
        dashboardState.value = current.copy(balance = current.balance + amount, xp = current.xp + gainedXp)
        pushHistory("Economia adicionada", "Depósito registrado", HistoryEventType.DEPOSIT_ADDED, amount, gainedXp)
        return Result.success(Unit)
    }

    override suspend fun createGoal(name: String, targetAmount: Double): Result<Unit> {
        if (name.isBlank()) return Result.failure(IllegalArgumentException("A meta precisa de um nome."))
        if (targetAmount <= 0.0) return Result.failure(IllegalArgumentException("O valor da meta deve ser maior que zero."))
        goalsState.value = goalsState.value + GoalModel(
            id = nextGoalId++,
            name = name.trim(),
            targetAmount = targetAmount,
            currentAmount = 0.0,
            completed = false,
        )
        val current = dashboardState.value
        dashboardState.value = current.copy(xp = current.xp + 20, topGoals = goalsState.value.take(3))
        pushHistory("Meta criada", name.trim(), HistoryEventType.GOAL_CREATED, targetAmount, 20)
        return Result.success(Unit)
    }

    override suspend fun completeMission(id: Long): Result<Unit> {
        val mission = missionsState.value.firstOrNull { it.id == id }
            ?: return Result.failure(IllegalArgumentException("Missão não encontrada."))
        if (mission.status == MissionStatus.COMPLETED) {
            return Result.failure(IllegalStateException("Missão já concluída."))
        }
        missionsState.value = missionsState.value.map {
            if (it.id == id) it.copy(status = MissionStatus.COMPLETED) else it
        }
        val current = dashboardState.value
        dashboardState.value = current.copy(
            balance = current.balance + mission.rewardMoney,
            xp = current.xp + mission.rewardXp,
            completedMissions = current.completedMissions + 1,
        )
        pushHistory("Missão concluída", mission.title, HistoryEventType.MISSION_COMPLETED, mission.rewardMoney, mission.rewardXp)
        return Result.success(Unit)
    }

    override suspend fun redeemReward(id: Long): Result<Unit> {
        val reward = rewardsState.value.firstOrNull { it.id == id }
            ?: return Result.failure(IllegalArgumentException("Recompensa não encontrada."))
        val current = dashboardState.value
        if (!reward.active) return Result.failure(IllegalStateException("Recompensa inativa."))
        if (reward.redeemed) return Result.failure(IllegalStateException("Recompensa já resgatada."))
        if (current.xp < reward.requiredXp) return Result.failure(IllegalStateException("XP insuficiente para resgatar."))
        if (current.xp < 10) return Result.failure(IllegalStateException("XP insuficiente para concluir o resgate."))

        rewardsState.value = rewardsState.value.map { if (it.id == id) it.copy(redeemed = true) else it }
        dashboardState.value = current.copy(
            xp = current.xp - 10,
            redeemedRewards = current.redeemedRewards + 1,
        )
        pushHistory("Recompensa resgatada", reward.title, HistoryEventType.REWARD_REDEEMED, 0.0, -10)
        return Result.success(Unit)
    }

    override suspend fun refreshAvatar(): Result<PokemonAvatarModel> {
        val currentXp = dashboardState.value.xp
        return Result.success(
            PokemonAvatarModel(
                basePokemonId = 25,
                teamName = "Time Pikachu",
                currentStageName = "Pikachu",
                spriteUrl = "",
                typeLabel = "Electric",
                evolutionNames = listOf("Pichu", "Pikachu", "Raichu"),
                currentXp = currentXp,
                nextLevelXp = 250,
            )
        )
    }

    private fun pushHistory(
        title: String,
        details: String,
        type: HistoryEventType,
        amount: Double,
        xpDelta: Int,
    ) {
        val nextId = (historyState.value.maxOfOrNull { it.id } ?: 0L) + 1L
        historyState.value = listOf(
            HistoryEventModel(
                id = nextId,
                title = title,
                details = details,
                type = type,
                amount = amount,
                xpDelta = xpDelta,
                createdAt = System.currentTimeMillis(),
            )
        ) + historyState.value
    }
}
