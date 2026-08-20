package com.zodiak.android.feature.savekids.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.feature.savekids.model.StarterAvatarOptions
import com.zodiak.android.feature.savekids.repository.SaveKidsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class SaveKidsLoginUiState(
    val username: String = "",
    val password: String = "",
    val familyName: String = "",
    val childName: String = "",
    val selectedAvatarId: Int? = null,
    val authStepDone: Boolean = false,
    val isRegistrationMode: Boolean = false,
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val success: Boolean = false,
)

@HiltViewModel
class SaveKidsLoginViewModel @Inject constructor(
    private val repository: SaveKidsRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(SaveKidsLoginUiState())
    val uiState: StateFlow<SaveKidsLoginUiState> = _uiState.asStateFlow()

    val starterAvatars = StarterAvatarOptions

    init {
        viewModelScope.launch {
            repository.ensureSeedData()
            val session = repository.session.first()
            if (session.authenticated && session.profileCompleted) {
                _uiState.update { it.copy(success = true) }
            }
        }
    }

    fun onUsernameChange(value: String) = _uiState.update { it.copy(username = value, errorMessage = null) }
    fun onPasswordChange(value: String) = _uiState.update { it.copy(password = value, errorMessage = null) }
    fun onFamilyNameChange(value: String) = _uiState.update { it.copy(familyName = value, errorMessage = null) }
    fun onChildNameChange(value: String) = _uiState.update { it.copy(childName = value, errorMessage = null) }
    fun onAvatarSelected(id: Int) = _uiState.update { it.copy(selectedAvatarId = id, errorMessage = null) }

    fun onToggleRegistration() = _uiState.update {
        it.copy(
            isRegistrationMode = !it.isRegistrationMode,
            errorMessage = null,
            authStepDone = false,
            success = false,
        )
    }

    fun authenticate() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, errorMessage = null) }
            val current = _uiState.value
            val result = repository.login(current.username, current.password)
            if (result.isSuccess) {
                val session = repository.session.first()
                if (session.profileCompleted) {
                    _uiState.update { it.copy(isLoading = false, success = true) }
                } else {
                    _uiState.update { it.copy(isLoading = false, authStepDone = true) }
                }
            } else {
                _uiState.update {
                    it.copy(
                        isLoading = false,
                        errorMessage = result.exceptionOrNull()?.message ?: "Não foi possível autenticar.",
                    )
                }
            }
        }
    }

    fun registerAccount() {
        viewModelScope.launch {
            val current = _uiState.value
            when {
                current.familyName.isBlank() -> {
                    _uiState.update { it.copy(errorMessage = "Informe o nome da família.") }
                    return@launch
                }
                current.username.isBlank() -> {
                    _uiState.update { it.copy(errorMessage = "Informe um e-mail da família.") }
                    return@launch
                }
                current.password.isBlank() -> {
                    _uiState.update { it.copy(errorMessage = "Informe uma senha ou PIN.") }
                    return@launch
                }
            }

            _uiState.update { it.copy(isLoading = true, errorMessage = null) }
            val result = repository.login(current.username, current.password)
            if (result.isSuccess) {
                _uiState.update { it.copy(isLoading = false, isRegistrationMode = false, authStepDone = true) }
            } else {
                _uiState.update {
                    it.copy(
                        isLoading = false,
                        errorMessage = result.exceptionOrNull()?.message ?: "Não foi possível criar a conta.",
                    )
                }
            }
        }
    }

    fun saveProfile() {
        val current = _uiState.value
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, errorMessage = null) }
            val avatarId = current.selectedAvatarId
            if (avatarId == null) {
                _uiState.update { it.copy(isLoading = false, errorMessage = "Selecione um avatar.") }
                return@launch
            }
            val result = repository.completeProfile(current.childName, avatarId)
            if (result.isSuccess) {
                _uiState.update { it.copy(isLoading = false, success = true) }
            } else {
                _uiState.update {
                    it.copy(
                        isLoading = false,
                        errorMessage = result.exceptionOrNull()?.message ?: "Não foi possível salvar o perfil.",
                    )
                }
            }
        }
    }
}
