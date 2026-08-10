import Combine
import SwiftUI

// MARK: - Activity 12: StudentGrades
final class StudentGradesViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var students: [Student] = StudentGradesConstants.sampleStudents
}
