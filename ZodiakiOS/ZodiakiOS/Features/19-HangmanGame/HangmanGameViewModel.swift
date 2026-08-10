import Combine
import SwiftUI

// MARK: - Hangman Phase

/// Representa o estado atual do fluxo do Jogo da Forca.
enum HangmanPhase: Equatable {
    /// Partida em andamento — letras podem ser selecionadas.
    case playing
    /// Usuário revelou todas as letras antes de atingir o limite de erros.
    case won
    /// Número máximo de erros atingido — palavra não foi descoberta.
    case lost
}

// MARK: - Activity 19: HangmanGame

/// ViewModel da Atividade 19 — orquestra o Jogo da Forca: palavra oculta, letras tentadas e estados win/lose.
final class HangmanGameViewModel: ObservableObject {
    // MARK: - State

    /// Fase atual do jogo.
    @Published var phase: HangmanPhase = .playing
    /// Palavra corrente em maiúsculas (ex.: "SWIFT").
    @Published var currentWord: String = ""
    /// Letras já tentadas pelo usuário (corretas e incorretas).
    @Published var guessedLetters: Set<Character> = []
    /// Contagem de letras erradas na sessão atual.
    @Published var wrongAttempts: Int = 0

    // MARK: - Computed

    /// Representação da palavra com letras reveladas e underscores para as ocultas (ex.: "S _ I _ T").
    var displayWord: String {
        currentWord
            .map { char in guessedLetters.contains(char) ? String(char) : "_" }
            .joined(separator: " ")
    }

    /// Tentativas de erro restantes.
    var remainingAttempts: Int {
        HangmanGameConstants.maxAttempts - wrongAttempts
    }

    /// `true` quando a letra já foi tentada.
    func isLetterUsed(_ letter: Character) -> Bool {
        guessedLetters.contains(letter)
    }

    /// `true` quando a letra está na palavra corrente.
    func isLetterCorrect(_ letter: Character) -> Bool {
        currentWord.contains(letter)
    }

    // MARK: - Init

    init() {
        restart()
    }

    // MARK: - Actions

    /// Registra a tentativa de uma letra. Ignora letras já tentadas.
    ///
    /// - Parameter letter: Letra do alfabeto em maiúscula.
    func guessLetter(_ letter: Character) {
        guard phase == .playing, !guessedLetters.contains(letter) else { return }
        guessedLetters.insert(letter)

        if !currentWord.contains(letter) {
            wrongAttempts += 1
            if wrongAttempts >= HangmanGameConstants.maxAttempts {
                phase = .lost
                return
            }
        }

        let allRevealed = currentWord.allSatisfy { guessedLetters.contains($0) }
        if allRevealed {
            phase = .won
        }
    }

    /// Reinicia o jogo com uma nova palavra aleatória e limpa todo o estado.
    func restart() {
        currentWord = HangmanService.randomWord()
        guessedLetters = []
        wrongAttempts = 0
        phase = .playing
    }
}
