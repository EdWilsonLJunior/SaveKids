import SwiftUI

// MARK: - Zodiak Slide To Submit
// Figma: "Button slide to submit"
// User slides a thumb to the right end to confirm a high-stakes action.
// Resets automatically on incomplete release.

struct ZodiakSlideToSubmit: View {
    let label: String
    let onSubmit: () -> Void
    var isEnabled: Bool = true

    @State private var dragOffset: CGFloat = 0
    @State private var isCompleted: Bool = false
    @State private var trackWidth: CGFloat = 0

    private let thumbDiameter: CGFloat = 44
    private let padding: CGFloat = ZodiakSpacing.s4
    private var maxDrag: CGFloat { trackWidth - thumbDiameter - padding * 2 }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Track background
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .fill(isCompleted
                        ? ZodiakColors.actionActive
                        : (isEnabled ? ZodiakColors.actionPrimary.opacity(0.12) : ZodiakColors.actionDisabled))

                // Fill progress
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .fill(isCompleted ? ZodiakColors.actionActive : ZodiakColors.actionPrimary.opacity(0.25))
                    .frame(width: thumbDiameter + padding + dragOffset + padding)

                // Label (fades as thumb advances)
                Text(isCompleted ? "Enviado!" : label)
                    .font(ZodiakTypography.button)
                    // swiftlint:disable:next line_length
                    .foregroundColor(isCompleted ? ZodiakColors.textInverse : (isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled))
                    .opacity(isCompleted ? 1 : max(0, 1 - (dragOffset / max(1, maxDrag)) * 2))
                    .frame(maxWidth: .infinity)

                // Thumb
                ZStack {
                    Circle()
                        .fill(isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.actionDisabled)
                        .frame(width: thumbDiameter, height: thumbDiameter)
                    Image(systemName: isCompleted ? "checkmark" : "chevron.right.2")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(ZodiakColors.textInverse)
                }
                .offset(x: padding + dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            guard isEnabled, !isCompleted else { return }
                            dragOffset = min(max(0, value.translation.width), maxDrag)
                        }
                        .onEnded { _ in
                            guard isEnabled, !isCompleted else { return }
                            if dragOffset >= maxDrag * 0.9 {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    dragOffset = maxDrag
                                    isCompleted = true
                                }
                                let generator = UIImpactFeedbackGenerator(style: .heavy)
                                generator.impactOccurred()
                                onSubmit()
                            } else {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    dragOffset = 0
                                }
                            }
                        }
                )
            }
            .frame(height: thumbDiameter + padding * 2)
            .onAppear { trackWidth = geo.size.width }
            .onChange(of: geo.size.width) { _, newWidth in trackWidth = newWidth }
        }
        .frame(height: thumbDiameter + padding * 2)
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityHint(isEnabled ? Text("shared.action.slide_to_confirm") : Text("shared.state.unavailable"))
        .accessibilityAddTraits(isCompleted ? [.isSelected] : [])
        .zodiakA11yID("slide-to-submit")
    }

    /// Resets to initial state (use when parent needs to allow re-submission)
    func reset() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            dragOffset = 0
            isCompleted = false
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: ZodiakSpacing.s32) {
        ZodiakSlideToSubmit(label: "Deslize para confirmar pagamento", onSubmit: {})

        ZodiakSlideToSubmit(label: "Deslize para enviar proposta", onSubmit: {})

        ZodiakSlideToSubmit(label: "Ação desabilitada", onSubmit: {}, isEnabled: false)
    }
    .padding()
    .background(ZodiakColors.background)
}
