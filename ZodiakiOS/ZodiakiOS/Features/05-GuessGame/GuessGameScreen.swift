import SwiftUI

// MARK: - Guess Game Screen
struct GuessGameScreen: View {
    @StateObject private var viewModel: GuessGameViewModel = GuessGameViewModel()
    @Environment(\.locale) private var locale

    var body: some View {
        ZodiakActivityTemplate(
            title: "catalog.examples.guess.name",
            eyebrow: "feature.guess.eyebrow",
            intro: "feature.guess.intro"
        ) {
            if !viewModel.gameWon {
                ZodiakFormWrapper {
                    ZodiakText(
                        String(
                            format: String(localized: "feature.guess.secret_number_range", locale: locale),
                            GuessGameConstants.minNumber,
                            GuessGameConstants.maxNumber
                        ),
                        style: .caption()
                    )
                    ZodiakLabelledField(
                        label: "feature.guess.guess_label",
                        placeholder: "shared.placeholder.enter_number",
                        text: $viewModel.guessInput,
                        keyboardType: .numberPad,
                        errorMessage: viewModel.isInputInvalid
                            // swiftlint:disable:next line_length
                            ? LocalizedStringKey(String(format: String(localized: "feature.guess.number_range_hint", locale: locale), GuessGameConstants.minNumber, GuessGameConstants.maxNumber))
                            : nil,
                        onSubmit: viewModel.makeGuess
                    )
                }

                ZodiakCounterControl(
                    value: $viewModel.attempts,
                    min: 0,
                    max: 999
                )
            }

            let buttonTitle: LocalizedStringKey = viewModel.gameWon
                ? "shared.action.play_again"
                : "feature.guess.submit_action"
            let buttonAction: () -> Void = { viewModel.gameWon ? viewModel.resetGame() : viewModel.makeGuess() }

            ZodiakButtonPrimary(
                title: buttonTitle,
                action: buttonAction
            )

            if let hint: String = viewModel.proximityHint {
                ZodiakResultCard(
                    title: "feature.guess.hint_label",
                    value: hint,
                    subtitle: String(
                        format: String(localized: "feature.guess.attempts_label", locale: locale),
                        viewModel.attempts)
                )
            }

            if viewModel.gameWon {
                ZodiakResultCard(
                    title: "Parabéns!",
                    // swiftlint:disable:next line_length
                    value: String(format: String(localized: "feature.guess.success_message", locale: locale), GuessGameConstants.celebrationSymbol, viewModel.attempts),
                    subtitle: nil
                )
            }
        }
        .accessibilityIdentifier("screen.05.guess_game")
    }
}

#Preview {
    GuessGameScreen()
}
