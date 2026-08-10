import Combine
import SwiftUI

// MARK: - Activity 13: ProductManager
final class ProductManagerViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var products: [Product] = ProductManagerConstants.sampleProducts
    @Published var selectedTab: Int = 0

    // Form inputs
    @Published var newName: String = ""
    @Published var newBrand: String = ""
    @Published var newSegment: ProductSegment?
    @Published var newPrice: Double?
    @Published var errorMessage: LocalizedStringKey?

    // MARK: - Computed

    var byBrand: [(key: String, value: [Product])] {
        ProductService.groupByBrand(products)
    }

    var bySegment: [(key: ProductSegment, value: [Product])] {
        ProductService.groupBySegment(products)
    }

    // MARK: - Public Actions

    func addProduct() {
        guard !newName.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "feature.product_manager.error_name_empty"
            return
        }
        guard !newBrand.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "feature.product_manager.error_brand_empty"
            return
        }
        guard let segment = newSegment else {
            errorMessage = "feature.product_manager.error_segment_empty"
            return
        }
        guard let price = newPrice, price > 0 else {
            errorMessage = "feature.product_manager.error_price_invalid"
            return
        }
        products.append(Product(name: newName, brand: newBrand, segment: segment, price: price))
        reset()
    }

    func reset() {
        newName = ""
        newBrand = ""
        newSegment = nil
        newPrice = nil
        errorMessage = nil
    }
}
