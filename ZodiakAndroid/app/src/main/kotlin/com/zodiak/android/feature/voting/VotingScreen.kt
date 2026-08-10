package com.zodiak.android.feature.voting

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.HowToVote
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.R
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer

@Composable
fun VotingScreen(viewModel: VotingViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            if (state.votingFinished && state.winner != null) {
                item {
                    ZodiakFormContainer(stringResource(R.string.voting_form_title_final_result)) {
                        Text(stringResource(R.string.voting_label_elected, state.winner!!.name), style = MaterialTheme.typography.headlineSmall)
                        Text(stringResource(R.string.voting_label_votes, state.winner!!.votes), style = MaterialTheme.typography.bodyLarge)
                        Spacer(Modifier.height(12.dp))
                        ZodiakButton(stringResource(R.string.voting_button_new_election), viewModel::reset, Modifier.fillMaxWidth())
                    }
                }
                return@LazyColumn
            }

            item {
                ZodiakFormContainer(if (state.isRunoff) stringResource(R.string.voting_form_title_runoff) else stringResource(R.string.voting_form_title_add_candidate)) {
                    if (!state.isRunoff) {
                        ZodiakInputField(state.candidateName, viewModel::onCandidateNameChange, stringResource(R.string.voting_input_label_candidate_name))
                        state.error?.let { error ->
                            val msg = when (error) {
                                is ValidationError.EmptyField    -> stringResource(R.string.shared_validation_empty_field, error.fieldName)
                                is ValidationError.InvalidNumber -> stringResource(R.string.shared_validation_invalid_number, error.fieldName)
                                is ValidationError.OutOfRange    -> stringResource(R.string.shared_validation_out_of_range, error.fieldName, error.min, error.max)
                                ValidationError.InvalidAge       -> stringResource(R.string.shared_validation_invalid_age)
                                ValidationError.InvalidGrade     -> stringResource(R.string.shared_validation_invalid_grade)
                            }
                            Text(msg, color = MaterialTheme.colorScheme.error, style = MaterialTheme.typography.bodySmall)
                        }
                        Spacer(Modifier.height(8.dp))
                        ZodiakButton(stringResource(R.string.voting_button_add), viewModel::addCandidate, Modifier.fillMaxWidth())
                    }
                }
            }

            items(state.candidates) { candidate ->
                Card(modifier = Modifier.fillMaxWidth()) {
                    Row(
                        modifier = Modifier.padding(16.dp).fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                    ) {
                        Column {
                            Text(candidate.name, style = MaterialTheme.typography.titleMedium)
                            Text(stringResource(R.string.voting_label_votes, candidate.votes), style = MaterialTheme.typography.bodyMedium)
                        }
                        IconButton(onClick = { viewModel.vote(candidate.id) }) {
                            Icon(Icons.Default.HowToVote, contentDescription = stringResource(R.string.voting_button_vote))
                        }
                    }
                }
            }

            if (state.candidates.size >= 2) {
                item {
                    ZodiakButton(
                        if (state.isRunoff) stringResource(R.string.voting_button_finish_runoff) else stringResource(R.string.voting_button_finish_voting),
                        viewModel::finishVoting,
                        Modifier.fillMaxWidth(),
                    )
                }
            }
        }
    }
}
