package com.zodiak.android.feature.guessgame

import androidx.compose.foundation.layout.*
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
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.R

@Composable
fun GuessGameScreen(viewModel: GuessGameViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            ZodiakFormContainer(stringResource(R.string.guessgame_form_title_game)) {
                Text(stringResource(R.string.guessgame_label_attempts, state.attempts), style = MaterialTheme.typography.titleMedium)
                Spacer(Modifier.height(12.dp))
                ZodiakInputField(state.guess, viewModel::onGuessChange, stringResource(R.string.guessgame_input_label_guess), keyboardType = KeyboardType.Number)
                Spacer(Modifier.height(12.dp))
                ZodiakButton(stringResource(R.string.guessgame_button_try), viewModel::submitGuess, Modifier.fillMaxWidth(), enabled = !state.isWon)
            }

            if (state.hint.isNotBlank()) {
                Card(modifier = Modifier.fillMaxWidth()) {
                    Text(
                        text = state.hint,
                        modifier = Modifier.padding(20.dp).fillMaxWidth(),
                        style = MaterialTheme.typography.headlineSmall,
                        textAlign = TextAlign.Center,
                    )
                }
            }

            if (state.isWon) {
                ZodiakButton(stringResource(R.string.guessgame_button_new_game), viewModel::newGame, Modifier.fillMaxWidth())
            }
        }
    }
}
