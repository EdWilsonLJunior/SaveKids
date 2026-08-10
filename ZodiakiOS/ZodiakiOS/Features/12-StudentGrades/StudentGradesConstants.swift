import Foundation

// MARK: - Constants
enum StudentGradesConstants {
    static let passingGrade: Double = 7.0
    static let criticalAbsences: Int = 15

    // MARK: - Sample Data
    static let sampleStudents: [Student] = [
        Student(
            name: "Ana Souza",
            absences: 4,
            address: "Rua das Flores, 123 — São Paulo, SP",
            phone: "(11) 91234-5678",
            subjects: [
                Subject(name: "Matemática", grade: 8.5),
                Subject(name: "Português", grade: 7.2),
                Subject(name: "História", grade: 9.0),
                Subject(name: "Física", grade: 6.8)
            ]
        ),
        Student(
            name: "Bruno Lima",
            absences: 18,
            address: "Av. Brasil, 456 — Rio de Janeiro, RJ",
            phone: "(21) 98765-4321",
            subjects: [
                Subject(name: "Matemática", grade: 5.0),
                Subject(name: "Português", grade: 6.5),
                Subject(name: "História", grade: 4.0),
                Subject(name: "Física", grade: 3.5)
            ]
        ),
        Student(
            name: "Carla Mendes",
            absences: 2,
            address: "Rua Ipiranga, 78 — Belo Horizonte, MG",
            phone: "(31) 97654-3210",
            subjects: [
                Subject(name: "Matemática", grade: 10.0),
                Subject(name: "Português", grade: 9.5),
                Subject(name: "História", grade: 9.8),
                Subject(name: "Física", grade: 8.7)
            ]
        ),
        Student(
            name: "Diego Rocha",
            absences: 12,
            address: "Rua XV de Novembro, 200 — Curitiba, PR",
            phone: "(41) 96543-2109",
            subjects: [
                Subject(name: "Matemática", grade: 7.0),
                Subject(name: "Português", grade: 6.0),
                Subject(name: "História", grade: 8.0),
                Subject(name: "Física", grade: 5.5)
            ]
        ),
        Student(
            name: "Elisa Costa",
            absences: 0,
            address: "Av. Paulista, 1000 — São Paulo, SP",
            phone: "(11) 95432-1098",
            subjects: [
                Subject(name: "Matemática", grade: 9.2),
                Subject(name: "Português", grade: 8.8),
                Subject(name: "História", grade: 7.5),
                Subject(name: "Física", grade: 9.0)
            ]
        )
    ]
}
