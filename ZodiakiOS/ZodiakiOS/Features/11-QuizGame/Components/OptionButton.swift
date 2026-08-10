import SwiftUI

// MARK: - Option Button State
enum OptionState {
    case normal
    case selected
    case correct
    case incorrect
}

// MARK: - Option Button Component
struct OptionButton: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) private var locale
    let text: String
    let index: Int
    let state: OptionState
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: ZodiakSpacing.s8) {
                Text(optionLabel)
                    .font(ZodiakTypography.bodySmall.weight(.semibold))
                    .foregroundColor(labelColor)
                    .frame(width: 28, height: 28)
                    .background(labelBackground)
                    .cornerRadius(ZodiakRadii.xs)

                ZodiakText(text, style: .body())

                Spacer()

                if state == .correct {
                    ZodiakIconView(.circleCheck, size: .small, color: ZodiakColors.textPositive)
                }
                if state == .incorrect {
                    ZodiakIconView(.close, size: .small, color: ZodiakColors.textNegative)
                }
            }
            .padding(ZodiakSpacing.s8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(ZodiakRadii.s)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .stroke(borderColor, lineWidth: state == .selected ? 2 : 1)
            )
        }
        .disabled(state == .correct || state == .incorrect)
        .expandedTouchTarget()
        .accessibilityLabel(
            Text(verbatim: String(
                format: String(localized: "feature.quiz_game.option_accessibility", locale: locale),
                index + 1,
                QuizGameConstants.optionsPerQuestion,
                text
            ))
        )
        .accessibilityAddTraits(state == .selected ? .isSelected : [])
    }

    // MARK: - Computed Styling

    private var optionLabel: String {
        let labels = ["A", "B", "C", "D"]
        return labels[index]
    }

    private var backgroundColor: Color {
        switch state {
        case .normal:
            return ZodiakColors.surface

        case .selected:
            return ZodiakColors.surfaceAzur.opacity(ZodiakOpacity.selected)

        case .correct:
            return ZodiakColors.surfacePositive

        case .incorrect:
            return ZodiakColors.surfaceNegative.opacity(ZodiakOpacity.disabled)
        }
    }

    private var borderColor: Color {
        switch state {
        case .normal:
            return ZodiakColors.borderPrimary

        case .selected:
            return ZodiakColors.actionPrimary

        case .correct:
            return ZodiakColors.textPositive

        case .incorrect:
            return ZodiakColors.textNegative
        }
    }

    private var labelColor: Color {
        switch state {
        case .normal:
            return ZodiakColors.textSecondary

        case .selected:
            return .white

        case .correct:
            return .white

        case .incorrect:
            return .white
        }
    }

    private var labelBackground: Color {
        switch state {
        case .normal:
            return ZodiakColors.borderPrimary

        case .selected:
            return ZodiakColors.actionPrimary

        case .correct:
            return ZodiakColors.textPositive

        case .incorrect:
            return ZodiakColors.textNegative
        }
    }
}

#Preview {
    VStack(spacing: ZodiakSpacing.s8) {
        OptionButton(text: "Opção normal", index: 0, state: .normal, onTap: {})
        OptionButton(text: "Opção selecionada", index: 1, state: .selected, onTap: {})
        OptionButton(text: "Opção correta", index: 2, state: .correct, onTap: {})
        OptionButton(text: "Opção incorreta", index: 3, state: .incorrect, onTap: {})
    }
    .padding(ZodiakSpacing.s8)
}
