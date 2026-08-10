import Combine
import SwiftUI

// MARK: - Activity 05: Guess Game

/// ViewModel da Atividade 05 — jogo de adivinhação com número secreto entre 1 e 100.
final class GuessGameViewModel: ObservableObject {
    /// Palpite atual digitado pelo usuário (string para bind com TextField).
    @Published var guessInput: String = ""
    /// Número secreto gerado aleatoriamente no início ou reset.
    @Published var secretNumber: Int = 0
    /// Número de tentativas realizadas na sessão atual.
    @Published var attempts: Int = 0
    /// Dica de proximidade exibida após cada tentativa incorreta; `nil` antes da primeira tentativa.
    @Published var proximityHint: String?
    /// `true` quando o usuário acertou o número secreto.
    @Published var gameWon: Bool = false
    /// `true` quando o palpite digitado é inválido (não é inteiro no intervalo válido).
    @Published var isInputInvalid: Bool = false

    init() {
        resetGame()
    }

    /// Processa o palpite atual. Valida o input e atualiza `gameWon` ou `proximityHint`.
    func makeGuess() {
        isInputInvalid = false
        proximityHint = nil

        guard let guess: Int = Int(guessInput),
              guess >= GuessGameConstants.minNumber,
              guess <= GuessGameConstants.maxNumber else {
            isInputInvalid = true
            return
        }

        attempts += 1

        if RandomService.isCorrect(guess, secretNumber) {
            gameWon = true
        } else {
            proximityHint = RandomService.getProximityHint(guess: guess, secret: secretNumber)
        }

        guessInput = ""
    }

    /// Gera novo número secreto e reinicia todas as estatísticas da sessão.
    func resetGame() {
        secretNumber = RandomService.generateSecret()
        attempts = 0
        guessInput = ""
        proximityHint = nil
        gameWon = false
        isInputInvalid = false
    }
}
