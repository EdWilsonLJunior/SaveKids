package com.zodiak.android.feature.temperatureconverter

import app.cash.turbine.test
import com.zodiak.android.core.testing.MainDispatcherExtension
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@ExtendWith(MainDispatcherExtension::class)
class TemperatureViewModelTest {

    private lateinit var viewModel: TemperatureViewModel

    @BeforeEach
    fun setup() {
        viewModel = TemperatureViewModel()
    }

    @Test
    fun `initial state is default`() = runTest {
        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.input.isEmpty())
            assertNull(state.result)
            assertEquals(TempDirection.CELSIUS_TO_FAHRENHEIT, state.direction)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `convert 0 Celsius returns 32 Fahrenheit`() = runTest {
        viewModel.onInputChange("0")
        viewModel.convert()

        viewModel.uiState.test {
            val state = awaitItem()
            assertNotNull(state.result)
            assertEquals(32.0, state.result!!, 0.001)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `convert 32 Fahrenheit returns 0 Celsius`() = runTest {
        viewModel.onDirectionChange(TempDirection.FAHRENHEIT_TO_CELSIUS)
        viewModel.onInputChange("32")
        viewModel.convert()

        viewModel.uiState.test {
            val state = awaitItem()
            assertNotNull(state.result)
            assertEquals(0.0, state.result!!, 0.001)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `reset clears state`() = runTest {
        viewModel.onInputChange("100")
        viewModel.convert()
        viewModel.reset()

        viewModel.uiState.test {
            val state = awaitItem()
            assertTrue(state.input.isEmpty())
            assertNull(state.result)
            cancelAndIgnoreRemainingEvents()
        }
    }

    @Test
    fun `convert with empty input does not crash`() = runTest {
        viewModel.convert()
        viewModel.uiState.test {
            val state = awaitItem()
            assertNull(state.result)
            cancelAndIgnoreRemainingEvents()
        }
    }
}
