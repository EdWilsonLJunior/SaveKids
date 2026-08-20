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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.organisms.ZodiakEmptyState
import com.zodiak.android.design_system.organisms.ZodiakMiniBadge
import com.zodiak.android.design_system.organisms.ZodiakSectionCard
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.utils.toMoneyLabel
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsHistoryViewModel
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

private val historyDateFormat = SimpleDateFormat("dd/MM HH:mm", Locale("pt", "BR"))

@Composable
fun SaveKidsHistoryScreen(
    onBack: () -> Unit,
    viewModel: SaveKidsHistoryViewModel = hiltViewModel(),
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
                Text("Histórico", style = MaterialTheme.typography.headlineSmall)
                Text(
                    "Eventos do mais recente para o mais antigo.",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                )
            }

            if (state.history.isEmpty() && !state.isLoading) {
                item {
                    ZodiakEmptyState(
                        title = "Sem registros",
                        message = "As ações de login, metas, missões e cofrinho aparecerão aqui.",
                    )
                }
            } else {
                items(state.history) { event ->
                    ZodiakSectionCard(
                        title = event.title,
                        subtitle = historyDateFormat.format(Date(event.createdAt)),
                    ) {
                        Row(horizontalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8)) {
                            ZodiakMiniBadge(event.type.displayName, Color(0xFF4E0B8F))
                            if (event.xpDelta != 0) {
                                ZodiakMiniBadge(
                                    "${if (event.xpDelta > 0) "+" else ""}${event.xpDelta} XP",
                                    if (event.xpDelta > 0) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.error,
                                )
                            }
                        }
                        Text(event.details)
                        if (event.amount > 0.0) {
                            Text(
                                "Valor: ${event.amount.toMoneyLabel()}",
                                style = MaterialTheme.typography.titleSmall,
                                modifier = Modifier.fillMaxWidth(),
                            )
                        }
                    }
                }
            }

            if (state.isLoading) {
                item { Text("Carregando histórico...") }
            }
        }
    }
}
