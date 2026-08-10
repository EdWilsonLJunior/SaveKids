import SwiftUI

// MARK: - Student Detail View
struct StudentDetailView: View {
    let student: Student

    var body: some View {
        ZodiakActivityTemplate(
            title: student.name,
            eyebrow: "feature.student_grades.eyebrow"
        ) {
            gradesSection
            absencesSection
            contactSection
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Sections

    private var gradesSection: some View {
        ZodiakAccordion(
            title: "feature.student_grades.section_grades",
            leadingIcon: "book.closed",
            initiallyExpanded: true
        ) {
            VStack(spacing: ZodiakSpacing.s4) {
                ForEach(student.subjects) { subject in
                    HStack {
                        ZodiakText(verbatim: subject.name, style: .body())
                        Spacer()
                ZodiakText(
                    verbatim: String(format: "%.1f", subject.grade),
                    style: .body(
                        bold: true,
                        color: subject.grade < StudentGradesConstants.passingGrade ? .negative : .primary
                    )
                )
                    }
                }
                ZodiakDivider(hierarchy: .secondary)
                ZodiakInfoRow(
                    label: String(localized: "feature.student_grades.average"),
                    value: String(format: "%.1f", student.average)
                )
            }
        }
    }

    private var absencesSection: some View {
        ZodiakAccordion(
            title: "feature.student_grades.section_attendance",
            leadingIcon: "calendar.badge.exclamationmark",
            initiallyExpanded: false
        ) {
            HStack {
                ZodiakText("feature.student_grades.absences_label", style: .body())
                Spacer()
                ZodiakText(verbatim: String(student.absences), style: .body(bold: true))
            }
            .padding(ZodiakSpacing.s8)
            .background(
                student.hasCriticalAbsences
                    ? ZodiakColors.surfaceNegative
                    : ZodiakColors.surface
            )
            .cornerRadius(ZodiakRadii.xs)
        }
    }

    private var contactSection: some View {
        ZodiakAccordion(
            title: "feature.student_grades.section_contact",
            leadingIcon: "person.crop.rectangle",
            initiallyExpanded: false
        ) {
            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakInfoRow(
                    label: String(localized: "feature.student_grades.address_label"),
                    value: student.address
                )
                ZodiakInfoRow(
                    label: String(localized: "feature.student_grades.phone_label"),
                    value: student.phone
                )
            }
        }
    }
}
