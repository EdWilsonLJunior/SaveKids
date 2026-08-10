package com.zodiak.android.feature.savekids.view

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.organisms.ZodiakHeroCard
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakLineChartPlaceholder
import com.zodiak.android.design_system.organisms.ZodiakSectionCard
import com.zodiak.android.design_system.organisms.ZodiakStatTile
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.navigation.SaveKidsAvatarRankingRoute
import com.zodiak.android.feature.savekids.navigation.SaveKidsHomeRoute
import com.zodiak.android.feature.savekids.navigation.SaveKidsHistoryRoute
import com.zodiak.android.feature.savekids.navigation.SaveKidsPiggyBankRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsTabs
import com.zodiak.android.feature.savekids.utils.toMoneyLabel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsHomeViewModel

@Composable
fun SaveKidsHomeScreen(
    onBack: () -> Unit,
    onNavigate: (Any) -> Unit,
    viewModel: SaveKidsHomeViewModel = hiltViewModel(),
) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = ZodiakSpacing.screenPad),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = ZodiakSpacing.screenPad),
        ) {
            item { SaveKidsBackButton(onBack) }

            item {
                val childName = state.profile?.childName ?: "Luna"
                Text(
                    "Save Kids",
                    style = MaterialTheme.typography.labelLarge,
                    color = MaterialTheme.colorScheme.primary,
                )
                Text(
                    "Educação financeira com evolução de Pokémon por XP.",
                    style = MaterialTheme.typography.titleMedium,
                )
                Spacer(Modifier.height(ZodiakSpacing.s8))

                val dashboard = state.dashboard
                if (dashboard != null) {
                    val avatarDisplayName = (state.profile?.avatarTeamName ?: "Pikachu")
                        .removePrefix("Time ")
                    ZodiakHeroCard(
                        title = "$childName, seu avatar evolui junto com suas economias.",
                        subtitle = "Guarde dinheiro, complete missões e ganhe XP para evoluir seu Pokémon.",
                        phaseLabel = dashboard.levelTitle,
                        avatarName = avatarDisplayName,
                        avatarMeta = "${dashboard.xp} XP",
                        actionLabel = "Editar",
                        onActionClick = { onNavigate(SaveKidsAvatarRankingRoute) },
                        avatarVisual = {
                            SaveKidsPokemonAvatar(
                                imageUrl = state.avatar?.spriteUrl,
                                contentDescription = state.avatar?.currentStageName ?: "Avatar atual",
                                size = 72.dp,
                            )
                        },
                    )
                }
            }

            if (state.isLoading) {
                item { Text("Carregando dashboard...") }
            }

            val dashboard = state.dashboard
            if (dashboard != null) {
                item {
                    Row(horizontalArrangement = Arrangement.spacedBy(10.dp), modifier = Modifier.fillMaxWidth()) {
                        ZodiakStatTile(
                            title = "No cofrinho",
                            value = dashboard.balance.toMoneyLabel(),
                            subtitle = "Saldo atual",
                            tint = MaterialTheme.colorScheme.primary,
                            modifier = Modifier.weight(1f),
                        )
                        ZodiakStatTile(
                            title = "XP acumulado",
                            value = "${dashboard.xp} XP",
                            subtitle = dashboard.levelTitle,
                            tint = MaterialTheme.colorScheme.tertiary,
                            modifier = Modifier.weight(1f),
                        )
                    }
                }
                item {
                    Row(horizontalArrangement = Arrangement.spacedBy(10.dp), modifier = Modifier.fillMaxWidth()) {
                        ZodiakStatTile(
                            title = "Missões feitas",
                            value = "${dashboard.completedMissions}/${dashboard.totalMissions}",
                            subtitle = "Rotina de consistência",
                            tint = MaterialTheme.colorScheme.primary,
                            modifier = Modifier.weight(1f),
                        )
                        ZodiakStatTile(
                            title = "Recompensas",
                            value = "${dashboard.redeemedRewards}/${dashboard.totalRewards}",
                            subtitle = "Prêmios liberados",
                            tint = MaterialTheme.colorScheme.primary,
                            modifier = Modifier.weight(1f),
                        )
                    }
                }
                item { SaveKidsTabs(saveKidsTabs, SaveKidsHomeRoute, onNavigate) }

                if (dashboard.topGoals.isEmpty()) {
                    item {
                        ZodiakSectionCard(
                            title = "Sem metas ainda",
                            subtitle = "Crie sua primeira meta para ver progresso nesta área.",
                        ) {
                            Text(
                                "Use o menu de metas para adicionar um objetivo.",
                                style = MaterialTheme.typography.bodySmall,
                                color = MaterialTheme.colorScheme.onSurfaceVariant,
                            )
                        }
                    }
                } else {
                    items(dashboard.topGoals) { goal ->
                        ZodiakSectionCard(
                            title = "Meta do cofrinho",
                            subtitle = goal.name,
                        ) {
                            Text(
                                "${goal.currentAmount.toMoneyLabel()} de ${goal.targetAmount.toMoneyLabel()}",
                                style = MaterialTheme.typography.titleLarge,
                            )
                            ZodiakButton(
                                text = "Abrir cofrinho",
                                onClick = { onNavigate(SaveKidsPiggyBankRoute) },
                                modifier = Modifier.fillMaxWidth(),
                            )
                        }
                    }
                }

                item {
                    ZodiakSectionCard(
                        title = "Economia da semana",
                        subtitle = "Acompanhe quanto entrou no cofrinho nos últimos dias.",
                    ) {
                        ZodiakLineChartPlaceholder()
                    }
                }

                item {
                    ZodiakSectionCard(
                        title = "Últimos movimentos",
                        subtitle = "Tudo o que entrou no cofrinho e no progresso do avatar.",
                    ) {
                        if (state.recentEvents.isEmpty()) {
                            Text(
                                "Nenhum movimento ainda.",
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant,
                            )
                        } else {
                            Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                                state.recentEvents.forEach { event ->
                                    Column(
                                        modifier = Modifier
                                            .fillMaxWidth()
                                                .padding(vertical = ZodiakSpacing.s4),
                                    ) {
                                        Text(event.title, style = MaterialTheme.typography.titleSmall)
                                        Text(
                                            event.details,
                                            style = MaterialTheme.typography.bodySmall,
                                            color = MaterialTheme.colorScheme.onSurfaceVariant,
                                        )
                                    }
                                }
                            }
                        }
                    }
                }

                item {
                    ZodiakButton(
                        text = "Ver histórico completo",
                        onClick = { onNavigate(SaveKidsHistoryRoute) },
                        modifier = Modifier.fillMaxWidth(),
                    )
                }
            }

            state.errorMessage?.let { error ->
                item {
                    Text(error, color = MaterialTheme.colorScheme.error)
                }
            }
        }
    }
}
