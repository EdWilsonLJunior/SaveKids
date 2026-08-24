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
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.HorizontalDivider
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.atoms.ZodiakOutlinedButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.molecules.ZodiakNotice
import com.zodiak.android.design_system.molecules.ZodiakNoticeType
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

            state.successMessage?.let { msg ->
                item {
                    ZodiakNotice(
                        message = msg,
                        type = ZodiakNoticeType.SUCCESS,
                        modifier = Modifier.padding(vertical = 4.dp)
                    )
                }
            }
            state.errorMessage?.let { err ->
                item {
                    ZodiakNotice(
                        message = err,
                        type = ZodiakNoticeType.ERROR,
                        modifier = Modifier.padding(vertical = 4.dp)
                    )
                }
            }

            item {
                SaveKidsTabs(saveKidsTabs, SaveKidsPiggyBankRoute(), onNavigate)
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
                    title = "Retirar do cofrinho",
                    subtitle = "O valor será enviado via Pix para você agora.",
                ) {
                    ZodiakInputField(
                        value = state.withdrawAmountText,
                        onValueChange = viewModel::onWithdrawAmountChange,
                        label = "Quanto quer sacar agora?",
                        keyboardType = KeyboardType.Decimal,
                    )
                    Spacer(Modifier.height(8.dp))
                    ZodiakButton(
                        text = "Sacar valor (Perder XP)",
                        onClick = viewModel::requestWithdrawal,
                        modifier = Modifier.fillMaxWidth(),
                    )
                }
            }

            item {
                ZodiakSectionCard(
                    title = if (state.targetGoalName != null) "Guardar para ${state.targetGoalName}" else "Depósito personalizado",
                    subtitle = if (state.targetGoalName != null) "O valor guardado irá direto para esta meta." else "Simule novos depósitos para acelerar a evolução do Pokémon.",
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

            if (state.isLoading) {
                item { Text("Carregando cofrinho...") }
            }
        }
    }

    if (state.showPixModal) {
        PixWithdrawalModal(
            amount = state.withdrawAmountText,
            isProcessing = state.isProcessingWithdrawal,
            onConfirm = viewModel::confirmWithdrawal,
            onDismiss = viewModel::dismissPixModal
        )
    }

    if (state.showDepositPixModal) {
        PixDepositModal(
            amount = state.amountText,
            isProcessing = state.isProcessingDeposit,
            onConfirm = viewModel::confirmDeposit,
            onDismiss = viewModel::dismissDepositPixModal
        )
    }
}

@Composable
fun PixDepositModal(
    amount: String,
    isProcessing: Boolean,
    onConfirm: () -> Unit,
    onDismiss: () -> Unit,
) {
    val amountDouble = amount.replace(',', '.').toDoubleOrNull() ?: 0.0
    val xpGain = amountDouble.toInt()

    AlertDialog(
        onDismissRequest = if (isProcessing) ({}) else onDismiss,
        title = { Text("Depósito via Pix", fontWeight = FontWeight.Bold) },
        text = {
            Column(
                verticalArrangement = Arrangement.spacedBy(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(
                    "Escaneie o QR Code abaixo para depositar R$ $amount",
                    textAlign = TextAlign.Center,
                    style = MaterialTheme.typography.bodyMedium
                )
                
                Column(
                    modifier = Modifier
                        .height(200.dp)
                        .fillMaxWidth()
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center
                ) {
                    if (isProcessing) {
                        CircularProgressIndicator()
                        Spacer(Modifier.height(8.dp))
                        Text("Processando depósito...", style = MaterialTheme.typography.labelSmall)
                    } else {
                        MockQrCode(
                            modifier = Modifier
                                .size(160.dp)
                                .padding(8.dp)
                        )
                    }
                }

                ZodiakNotice(
                    message = "Ao depositar R$ $amount, você ganhará $xpGain XP! (1 XP para cada 1 real inteiro)",
                    type = ZodiakNoticeType.INFO,
                )
            }
        },
        confirmButton = {
            ZodiakButton(
                text = "Confirmar pagamento",
                onClick = onConfirm,
                enabled = !isProcessing
            )
        },
        dismissButton = {
            if (!isProcessing) {
                ZodiakOutlinedButton(
                    text = "Cancelar",
                    onClick = onDismiss
                )
            }
        }
    )
}

@Composable
fun PixWithdrawalModal(
    amount: String,
    isProcessing: Boolean,
    onConfirm: () -> Unit,
    onDismiss: () -> Unit,
) {
    AlertDialog(
        onDismissRequest = if (isProcessing) ({}) else onDismiss,
        title = { Text("Retirada via Pix", fontWeight = FontWeight.Bold) },
        text = {
            Column(
                verticalArrangement = Arrangement.spacedBy(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(
                    "Escaneie o QR Code abaixo para receber R$ $amount",
                    textAlign = TextAlign.Center,
                    style = MaterialTheme.typography.bodyMedium
                )
                
                // Placeholder para QR Code
                Column(
                    modifier = Modifier
                        .height(200.dp)
                        .fillMaxWidth()
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center
                ) {
                    if (isProcessing) {
                        CircularProgressIndicator()
                        Spacer(Modifier.height(8.dp))
                        Text("Processando pagamento...", style = MaterialTheme.typography.labelSmall)
                    } else {
                        MockQrCode(
                            modifier = Modifier
                                .size(160.dp)
                                .padding(8.dp)
                        )
                    }
                }

                ZodiakNotice(
                    message = "Ao fazer essa ação, você perderá XP proporcional ao valor retirado.",
                    type = ZodiakNoticeType.WARNING,
                )
            }
        },
        confirmButton = {
            ZodiakButton(
                text = "Confirmar recebimento",
                onClick = onConfirm,
                enabled = !isProcessing
            )
        },
        dismissButton = {
            if (!isProcessing) {
                ZodiakOutlinedButton(
                    text = "Cancelar",
                    onClick = onDismiss
                )
            }
        }
    )
}

@Composable
fun MockQrCode(modifier: Modifier = Modifier) {
    val color = MaterialTheme.colorScheme.onSurface
    androidx.compose.foundation.Canvas(modifier = modifier) {
        val size = 15 // 15x15 grid
        val cellSize = this.size.width / size
        
        // Simular padrões de busca (os quadrados nos cantos)
        val finders = listOf(
            0 to 0,
            0 to size - 7,
            size - 7 to 0
        )
        
        for (f in finders) {
            drawRect(color, androidx.compose.ui.geometry.Offset(f.first * cellSize, f.second * cellSize), androidx.compose.ui.geometry.Size(7 * cellSize, 7 * cellSize))
            drawRect(Color.White, androidx.compose.ui.geometry.Offset((f.first + 1) * cellSize, (f.second + 1) * cellSize), androidx.compose.ui.geometry.Size(5 * cellSize, 5 * cellSize))
            drawRect(color, androidx.compose.ui.geometry.Offset((f.first + 2) * cellSize, (f.second + 2) * cellSize), androidx.compose.ui.geometry.Size(3 * cellSize, 3 * cellSize))
        }

        // Simular dados aleatórios (pseudo-random grid)
        val random = java.util.Random(42) // Fixed seed for consistent look
        for (row in 0 until size) {
            for (col in 0 until size) {
                // Skip finder pattern areas
                val inFinder = (row < 7 && col < 7) || (row < 7 && col >= size - 7) || (row >= size - 7 && col < 7)
                if (!inFinder && random.nextBoolean()) {
                    drawRect(
                        color,
                        androidx.compose.ui.geometry.Offset(col * cellSize, row * cellSize),
                        androidx.compose.ui.geometry.Size(cellSize, cellSize)
                    )
                }
            }
        }
    }
}
