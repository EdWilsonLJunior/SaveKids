package com.zodiak.android.feature.shopmaster

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.ShoppingCart
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.ShopCategory
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.atoms.ZodiakTextField
import com.zodiak.android.R

@Composable
fun ShopMasterScreen(viewModel: ShopMasterViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    if (state.isCartVisible) {
        CartBottomSheet(state = state, viewModel = viewModel)
    }

    Scaffold(
        floatingActionButton = {
            if (state.cart.isNotEmpty()) {
                ExtendedFloatingActionButton(
                    onClick = viewModel::toggleCart,
                    icon = { Icon(Icons.Default.ShoppingCart, null) },
                    text = { Text(stringResource(R.string.shopmaster_fab_cart, state.cart.sumOf { it.quantity })) },
                )
            }
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            item {
                ZodiakTextField(
                    value = state.searchQuery,
                    onValueChange = viewModel::onSearchChange,
                    label = stringResource(R.string.shopmaster_input_label_search),
                    trailingIcon = { Icon(Icons.Default.Search, null) },
                )
            }

            item {
                LazyRow(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    item {
                        FilterChip(
                            selected = state.selectedCategory == null,
                            onClick  = { viewModel.onCategorySelect(null) },
                            label    = { Text(stringResource(R.string.shopmaster_filter_all)) },
                        )
                    }
                    items(ShopCategory.entries) { category ->
                        FilterChip(
                            selected = state.selectedCategory == category,
                            onClick  = { viewModel.onCategorySelect(category) },
                            label    = {
                                Text(when (category) {
                                    ShopCategory.ELECTRONICS -> stringResource(R.string.shopmaster_category_electronics)
                                    ShopCategory.FOOD        -> stringResource(R.string.shopmaster_category_food)
                                    ShopCategory.HOME        -> stringResource(R.string.shopmaster_category_home)
                                })
                            },
                        )
                    }
                }
            }

            if (state.filteredProducts.isEmpty()) {
                item { Text(stringResource(R.string.shopmaster_text_no_products), textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth().padding(32.dp)) }
            }

            items(state.filteredProducts, key = { it.id }) { product ->
                ListItem(
                    headlineContent  = { Text("${product.icon} ${product.name}") },
                    supportingContent = { Text(when (product.category) { ShopCategory.ELECTRONICS -> "Eletrônicos"; ShopCategory.FOOD -> "Alimentos"; ShopCategory.HOME -> "Casa" }) },
                    trailingContent  = {
                        Column(horizontalAlignment = androidx.compose.ui.Alignment.End) {
                            Text("R$ ${"%.2f".format(product.price)}", style = MaterialTheme.typography.titleMedium)
                            TextButton(onClick = { viewModel.addToCart(product) }) { Text(stringResource(R.string.shopmaster_button_add_to_cart)) }
                        }
                    },
                )
                HorizontalDivider()
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun CartBottomSheet(state: ShopMasterUiState, viewModel: ShopMasterViewModel) {
    ModalBottomSheet(onDismissRequest = viewModel::toggleCart) {
        Column(modifier = Modifier.padding(16.dp).navigationBarsPadding()) {
            Text(stringResource(R.string.shopmaster_sheet_title_cart), style = MaterialTheme.typography.headlineSmall)
            Spacer(Modifier.height(8.dp))

            if (state.cart.isEmpty()) {
                Text(stringResource(R.string.shopmaster_text_cart_empty), modifier = Modifier.padding(16.dp))
            } else {
                state.cart.forEach { item ->
                    ListItem(
                        headlineContent  = { Text(item.product.name) },
                        supportingContent = { Text(stringResource(R.string.shopmaster_label_cart_item, item.quantity, item.subtotal)) },
                        trailingContent  = {
                            IconButton(onClick = { viewModel.removeFromCart(item.id) }) {
                                Icon(Icons.Default.Delete, null)
                            }
                        },
                    )
                }
                HorizontalDivider(Modifier.padding(vertical = 8.dp))
                Text(stringResource(R.string.shopmaster_label_cart_total, state.cartTotal), style = MaterialTheme.typography.titleLarge)
                Spacer(Modifier.height(16.dp))
                ZodiakButton(stringResource(R.string.shopmaster_button_clear_cart), viewModel::clearCart, Modifier.fillMaxWidth())
            }
            Spacer(Modifier.height(16.dp))
        }
    }
}
