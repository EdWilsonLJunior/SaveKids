import SwiftUI

// MARK: - Quiz Game Screen
struct QuizGameScreen: View {
    @StateObject private var viewModel: QuizGameViewModel = QuizGameViewModel()
    @Environment(\.locale) private var locale

    var body: some View {
        ZodiakAdaptiveTemplate(
            title: "feature.quiz_game.short_title",
            eyebrow: "feature.quiz_game.eyebrow",
            intro: "feature.quiz_game.intro"
        ) {
            switch viewModel.phase {
            case .selectingTheme:
                themeSelectionView

            case .answering:
                answeringView

            case .feedback:
                feedbackView

            case .finished:
                finishedView
            }
        }
        .accessibilityIdentifier("screen.11.quiz_game")
    }

    // MARK: - Theme Selection Phase

    @ViewBuilder
    private var themeSelectionView: some View {
        ZodiakFormContainer {
            ZodiakText(QuizGameConstants.selectThemeTitle, style: .title3)

            ForEach(QuizTheme.allCases) { theme in
                ThemeCard(theme: theme) {
                    viewModel.selectTheme(theme)
                }
            }
        }
    }

    // MARK: - Answering Phase

    @ViewBuilder
    private var answeringView: some View {
        if let question: Question = viewModel.currentQuestion {
            VStack(spacing: ZodiakSpacing.s16) {
                // Progresso
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    HStack {
                        ZodiakText(
                            String(
                                format: String(localized: "feature.quiz_game.question_progress", locale: locale),
                                viewModel.currentIndex + 1,
                                QuizGameConstants.questionsPerGame
                            ),
                            style: .caption()
                        )
                        Spacer()
                        ZodiakText(
                            String(
                                format: String(localized: "feature.quiz_game.correct_count", locale: locale),
                                viewModel.correctCount),
                            style: .caption()
                        )
                    }
                    ZodiakProgressBar(
                        progress: Double(viewModel.currentIndex) / Double(QuizGameConstants.questionsPerGame)
                    )
                }

                // Pergunta e opções
                ZodiakFormWrapper {
                    ZodiakText(question.text, style: .title3)

                    ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                        OptionButton(
                            text: option,
                            index: index,
                            state: viewModel.selectedOptionIndex == index ? .selected : .normal,
                            onTap: { viewModel.selectOption(index) }
                        )
                    }
                }

                // Botão confirmar
                ZodiakButtonPrimary(
                    title: QuizGameConstants.confirmButton,
                    action: viewModel.confirmAnswer,
                    isEnabled: viewModel.selectedOptionIndex != nil
                )
            }
        }
    }

    // MARK: - Feedback Phase

    @ViewBuilder
    private var feedbackView: some View {
        if let lastAnswer: QuizAnswer = viewModel.answers.last {
            QuizFeedbackCard(
                answer: lastAnswer,
                isLastQuestion: viewModel.isLastQuestion,
                onNext: viewModel.advance
            )
        }
    }

    // MARK: - Finished Phase

    @ViewBuilder
    private var finishedView: some View {
        QuizScoreView(
            answers: viewModel.answers,
            onPlayAgain: viewModel.restart
        )
    }
}

#Preview {
    QuizGameScreen()
}
