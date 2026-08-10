package com.zodiak.android.feature.cardmanager

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.expandVertically
import androidx.compose.animation.fadeIn
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.CardTheme
import com.zodiak.android.core.models.CreditCard
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.R
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakInfoRow

@Composable
fun CardManagerScreen(viewModel: CardManagerViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    state.selectedCard?.let { card ->
        CardDetailDialog(card = card, onDismiss = { viewModel.selectCard(null) })
    }

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakFormContainer(stringResource(R.string.cardmanager_form_title_new_card)) {
                    ZodiakInputField(state.bankName, viewModel::onBankNameChange, stringResource(R.string.cardmanager_input_label_bank))
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.brand, viewModel::onBrandChange, stringResource(R.string.cardmanager_input_label_brand))
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.lastDigits, viewModel::onLastDigitsChange, stringResource(R.string.cardmanager_input_label_last_digits), keyboardType = KeyboardType.Number)
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.limit, viewModel::onLimitChange, stringResource(R.string.cardmanager_input_label_limit), keyboardType = KeyboardType.Decimal)
                    Spacer(Modifier.height(8.dp))
                    Text(stringResource(R.string.cardmanager_label_theme), style = MaterialTheme.typography.labelLarge)
                    LazyRow(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        items(CardTheme.entries) { theme ->
                            val bg = Color(theme.r, theme.g, theme.b)
                            FilterChip(
                                selected = state.theme == theme,
                                onClick  = { viewModel.onThemeChange(theme) },
                                label    = { Text(theme.name, color = Color.White) },
                                colors   = FilterChipDefaults.filterChipColors(containerColor = bg, selectedContainerColor = bg),
                            )
                        }
                    }
                    state.error?.let { error ->
                        val msg = when (error) {
                            is ValidationError.EmptyField    -> stringResource(R.string.shared_validation_empty_field, error.fieldName)
                            is ValidationError.InvalidNumber -> stringResource(R.string.shared_validation_invalid_number, error.fieldName)
                            is ValidationError.OutOfRange    -> stringResource(R.string.shared_validation_out_of_range, error.fieldName, error.min, error.max)
                            ValidationError.InvalidAge       -> stringResource(R.string.shared_validation_invalid_age)
                            ValidationError.InvalidGrade     -> stringResource(R.string.shared_validation_invalid_grade)
                        }
                        Text(msg, color = MaterialTheme.colorScheme.error, style = MaterialTheme.typography.bodySmall)
                    }
                    Spacer(Modifier.height(12.dp))
                    ZodiakButton(stringResource(R.string.cardmanager_button_add_card), viewModel::addCard, Modifier.fillMaxWidth())
                }
            }

            items(state.cards, key = { it.id }) { card ->
                AnimatedVisibility(visible = true, enter = fadeIn() + expandVertically()) {
                    CreditCardView(card = card, onClick = { viewModel.selectCard(card) }, onRemove = { viewModel.removeCard(card.id) })
                }
            }
        }
    }
}

@Composable
fun CreditCardView(card: CreditCard, onClick: () -> Unit, onRemove: () -> Unit) {
    val bg = Color(card.theme.r, card.theme.g, card.theme.b)
    Card(
        onClick = onClick,
        modifier = Modifier.fillMaxWidth().height(160.dp),
        shape = RoundedCornerShape(16.dp),
    ) {
        Box(
            modifier = Modifier.fillMaxSize().background(bg).padding(20.dp),
        ) {
            Column {
                Text(card.bankName, color = Color.White, style = MaterialTheme.typography.titleLarge)
                Spacer(Modifier.weight(1f))
                Text("**** **** **** ${card.lastDigits}", color = Color.White, style = MaterialTheme.typography.bodyLarge)
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                    Text(card.brand, color = Color.White)
                    Text(stringResource(R.string.cardmanager_label_card_limit, card.limit), color = Color.White)
                }
            }
            IconButton(modifier = Modifier.align(Alignment.TopEnd), onClick = onRemove) {
                Icon(Icons.Default.Delete, contentDescription = stringResource(R.string.cardmanager_content_desc_remove), tint = Color.White)
            }
        }
    }
}

@Composable
private fun CardDetailDialog(card: CreditCard, onDismiss: () -> Unit) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(card.bankName) },
        text = {
            Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
                ZodiakInfoRow(stringResource(R.string.cardmanager_info_row_brand), card.brand)
                ZodiakInfoRow(stringResource(R.string.cardmanager_info_row_last_digits), "**** ${card.lastDigits}")
                ZodiakInfoRow(stringResource(R.string.cardmanager_info_row_limit), "R$ ${"%.2f".format(card.limit)}")
                ZodiakInfoRow(stringResource(R.string.cardmanager_info_row_theme), card.theme.name)
            }
        },
        confirmButton = { TextButton(onClick = onDismiss) { Text(stringResource(R.string.cardmanager_button_close)) } },
    )
}
