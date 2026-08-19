package com.zodiak.android.feature.savekids.repository

import com.zodiak.android.feature.savekids.data.local.datastore.SaveKidsSessionDataStore
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsFamilyDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsFamilyMemberEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsGoalDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsGoalEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsHistoryDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsHistoryEventEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsMissionDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsMissionEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsProfileDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsProfileEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsRewardDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsRewardEntity
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsWalletDao
import com.zodiak.android.feature.savekids.data.local.room.SaveKidsWalletEntity
import com.zodiak.android.feature.savekids.data.remote.retrofit.EvolutionNodeDto
import com.zodiak.android.feature.savekids.data.remote.retrofit.PokemonDto
import com.zodiak.android.feature.savekids.data.remote.retrofit.PokeApiService
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
import com.zodiak.android.feature.savekids.model.StarterAvatarOptions
import com.zodiak.android.feature.savekids.utils.GamificationRules
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class SaveKidsRepositoryImpl @Inject constructor(
    private val sessionDataStore: SaveKidsSessionDataStore,
    private val profileDao: SaveKidsProfileDao,
    private val walletDao: SaveKidsWalletDao,
    private val goalDao: SaveKidsGoalDao,
    private val missionDao: SaveKidsMissionDao,
    private val rewardDao: SaveKidsRewardDao,
    private val historyDao: SaveKidsHistoryDao,
    private val familyDao: SaveKidsFamilyDao,
    private val pokeApiService: PokeApiService,
) : SaveKidsRepository {

    private val seedMutex = Mutex()
    private val rewardRedemptionCostXp = 10

    override val session: Flow<SaveKidsSession> = sessionDataStore.session

    override val profile: Flow<SaveKidsProfile?> = profileDao.observeProfile().map { entity ->
        entity?.let {
            SaveKidsProfile(
                childName = it.childName,
                avatarPokemonId = it.avatarPokemonId,
                avatarTeamName = it.avatarTeamName,
            )
        }
    }

    override val goals: Flow<List<GoalModel>> = goalDao.observeGoals().map { entities ->
        entities.map {
            GoalModel(
                id = it.id,
                name = it.name,
                targetAmount = it.targetAmount,
                currentAmount = it.currentAmount,
                completed = it.completed,
            )
        }
    }

    override val missions: Flow<List<MissionModel>> = missionDao.observeMissions().map { entities ->
        entities.map {
            MissionModel(
                id = it.id,
                title = it.title,
                description = it.description,
                rewardXp = it.rewardXp,
                rewardMoney = it.rewardMoney,
                status = it.status,
            )
        }
    }

    override val rewards: Flow<List<RewardModel>> = rewardDao.observeRewards().map { entities ->
        entities.map {
            RewardModel(
                id = it.id,
                title = it.title,
                description = it.description,
                requiredXp = it.requiredXp,
                active = it.active,
                redeemed = it.redeemed,
            )
        }
    }

    override val history: Flow<List<HistoryEventModel>> = historyDao.observeHistory().map { entities ->
        entities.map {
            HistoryEventModel(
                id = it.id,
                title = it.title,
                details = it.details,
                type = it.type,
                amount = it.amount,
                xpDelta = it.xpDelta,
                createdAt = it.createdAt,
            )
        }
    }

    override val family: Flow<List<FamilyMemberModel>> = familyDao.observeFamily().map { entities ->
        entities.map {
            FamilyMemberModel(
                id = it.id,
                name = it.name,
                role = it.role,
                savings = it.savings,
                xp = it.xp,
                streakDays = it.streakDays,
                highlighted = it.highlighted,
            )
        }
    }

    override val dashboard: Flow<DashboardModel> = combine(
        walletDao.observeWallet(),
        goalDao.observeTopGoals(),
        missionDao.observeMissions(),
        rewardDao.observeRewards(),
    ) { wallet, topGoals, missions, rewards ->
        val safeWallet = wallet ?: SaveKidsWalletEntity(
            id = 1,
            balance = 0.0,
            xp = 0,
            level = 1,
            updatedAt = System.currentTimeMillis(),
        )
        val levelInfo = GamificationRules.levelForXp(safeWallet.xp)
        DashboardModel(
            balance = safeWallet.balance,
            xp = safeWallet.xp,
            level = levelInfo.level,
            levelTitle = levelInfo.title,
            topGoals = topGoals.map {
                GoalModel(
                    id = it.id,
                    name = it.name,
                    targetAmount = it.targetAmount,
                    currentAmount = it.currentAmount,
                    completed = it.completed,
                )
            },
            completedMissions = missions.count { it.status == MissionStatus.COMPLETED },
            totalMissions = missions.size,
            redeemedRewards = rewards.count { it.redeemed },
            totalRewards = rewards.size,
        )
    }

    override suspend fun ensureSeedData() {
        seedMutex.withLock {
            withContext(Dispatchers.IO) {
                if (walletDao.getWallet() == null) {
                    walletDao.upsert(
                        SaveKidsWalletEntity(
                            id = 1,
                            balance = 0.0,
                            xp = 0,
                            level = 1,
                            updatedAt = System.currentTimeMillis(),
                        )
                    )
                }

                if (missionDao.getMissions().isEmpty()) {
                    missionDao.insertAll(
                        listOf(
                            SaveKidsMissionEntity(title = "Guardar hoje", description = "Coloque pelo menos R$ 5 no cofrinho hoje.", rewardXp = 28, rewardMoney = 5.0, status = MissionStatus.AVAILABLE),
                            SaveKidsMissionEntity(title = "Missão da casa", description = "Ajude em uma tarefa simples e receba recompensa.", rewardXp = 42, rewardMoney = 10.0, status = MissionStatus.AVAILABLE),
                            SaveKidsMissionEntity(title = "Sem gasto por impulso", description = "Espere 24h antes de pedir algo novo.", rewardXp = 36, rewardMoney = 0.0, status = MissionStatus.AVAILABLE),
                            SaveKidsMissionEntity(title = "Desafio em família", description = "Compare quem economizou mais na semana.", rewardXp = 58, rewardMoney = 15.0, status = MissionStatus.AVAILABLE),
                            SaveKidsMissionEntity(title = "Lista de prioridades", description = "Escreva 3 coisas que você quer comprar e escolha só 1 pra pedir primeiro.", rewardXp = 34, rewardMoney = 6.0, status = MissionStatus.AVAILABLE),
                            SaveKidsMissionEntity(title = "Caça ao desperdício", description = "Encontre algo em casa sendo desperdiçado (água, luz, comida) e ajude a corrigir.", rewardXp = 30, rewardMoney = 5.0, status = MissionStatus.AVAILABLE),
                            SaveKidsMissionEntity(title = "Comparador de preços", description = "Compare o preço do mesmo produto em dois lugares antes de comprar.", rewardXp = 32, rewardMoney = 6.0, status = MissionStatus.AVAILABLE),
                            SaveKidsMissionEntity(title = "Gesto solidário", description = "Doe um brinquedo ou parte do que economizou para alguém que precisa.", rewardXp = 45, rewardMoney = 10.0, status = MissionStatus.AVAILABLE),
                        )
                    )
                }

                if (goalDao.observeGoals().first().isEmpty()) {
                    goalDao.insert(
                        SaveKidsGoalEntity(
                            name = "Bicicleta nova",
                            targetAmount = 350.0,
                            currentAmount = 60.0,
                            completed = false,
                        )
                    )
                }

                if (rewardDao.getRewards().isEmpty()) {
                    rewardDao.insertAll(
                        listOf(
                            SaveKidsRewardEntity(title = "Distintivo Primeiros Passos", description = "Desbloqueia um selo para mostrar início da jornada.", requiredXp = 30, active = true, redeemed = false),
                            SaveKidsRewardEntity(title = "Modo Super Foco", description = "Libera um cartão comemorativo da meta em andamento.", requiredXp = 90, active = true, redeemed = false),
                            SaveKidsRewardEntity(title = "Passe de Evolução", description = "Mostra evolução avançada do avatar.", requiredXp = 150, active = true, redeemed = false),
                            SaveKidsRewardEntity(title = "Troféu da Família", description = "Reconhece quem lidera o ranking mensal.", requiredXp = 240, active = true, redeemed = false),
                        )
                    )
                }

                if (familyDao.getFamily().isEmpty()) {
                    familyDao.insertAll(
                        listOf(
                            SaveKidsFamilyMemberEntity(name = "Mamãe", role = "Responsável", savings = 220.0, xp = 172, streakDays = 8, highlighted = false),
                            SaveKidsFamilyMemberEntity(name = "Maria", role = "Irmã", savings = 180.0, xp = 138, streakDays = 6, highlighted = false),
                            SaveKidsFamilyMemberEntity(name = "Luna", role = "Você", savings = 145.0, xp = 96, streakDays = 4, highlighted = true),
                            SaveKidsFamilyMemberEntity(name = "Caio", role = "Irmão", savings = 95.0, xp = 84, streakDays = 4, highlighted = false),
                        )
                    )
                }
            }
        }
    }

    override suspend fun clearAuthentication() = withContext(Dispatchers.IO) {
        sessionDataStore.clearSession()
    }

    override suspend fun login(username: String, password: String): Result<Unit> = withContext(Dispatchers.IO) {
        if (username.trim().lowercase() != "teste" || password.trim().lowercase() != "teste") {
            return@withContext Result.failure(IllegalArgumentException("Use teste/teste para entrar."))
        }
        sessionDataStore.saveLoginState(authenticated = true)
        Result.success(Unit)
    }

    override suspend fun completeProfile(name: String, avatarPokemonId: Int): Result<Unit> = withContext(Dispatchers.IO) {
        val profile = validateProfile(name, avatarPokemonId).getOrElse { error ->
            return@withContext Result.failure(error)
        }
        saveProfile(profile)
        historyDao.insert(
            SaveKidsHistoryEventEntity(
                title = "Login realizado",
                details = "${profile.childName} entrou no Save Kids.",
                type = HistoryEventType.LOGIN,
                amount = 0.0,
                xpDelta = 0,
                createdAt = System.currentTimeMillis(),
            )
        )
        Result.success(Unit)
    }

    override suspend fun updateProfile(name: String, avatarPokemonId: Int): Result<Unit> = withContext(Dispatchers.IO) {
        val profile = validateProfile(name, avatarPokemonId).getOrElse { error ->
            return@withContext Result.failure(error)
        }
        saveProfile(profile)
        Result.success(Unit)
    }

    private suspend fun saveProfile(profile: SaveKidsProfile) {
        profileDao.upsert(
            SaveKidsProfileEntity(
                id = 1,
                childName = profile.childName,
                avatarPokemonId = profile.avatarPokemonId,
                avatarTeamName = profile.avatarTeamName,
            )
        )
        sessionDataStore.saveProfile(
            profile.childName,
            profile.avatarPokemonId,
            profile.avatarTeamName,
        )
    }

    private fun validateProfile(name: String, avatarPokemonId: Int): Result<SaveKidsProfile> {
        val cleanName = name.trim()
        if (cleanName.length !in 3..30) {
            return Result.failure(IllegalArgumentException("Informe um nome v\u00e1lido entre 3 e 30 caracteres."))
        }
        val avatarOption = StarterAvatarOptions.firstOrNull { it.pokemonId == avatarPokemonId }
            ?: return Result.failure(IllegalArgumentException("Selecione um avatar."))
        return Result.success(
            SaveKidsProfile(
                childName = cleanName,
                avatarPokemonId = avatarPokemonId,
                avatarTeamName = avatarOption.teamName,
            )
        )
    }

    override suspend fun addDeposit(amount: Double): Result<Unit> = withContext(Dispatchers.IO) {
        if (amount <= 0.0 || amount > 10000.0) {
            return@withContext Result.failure(IllegalArgumentException("O valor deve ser maior que zero e até R$ 10.000."))
        }

        val wallet = walletDao.getWallet() ?: return@withContext Result.failure(IllegalStateException("Carteira não inicializada."))
        val gainedXp = amount.toInt() * GamificationRules.XP_PER_REAL
        val beforeLevel = wallet.level
        var levelUp = false

        val updatedWallet = wallet.copy(
            balance = wallet.balance + amount,
            xp = wallet.xp + gainedXp,
            updatedAt = System.currentTimeMillis(),
        )
        val levelInfo = GamificationRules.levelForXp(updatedWallet.xp)
        val finalWallet = updatedWallet.copy(level = levelInfo.level)
        if (finalWallet.level > beforeLevel) levelUp = true
        walletDao.upsert(finalWallet)

        historyDao.insert(
            SaveKidsHistoryEventEntity(
                title = "Economia adicionada",
                details = "Depósito no cofrinho.",
                type = HistoryEventType.DEPOSIT_ADDED,
                amount = amount,
                xpDelta = gainedXp,
                createdAt = System.currentTimeMillis(),
            )
        )

        applyContributionToActiveGoal(amount)

        if (levelUp) {
            historyDao.insert(
                SaveKidsHistoryEventEntity(
                    title = "Evolução de nível",
                    details = "Novo nível desbloqueado no Save Kids.",
                    type = HistoryEventType.LEVEL_UP,
                    amount = 0.0,
                    xpDelta = 0,
                    createdAt = System.currentTimeMillis(),
                )
            )
        }

        Result.success(Unit)
    }

    override suspend fun createGoal(name: String, targetAmount: Double): Result<Unit> = withContext(Dispatchers.IO) {
        val cleanName = name.trim()
        if (cleanName.isBlank()) {
            return@withContext Result.failure(IllegalArgumentException("A meta precisa de um nome."))
        }
        if (targetAmount <= 0.0) {
            return@withContext Result.failure(IllegalArgumentException("O valor da meta deve ser maior que zero."))
        }

        goalDao.insert(
            SaveKidsGoalEntity(
                name = cleanName,
                targetAmount = targetAmount,
                currentAmount = 0.0,
                completed = false,
            )
        )

        val wallet = walletDao.getWallet() ?: return@withContext Result.failure(IllegalStateException("Carteira não inicializada."))
        val xpAfter = wallet.xp + GamificationRules.XP_CREATE_GOAL
        val level = GamificationRules.levelForXp(xpAfter)
        walletDao.upsert(wallet.copy(xp = xpAfter, level = level.level, updatedAt = System.currentTimeMillis()))

        historyDao.insert(
            SaveKidsHistoryEventEntity(
                title = "Meta criada",
                details = "Nova meta: $cleanName",
                type = HistoryEventType.GOAL_CREATED,
                amount = targetAmount,
                xpDelta = GamificationRules.XP_CREATE_GOAL,
                createdAt = System.currentTimeMillis(),
            )
        )

        Result.success(Unit)
    }

    override suspend fun completeMission(id: Long): Result<Unit> = withContext(Dispatchers.IO) {
        val mission = missionDao.findById(id) ?: return@withContext Result.failure(IllegalArgumentException("Missão não encontrada."))
        if (mission.status == MissionStatus.COMPLETED) {
            return@withContext Result.failure(IllegalStateException("Missão já concluída."))
        }

        // A carteira e validada antes de marcar a missao como concluida:
        // do contrario a missao seria consumida sem pagar a recompensa.
        val wallet = walletDao.getWallet() ?: return@withContext Result.failure(IllegalStateException("Carteira não inicializada."))
        missionDao.update(mission.copy(status = MissionStatus.COMPLETED))
        val xpAfter = wallet.xp + mission.rewardXp
        val level = GamificationRules.levelForXp(xpAfter)
        walletDao.upsert(
            wallet.copy(
                balance = wallet.balance + mission.rewardMoney,
                xp = xpAfter,
                level = level.level,
                updatedAt = System.currentTimeMillis(),
            )
        )

        historyDao.insert(
            SaveKidsHistoryEventEntity(
                title = "Missão concluída",
                details = mission.title,
                type = HistoryEventType.MISSION_COMPLETED,
                amount = mission.rewardMoney,
                xpDelta = mission.rewardXp,
                createdAt = System.currentTimeMillis(),
            )
        )

        if (mission.rewardMoney > 0) {
            applyContributionToActiveGoal(mission.rewardMoney)
        }

        Result.success(Unit)
    }

    override suspend fun redeemReward(id: Long): Result<Unit> = withContext(Dispatchers.IO) {
        val reward = rewardDao.findById(id) ?: return@withContext Result.failure(IllegalArgumentException("Recompensa não encontrada."))
        if (!reward.active) return@withContext Result.failure(IllegalStateException("Recompensa inativa."))
        if (reward.redeemed) return@withContext Result.failure(IllegalStateException("Recompensa já resgatada."))

        val wallet = walletDao.getWallet() ?: return@withContext Result.failure(IllegalStateException("Carteira não inicializada."))
        if (wallet.xp < reward.requiredXp) {
            return@withContext Result.failure(IllegalStateException("XP insuficiente para resgatar."))
        }
        if (wallet.xp < rewardRedemptionCostXp) {
            return@withContext Result.failure(IllegalStateException("XP insuficiente para concluir o resgate."))
        }

        rewardDao.update(reward.copy(redeemed = true))
        val xpAfter = wallet.xp - rewardRedemptionCostXp
        val level = GamificationRules.levelForXp(xpAfter)
        walletDao.upsert(wallet.copy(xp = xpAfter, level = level.level, updatedAt = System.currentTimeMillis()))

        historyDao.insert(
            SaveKidsHistoryEventEntity(
                title = "Recompensa resgatada",
                details = reward.title,
                type = HistoryEventType.REWARD_REDEEMED,
                amount = 0.0,
                xpDelta = -rewardRedemptionCostXp,
                createdAt = System.currentTimeMillis(),
            )
        )

        Result.success(Unit)
    }

    override suspend fun refreshAvatar(): Result<PokemonAvatarModel> = withContext(Dispatchers.IO) {
        val profileEntity = profileDao.observeProfile().first()
            ?: return@withContext Result.failure(IllegalStateException("Perfil ainda não foi criado."))
        val wallet = walletDao.getWallet() ?: SaveKidsWalletEntity(1, 0.0, 0, 1, System.currentTimeMillis())

        val avatar = runCatching {
            val basePokemon = pokeApiService.getPokemon(profileEntity.avatarPokemonId)
            val species = pokeApiService.getPokemonSpecies(profileEntity.avatarPokemonId)
            val evolutionChain = pokeApiService.getEvolutionChainByUrl(species.evolution_chain.url)
            val chainNames = flattenEvolution(evolutionChain.chain).ifEmpty { listOf(basePokemon.name) }

            val stage = when {
                wallet.xp >= 500 -> 2
                wallet.xp >= 100 -> 1
                else -> 0
            }.coerceAtMost(chainNames.lastIndex)

            val evolvedName = chainNames[stage]
            val evolvedPokemon = runCatching { pokeApiService.getPokemonByName(evolvedName) }.getOrNull()
            val stagePokemon = evolvedPokemon ?: basePokemon

            PokemonAvatarModel(
                basePokemonId = profileEntity.avatarPokemonId,
                teamName = profileEntity.avatarTeamName,
                currentStageName = evolvedName.replaceFirstChar { it.uppercase() },
                spriteUrl = resolveSpriteUrl(stagePokemon),
                typeLabel = basePokemon.types.firstOrNull()?.type?.name?.replaceFirstChar { it.uppercase() } ?: "Desconhecido",
                evolutionNames = chainNames.map { it.replaceFirstChar { c -> c.uppercase() } },
                currentXp = wallet.xp,
                nextLevelXp = GamificationRules.nextLevelXp(wallet.xp),
            )
        }.getOrElse {
            // Fallback resiliente: mantém o fluxo funcional mesmo sem rede/API.
            PokemonAvatarModel(
                basePokemonId = profileEntity.avatarPokemonId,
                teamName = profileEntity.avatarTeamName,
                currentStageName = profileEntity.avatarTeamName,
                spriteUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${profileEntity.avatarPokemonId}.png",
                typeLabel = "Offline",
                evolutionNames = listOf(profileEntity.avatarTeamName),
                currentXp = wallet.xp,
                nextLevelXp = GamificationRules.nextLevelXp(wallet.xp),
            )
        }

        Result.success(avatar)
    }

    override suspend fun withdrawMoney(amount: Double): Result<Unit> = withContext(Dispatchers.IO) {
        if (amount <= 0.0) {
            return@withContext Result.failure(IllegalArgumentException("O valor do saque deve ser maior que zero."))
        }

        val wallet = walletDao.getWallet() ?: return@withContext Result.failure(IllegalStateException("Carteira não inicializada."))
        if (wallet.balance < amount) {
            return@withContext Result.failure(IllegalStateException("Saldo insuficiente no cofrinho."))
        }

        val lostXp = amount.toInt() * GamificationRules.XP_LOSS_PER_REAL_WITHDRAWN
        val updatedWallet = wallet.copy(
            balance = wallet.balance - amount,
            xp = maxOf(0, wallet.xp - lostXp),
            updatedAt = System.currentTimeMillis()
        )
        val levelInfo = GamificationRules.levelForXp(updatedWallet.xp)
        walletDao.upsert(updatedWallet.copy(level = levelInfo.level))

        historyDao.insert(
            SaveKidsHistoryEventEntity(
                title = "Saque realizado",
                details = "Dinheiro retirado do cofrinho.",
                type = HistoryEventType.GOAL_UPDATED, // Reusing existing type or could add WITHDRAWAL
                amount = -amount,
                xpDelta = -lostXp,
                createdAt = System.currentTimeMillis(),
            )
        )

        // Reduzir progresso da meta ativa se houver
        val firstOpenGoal = goalDao.observeGoals().first().firstOrNull { !it.completed }
        if (firstOpenGoal != null) {
            val nextAmount = maxOf(0.0, firstOpenGoal.currentAmount - amount)
            goalDao.update(firstOpenGoal.copy(currentAmount = nextAmount))
            historyDao.insert(
                SaveKidsHistoryEventEntity(
                    title = "Meta atualizada",
                    details = "Saque afetou o progresso da meta ${firstOpenGoal.name}.",
                    type = HistoryEventType.GOAL_UPDATED,
                    amount = -amount,
                    xpDelta = 0,
                    createdAt = System.currentTimeMillis(),
                )
            )
        }

        Result.success(Unit)
    }

    private fun resolveSpriteUrl(pokemon: PokemonDto): String {
        return pokemon.sprites.other?.officialArtwork?.front_default
            ?: pokemon.sprites.front_default
            ?: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png"
    }

    private suspend fun applyContributionToActiveGoal(amount: Double) {
        if (amount <= 0) return
        val firstOpenGoal = goalDao.observeGoals().first().firstOrNull { !it.completed } ?: return

        val nextAmount = firstOpenGoal.currentAmount + amount
        val completed = nextAmount >= firstOpenGoal.targetAmount
        val updatedGoal = firstOpenGoal.copy(
            currentAmount = minOf(nextAmount, firstOpenGoal.targetAmount),
            completed = completed,
        )
        goalDao.update(updatedGoal)

        historyDao.insert(
            SaveKidsHistoryEventEntity(
                title = "Meta atualizada",
                details = "Progresso da meta ${updatedGoal.name} atualizado.",
                type = HistoryEventType.GOAL_UPDATED,
                amount = amount,
                xpDelta = 0,
                createdAt = System.currentTimeMillis(),
            )
        )

        if (completed && !firstOpenGoal.completed) {
            val wallet = walletDao.getWallet()
            if (wallet != null) {
                val xpAfterBonus = wallet.xp + GamificationRules.XP_COMPLETE_GOAL
                val levelInfo = GamificationRules.levelForXp(xpAfterBonus)
                walletDao.upsert(
                    wallet.copy(
                        xp = xpAfterBonus,
                        level = levelInfo.level,
                        updatedAt = System.currentTimeMillis(),
                    )
                )
                historyDao.insert(
                    SaveKidsHistoryEventEntity(
                        title = "Meta concluída",
                        details = "Parabéns! A meta ${updatedGoal.name} foi concluída.",
                        type = HistoryEventType.GOAL_COMPLETED,
                        amount = 0.0,
                        xpDelta = GamificationRules.XP_COMPLETE_GOAL,
                        createdAt = System.currentTimeMillis(),
                    )
                )
            }
        }
    }

    private fun flattenEvolution(node: EvolutionNodeDto): List<String> {
        val result = mutableListOf(node.species.name)
        var current = node.evolves_to.firstOrNull()
        while (current != null) {
            result += current.species.name
            current = current.evolves_to.firstOrNull()
        }
        return result
    }
}
