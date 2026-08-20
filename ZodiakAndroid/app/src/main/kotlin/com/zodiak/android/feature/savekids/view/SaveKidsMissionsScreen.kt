package com.zodiak.android.feature.savekids.view

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.AlertDialog
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.atoms.ZodiakOutlinedButton
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakMiniBadge
import com.zodiak.android.design_system.organisms.ZodiakSectionCard
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.model.MissionStatus
import com.zodiak.android.feature.savekids.navigation.SaveKidsMissionsRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsTabs
import com.zodiak.android.feature.savekids.utils.toMoneyLabel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsMissionsViewModel

@Composable
fun SaveKidsMissionsScreen(
    onBack: () -> Unit,
    onNavigate: (Any) -> Unit,
    viewModel: SaveKidsMissionsViewModel = hiltViewModel(),
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

            item { SaveKidsTabs(saveKidsTabs, SaveKidsMissionsRoute, onNavigate) }

            if (state.missions.isEmpty() && !state.isLoading) {
                item {
                    ZodiakEmptyState(
                        title = "Sem missões",
                        message = "Novas missões aparecerão em breve.",
                    )
                }
            } else {
                items(state.missions) { mission ->
                    val statusLabel = when (mission.status) {
                        MissionStatus.AVAILABLE -> "Disponível"
                        MissionStatus.IN_PROGRESS -> "Em andamento"
                        MissionStatus.COMPLETED -> "Concluída"
                    }
                    ZodiakSectionCard(
                        title = mission.title,
                        subtitle = mission.description,
                    ) {
                        Row(horizontalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8)) {
                            ZodiakMiniBadge(statusLabel, MaterialTheme.colorScheme.primary)
                            ZodiakMiniBadge(
                                if (mission.rewardXp >= 50) "Especial" else "Fácil",
                                Color(0xFF165904),
                            )
                        }
                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                            Text("+${mission.rewardXp} XP", color = MaterialTheme.colorScheme.primary)
                            Text("+${mission.rewardMoney.toMoneyLabel()}", color = MaterialTheme.colorScheme.primary)
                        }
                        if (mission.status == MissionStatus.COMPLETED) {
                            Text("Missão concluída", color = MaterialTheme.colorScheme.primary)
                        } else {
                            ZodiakButton(
                                text = "Concluir missão",
                                onClick = { viewModel.completeMission(mission.id) },
                                modifier = Modifier.fillMaxWidth(),
                            )
                        }
                    }
                }
            }

            state.successMessage?.let { msg -> item { Text(msg, color = MaterialTheme.colorScheme.primary) } }
            state.errorMessage?.let { err -> item { Text(err, color = MaterialTheme.colorScheme.error) } }
            if (state.isLoading) {
                item { Text("Carregando missões...") }
            }
        }
    }

    if (state.isGoalSelectionOpen) {
        MissionGoalSelectionModal(
            goals = state.goals,
            onGoalSelected = viewModel::confirmGoalSelection,
            onDismiss = viewModel::dismissGoalSelection
        )
    }
}

@Composable
fun MissionGoalSelectionModal(
    goals: List<com.zodiak.android.feature.savekids.model.GoalModel>,
    onGoalSelected: (Long) -> Unit,
    onDismiss: () -> Unit,
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Escolha o destino da recompensa", style = MaterialTheme.typography.titleLarge) },
        text = {
            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text(
                    "Esta missão tem recompensa em dinheiro! Para qual meta você quer enviar?",
                    style = MaterialTheme.typography.bodyMedium
                )
                val openGoals = goals.filter { !it.completed }
                if (openGoals.isEmpty()) {
                    Text("Nenhuma meta aberta encontrada. O dinheiro irá para o saldo geral.", color = MaterialTheme.colorScheme.error)
                } else {
                    openGoals.forEach { goal ->
                        ZodiakOutlinedButton(
                            text = goal.name,
                            onClick = { onGoalSelected(goal.id) },
                            modifier = Modifier.fillMaxWidth()
                        )
                    }
                }
            }
        },
        confirmButton = {},
        dismissButton = {
            ZodiakOutlinedButton(text = "Cancelar", onClick = onDismiss)
        }
    )
}
