package com.zodiak.android.feature.shopmaster

import app.cash.turbine.test
import com.zodiak.android.core.models.ShopCategory
import com.zodiak.android.core.models.ShopProduct
import com.zodiak.android.core.testing.MainDispatcherExtension
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@ExtendWith(MainDispatcherExtension::class)
class ShopMasterViewModelTest {

    private lateinit var viewModel: ShopMasterViewModel

    @BeforeEach
    fun setup() {
        viewModel = ShopMasterViewModel()
    }

    @Test
    fun `initial state has 8 products and empty cart`() = runTest {
        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(8, state.products.size)
            assertTrue(state.cart.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `addToCart adds product`() = runTest {
        val product = viewModel.uiState.value.products.first()
        viewModel.addToCart(product)

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(1, state.cart.size)
            assertEquals(1, state.cart.first().quantity)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `addToCart increments quantity for same product`() = runTest {
        val product = viewModel.uiState.value.products.first()
        viewModel.addToCart(product)
        viewModel.addToCart(product)

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(1, state.cart.size)
            assertEquals(2, state.cart.first().quantity)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `removeFromCart removes item`() = runTest {
        val product = viewModel.uiState.value.products.first()
        viewModel.addToCart(product)
        viewModel.removeFromCart(product.id)

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.cart.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `clearCart empties cart`() = runTest {
        val product = viewModel.uiState.value.products.first()
        viewModel.addToCart(product)
        viewModel.clearCart()

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.cart.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `category filter reduces products`() = runTest {
        viewModel.onCategorySelect(ShopCategory.ELECTRONICS)

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.filteredProducts.all { it.category == ShopCategory.ELECTRONICS })
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `cartTotal is sum of all subtotals`() = runTest {
        val products = viewModel.uiState.value.products.take(2)
        products.forEach { viewModel.addToCart(it) }

        viewModel.uiState.test {
            val state = awaitItem()
            val expected = state.cart.sumOf { it.subtotal }
            assertEquals(expected, state.cartTotal, 0.001)
            cancelAndIgnoreRemainingEvents()
        }
    }
}
