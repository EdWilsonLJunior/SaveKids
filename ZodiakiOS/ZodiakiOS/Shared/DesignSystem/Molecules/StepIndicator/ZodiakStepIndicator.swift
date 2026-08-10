import SwiftUI

// MARK: - Zodiak Step Indicator
// Figma: "Stepper" — horizontal step wizard progress indicator

public struct ZodiakStepIndicator: View {
    let steps: [String]
    let currentStep: Int  // 0-indexed

    public init(steps: [String], currentStep: Int) {
        self.steps = steps
        self.currentStep = currentStep
    }

    public var body: some View {
        VStack(spacing: ZodiakSpacing.s4) {
            // Dots + connectors
            HStack(spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, _ in
                    stepCircle(index: index)

                    if index < steps.count - 1 {
                        connector(index: index)
                    }
                }
            }

            // Labels
            HStack(spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, label in
                    Text(LocalizedStringKey(label))
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(labelColor(for: index))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("shared.label.step_indicator"))
        .accessibilityValue(
            Text(verbatim: String(
                format: String(localized: "shared.format.step_progress"),
                currentStep + 1,
                steps.count
            ))
        )
        .zodiakA11yID("step", role: "indicator")
    }

    private var currentStepLabel: String {
        guard currentStep >= 0, currentStep < steps.count else { return "" }
        return steps[currentStep]
    }

    private func stepCircle(index: Int) -> some View {
        let state = stepState(index)
        return ZStack {
            Circle()
                .fill(circleFill(for: state))
                .overlay(Circle().stroke(circleBorder(for: state), lineWidth: 1.5))
                .frame(width: 28, height: 28)

            if state == .completed {
                Image(systemName: "checkmark")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ZodiakColors.textInverse)
            } else {
                Text("\(index + 1)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(numberColor(for: state))
            }
        }
    }

    private func connector(index: Int) -> some View {
        let isCompleted = index < currentStep
        return Rectangle()
            .fill(isCompleted ? ZodiakColors.actionPrimary : ZodiakColors.borderPrimary)
            .frame(height: 2)
            .frame(maxWidth: .infinity)
    }

    private enum StepState { case completed, current, upcoming }

    private func stepState(_ index: Int) -> StepState {
        if index < currentStep { return .completed }
        if index == currentStep { return .current }
        return .upcoming
    }

    private func circleFill(for state: StepState) -> Color {
        switch state {
        case .completed: return ZodiakColors.actionPrimary
        case .current:   return ZodiakColors.surface
        case .upcoming:  return ZodiakColors.surfaceSmoke
        }
    }

    private func circleBorder(for state: StepState) -> Color {
        switch state {
        case .completed: return ZodiakColors.actionPrimary
        case .current:   return ZodiakColors.actionPrimary
        case .upcoming:  return ZodiakColors.borderPrimary
        }
    }

    private func numberColor(for state: StepState) -> Color {
        switch state {
        case .completed: return ZodiakColors.textInverse
        case .current:   return ZodiakColors.actionPrimary
        case .upcoming:  return ZodiakColors.textDisabled
        }
    }

    private func labelColor(for index: Int) -> Color {
        if index == currentStep { return ZodiakColors.textPrimary }
        if index < currentStep { return ZodiakColors.actionPrimary }
        return ZodiakColors.textDisabled
    }
}
