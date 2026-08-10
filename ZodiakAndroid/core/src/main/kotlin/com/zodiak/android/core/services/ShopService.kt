package com.zodiak.android.core.services

import com.zodiak.android.core.models.CartItem
import com.zodiak.android.core.models.ShopCategory
import com.zodiak.android.core.models.ShopProduct

/**
 * Operações do catálogo e carrinho da loja — stateless object.
 */
object ShopService {

    fun filter(
        products: List<ShopProduct>,
        category: ShopCategory,
        query: String,
    ): List<ShopProduct> {
        val byCategory = products.filter { it.category == category }
        return if (query.trim().isEmpty()) byCategory
        else byCategory.filter { it.name.contains(query, ignoreCase = true) }
    }

    fun cartTotal(items: List<CartItem>): Double = items.sumOf { it.subtotal }
}
