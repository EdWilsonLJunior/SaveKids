import Combine
import SwiftUI

// MARK: - Activity 09: Temperature Converter

/// ViewModel da Atividade 09 — converte temperaturas bidirecional entre Celsius e Fahrenheit.
final class TemperatureConverterViewModel: ObservableObject {
    /// Temperatura em graus Celsius; `nil` quando não preenchida.
    @Published var celsius: Double?
    /// Temperatura em graus Fahrenheit; `nil` quando não preenchida.
    @Published var fahrenheit: Double?

    /// Atualiza `celsius` e recalcula `fahrenheit` a partir do novo valor.
    ///
    /// - Parameter value: Nova temperatura em Celsius, ou `nil` para limpar.
    func updateCelsius(_ value: Double?) {
        celsius = value
        if let c: Double = value {
            let converted: Double = CalculationService.celsiusToFahrenheit(c)
            fahrenheit = converted.rounded(toPlaces: TemperatureConverterConstants.decimalPlaces)
        }
    }

    /// Atualiza `fahrenheit` e recalcula `celsius` a partir do novo valor.
    ///
    /// - Parameter value: Nova temperatura em Fahrenheit, ou `nil` para limpar.
    func updateFahrenheit(_ value: Double?) {
        fahrenheit = value
        if let f: Double = value {
            let converted: Double = CalculationService.fahrenheitToCelsius(f)
            celsius = converted.rounded(toPlaces: TemperatureConverterConstants.decimalPlaces)
        }
    }

    /// Limpa ambas as temperaturas, retornando ao estado inicial.
    func reset() {
        celsius = nil
        fahrenheit = nil
    }
}
