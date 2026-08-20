package com.zodiak.android.feature.savekids.view

import androidx.compose.foundation.layout.Arrangement
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
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakMiniBadge
import com.zodiak.android.design_system.organisms.ZodiakSectionCard
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.navigation.SaveKidsAvatarRankingRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsTabs
import com.zodiak.android.feature.savekids.utils.toMoneyLabel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsAvatarRankingViewModel

@Composable
fun SaveKidsAvatarRankingScreen(
    onBack: () -> Unit,
    onNavigate: (Any) -> Unit,
    viewModel: SaveKidsAvatarRankingViewModel = hiltViewModel(),
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

            item { SaveKidsTabs(saveKidsTabs, SaveKidsAvatarRankingRoute, onNavigate) }

//            item {
//                ZodiakSectionCard(
//                    title = "Avatar atual",
//                    subtitle = "Pokémon evolui conforme o XP cresce.",
//                ) {
//                    val avatar = state.avatar
//                    if (avatar == null) {
//                        Text("Avatar indisponível.")
//                    } else {
//                        Row(horizontalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8)) {
//                            ZodiakMiniBadge(avatar.teamName, MaterialTheme.colorScheme.primary)
//                            ZodiakMiniBadge("${avatar.currentXp}/${avatar.nextLevelXp} XP", MaterialTheme.colorScheme.tertiary)
//                        }
//                        Text(avatar.currentStageName, style = MaterialTheme.typography.headlineSmall)
//                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
//                            SaveKidsPokemonAvatar(
//                                imageUrl = avatar.spriteUrl,
//                                contentDescription = avatar.currentStageName,
//                                size = 128.dp,
//                            )
//                        }
//                        Text("Tipo: ${avatar.typeLabel}")
//                        Text("Linha de evolução: ${avatar.evolutionNames.joinToString(" → ")}")
//                        ZodiakButton(
//                            text = "Atualizar Pokémon",
//                            onClick = viewModel::refreshAvatar,
//                            modifier = Modifier.fillMaxWidth(),
//                        )
//                    }
//                }
//            }

            item {
                Text("Ranking da família", style = MaterialTheme.typography.titleMedium)
            }

            if (state.family.isEmpty() && !state.isLoading) {
                item {
                    ZodiakEmptyState(
                        title = "Sem participantes",
                        message = "Adicione familiares para acompanhar o ranking.",
                    )
                }
            } else {
                items(state.family) { member ->
                    ZodiakSectionCard(
                        title = member.name,
                        subtitle = "${member.role} • sequência de ${member.streakDays} dias",
                    ) {
                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                            Text(member.savings.toMoneyLabel(), style = MaterialTheme.typography.titleMedium)
                            Text("${member.xp} XP", color = MaterialTheme.colorScheme.primary)
                        }
                        if (member.highlighted) {
                            ZodiakMiniBadge("Você", MaterialTheme.colorScheme.primary)
                        }
                    }
                }
            }

            state.errorMessage?.let { msg ->
                item { Text(msg, color = MaterialTheme.colorScheme.error) }
            }
            if (state.isLoading) {
                item { Text("Carregando avatar e ranking...") }
            }
        }
    }
}
