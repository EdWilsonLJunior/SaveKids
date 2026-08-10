import SwiftUI

// MARK: - Card Manager Screen
struct CardManagerScreen: View {
    @StateObject private var viewModel: CardManagerViewModel = CardManagerViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.card_manager.title",
            eyebrow: "feature.card_manager.eyebrow",
            intro: "feature.card_manager.intro"
        ) {
            VStack(spacing: ZodiakSpacing.s8) {
                ForEach(viewModel.cards) { card in
                    Button { viewModel.select(card) } label: {
                        CreditCardView(card: card)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .zodiakContentBlur(isActive: viewModel.selectedCard != nil)
        .zodiakModal(
            isPresented: Binding(
                get: { viewModel.selectedCard != nil },
                set: { if !$0 { viewModel.dismiss() } }
            ),
            title: viewModel.selectedCard.map { "\($0.bankName) ···· \($0.lastDigits)" }
        ) {
            if let card = viewModel.selectedCard {
                CardDetailContent(card: card)
            }
        }
        .accessibilityIdentifier("screen.14.card_manager")
    }
}

#Preview {
    CardManagerScreen()
}
