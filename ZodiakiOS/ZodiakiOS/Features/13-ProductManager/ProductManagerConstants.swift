import Foundation

// MARK: - Constants
enum ProductManagerConstants {
    static let sampleProducts: [Product] = [
        Product(name: "Arroz Integral 1kg", brand: "NaturaBio", segment: .food, price: 12.90),
        Product(name: "Feijão Carioca 500g", brand: "NaturaBio", segment: .food, price: 8.50),
        Product(name: "Smartphone X12", brand: "TechNova", segment: .electronics, price: 1_899.00),
        Product(name: "Fone Bluetooth Pro", brand: "TechNova", segment: .electronics, price: 349.90),
        Product(name: "Notebook Ultra", brand: "TechNova", segment: .electronics, price: 4_299.00),
        Product(name: "Cadeira Ergonômica", brand: "ComfortHome", segment: .home, price: 899.00),
        Product(name: "Luminária LED", brand: "ComfortHome", segment: .home, price: 129.90),
        Product(name: "Travesseiro Premium", brand: "DormirBem", segment: .home, price: 199.00)
    ]
}
