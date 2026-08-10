package com.zodiak.android.feature.currencyconverter

import app.cash.turbine.test
import com.zodiak.android.core.testing.MainDispatcherExtension
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@ExtendWith(MainDispatcherExtension::class)
class CurrencyConverterViewModelTest {

    private lateinit var viewModel: CurrencyConverterViewModel

    @BeforeEach
    fun setup() {
        viewModel = CurrencyConverterViewModel()
    }

    @Test
    fun `initial state has USD as from and BRL as to`() = runTest {
        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals("USD", state.fromCurrency.code)
            assertEquals("BRL", state.toCurrency.code)
            assertNull(state.result)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `convert 1 USD to BRL returns approximately 5_70`() = runTest {
        viewModel.onAmountChange("1")
        viewModel.convert()

        viewModel.uiState.test {
            val state = awaitItem()
            assertNotNull(state.result)
            assertEquals(5.70, state.result!!, 0.01)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `swapCurrencies swaps from and to`() = runTest {
        viewModel.swapCurrencies()

        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals("BRL", state.fromCurrency.code)
            assertEquals("USD", state.toCurrency.code)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `reset clears amount and result`() = runTest {
        viewModel.onAmountChange("100")
        viewModel.convert()
        viewModel.reset()

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.amountInput.isEmpty())
            assertNull(state.result)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `convert with empty input does not produce result`() = runTest {
        viewModel.convert()

        viewModel.uiState.test {
            val state = awaitItem()
            assertNull(state.result)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `8 currencies available`() = runTest {
        viewModel.uiState.test {
            val state = awaitItem()
            assertEquals(8, state.currencies.size)
            cancelAndIgnoreRemainingEvents()
        }
    }
}
