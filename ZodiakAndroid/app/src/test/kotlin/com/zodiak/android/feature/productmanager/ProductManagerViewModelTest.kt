package com.zodiak.android.feature.productmanager

import app.cash.turbine.test
import com.zodiak.android.core.models.ProductSegment
import com.zodiak.android.core.testing.MainDispatcherExtension
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@ExtendWith(MainDispatcherExtension::class)
class ProductManagerViewModelTest {

    private lateinit var viewModel: ProductManagerViewModel

    @BeforeEach
    fun setup() {
        viewModel = ProductManagerViewModel()
    }

    @Test
    fun `initial state has empty products`() = runTest {
        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.products.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `addProduct adds product to list`() = runTest {
        viewModel.onNameChange("Notebook")
        viewModel.onBrandChange("Dell")
        viewModel.onSegmentChange(ProductSegment.ELECTRONICS)
        viewModel.onPriceChange("3999.0")
        viewModel.addProduct()

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(1, state.products.size)
            assertEquals("Notebook", state.products.first().name)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `addProduct with empty name shows error`() = runTest {
        viewModel.onBrandChange("Dell")
        viewModel.onPriceChange("999.0")
        viewModel.addProduct()

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.products.isEmpty())
            assertNotNull(state.error)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `removeProduct removes correct item`() = runTest {
        viewModel.onNameChange("A")
        viewModel.onBrandChange("X")
        viewModel.onPriceChange("10.0")
        viewModel.addProduct()
        val id = viewModel.uiState.value.products.first().id
        viewModel.removeProduct(id)

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.products.isEmpty())
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `averagePrice calculates correctly`() = runTest {
        viewModel.onNameChange("A"); viewModel.onBrandChange("X"); viewModel.onPriceChange("100.0"); viewModel.addProduct()
        viewModel.onNameChange("B"); viewModel.onBrandChange("Y"); viewModel.onPriceChange("200.0"); viewModel.addProduct()

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(150.0, state.averagePrice, 0.001)
            cancelAndIgnoreRemainingEvents()
        }
    }
}
