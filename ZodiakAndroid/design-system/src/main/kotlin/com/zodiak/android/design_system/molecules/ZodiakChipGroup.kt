package com.zodiak.android.design_system.molecules

import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.rememberScrollState
import androidx.compose.material3.FilterChip
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

/**
 * Linha de FilterChip com seleção única.
 * [items] é a lista de rótulos; [selectedIndex] o índice ativo.
 */
@Composable
fun <T> ZodiakChipGroup(
    items: List<T>,
    selectedItem: T,
    onSelect: (T) -> Unit,
    label: (T) -> String,
    modifier: Modifier = Modifier,
) {
    Row(
        modifier = modifier.horizontalScroll(rememberScrollState()),
        horizontalArrangement = Arrangement.spacedBy(8.dp),
    ) {
        items.forEach { item ->
            FilterChip(
                selected = item == selectedItem,
                onClick  = { onSelect(item) },
                label    = { Text(label(item)) },
            )
        }
    }
}
