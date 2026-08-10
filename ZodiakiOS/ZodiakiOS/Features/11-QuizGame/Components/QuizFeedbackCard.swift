import SwiftUI

// MARK: - Quiz Feedback Card Component
struct QuizFeedbackCard: View {
    @Environment(\.colorScheme) var colorScheme
    let answer: QuizAnswer
    let isLastQuestion: Bool
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            // Badge de status
            HStack {
                if answer.isCorrect {
                    ZodiakSuccessBadge(text: QuizGameConstants.correctFeedback)
                } else {
                    ZodiakErrorBadge(text: QuizGameConstants.incorrectFeedback)
                }
                Spacer()
            }

            // Pergunta
            ZodiakFormWrapper {
                ZodiakText(answer.question.text, style: .title3)

                // Opções com feedback visual
                ForEach(Array(answer.question.options.enumerated()), id: \.offset) { index, option in
                    let state: OptionState = optionState(for: index)
                    OptionButton(
                        text: option,
                        index: index,
                        state: state,
                        onTap: {}
                    )
                }
            }

            // Resposta correta quando errou
            if !answer.isCorrect {
                ZodiakAlert(
                    title: "feature.quiz_game.correct_answer_label",
                    message: LocalizedStringKey(answer.question.options[answer.question.correctIndex]),
                    variant: .warning
                )
            }

            // Botão próxima/resultado
            ZodiakButtonPrimary(
                title: isLastQuestion ? QuizGameConstants.finishButton : QuizGameConstants.nextButton,
                action: onNext
            )
        }
    }

    // MARK: - Helpers

    private func optionState(for index: Int) -> OptionState {
        if index == answer.question.correctIndex {
            return .correct
        }
        if index == answer.selectedIndex && !answer.isCorrect {
            return .incorrect
        }
        return .normal
    }
}

#Preview {
    let question = Question(
        text: "Qual palavra-chave define uma constante em Swift?",
        options: ["var", "let", "const", "final"],
        correctIndex: 1
    )

    VStack(spacing: ZodiakSpacing.s32) {
        QuizFeedbackCard(
            answer: QuizAnswer(question: question, selectedIndex: 1, isCorrect: true),
            isLastQuestion: false,
            onNext: {}
        )
    }
    .padding(ZodiakSpacing.s8)
}
