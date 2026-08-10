import Foundation

// MARK: - ShopMasterConstants

// swiftlint:disable:next inclusive_language
enum ShopMasterConstants {
    static let productListMaxWidth: CGFloat = 640

    static let sampleProducts: [ShopProduct] = [
        // Electronics
        ShopProduct(
            name: String(localized: "feature.shop_master.product_smartphone_x12"),
            category: .electronics, price: 1_899.00, icon: "iphone"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_headphones_pro"),
            category: .electronics, price: 349.90, icon: "headphones"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_notebook_ultra"),
            category: .electronics, price: 4_299.00, icon: "laptopcomputer"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_smartwatch_s5"),
            category: .electronics, price: 799.00, icon: "applewatch"
        ),
        // Food
        ShopProduct(
            name: String(localized: "feature.shop_master.product_rice_integral"),
            category: .food, price: 12.90, icon: "fork.knife"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_beans"),
            category: .food, price: 8.50, icon: "leaf"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_olive_oil"),
            category: .food, price: 34.90, icon: "drop.fill"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_granola"),
            category: .food, price: 22.00, icon: "sun.max"
        ),
        // Home
        ShopProduct(
            name: String(localized: "feature.shop_master.product_ergonomic_chair"),
            category: .home, price: 899.00, icon: "chair.lounge"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_led_lamp"),
            category: .home, price: 129.90, icon: "lightbulb"
        ),
        ShopProduct(
            name: String(localized: "feature.shop_master.product_pillow"),
            category: .home, price: 199.00, icon: "bed.double")
    ]
}
