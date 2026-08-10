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
import com.zodiak.android.design_system.organisms.ZodiakSectionCard
import com.zodiak.android.design_system.organisms.ZodiakStatTile
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.navigation.SaveKidsPiggyBankRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsTabs
import com.zodiak.android.feature.savekids.utils.toMoneyLabel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsPiggyBankViewModel

@Composable
fun SaveKidsPiggyBankScreen(
    onBack: () -> Unit,
    onNavigate: (Any) -> Unit,
    viewModel: SaveKidsPiggyBankViewModel = hiltViewModel(),
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
                SaveKidsTabs(saveKidsTabs, SaveKidsPiggyBankRoute, onNavigate)
            }

            item {
                val dashboard = state.dashboard
                val balance = dashboard?.balance ?: 0.0
                val xp = dashboard?.xp ?: 0
                Row(horizontalArrangement = Arrangement.spacedBy(10.dp), modifier = Modifier.fillMaxWidth()) {
                    ZodiakStatTile(
                        title = "No cofrinho",
                        value = balance.toMoneyLabel(),
                        subtitle = "Saldo atual",
                        tint = MaterialTheme.colorScheme.primary,
                        modifier = Modifier.weight(1f),
                    )
                    ZodiakStatTile(
                        title = "XP",
                        value = "$xp XP",
                        subtitle = dashboard?.levelTitle ?: "Iniciante",
                        tint = MaterialTheme.colorScheme.tertiary,
                        modifier = Modifier.weight(1f),
                    )
                }
            }

            item {
                ZodiakSectionCard(
                    title = "Depósito personalizado",
                    subtitle = "Simule novos depósitos para acelerar a evolução do Pokémon.",
                ) {
                    ZodiakInputField(
                        value = state.amountText,
                        onValueChange = viewModel::onAmountChange,
                        label = "Quanto quer guardar hoje?",
                        keyboardType = KeyboardType.Decimal,
                    )
                    Spacer(Modifier.height(12.dp))
                    ZodiakButton(
                        text = "Guardar valor e ganhar XP",
                        onClick = viewModel::submitDeposit,
                        modifier = Modifier.fillMaxWidth(),
                    )
                    Spacer(Modifier.height(12.dp))
                    Text(
                        "Ações rápidas",
                        style = MaterialTheme.typography.labelLarge,
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                    )
                    Row(horizontalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8), modifier = Modifier.fillMaxWidth()) {
                        ZodiakButton("Guardar R$ 5", { viewModel.applyQuickAmount(5) }, Modifier.weight(1f))
                        ZodiakButton("Guardar R$ 10", { viewModel.applyQuickAmount(10) }, Modifier.weight(1f))
                        ZodiakButton("Guardar R$ 20", { viewModel.applyQuickAmount(20) }, Modifier.weight(1f))
                    }
                    Spacer(Modifier.height(6.dp))
                    Text(
                        "Dica: alternar entre pequenos depósitos e missões ajuda a manter o progresso constante.",
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                    )
                }
            }

            state.successMessage?.let { msg ->
                item { Text(msg, color = MaterialTheme.colorScheme.primary) }
            }
            state.errorMessage?.let { err ->
                item { Text(err, color = MaterialTheme.colorScheme.error) }
            }
            if (state.isLoading) {
                item { Text("Carregando cofrinho...") }
            }
        }
    }
}
