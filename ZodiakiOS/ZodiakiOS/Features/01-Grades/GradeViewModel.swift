import Combine
import SwiftUI

// MARK: - Activity 01: Grades

/// ViewModel da Atividade 01 — valida três notas e calcula média e situação do aluno.
final class GradeViewModel: ObservableObject {
    /// Nome do aluno fornecido pelo usuário.
    @Published var name: String = ""
    /// Três notas digitáveis pelo usuário; `nil` enquanto não preenchidas.
    @Published var grades: [Double?] = Array(repeating: nil, count: GradeConstants.minGradeCount)
    /// Resultado calculado após submissão bem-sucedida; `nil` antes da validação.
    @Published var result: Grade?
    /// Mensagem de erro geral (ex.: nome vazio); `nil` quando não há erro.
    @Published var errorMessage: LocalizedStringKey?
    /// Erros individuais por nota; `nil` em cada posição quando a nota é válida.
    @Published var gradeErrors: [LocalizedStringKey?] = Array(repeating: nil, count: GradeConstants.minGradeCount)

    private func validateGradeInput(at index: Int) -> Double? {
        guard index < grades.count else { return nil }

        do {
            let validatedGrade: Double = try ValidationService.validateGrade(grades[index])
            return validatedGrade
        } catch let error as ValidationError {
            gradeErrors[index] = error.localizedKey
            return nil
        } catch {
            gradeErrors[index] = "shared.error.unknown"
            return nil
        }
    }

    private func clearErrors() {
        errorMessage = nil
        gradeErrors = Array(repeating: nil, count: GradeConstants.minGradeCount)
        result = nil
    }

    /// Valida nome e as três notas e, em caso de sucesso, atualiza `result`.
    /// Em caso de falha, preenche `errorMessage` ou `gradeErrors`.
    func submit() {
        ZodiakLog.info(.viewModel, "GradeViewModel.submit() started [trace=\(ZodiakTrace.short)]")
        clearErrors()

        // Validar nome
        do {
            try ValidationService.validateNotEmpty(name, fieldName: "shared.label.name")
        } catch let error as ValidationError {
            ZodiakSessionMetrics.shared.trackValidationError()
            let errorDesc = String(describing: error)
            ZodiakLog.warning(.error,
                              "GradeViewModel validation failed error=\(errorDesc) [trace=\(ZodiakTrace.short)]",
                              metadata: ["field": "name", "error_type": errorDesc])
            errorMessage = error.localizedKey
            return
        } catch {
            errorMessage = "shared.error.unknown"
            return
        }

        // Validar todas as notas
        let validGrades: [Double] = (0..<GradeConstants.minGradeCount)
            .compactMap { (index: Int) -> Double? in validateGradeInput(at: index) }

        guard validGrades.count == GradeConstants.minGradeCount else {
            ZodiakSessionMetrics.shared.trackValidationError()
            let msg = "GradeViewModel validation failed — invalid grade inputs [trace=\(ZodiakTrace.short)]"
            ZodiakLog.warning(.error, msg, metadata: ["field": "grades"])
            return
        }

        let grade: Grade = Grade(
            name: name,
            grade1: validGrades[0],
            grade2: validGrades[1],
            grade3: validGrades[2]
        )
        self.result = grade
        let msg = "GradeViewModel.submit() succeeded average=\(grade.average) [trace=\(ZodiakTrace.short)]"
        ZodiakLog.info(.viewModel, msg,
                       metadata: ["status": grade.isPassing ? "passing" : "failing"],
                       metrics: ["average": grade.average])
    }

    /// Limpa todos os campos de entrada, erros e o resultado calculado.
    func reset() {
        ZodiakLog.info(.viewModel, "GradeViewModel.reset() [trace=\(ZodiakTrace.short)]")
        name = ""
        grades = Array(repeating: nil, count: GradeConstants.minGradeCount)
        result = nil
        clearErrors()
    }
}
