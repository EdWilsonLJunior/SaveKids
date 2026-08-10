import SwiftUI

// MARK: - Student Grades Screen
struct StudentGradesScreen: View {
    @StateObject private var viewModel: StudentGradesViewModel = StudentGradesViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.student_grades.title",
            eyebrow: "feature.student_grades.eyebrow",
            intro: "feature.student_grades.intro"
        ) {
            VStack(spacing: ZodiakSpacing.s4) {
                ForEach(viewModel.students) { student in
                    NavigationLink(destination: StudentDetailView(student: student)) {
                        studentRow(student)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .accessibilityIdentifier("screen.12.student_grades")
    }

    // MARK: - Row

    private func studentRow(_ student: Student) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(verbatim: student.name, style: .title3)
                ZodiakText(
                    verbatim: String(format: "%.1f", student.average),
                    style: .caption()
                )
            }
            Spacer()
            ZodiakChip(
                text: student.isPassing
                    ? "feature.student_grades.status_passing"
                    : "feature.student_grades.status_failing",
                isActive: student.isPassing
            )
            Image(systemName: "chevron.right")
                .foregroundColor(ZodiakColors.textSecondary)
                .font(ZodiakTypography.captionLarge)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    NavigationStack {
        StudentGradesScreen()
    }
}
