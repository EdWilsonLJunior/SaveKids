package com.zodiak.android.core.services

import com.zodiak.android.core.models.Product
import com.zodiak.android.core.models.ProductSegment

/**
 * Operações sobre produtos — stateless object.
 */
object ProductService {

    fun groupByBrand(products: List<Product>): List<Pair<String, List<Product>>> =
        products.groupBy { it.brand }
            .entries
            .sortedBy { it.key }
            .map { it.key to it.value }

    fun groupBySegment(products: List<Product>): List<Pair<ProductSegment, List<Product>>> {
        val grouped = products.groupBy { it.segment }
        return ProductSegment.entries
            .mapNotNull { seg -> grouped[seg]?.let { seg to it } }
    }

    fun averagePrice(products: List<Product>): Double =
        if (products.isEmpty()) 0.0 else products.sumOf { it.price } / products.size
}
