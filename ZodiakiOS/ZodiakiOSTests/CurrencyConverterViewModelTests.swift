import Testing
@testable import ZodiakiOS

// MARK: - CurrencyConverterViewModel Tests

@Suite("CurrencyConverterViewModel")
struct CurrencyConverterViewModelTests {
    // MARK: - Result: guard conditions

    @Test("result é nil quando amount é nil")
    func resultIsNilWhenAmountIsNil() {
        let vm = CurrencyConverterViewModel()
        vm.fromCurrency = CurrencyConverterConstants.currencies.first { $0.code == "USD" }
        vm.toCurrency = CurrencyConverterConstants.currencies.first { $0.code == "BRL" }
        vm.amount = nil
        #expect(vm.result == nil)
    }

    @Test("result é nil quando fromCurrency é nil")
    func resultIsNilWhenFromCurrencyIsNil() {
        let vm = CurrencyConverterViewModel()
        vm.fromCurrency = nil
        vm.toCurrency = CurrencyConverterConstants.currencies.first { $0.code == "BRL" }
        vm.amount = 100
        #expect(vm.result == nil)
    }

    @Test("result é nil quando toCurrency é nil")
    func resultIsNilWhenToCurrencyIsNil() {
        let vm = CurrencyConverterViewModel()
        vm.fromCurrency = CurrencyConverterConstants.currencies.first { $0.code == "USD" }
        vm.toCurrency = nil
        vm.amount = 100
        #expect(vm.result == nil)
    }

    @Test("result é nil quando amount é zero")
    func resultIsNilWhenAmountIsZero() {
        let vm = CurrencyConverterViewModel()
        vm.fromCurrency = CurrencyConverterConstants.currencies.first { $0.code == "USD" }
        vm.toCurrency = CurrencyConverterConstants.currencies.first { $0.code == "BRL" }
        vm.amount = 0
        #expect(vm.result == nil)
    }

    // MARK: - Result: conversions

    @Test("conversão USD→USD com 100 retorna 100")
    func sameCurrencyConversionIsIdentity() {
        let vm = CurrencyConverterViewModel()
        let usd = CurrencyConverterConstants.currencies.first { $0.code == "USD" }
        vm.fromCurrency = usd
        vm.toCurrency = usd
        vm.amount = 100
        #expect(vm.result == 100.0)
    }

    @Test("conversão USD→BRL usa taxa correta")
    func usdToBrlConversionUsesRate() throws {
        let vm = CurrencyConverterViewModel()
        let usd = try #require(CurrencyConverterConstants.currencies.first { $0.code == "USD" })
        let brl = try #require(CurrencyConverterConstants.currencies.first { $0.code == "BRL" })
        vm.fromCurrency = usd
        vm.toCurrency = brl
        vm.amount = 1
        let expected = CurrencyConverterService.convert(
            amount: 1,
            fromRate: usd.usdRate,
            toRate: brl.usdRate
        )
        #expect(vm.result == expected)
    }

    // MARK: - swap()

    @Test("swap() troca fromCurrency e toCurrency preservando amount")
    func swapExchangesCurrenciesAndPreservesAmount() {
        let vm = CurrencyConverterViewModel()
        let usd = CurrencyConverterConstants.currencies.first { $0.code == "USD" }
        let brl = CurrencyConverterConstants.currencies.first { $0.code == "BRL" }
        vm.fromCurrency = usd
        vm.toCurrency = brl
        vm.amount = 50
        vm.swap()
        #expect(vm.fromCurrency?.code == "BRL")
        #expect(vm.toCurrency?.code == "USD")
        #expect(vm.amount == 50)
    }

    // MARK: - reset()

    @Test("reset() zera todos os campos")
    func resetClearsAllFields() {
        let vm = CurrencyConverterViewModel()
        vm.fromCurrency = CurrencyConverterConstants.currencies.first { $0.code == "USD" }
        vm.toCurrency = CurrencyConverterConstants.currencies.first { $0.code == "EUR" }
        vm.amount = 200
        vm.reset()
        #expect(vm.fromCurrency == nil)
        #expect(vm.toCurrency == nil)
        #expect(vm.amount == nil)
        #expect(vm.result == nil)
    }

    // MARK: - exchangeRateLabel

    @Test("exchangeRateLabel não é nil quando todos os inputs estão preenchidos")
    func exchangeRateLabelNotNilWhenInputsComplete() {
        let vm = CurrencyConverterViewModel()
        vm.fromCurrency = CurrencyConverterConstants.currencies.first { $0.code == "USD" }
        vm.toCurrency = CurrencyConverterConstants.currencies.first { $0.code == "EUR" }
        vm.amount = 100
        #expect(vm.exchangeRateLabel != nil)
    }
}
