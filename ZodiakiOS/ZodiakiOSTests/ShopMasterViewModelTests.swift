import Foundation
import Testing
@testable import ZodiakiOS

// MARK: - ShopMasterViewModel Tests

@Suite("ShopMasterViewModel")
// swiftlint:disable:next inclusive_language
struct ShopMasterViewModelTests {
    @Test("estado inicial: carrinho vazio e primeira aba selecionada")
    func initialStateIsEmpty() {
        let vm = ShopMasterViewModel()
        #expect(vm.cartItems.isEmpty)
        #expect(vm.selectedTab == 0)
        #expect(vm.cartTotal == 0)
        #expect(vm.cartItemCount == 0)
        #expect(vm.searchText.isEmpty)
    }

    @Test("addToCart com produto novo cria CartItem com quantidade 1")
    func addToCartNewProductCreatesItem() {
        let vm = ShopMasterViewModel()
        let product = ShopMasterConstants.sampleProducts[0]
        vm.addToCart(product)
        #expect(vm.cartItems.count == 1)
        #expect(vm.cartItems[0].quantity == 1)
        #expect(vm.cartItems[0].product.id == product.id)
        #expect(vm.cartItemCount == 1)
    }

    @Test("addToCart com produto já no carrinho incrementa a quantidade")
    func addToCartExistingProductIncrementsQuantity() {
        let vm = ShopMasterViewModel()
        let product = ShopMasterConstants.sampleProducts[0]
        vm.addToCart(product)
        vm.addToCart(product)
        #expect(vm.cartItems.count == 1)
        #expect(vm.cartItems[0].quantity == 2)
        #expect(vm.cartItemCount == 2)
    }

    @Test("increaseQuantity adiciona 1 à quantidade existente")
    func increaseQuantityAddsOne() {
        let vm = ShopMasterViewModel()
        let product = ShopMasterConstants.sampleProducts[0]
        vm.addToCart(product)
        let item = vm.cartItems[0]
        vm.increaseQuantity(of: item)
        #expect(vm.cartItems[0].quantity == 2)
    }

    @Test("decreaseQuantity com quantidade 2 reduz para 1")
    func decreaseQuantityReducesToOne() {
        let vm = ShopMasterViewModel()
        let product = ShopMasterConstants.sampleProducts[0]
        vm.addToCart(product)
        vm.addToCart(product)
        let item = vm.cartItems[0]
        vm.decreaseQuantity(of: item)
        #expect(vm.cartItems.count == 1)
        #expect(vm.cartItems[0].quantity == 1)
    }

    @Test("decreaseQuantity com quantidade 1 remove o item do carrinho")
    func decreaseQuantityToOneRemovesItem() {
        let vm = ShopMasterViewModel()
        let product = ShopMasterConstants.sampleProducts[0]
        vm.addToCart(product)
        let item = vm.cartItems[0]
        vm.decreaseQuantity(of: item)
        #expect(vm.cartItems.isEmpty)
        #expect(vm.cartItemCount == 0)
    }

    @Test("removeFromCart elimina o item do carrinho")
    func removeFromCartDeletesItem() {
        let vm = ShopMasterViewModel()
        let product = ShopMasterConstants.sampleProducts[0]
        vm.addToCart(product)
        let item = vm.cartItems[0]
        vm.removeFromCart(item)
        #expect(vm.cartItems.isEmpty)
    }

    @Test("cartTotal reflete corretamente o subtotal dos itens")
    func cartTotalReflectsItemsCorrectly() {
        let vm = ShopMasterViewModel()
        let p1 = ShopMasterConstants.sampleProducts[0]
        let p2 = ShopMasterConstants.sampleProducts[4]
        vm.addToCart(p1)
        vm.addToCart(p1)
        vm.addToCart(p2)
        let expected = ShopService.cartTotal(vm.cartItems)
        #expect(vm.cartTotal == expected)
        #expect(vm.cartTotal == p1.price * 2 + p2.price)
    }

    @Test("ShopService.filter retorna somente produtos da categoria solicitada")
    func filterByCategory() {
        let all = ShopMasterConstants.sampleProducts
        let electronics = ShopService.filter(all, category: .electronics, query: "")
        #expect(electronics.allSatisfy { $0.category == .electronics })
        #expect(!electronics.isEmpty)
    }

    @Test("ShopService.filter aplica busca por texto (case-insensitive)")
    func filterByQueryIsCaseInsensitive() {
        let all = ShopMasterConstants.sampleProducts
        let result = ShopService.filter(all, category: .electronics, query: "smartphone")
        #expect(!result.isEmpty)
        #expect(result.allSatisfy { $0.name.localizedCaseInsensitiveContains("smartphone") })
    }

    @Test("ShopService.filter com query vazia retorna toda a categoria")
    func filterEmptyQueryReturnsFullCategory() {
        let all = ShopMasterConstants.sampleProducts
        let food = ShopService.filter(all, category: .food, query: "")
        let expected = all.filter { $0.category == .food }
        #expect(food.count == expected.count)
    }

    @Test("CartItem.subtotal é price * quantity")
    func cartItemSubtotalIsCorrect() {
        let product = ShopMasterConstants.sampleProducts[0]
        let item = CartItem(product: product, quantity: 3)
        #expect(item.subtotal == product.price * 3)
    }
}
