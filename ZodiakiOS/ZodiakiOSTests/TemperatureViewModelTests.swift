import Testing
@testable import ZodiakiOS

// MARK: - TemperatureConverterViewModel Tests

@Suite("TemperatureConverterViewModel")
struct TemperatureConverterViewModelTests {
    @Test("0°C converte para 32°F")
    func zeroCelsiusToFahrenheit() {
        let vm = TemperatureConverterViewModel()
        vm.updateCelsius(0)
        #expect(vm.fahrenheit == 32.0)
    }

    @Test("100°C converte para 212°F")
    func boilingPointCelsiusToFahrenheit() {
        let vm = TemperatureConverterViewModel()
        vm.updateCelsius(100)
        #expect(vm.fahrenheit == 212.0)
    }

    @Test("212°F converte para 100°C")
    func boilingPointFahrenheitToCelsius() {
        let vm = TemperatureConverterViewModel()
        vm.updateFahrenheit(212)
        #expect(vm.celsius == 100.0)
    }

    @Test("32°F converte para 0°C")
    func freezingPointFahrenheitToCelsius() {
        let vm = TemperatureConverterViewModel()
        vm.updateFahrenheit(32)
        #expect(vm.celsius == 0.0)
    }

    @Test("updateCelsius com nil não define fahrenheit")
    func nilCelsiusDoesNotSetFahrenheit() {
        let vm = TemperatureConverterViewModel()
        vm.updateCelsius(nil)
        #expect(vm.fahrenheit == nil)
    }

    @Test("reset limpa ambos os campos")
    func resetClearsState() {
        let vm = TemperatureConverterViewModel()
        vm.updateCelsius(100)
        vm.reset()
        #expect(vm.celsius == nil)
        #expect(vm.fahrenheit == nil)
    }
}
