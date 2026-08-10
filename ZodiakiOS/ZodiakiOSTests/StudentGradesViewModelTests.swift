import Foundation
import Testing
@testable import ZodiakiOS

// MARK: - StudentGradesViewModel Tests

@Suite("StudentGradesViewModel")
struct StudentGradesViewModelTests {
    @Test("estado inicial carrega alunos de amostra")
    func initialStateHasSampleStudents() {
        let vm = StudentGradesViewModel()
        #expect(!vm.students.isEmpty)
        #expect(vm.students.count == StudentGradesConstants.sampleStudents.count)
    }

    @Test("média calculada corretamente para aluno com 4 matérias")
    func averageCalculatedCorrectly() {
        let student = Student(
            name: "Test",
            absences: 0,
            address: "",
            phone: "",
            subjects: [
                Subject(name: "A", grade: 6.0),
                Subject(name: "B", grade: 8.0),
                Subject(name: "C", grade: 10.0),
                Subject(name: "D", grade: 4.0)
            ]
        )
        #expect(student.average == 7.0)
    }

    @Test("isPassing é true quando média >= 7.0")
    func isPassingTrueAtThreshold() {
        let student = Student(
            name: "Test",
            absences: 0,
            address: "",
            phone: "",
            subjects: [Subject(name: "A", grade: 7.0)]
        )
        #expect(student.isPassing)
    }

    @Test("isPassing é false quando média < 7.0")
    func isPassingFalseBelowThreshold() {
        let student = Student(
            name: "Test",
            absences: 0,
            address: "",
            phone: "",
            subjects: [Subject(name: "A", grade: 6.9)]
        )
        #expect(!student.isPassing)
    }

    @Test("hasCriticalAbsences é true quando faltas >= 15")
    func criticalAbsencesAtThreshold() {
        let student = Student(
            name: "Test",
            absences: 15,
            address: "",
            phone: "",
            subjects: [Subject(name: "A", grade: 8.0)]
        )
        #expect(student.hasCriticalAbsences)
    }

    @Test("hasCriticalAbsences é false quando faltas < 15")
    func criticalAbsencesBelowThreshold() {
        let student = Student(
            name: "Test",
            absences: 14,
            address: "",
            phone: "",
            subjects: [Subject(name: "A", grade: 8.0)]
        )
        #expect(!student.hasCriticalAbsences)
    }

    @Test("média de aluno sem matérias retorna 0")
    func averageWithNoSubjectsReturnsZero() {
        let student = Student(name: "Test", absences: 0, address: "", phone: "", subjects: [])
        #expect(student.average == 0)
    }
}
