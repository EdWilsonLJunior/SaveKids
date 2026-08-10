import Combine
import SwiftUI

// MARK: - Activity 03: Voting

/// ViewModel da Atividade 03 — gerencia votação entre três candidatos e determina o vencedor.
final class VotingViewModel: ObservableObject {
    /// Lista de candidatos com contadores de voto.
    @Published var candidates: [Candidate] = [
        Candidate(name: VotingConstants.candidateNames[0]),
        Candidate(name: VotingConstants.candidateNames[1]),
        Candidate(name: VotingConstants.candidateNames[2])
    ]
    /// `true` quando a votação foi encerrada.
    @Published var votingFinished: Bool = false
    /// Candidato com mais votos após encerramento; `nil` em segundo turno ou antes do fim.
    @Published var leadingCandidate: Candidate?
    // Reason: nil = sem segundo turno; [] seria semanticamente incorreto
    // swiftlint:disable:next discouraged_optional_collection
    @Published var runoffCandidates: [Candidate]?

    /// Registra um voto para o candidato com o `id` especificado.
    ///
    /// - Parameter candidateId: `UUID` do candidato que recebe o voto.
    func vote(for candidateId: UUID) {
        if let index: Int = candidates.firstIndex(where: { candidate in candidate.id == candidateId }) {
            candidates[index].votes += 1
        }
    }

    /// Encerra a votação e determina o vencedor ou candidatos ao segundo turno.
    func finishVoting() {
        votingFinished = true
        determineWinner()
    }

    private func determineWinner() {
        let maxVotes: Int = candidates.map { candidate in candidate.votes }.max() ?? 0
        let winners: [Candidate] = candidates.filter { candidate in candidate.votes == maxVotes }

        if winners.count > 1 {
            runoffCandidates = winners
        } else {
            leadingCandidate = winners.first
        }
    }

    private func initializeCandidates() -> [Candidate] {
        return VotingConstants.candidateNames.map { name in
            Candidate(name: name)
        }
    }

    /// Reinicia a votação com os candidatos originais e votos zerados.
    func reset() {
        candidates = initializeCandidates()
        votingFinished = false
        leadingCandidate = nil
        runoffCandidates = nil
    }
}
