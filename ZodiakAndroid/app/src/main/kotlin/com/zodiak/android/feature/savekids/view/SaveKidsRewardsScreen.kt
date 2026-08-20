package com.zodiak.android.feature.savekids.view

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakMiniBadge
import com.zodiak.android.design_system.organisms.ZodiakSectionCard
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.navigation.SaveKidsRewardsRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsTabs
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsRewardsViewModel

@Composable
fun SaveKidsRewardsScreen(
    onBack: () -> Unit,
    onNavigate: (Any) -> Unit,
    viewModel: SaveKidsRewardsViewModel = hiltViewModel(),
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

            item { SaveKidsTabs(saveKidsTabs, SaveKidsRewardsRoute, onNavigate) }
            item {
                Text(
                    "XP atual: ${state.currentXp}",
                    style = MaterialTheme.typography.titleMedium,
                )
            }

            if (state.rewards.isEmpty() && !state.isLoading) {
                item {
                    ZodiakEmptyState(title = "Sem recompensas", message = "Nenhuma recompensa disponível no momento.")
                }
            } else {
                items(state.rewards) { reward ->
                    ZodiakSectionCard(
                        title = reward.title,
                        subtitle = reward.description,
                    ) {
                        Row(horizontalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8)) {
                            ZodiakMiniBadge("Desbloqueia com ${reward.requiredXp} XP", MaterialTheme.colorScheme.primary)
                            ZodiakMiniBadge(if (reward.requiredXp >= 150) "Troféu" else "Selo", Color(0xFF165904))
                        }
                        when {
                            reward.redeemed -> Text("Recompensa coletada", color = MaterialTheme.colorScheme.primary)
                            state.currentXp < reward.requiredXp -> Text("Continue evoluindo", color = MaterialTheme.colorScheme.onSurfaceVariant)
                            else -> ZodiakButton(
                                text = "Coletar recompensa",
                                onClick = { viewModel.redeemReward(reward.id) },
                                modifier = Modifier.fillMaxWidth(),
                            )
                        }
                    }
                }
            }

            state.successMessage?.let { msg -> item { Text(msg, color = MaterialTheme.colorScheme.primary) } }
            state.errorMessage?.let { err -> item { Text(err, color = MaterialTheme.colorScheme.error) } }
            if (state.isLoading) {
                item { Text("Carregando recompensas...") }
            }
        }
    }
}
