package com.zodiak.android.feature.quizgame

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.selection.selectable
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.QuizTheme
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.R

@Composable
fun QuizGameScreen(viewModel: QuizGameViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        when (state.phase) {
            QuizGamePhase.ThemeSelection -> ThemeSelectionContent(padding, viewModel::selectTheme)
            is QuizGamePhase.Playing     -> PlayingContent(state, padding, viewModel)
            QuizGamePhase.Results        -> ResultsContent(state, padding, viewModel::restart)
        }
    }
}

@Composable
private fun ThemeSelectionContent(padding: PaddingValues, onSelect: (QuizTheme) -> Unit) {
    LazyColumn(
        modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
        contentPadding = PaddingValues(vertical = 16.dp),
    ) {
        item { Text(stringResource(R.string.quizgame_text_choose_theme), style = MaterialTheme.typography.headlineSmall) }
        items(QuizTheme.entries) { theme ->
            ElevatedCard(
                modifier = Modifier.fillMaxWidth(),
                onClick = { onSelect(theme) },
            ) {
                Text(
                    text = when (theme) {
                        QuizTheme.SWIFT     -> stringResource(R.string.quizgame_theme_swift)
                        QuizTheme.FILMES    -> stringResource(R.string.quizgame_theme_movies)
                        QuizTheme.HISTORIA  -> stringResource(R.string.quizgame_theme_history)
                        QuizTheme.GEOGRAFIA -> stringResource(R.string.quizgame_theme_geography)
                    },
                    modifier = Modifier.padding(20.dp),
                    style = MaterialTheme.typography.titleLarge,
                )
            }
        }
    }
}

@Composable
private fun PlayingContent(state: QuizGameUiState, padding: PaddingValues, viewModel: QuizGameViewModel) {
    val question = state.currentQuestion ?: return
    val playingPhase = state.phase as QuizGamePhase.Playing

    Column(
        modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        LinearProgressIndicator(
            progress = { (playingPhase.currentIndex).toFloat() / state.questions.size },
            modifier = Modifier.fillMaxWidth(),
        )
        Text(stringResource(R.string.quizgame_label_question_counter, playingPhase.currentIndex + 1, state.questions.size), style = MaterialTheme.typography.labelLarge)

        ZodiakFormContainer(question.text) {
            question.options.forEachIndexed { index, option ->
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .selectable(selected = state.selectedOptionIndex == index, role = Role.RadioButton) {
                            viewModel.selectOption(index)
                        }
                        .padding(vertical = 4.dp),
                ) {
                    RadioButton(selected = state.selectedOptionIndex == index, onClick = { viewModel.selectOption(index) })
                    Spacer(Modifier.width(8.dp))
                    Text(option, style = MaterialTheme.typography.bodyLarge)
                }
            }
        }

        ZodiakButton(
            stringResource(R.string.quizgame_button_confirm),
            viewModel::confirmAnswer,
            Modifier.fillMaxWidth(),
            enabled = state.selectedOptionIndex != null,
        )
    }
}

@Composable
private fun ResultsContent(state: QuizGameUiState, padding: PaddingValues, onRestart: () -> Unit) {
    Column(
        modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        ZodiakFormContainer(stringResource(R.string.quizgame_form_title_results)) {
            Text(
                stringResource(R.string.quizgame_label_score, state.score, state.questions.size),
                style = MaterialTheme.typography.displaySmall,
                textAlign = TextAlign.Center,
                modifier = Modifier.fillMaxWidth(),
            )
        }
        LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            items(state.answers) { answer ->
                ListItem(
                    headlineContent = { Text(answer.question.text) },
                    supportingContent = {
                        Text(
                            if (answer.isCorrect) stringResource(R.string.quizgame_result_correct) else stringResource(R.string.quizgame_result_incorrect, answer.question.options[answer.question.correctIndex]),
                        )
                    },
                )
                HorizontalDivider()
            }
        }
        ZodiakButton(stringResource(R.string.quizgame_button_new_quiz), onRestart, Modifier.fillMaxWidth())
    }
}
