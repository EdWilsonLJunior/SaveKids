import Combine
import SwiftUI

// MARK: - Activity 14: CardManager
final class CardManagerViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var cards: [CreditCard] = CardManagerConstants.sampleCards
    @Published var selectedCard: CreditCard?

    // MARK: - Public Actions

    func select(_ card: CreditCard) {
        selectedCard = card
    }

    func dismiss() {
        selectedCard = nil
    }
}
