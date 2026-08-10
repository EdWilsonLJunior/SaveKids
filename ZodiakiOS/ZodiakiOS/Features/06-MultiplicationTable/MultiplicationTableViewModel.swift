import Combine
import SwiftUI

// MARK: - Activity 06: Multiplication Table

/// ViewModel da Atividade 06 — gera a tabuada de multiplicação para um número positivo.
final class MultiplicationTableViewModel: ObservableObject {
    /// Número base da tabuada; `nil` enquanto não preenchido.
    @Published var number: Double?
    // Reason: nil = tabela ainda não gerada; [] seria semanticamente incorreto
    // swiftlint:disable:next discouraged_optional_collection
    @Published var table: [(multiplier: Int, result: Int)]?
    /// Mensagem de erro de validação; `nil` quando não há erro.
    @Published var errorMessage: LocalizedStringKey?

    /// Valida o número e gera a tabuada de 1 a 10. Atualiza `table` ou `errorMessage`.
    func generateTable() {
        errorMessage = nil

        do {
            let num: Double = try ValidationService.validatePositiveNumber(number, fieldName: "shared.label.number")
            let intNum: Int = Int(num)
            // swiftlint:disable:next line_length
            let generatedTable: [(multiplier: Int, result: Int)] = CalculationService.generateMultiplicationTable(for: intNum)
            self.table = generatedTable
        } catch let error as ValidationError {
            errorMessage = error.localizedKey
        } catch {
            errorMessage = "shared.error.unknown"
        }
    }

    /// Limpa todos os campos, a tabela gerada e eventuais erros.
    func reset() {
        number = nil
        table = nil
        errorMessage = nil
    }
}
