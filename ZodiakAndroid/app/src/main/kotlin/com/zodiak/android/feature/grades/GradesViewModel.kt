package com.zodiak.android.feature.grades

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Grade
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.CalculationService
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

data class GradesUiState(
    val name: String = "",
    val grade1: String = "",
    val grade2: String = "",
    val grade3: String = "",
    val result: Grade? = null,
    val error: ValidationError? = null,
)

@HiltViewModel
class GradesViewModel @Inject constructor() : ViewModel() {

    private val _uiState = MutableStateFlow(GradesUiState())
    val uiState: StateFlow<GradesUiState> = _uiState.asStateFlow()

    fun onNameChange(value: String)   = _uiState.update { it.copy(name = value, error = null) }
    fun onGrade1Change(value: String) = _uiState.update { it.copy(grade1 = value, error = null) }
    fun onGrade2Change(value: String) = _uiState.update { it.copy(grade2 = value, error = null) }
    fun onGrade3Change(value: String) = _uiState.update { it.copy(grade3 = value, error = null) }

    fun calculate() {
        val state = _uiState.value
        try {
            ValidationService.validateNotEmpty(state.name, "Nome")
            val g1 = ValidationService.validateGrade(state.grade1.toDoubleOrNull())
            val g2 = ValidationService.validateGrade(state.grade2.toDoubleOrNull())
            val g3 = ValidationService.validateGrade(state.grade3.toDoubleOrNull())
            val grade = Grade(name = state.name.trim(), grade1 = g1, grade2 = g2, grade3 = g3)
            _uiState.update { it.copy(result = grade, error = null) }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun reset() = _uiState.update { GradesUiState() }
}
