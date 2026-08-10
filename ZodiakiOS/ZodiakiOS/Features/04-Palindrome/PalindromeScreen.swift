import SwiftUI

// MARK: - Palindrome Screen
struct PalindromeScreen: View {
    @StateObject private var viewModel: PalindromeViewModel = PalindromeViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: "catalog.examples.palindrome.name",
            eyebrow: "feature.palindrome.eyebrow",
            intro: "feature.palindrome.intro"
        ) {
            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "feature.palindrome.label",
                    placeholder: "feature.palindrome.placeholder",
                    text: $viewModel.input
                )
            }

            ZodiakButtonPrimary(title: "shared.action.verify", action: viewModel.check)

            if let result: (text: String, isPalindrome: Bool) = viewModel.result {
                VStack(spacing: ZodiakSpacing.s16) {
                    let isPalindrome: Bool = result.isPalindrome
                    let resultText: String = isPalindrome ? "É um Palíndromo!" : "Não é um Palíndromo"
                    // swiftlint:disable:next line_length
                    let badgeText: String = isPalindrome ? PalindromeConstants.palindromeSymbol : PalindromeConstants.notPalindromeSymbol
                    let badgeColor: Color = isPalindrome ? ZodiakColors.surfacePositive : ZodiakColors.textNegative

                    ZodiakResultCardWithBadge(
                        title: "feature.voting.result",
                        value: resultText,
                        badgeText: badgeText,
                        badgeColor: badgeColor,
                        subtitle: nil
                    )

                    ZodiakInfoRow(
                        label: "Texto original",
                        value: result.text
                    )

                    ZodiakButtonSecondary(title: "shared.action.clear", action: viewModel.reset)
                }
            }
        }
        .accessibilityIdentifier("screen.04.palindrome")
    }
}

#Preview {
    PalindromeScreen()
}
