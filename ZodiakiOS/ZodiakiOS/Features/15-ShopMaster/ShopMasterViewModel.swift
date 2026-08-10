import Combine
import SwiftUI

// MARK: - ShopMasterViewModel

// swiftlint:disable:next inclusive_language
final class ShopMasterViewModel: ObservableObject {
    // MARK: - Inputs (mutados pela UI)

    @Published var selectedTab: Int = 0
    @Published var searchText: String = ""

    // MARK: - Estado derivado (somente leitura — atribuídos por pipelines Combine)

    @Published private(set) var filteredProducts: [ShopProduct] = []
    @Published private(set) var cartTotal: Double = 0
    @Published private(set) var cartItemCount: Int = 0

    // MARK: - Estado mutável das actions

    @Published private(set) var cartItems: [CartItem] = []

    // MARK: - Estado de UI (feedback visual)

    @Published var toast: ZodiakToastConfig?

    // MARK: - Init

    init() {
        bindFilteredProducts()
        bindCartTotal()
        bindCartItemCount()
    }

    // MARK: - Pipelines Combine (estado derivado)

    /// Pipeline 1: filtra produtos reativamente ao mudar aba ou texto de busca,
    /// com debounce de 300 ms para evitar processamento a cada tecla.
    private func bindFilteredProducts() {
        Publishers.CombineLatest($selectedTab, $searchText)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates { $0.0 == $1.0 && $0.1 == $1.1 }
            .map { tab, query -> [ShopProduct] in
                let category = ShopCategory.allCases[tab]
                return ShopService.filter(
                    ShopMasterConstants.sampleProducts,
                    category: category,
                    query: query
                )
            }
            .assign(to: &$filteredProducts)
    }

    /// Pipeline 2: recalcula o total do carrinho sempre que `cartItems` mudar.
    private func bindCartTotal() {
        $cartItems
            .map { ShopService.cartTotal($0) }
            .assign(to: &$cartTotal)
    }

    /// Pipeline 3: soma as quantidades de todos os itens para o badge do carrinho.
    private func bindCartItemCount() {
        $cartItems
            .map { $0.reduce(0) { $0 + $1.quantity } }
            .assign(to: &$cartItemCount)
    }

    // MARK: - Actions

    /// Adiciona o produto ao carrinho. Se já existe, incrementa a quantidade.
    /// Dispara um toast de confirmação com o nome do produto.
    func addToCart(_ product: ShopProduct) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product))
        }
        toast = ZodiakToastConfig(
            message: product.name,
            variant: .success,
            duration: 2.0,
            action: nil
        )
    }

    /// Remove o item do carrinho completamente.
    func removeFromCart(_ item: CartItem) {
        cartItems.removeAll { $0.id == item.id }
    }

    /// Aumenta em 1 a quantidade do item.
    func increaseQuantity(of item: CartItem) {
        guard let index = cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        cartItems[index].quantity += 1
    }

    /// Diminui em 1 a quantidade do item. Remove-o quando atingir zero.
    func decreaseQuantity(of item: CartItem) {
        guard let index = cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        if cartItems[index].quantity > 1 {
            cartItems[index].quantity -= 1
        } else {
            cartItems.remove(at: index)
        }
    }
}
