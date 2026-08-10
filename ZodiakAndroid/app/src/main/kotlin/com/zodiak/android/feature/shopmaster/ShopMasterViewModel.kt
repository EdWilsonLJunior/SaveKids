package com.zodiak.android.feature.shopmaster

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.CartItem
import com.zodiak.android.core.models.ShopCategory
import com.zodiak.android.core.models.ShopProduct
import com.zodiak.android.core.services.ShopService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import java.util.UUID
import javax.inject.Inject

private val SAMPLE_PRODUCTS = listOf(
    ShopProduct(name = "Notebook Pro",     category = ShopCategory.ELECTRONICS, price = 4999.0,  icon = "💻"),
    ShopProduct(name = "Smartphone X",     category = ShopCategory.ELECTRONICS, price = 2999.0,  icon = "📱"),
    ShopProduct(name = "Fones Bluetooth",  category = ShopCategory.ELECTRONICS, price = 299.0,   icon = "🎧"),
    ShopProduct(name = "Geladeira Frost",  category = ShopCategory.HOME,        price = 3200.0,  icon = "🧊"),
    ShopProduct(name = "Cadeira Gamer",    category = ShopCategory.HOME,        price = 1500.0,  icon = "🪑"),
    ShopProduct(name = "Cafeteira Nespresso", category = ShopCategory.FOOD,     price = 799.0,   icon = "☕"),
    ShopProduct(name = "Granola Orgânica", category = ShopCategory.FOOD,        price = 29.90,   icon = "🥣"),
    ShopProduct(name = "Azeite Extra Virgem", category = ShopCategory.FOOD,     price = 55.0,   icon = "🫒"),
)

data class ShopMasterUiState(
    val searchQuery: String = "",
    val selectedCategory: ShopCategory? = null,
    val products: List<ShopProduct> = SAMPLE_PRODUCTS,
    val cart: List<CartItem> = emptyList(),
    val isCartVisible: Boolean = false,
) {
    val filteredProducts: List<ShopProduct> get() = when {
        selectedCategory == null && searchQuery.isBlank() -> products
        selectedCategory == null -> products.filter { it.name.contains(searchQuery, ignoreCase = true) }
        else -> ShopService.filter(products, selectedCategory, searchQuery)
    }
    val cartTotal: Double get() = ShopService.cartTotal(cart)
}

@HiltViewModel
class ShopMasterViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(ShopMasterUiState())
    val uiState: StateFlow<ShopMasterUiState> = _uiState.asStateFlow()

    fun onSearchChange(v: String) = _uiState.update { it.copy(searchQuery = v) }
    fun onCategorySelect(c: ShopCategory?) = _uiState.update { it.copy(selectedCategory = c) }
    fun toggleCart() = _uiState.update { it.copy(isCartVisible = !it.isCartVisible) }

    fun addToCart(product: ShopProduct) {
        _uiState.update { state ->
            val existing = state.cart.find { it.id == product.id }
            val newCart = if (existing != null) {
                state.cart.map { if (it.id == product.id) it.copy(quantity = it.quantity + 1) else it }
            } else {
                state.cart + CartItem(id = product.id, product = product, quantity = 1)
            }
            state.copy(cart = newCart)
        }
    }

    fun removeFromCart(id: UUID) = _uiState.update { it.copy(cart = it.cart.filter { c -> c.id != id }) }
    fun clearCart() = _uiState.update { it.copy(cart = emptyList(), isCartVisible = false) }
}
