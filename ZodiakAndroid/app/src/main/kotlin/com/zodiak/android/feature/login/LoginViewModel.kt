package com.zodiak.android.feature.login

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.core.datastore.ZodiakPreferencesRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class LoginUiState(
    val email: String = "",
    val rememberMe: Boolean = false,
    val isLoggedIn: Boolean = false,
    val isEmailInvalid: Boolean = false,
)

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val preferences: ZodiakPreferencesRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(LoginUiState())
    val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            val savedEmail = preferences.savedEmail.first()
            if (savedEmail.isNotBlank()) {
                _uiState.update { it.copy(email = savedEmail, rememberMe = true) }
            }
        }
    }

    fun onEmailChange(v: String)      = _uiState.update { it.copy(email = v, isEmailInvalid = false) }
    fun onRememberMeChange(v: Boolean) = _uiState.update { it.copy(rememberMe = v) }

    fun login() {
        val email = _uiState.value.email.trim()
        if (!android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            _uiState.update { it.copy(isEmailInvalid = true) }
            return
        }
        viewModelScope.launch {
            val toSave = if (_uiState.value.rememberMe) email else ""
            preferences.setSavedEmail(toSave)
            _uiState.update { it.copy(isLoggedIn = true, isEmailInvalid = false) }
        }
    }

    fun logout() {
        viewModelScope.launch {
            preferences.setSavedEmail("")
            _uiState.update { LoginUiState() }
        }
    }
}
