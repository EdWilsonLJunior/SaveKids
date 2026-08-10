package com.zodiak.android.feature.personmanager

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Person
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import java.util.UUID
import javax.inject.Inject

data class PersonManagerUiState(
    val name: String = "",
    val age: String = "",
    val people: List<Person> = emptyList(),
    val error: ValidationError? = null,
)

@HiltViewModel
class PersonManagerViewModel @Inject constructor() : ViewModel() {
    private val _uiState = MutableStateFlow(PersonManagerUiState())
    val uiState: StateFlow<PersonManagerUiState> = _uiState.asStateFlow()

    fun onNameChange(v: String) = _uiState.update { it.copy(name = v, error = null) }
    fun onAgeChange(v: String)  = _uiState.update { it.copy(age = v, error = null) }

    fun addPerson() {
        try {
            ValidationService.validateNotEmpty(_uiState.value.name, "Nome")
            val age = ValidationService.validateAge(_uiState.value.age.toIntOrNull())
            val person = Person(name = _uiState.value.name.trim(), age = age)
            _uiState.update { it.copy(people = it.people + person, name = "", age = "", error = null) }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun removePerson(id: UUID) = _uiState.update { it.copy(people = it.people.filter { p -> p.id != id }) }
}
