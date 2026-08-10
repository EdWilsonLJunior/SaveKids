package com.zodiak.android.feature.voting

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Candidate
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import javax.inject.Inject

data class VotingUiState(
    val candidateName: String = "",
    val candidates: List<Candidate> = emptyList(),
    val winner: Candidate? = null,
    val isRunoff: Boolean = false,
    val error: ValidationError? = null,
    val votingFinished: Boolean = false,
)

@HiltViewModel
class VotingViewModel @Inject constructor() : ViewModel() {

    private val _uiState = MutableStateFlow(VotingUiState())
    val uiState: StateFlow<VotingUiState> = _uiState.asStateFlow()

    fun onCandidateNameChange(v: String) = _uiState.update { it.copy(candidateName = v, error = null) }

    fun addCandidate() {
        try {
            ValidationService.validateNotEmpty(_uiState.value.candidateName, "Nome")
            val newCandidate = Candidate(name = _uiState.value.candidateName.trim())
            _uiState.update { it.copy(candidates = it.candidates + newCandidate, candidateName = "", error = null) }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e) }
        }
    }

    fun vote(candidateId: java.util.UUID) {
        _uiState.update { state ->
            state.copy(candidates = state.candidates.map { c ->
                if (c.id == candidateId) c.copy(votes = c.votes + 1) else c
            })
        }
    }

    fun finishVoting() {
        val candidates = _uiState.value.candidates
        val totalVotes = candidates.sumOf { it.votes }
        if (totalVotes == 0) return

        val winner = candidates.maxByOrNull { it.votes }
        val winnerPercent = (winner?.votes?.toDouble() ?: 0.0) / totalVotes

        if (winnerPercent > 0.5) {
            _uiState.update { it.copy(winner = winner, isRunoff = false, votingFinished = true) }
        } else {
            val top2 = candidates.sortedByDescending { it.votes }.take(2)
            _uiState.update { it.copy(candidates = top2, isRunoff = true, votingFinished = false) }
        }
    }

    fun reset() = _uiState.update { VotingUiState() }
}
