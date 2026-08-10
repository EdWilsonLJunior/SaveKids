package com.zodiak.android.feature.savekids.model

enum class MissionStatus {
    AVAILABLE,
    IN_PROGRESS,
    COMPLETED,
}

enum class HistoryEventType {
    LOGIN,
    GOAL_CREATED,
    GOAL_UPDATED,
    GOAL_COMPLETED,
    DEPOSIT_ADDED,
    MISSION_STARTED,
    MISSION_COMPLETED,
    REWARD_REDEEMED,
    LEVEL_UP,
}

data class SaveKidsSession(
    val authenticated: Boolean = false,
    val profileCompleted: Boolean = false,
)

data class SaveKidsProfile(
    val childName: String,
    val avatarPokemonId: Int,
    val avatarTeamName: String,
)

data class GoalModel(
    val id: Long,
    val name: String,
    val targetAmount: Double,
    val currentAmount: Double,
    val completed: Boolean,
)

data class MissionModel(
    val id: Long,
    val title: String,
    val description: String,
    val rewardXp: Int,
    val rewardMoney: Double,
    val status: MissionStatus,
)

data class RewardModel(
    val id: Long,
    val title: String,
    val description: String,
    val requiredXp: Int,
    val active: Boolean,
    val redeemed: Boolean,
)

data class HistoryEventModel(
    val id: Long,
    val title: String,
    val details: String,
    val type: HistoryEventType,
    val amount: Double,
    val xpDelta: Int,
    val createdAt: Long,
)

data class FamilyMemberModel(
    val id: Long,
    val name: String,
    val role: String,
    val savings: Double,
    val xp: Int,
    val streakDays: Int,
    val highlighted: Boolean,
)

data class DashboardModel(
    val balance: Double,
    val xp: Int,
    val level: Int,
    val levelTitle: String,
    val topGoals: List<GoalModel>,
    val completedMissions: Int,
    val totalMissions: Int,
    val redeemedRewards: Int,
    val totalRewards: Int,
)

data class PokemonAvatarModel(
    val basePokemonId: Int,
    val teamName: String,
    val currentStageName: String,
    val spriteUrl: String,
    val typeLabel: String,
    val evolutionNames: List<String>,
    val currentXp: Int,
    val nextLevelXp: Int,
)

data class StarterAvatarOption(
    val pokemonId: Int,
    val teamName: String,
    val description: String,
)

val StarterAvatarOptions = listOf(
    StarterAvatarOption(1, "Time Bulbasaur", "Calmo, consistente e ótimo para quem gosta de crescer aos poucos."),
    StarterAvatarOption(4, "Time Charmander", "Cheio de energia e perfeito para missões com muita ação."),
    StarterAvatarOption(7, "Time Squirtle", "Estratégico, curioso e ótimo para metas de longo prazo."),
    StarterAvatarOption(25, "Time Pikachu", "Rápido e divertido, sempre pronto para novas conquistas."),
)

data class LevelInfo(
    val level: Int,
    val title: String,
    val requiredXp: Int,
)

val SaveKidsLevels = listOf(
    LevelInfo(level = 1, title = "Iniciante", requiredXp = 0),
    LevelInfo(level = 2, title = "Aprendiz Econômico", requiredXp = 100),
    LevelInfo(level = 3, title = "Guardião do Cofrinho", requiredXp = 250),
    LevelInfo(level = 4, title = "Mestre das Economias", requiredXp = 500),
    LevelInfo(level = 5, title = "Rei da Poupança", requiredXp = 1000),
)
