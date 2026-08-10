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
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakMiniBadge
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakSectionCard
import com.zodiak.android.design_system.organisms.ZodiakStatTile
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.navigation.SaveKidsGoalsRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsTabs
import com.zodiak.android.feature.savekids.utils.toMoneyLabel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsGoalsViewModel

@Composable
fun SaveKidsGoalsScreen(
    onBack: () -> Unit,
    onNavigate: (Any) -> Unit,
    viewModel: SaveKidsGoalsViewModel = hiltViewModel(),
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
                SaveKidsTabs(saveKidsTabs, SaveKidsGoalsRoute, onNavigate)
            }

            item {
                ZodiakSectionCard(
                    title = "Criar meta",
                    subtitle = "Defina um objetivo e acompanhe o progresso no cofrinho.",
                ) {
                    ZodiakInputField(
                        value = state.goalName,
                        onValueChange = viewModel::onGoalNameChange,
                        label = "Nome da meta",
                    )
                    Spacer(Modifier.height(ZodiakSpacing.s8))
                    ZodiakInputField(
                        value = state.targetAmount,
                        onValueChange = viewModel::onTargetAmountChange,
                        label = "Valor alvo",
                        keyboardType = KeyboardType.Decimal,
                    )
                    Spacer(Modifier.height(12.dp))
                    ZodiakButton("Salvar meta", viewModel::createGoal, Modifier.fillMaxWidth())
                }
            }

            item {
                Text("Metas cadastradas", style = MaterialTheme.typography.titleMedium)
            }

            if (state.goals.isEmpty()) {
                item {
                    ZodiakEmptyState(
                        title = "Sem metas",
                        message = "Crie a primeira meta para começar o planejamento.",
                    )
                }
            } else {
                items(state.goals) { goal ->
                    ZodiakSectionCard(
                        title = goal.name,
                        subtitle = if (goal.completed) "Meta concluída" else "Meta em andamento",
                    ) {
                        Row(horizontalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8)) {
                            ZodiakMiniBadge(
                                if (goal.completed) "Concluída" else "Em andamento",
                                if (goal.completed) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.tertiary,
                            )
                        }
                        Text(
                            "${goal.currentAmount.toMoneyLabel()} de ${goal.targetAmount.toMoneyLabel()}",
                            style = MaterialTheme.typography.titleLarge,
                        )
                        val remaining = (goal.targetAmount - goal.currentAmount).coerceAtLeast(0.0)
                        Text(
                            "Faltam ${remaining.toMoneyLabel()} para completar esta meta.",
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant,
                        )
                        Row(horizontalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8), modifier = Modifier.fillMaxWidth()) {
                            ZodiakStatTile(
                                title = "Guardado",
                                value = goal.currentAmount.toMoneyLabel(),
                                subtitle = "Atual",
                                tint = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.weight(1f),
                            )
                            ZodiakStatTile(
                                title = "Meta",
                                value = goal.targetAmount.toMoneyLabel(),
                                subtitle = "Objetivo",
                                tint = MaterialTheme.colorScheme.tertiary,
                                modifier = Modifier.weight(1f),
                            )
                        }
                    }
                }
            }

            state.successMessage?.let { msg ->
                item { Text(msg, color = MaterialTheme.colorScheme.primary) }
            }
            state.errorMessage?.let { err ->
                item { Text(err, color = MaterialTheme.colorScheme.error) }
            }
            if (state.isLoading) {
                item { Text("Carregando metas...") }
            }
        }
    }
}
