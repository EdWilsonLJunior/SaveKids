import SwiftUI

// MARK: - Grade Screen
struct GradeScreen: View {
    @StateObject private var viewModel: GradeViewModel = GradeViewModel()
    @Environment(\.locale) private var locale

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.grades.short_title",
            eyebrow: "feature.grades.eyebrow",
            intro: "feature.grades.intro"
        ) {
            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "shared.label.name",
                    placeholder: "shared.placeholder.name",
                    text: $viewModel.name,
                    errorMessage: viewModel.errorMessage
                )

                gradeInputs
            }

            ZodiakButtonPrimary(title: "feature.grades.calculate_action", action: viewModel.submit)

            if let result: Grade = viewModel.result {
                VStack(spacing: ZodiakSpacing.s16) {
                    let averageValue: String = String(format: "%.1f", result.average)
                    let subtitle: String = result.average >= GradeConstants.passingGrade
                        ? "feature.grades.above_average"
                        : "feature.grades.below_average"

                    ZodiakResultCard(
                        title: String(
                            format: String(localized: "feature.grades.student_label", locale: locale),
                            result.name),
                        value: averageValue,
                        subtitle: subtitle
                    )

                    HStack(spacing: ZodiakSpacing.s8) {
                        if result.isPassing {
                            ZodiakSuccessBadge(text: "shared.state.passed_decorated")
                        } else {
                            ZodiakErrorBadge(text: "shared.state.failed_decorated")
                        }
                        Spacer()
                    }

                    ZodiakButtonSecondary(title: "shared.action.clear", action: viewModel.reset)
                }
            }
        }
        .accessibilityIdentifier("screen.01.grades")
    }

    @ViewBuilder
    private var gradeInputs: some View {
        Group {
            ForEach(Array(0..<GradeConstants.minGradeCount), id: \.self) { index in
                labelledField(for: index)
            }
        }
    }

    @ViewBuilder
    private func labelledField(for index: Int) -> some View {
        let label: String = GradeConstants.gradeLabels[index]

        ZodiakLabelledNumericField(
            label: label,
            placeholder: "feature.grades.range_hint",
            value: $viewModel.grades[index],
            minimum: GradeConstants.minGrade,
            maximum: GradeConstants.maxGrade,
            errorMessage: viewModel.gradeErrors[index],
            onSubmit: viewModel.submit
        )
    }
}

#Preview {
    GradeScreen()
}
