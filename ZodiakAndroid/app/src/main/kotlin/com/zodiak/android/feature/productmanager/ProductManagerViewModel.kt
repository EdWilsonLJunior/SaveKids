package com.zodiak.android.feature.productmanager

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Product
import com.zodiak.android.core.models.ProductSegment
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.ProductService
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import java.util.UUID
import javax.inject.Inject

enum class GroupBy { BRAND, SEGMENT }

data class ProductManagerUiState(
    val name: String = "",
    val brand: String = "",
    val segment: ProductSegment = ProductSegment.FOOD,
    val price: String = "",
    val products: List<Product> = emptyList(),
    val groupBy: GroupBy = GroupBy.BRAND,
    val error: ValidationError? = null,
) {
    val groupedByBrand: List<Pair<String, List<Product>>> get() = ProductService.groupByBrand(products)
    val groupedBySegment: List<Pair<ProductSegment, List<Product>>> get() = ProductService.groupBySegment(products)
    val averagePrice: Double get() = ProductService.averagePrice(products)
}

@HiltViewModel
class ProductManagerViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(ProductManagerUiState())
    val uiState: StateFlow<ProductManagerUiState> = _uiState.asStateFlow()

    fun onNameChange(v: String)    = _uiState.update { it.copy(name = v, error = null) }
    fun onBrandChange(v: String)   = _uiState.update { it.copy(brand = v) }
    fun onSegmentChange(s: ProductSegment) = _uiState.update { it.copy(segment = s) }
    fun onPriceChange(v: String)   = _uiState.update { it.copy(price = v) }
    fun onGroupByChange(g: GroupBy) = _uiState.update { it.copy(groupBy = g) }

    fun addProduct() {
        try {
            ValidationService.validateNotEmpty(_uiState.value.name, "Nome")
            ValidationService.validateNotEmpty(_uiState.value.brand, "Marca")
            val price = ValidationService.validatePositiveNumber(_uiState.value.price.replace(",", ".").toDoubleOrNull(), "Preço")
            val product = Product(
                name = _uiState.value.name.trim(),
                brand = _uiState.value.brand.trim(),
                segment = _uiState.value.segment,
                price = price,
            )
            _uiState.update { it.copy(products = it.products + product, name = "", brand = "", price = "", error = null) }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun removeProduct(id: UUID) = _uiState.update { it.copy(products = it.products.filter { p -> p.id != id }) }
}
