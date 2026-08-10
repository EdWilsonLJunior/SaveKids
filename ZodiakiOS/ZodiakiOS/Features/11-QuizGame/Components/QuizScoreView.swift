import SwiftUI

// MARK: - Quiz Score View Component
struct QuizScoreView: View {
    @Environment(\.colorScheme) var colorScheme
    let answers: [QuizAnswer]
    let onPlayAgain: () -> Void

    private var correctCount: Int {
        answers.filter { $0.isCorrect }.count
    }

    private var incorrectCount: Int {
        answers.filter { !$0.isCorrect }.count
    }

    private var scoreText: String {
        "\(correctCount) de \(answers.count)"
    }

    private var performanceBadge: String {
        if correctCount == answers.count {
            return "🏆 Perfeito!"
        } else if correctCount >= 4 {
            return "🌟 Excelente!"
        } else if correctCount >= 3 {
            return "👍 Bom trabalho!"
        } else {
            return "📚 Continue praticando"
        }
    }

    private var badgeColor: Color {
        if correctCount >= 4 {
            return ZodiakColors.textPositive
        } else if correctCount >= 3 {
            return ZodiakColors.actionWarning
        } else {
            return ZodiakColors.textNegative
        }
    }

    var body: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            // Card principal com pontuação
            ZodiakResultCardWithBadge(
                title: "feature.voting.result",
                value: scoreText,
                badgeText: performanceBadge,
                badgeColor: badgeColor,
                subtitle: nil,
                valueColor: ZodiakColors.actionPrimary
            )

            // Detalhes
            ZodiakFormContainer {
                ZodiakInfoRow(label: "feature.quiz_game.correct_count_label", value: "\(correctCount)")
                ZodiakInfoRow(label: "feature.quiz_game.wrong_count_label", value: "\(incorrectCount)")
            }

            // Lista de respostas
            ZodiakFormWrapper {
                ZodiakText("feature.quiz_game.summary", style: .title3)

                ForEach(Array(answers.enumerated()), id: \.offset) { index, answer in
                    HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakIconView(
                            answer.isCorrect ? .circleCheck : .close,
                            size: .small,
                            color: answer.isCorrect ? ZodiakColors.textPositive : ZodiakColors.textNegative
                        )

                        ZodiakText(verbatim: "P\(index + 1): \(answer.question.text)", style: .caption())

                        Spacer()
                    }

                    if index < answers.count - 1 {
                        Divider()
                    }
                }
            }

            // Botões de ação
            ZodiakButtonPrimary(
                title: QuizGameConstants.playAgainButton,
                action: onPlayAgain
            )
        }
    }
}

#Preview {
    let q1 = Question(text: "Pergunta 1?", options: ["A", "B", "C", "D"], correctIndex: 0)
    let q2 = Question(text: "Pergunta 2?", options: ["A", "B", "C", "D"], correctIndex: 1)

    ScrollView {
        QuizScoreView(
            answers: [
                QuizAnswer(question: q1, selectedIndex: 0, isCorrect: true),
                QuizAnswer(question: q2, selectedIndex: 2, isCorrect: false)
            ],
            onPlayAgain: {}
        )
        .padding(ZodiakSpacing.s8)
    }
}
