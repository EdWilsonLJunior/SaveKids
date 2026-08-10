import Combine
import SwiftUI

// MARK: - Activity 04: Palindrome

/// ViewModel da Atividade 04 — verifica se um texto é palíndromo ignorando acentos e maiúsculas.
final class PalindromeViewModel: ObservableObject {
    /// Texto digitado pelo usuário para análise.
    @Published var input: String = ""
    /// Resultado da última verificação: texto analisado e se é palíndromo. `nil` antes da análise.
    @Published var result: (text: String, isPalindrome: Bool)?

    /// Analisa o texto em `input` e atualiza `result`. Não executa quando `input` está vazio.
    func check() {
        guard !input.isEmpty else { return }

        let isPalin: Bool = StringProcessingService.isPalindrome(input)
        let resultTuple: (text: String, isPalindrome: Bool) = (text: input, isPalindrome: isPalin)
        self.result = resultTuple
    }

    /// Limpa `input` e o resultado da última análise.
    func reset() {
        input = ""
        result = nil
    }
}
