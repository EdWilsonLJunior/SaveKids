import Combine
import SwiftUI

// MARK: - Activity 26: Currency Converter

/// ViewModel da Atividade 26 — conversor de moedas com taxas estáticas relativas ao USD.
final class CurrencyConverterViewModel: ObservableObject {
    // MARK: - Inputs

    @Published var fromCurrency: Currency?
    @Published var toCurrency: Currency?
    @Published var amount: Double?

    // MARK: - Outputs

    @Published var result: Double?

    var availableCurrencies: [Currency] { CurrencyConverterConstants.currencies }

    var formattedResult: String? {
        guard let result, let to = toCurrency else { return nil }
        return "\(to.symbol) \(String(format: "%.2f", result))"
    }

    var exchangeRateLabel: String? {
        guard let from = fromCurrency, let to = toCurrency else { return nil }
        let rate = CurrencyConverterService.convert(amount: 1, fromRate: from.usdRate, toRate: to.usdRate)
        return "1 \(from.code) = \(String(format: "%.4f", rate)) \(to.code)"
    }

    // MARK: - Lifecycle

    private var cancellables: Set<AnyCancellable> = []

    init() {
        Publishers.CombineLatest3($fromCurrency, $toCurrency, $amount)
            .map { from, to, amount -> Double? in
                guard let from, let to, let amount, amount > 0 else { return nil }
                return CurrencyConverterService.convert(
                    amount: amount,
                    fromRate: from.usdRate,
                    toRate: to.usdRate
                )
            }
            .sink { [weak self] value in self?.result = value }
            .store(in: &cancellables)
    }

    // MARK: - Actions

    func swap() {
        let temp = fromCurrency
        fromCurrency = toCurrency
        toCurrency = temp
    }

    func reset() {
        fromCurrency = nil
        toCurrency = nil
        amount = nil
    }
}
