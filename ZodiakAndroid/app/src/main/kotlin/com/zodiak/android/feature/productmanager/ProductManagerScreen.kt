package com.zodiak.android.feature.productmanager

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.R
import com.zodiak.android.core.models.ProductSegment
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakChipGroup
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakInfoRow

@Composable
fun ProductManagerScreen(viewModel: ProductManagerViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakFormContainer(stringResource(R.string.productmanager_form_title_add_product)) {
                    ZodiakInputField(state.name, viewModel::onNameChange, stringResource(R.string.productmanager_input_label_name))
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.brand, viewModel::onBrandChange, stringResource(R.string.productmanager_input_label_brand))
                    Spacer(Modifier.height(8.dp))
                    val segmentFood = stringResource(R.string.productmanager_segment_food)
                    val segmentElectronics = stringResource(R.string.productmanager_segment_electronics)
                    val segmentHome = stringResource(R.string.productmanager_segment_home)
                    ZodiakChipGroup(
                        items = ProductSegment.entries,
                        selectedItem = state.segment,
                        onSelect = viewModel::onSegmentChange,
                        label = { when (it) { ProductSegment.FOOD -> segmentFood; ProductSegment.ELECTRONICS -> segmentElectronics; ProductSegment.HOME -> segmentHome } },
                    )
                    Spacer(Modifier.height(8.dp))
                    ZodiakInputField(state.price, viewModel::onPriceChange, stringResource(R.string.productmanager_input_label_price), keyboardType = KeyboardType.Decimal)
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
                    ZodiakButton(stringResource(R.string.productmanager_button_add), viewModel::addProduct, Modifier.fillMaxWidth())
                }
            }

            if (state.products.isNotEmpty()) {
                item {
                    ZodiakFormContainer(stringResource(R.string.productmanager_form_title_grouping)) {
                        ZodiakInfoRow(stringResource(R.string.productmanager_info_row_avg_price), "R$ ${"%.2f".format(state.averagePrice)}")
                        Spacer(Modifier.height(8.dp))
                        val groupBrand = stringResource(R.string.productmanager_group_by_brand)
                        val groupSegment = stringResource(R.string.productmanager_group_by_segment)
                        ZodiakChipGroup(
                            items = GroupBy.entries,
                            selectedItem = state.groupBy,
                            onSelect = viewModel::onGroupByChange,
                            label = { if (it == GroupBy.BRAND) groupBrand else groupSegment },
                        )
                    }
                }

                if (state.groupBy == GroupBy.BRAND) {
                    state.groupedByBrand.forEach { (brand, products) ->
                        item { Text(brand, style = MaterialTheme.typography.titleMedium, modifier = Modifier.padding(top = 8.dp)) }
                        items(products, key = { it.id }) { product ->
                            ProductRow(product.name, "R$ ${"%.2f".format(product.price)}") { viewModel.removeProduct(product.id) }
                        }
                    }
                } else {
                    state.groupedBySegment.forEach { (segment, products) ->
                        item {
                            Text(
                                when (segment) { ProductSegment.FOOD -> stringResource(R.string.productmanager_segment_food); ProductSegment.ELECTRONICS -> stringResource(R.string.productmanager_segment_electronics); ProductSegment.HOME -> stringResource(R.string.productmanager_segment_home) },
                                style = MaterialTheme.typography.titleMedium,
                                modifier = Modifier.padding(top = 8.dp),
                            )
                        }
                        items(products, key = { it.id }) { product ->
                            ProductRow(product.name, "R$ ${"%.2f".format(product.price)}") { viewModel.removeProduct(product.id) }
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun ProductRow(name: String, price: String, onRemove: () -> Unit) {
    ListItem(
        headlineContent = { Text(name) },
        trailingContent = {
            Row {
                Text(price, style = MaterialTheme.typography.bodyMedium)
                Spacer(Modifier.width(8.dp))
                IconButton(onClick = onRemove) { Icon(Icons.Default.Delete, null) }
            }
        },
    )
    HorizontalDivider()
}
