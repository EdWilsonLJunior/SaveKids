package com.zodiak.android.feature.login

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Email
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.R
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.atoms.ZodiakDestructiveButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.molecules.ZodiakSwitch
import com.zodiak.android.design_system.organisms.ZodiakFormContainer

@Composable
fun LoginScreen(viewModel: LoginViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            if (state.isLoggedIn) {
                LoggedInContent(email = state.email, onLogout = viewModel::logout)
            } else {
                LoginForm(state = state, viewModel = viewModel)
            }
        }
    }
}

@Composable
private fun LoginForm(state: LoginUiState, viewModel: LoginViewModel) {
    ZodiakFormContainer(stringResource(R.string.login_form_title_login)) {
        ZodiakInputField(
            value = state.email,
            onValueChange = viewModel::onEmailChange,
            label = stringResource(R.string.login_input_label_email),
            keyboardType = KeyboardType.Email,
        )
        if (state.isEmailInvalid) {
            Text(
                text = stringResource(R.string.shared_validation_invalid_email),
                color = MaterialTheme.colorScheme.error,
                style = MaterialTheme.typography.bodySmall,
            )
        }
        Spacer(Modifier.height(8.dp))
        ZodiakSwitch(
            label = stringResource(R.string.login_switch_label_remember_email),
            checked = state.rememberMe,
            onCheckedChange = viewModel::onRememberMeChange,
        )
        Spacer(Modifier.height(12.dp))
        ZodiakButton(stringResource(R.string.login_button_login), viewModel::login, Modifier.fillMaxWidth())
    }
}

@Composable
private fun LoggedInContent(email: String, onLogout: () -> Unit) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(16.dp)) {
        Icon(Icons.Default.Email, contentDescription = null, modifier = Modifier.size(64.dp), tint = MaterialTheme.colorScheme.primary)
        Text(stringResource(R.string.login_text_welcome), style = MaterialTheme.typography.headlineMedium, textAlign = TextAlign.Center)
        Text(email, style = MaterialTheme.typography.bodyLarge, color = MaterialTheme.colorScheme.onSurfaceVariant)
        Spacer(Modifier.height(8.dp))
        ZodiakDestructiveButton(stringResource(R.string.login_button_logout), onLogout, Modifier.fillMaxWidth(0.6f))
    }
}
