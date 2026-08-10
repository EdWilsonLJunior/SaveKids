import Combine
import SwiftUI

// MARK: - Quiz Phase

/// Representa o estado atual do fluxo de jogo do quiz.
enum QuizPhase: Equatable {
    /// Tela inicial de seleção de tema.
    case selectingTheme
    /// Pergunta atual sendo respondida.
    case answering
    /// Exibindo feedback da resposta (`isCorrect` indica se acertou).
    case feedback(isCorrect: Bool)
    /// Quiz concluído — todas as perguntas respondidas.
    case finished
}

// MARK: - Quiz Game ViewModel

/// ViewModel da Atividade 11 — orquestra o fluxo completo do quiz: tema, perguntas, respostas e resultado.
final class QuizGameViewModel: ObservableObject {
    /// Fase atual do quiz, controla qual tela é exibida.
    @Published var phase: QuizPhase = .selectingTheme
    /// Perguntas selecionadas aleatoriamente para a sessão atual.
    @Published var questions: [Question] = []
    /// Respostas do usuário às perguntas já respondidas.
    @Published var answers: [QuizAnswer] = []
    /// Índice da pergunta atual na lista `questions`.
    @Published var currentIndex: Int = 0
    /// Índice da opção selecionada pelo usuário na pergunta atual; `nil` antes de selecionar.
    @Published var selectedOptionIndex: Int?

    // MARK: - Computed Properties

    /// Pergunta atual com base em `currentIndex`; `nil` quando o índice está fora do range.
    var currentQuestion: Question? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    /// Número de respostas corretas na sessão.
    var correctCount: Int {
        answers.filter { $0.isCorrect }.count
    }

    /// Número de respostas incorretas na sessão.
    var incorrectCount: Int {
        answers.filter { !$0.isCorrect }.count
    }

    /// `true` quando a pergunta atual é a última da sessão.
    var isLastQuestion: Bool {
        currentIndex >= QuizGameConstants.questionsPerGame - 1
    }

    // MARK: - Actions

    /// Inicia o quiz com o tema selecionado, carregando perguntas aleatórias.
    ///
    /// - Parameter theme: Tema escolhido pelo usuário.
    func selectTheme(_ theme: QuizTheme) {
        let allQuestions = QuizService.questions(for: theme)
        questions = QuizService.randomQuestions(from: allQuestions, count: QuizGameConstants.questionsPerGame)
        answers = []
        currentIndex = 0
        selectedOptionIndex = nil
        phase = .answering
    }

    /// Registra a seleção de uma opção de resposta pelo usuário.
    ///
    /// - Parameter index: Índice (0-based) da opção selecionada.
    func selectOption(_ index: Int) {
        selectedOptionIndex = index
    }

    /// Confirma a opção selecionada, salva a resposta e avança para a fase de feedback.
    func confirmAnswer() {
        guard let question = currentQuestion,
              let selected = selectedOptionIndex else { return }

        let correct = QuizService.isCorrect(question: question, selectedIndex: selected)
        let answer = QuizAnswer(
            question: question,
            selectedIndex: selected,
            isCorrect: correct
        )
        answers.append(answer)
        phase = .feedback(isCorrect: correct)
    }

    /// Avança para a próxima pergunta ou conclui o quiz se for a última.
    func advance() {
        if isLastQuestion {
            phase = .finished
        } else {
            currentIndex += 1
            selectedOptionIndex = nil
            phase = .answering
        }
    }

    /// Reinicia o quiz completamente, retornando à tela de seleção de tema.
    func restart() {
        phase = .selectingTheme
        questions = []
        answers = []
        currentIndex = 0
        selectedOptionIndex = nil
    }
}
