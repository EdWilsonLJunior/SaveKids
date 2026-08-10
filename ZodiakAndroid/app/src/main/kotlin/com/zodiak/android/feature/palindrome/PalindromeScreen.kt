package com.zodiak.android.feature.palindrome

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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
fun PalindromeScreen(viewModel: PalindromeViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            ZodiakFormContainer(stringResource(R.string.palindrome_form_title_palindrome)) {
                ZodiakInputField(state.input, viewModel::onInputChange, stringResource(R.string.palindrome_input_label_word))
                Spacer(Modifier.height(16.dp))
                ZodiakButton(stringResource(R.string.palindrome_button_check), viewModel::check, Modifier.fillMaxWidth())
            }

            state.result?.let { isPalindrome ->
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    colors = CardDefaults.cardColors(
                        containerColor = if (isPalindrome) MaterialTheme.colorScheme.tertiaryContainer
                                         else MaterialTheme.colorScheme.errorContainer,
                    ),
                ) {
                    Column(
                        modifier = Modifier.padding(24.dp).fillMaxWidth(),
                        horizontalAlignment = Alignment.CenterHorizontally,
                    ) {
                        Text(
                            text = if (isPalindrome) stringResource(R.string.palindrome_result_is_palindrome) else stringResource(R.string.palindrome_result_not_palindrome),
                            style = MaterialTheme.typography.headlineSmall,
                            textAlign = TextAlign.Center,
                        )
                        Spacer(Modifier.height(8.dp))
                        Text(
                            text = "\"${state.input}\"",
                            style = MaterialTheme.typography.bodyLarge,
                            textAlign = TextAlign.Center,
                        )
                    }
                }
                ZodiakButton(stringResource(R.string.palindrome_button_clear), viewModel::reset, Modifier.fillMaxWidth())
            }
        }
    }
}
