import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ProductManagerViewModel Tests

@Suite("ProductManagerViewModel")
struct ProductManagerViewModelTests {
    @Test("estado inicial carrega produtos de amostra")
    func initialStateHasSampleProducts() {
        let vm = ProductManagerViewModel()
        #expect(vm.products.count == ProductManagerConstants.sampleProducts.count)
        #expect(vm.errorMessage == nil)
        #expect(vm.selectedTab == 0)
    }

    @Test("addProduct com campos válidos aumenta a lista em 1")
    func addProductValidIncreasesCount() {
        let vm = ProductManagerViewModel()
        let initial = vm.products.count
        vm.newName = "Produto Teste"
        vm.newBrand = "Marca X"
        vm.newSegment = .food
        vm.newPrice = 10.0
        vm.addProduct()
        #expect(vm.products.count == initial + 1)
        #expect(vm.errorMessage == nil)
    }

    @Test("addProduct com nome vazio gera errorMessage")
    func addProductEmptyNameSetsError() {
        let vm = ProductManagerViewModel()
        vm.newName = ""
        vm.newBrand = "Marca X"
        vm.newSegment = .electronics
        vm.newPrice = 99.0
        vm.addProduct()
        #expect(vm.errorMessage != nil)
        #expect(vm.products.count == ProductManagerConstants.sampleProducts.count)
    }

    @Test("addProduct sem segmento gera errorMessage")
    func addProductNoSegmentSetsError() {
        let vm = ProductManagerViewModel()
        vm.newName = "Produto Teste"
        vm.newBrand = "Marca X"
        vm.newSegment = nil
        vm.newPrice = 50.0
        vm.addProduct()
        #expect(vm.errorMessage != nil)
    }

    @Test("addProduct com preço inválido gera errorMessage")
    func addProductInvalidPriceSetsError() {
        let vm = ProductManagerViewModel()
        vm.newName = "Produto Teste"
        vm.newBrand = "Marca X"
        vm.newSegment = .home
        vm.newPrice = nil
        vm.addProduct()
        #expect(vm.errorMessage != nil)
    }

    @Test("reset limpa todos os campos do formulário")
    func resetClearsAllFields() {
        let vm = ProductManagerViewModel()
        vm.newName = "Nome"
        vm.newBrand = "Marca"
        vm.newSegment = .food
        vm.newPrice = 99.0
        vm.errorMessage = "Erro"
        vm.reset()
        #expect(vm.newName.isEmpty)
        #expect(vm.newBrand.isEmpty)
        #expect(vm.newSegment == nil)
        #expect(vm.newPrice == nil)
        #expect(vm.errorMessage == nil)
    }

    @Test("ProductService.groupByBrand agrupa corretamente")
    func groupByBrandGroupsCorrectly() {
        let products = [
            Product(name: "A", brand: "X", segment: .food, price: 10),
            Product(name: "B", brand: "X", segment: .home, price: 20),
            Product(name: "C", brand: "Y", segment: .electronics, price: 30)
        ]
        let grouped = ProductService.groupByBrand(products)
        #expect(grouped.count == 2)
        #expect(grouped.first?.key == "X")
        #expect(grouped.first?.value.count == 2)
    }

    @Test("ProductService.averagePrice retorna média correta")
    func averagePriceCalculatedCorrectly() {
        let products = [
            Product(name: "A", brand: "X", segment: .food, price: 10.0),
            Product(name: "B", brand: "X", segment: .food, price: 30.0)
        ]
        #expect(ProductService.averagePrice(products) == 20.0)
    }

    @Test("ProductService.averagePrice retorna 0 para lista vazia")
    func averagePriceEmptyListReturnsZero() {
        #expect(ProductService.averagePrice([]) == 0)
    }
}
