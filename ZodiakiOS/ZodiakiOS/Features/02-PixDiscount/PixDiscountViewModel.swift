import Combine
import SwiftUI

// MARK: - Activity 02: Pix Discount

/// ViewModel da Atividade 02 — calcula desconto Pix de 10% para compras acima do valor mínimo.
final class PixDiscountViewModel: ObservableObject {
    /// Nome do produto fornecido pelo usuário.
    @Published var productName: String = ""
    /// Valor original do produto; `nil` enquanto não preenchido.
    @Published var productValue: Double?
    /// `true` quando o usuário selecionou pagamento via Pix.
    @Published var isPixSelected: Bool = false
    /// Resultado do cálculo com valor final e desconto aplicado; `nil` antes da validação.
    @Published var result: (finalValue: Double, discount: Double)?
    /// Mensagem de erro de validação; `nil` quando não há erro.
    @Published var errorMessage: LocalizedStringKey?

    private func calculateDiscount() -> (finalValue: Double, discount: Double) {
        guard let value: Double = productValue else {
            return (finalValue: 0, discount: 0)
        }

        let discount: Double = (isPixSelected && value >= PixDiscountConstants.minValueForDiscount)
            ? value * PixDiscountConstants.pixDiscountPercentage
            : 0.0
        let finalValue: Double = value - discount

        return (finalValue: finalValue, discount: discount)
    }

    private func clearErrors() {
        errorMessage = nil
        result = nil
    }

    /// Valida produto e valor e, em caso de sucesso, atualiza `result` com o cálculo do desconto.
    func submit() {
        do {
            try ValidationService.validateNotEmpty(productName, fieldName: "shared.placeholder.product_name")
            _ = try ValidationService.validatePositiveNumber(productValue, fieldName: "Valor")

            let calculation: (finalValue: Double, discount: Double) = calculateDiscount()
            self.result = calculation
        } catch let error as ValidationError {
            errorMessage = error.localizedKey
        } catch {
            errorMessage = "shared.error.unknown"
        }
    }

    /// Limpa todos os campos de entrada, seleções, erros e o resultado calculado.
    func reset() {
        productName = ""
        productValue = nil
        isPixSelected = false
        result = nil
        errorMessage = nil
    }
}
