import SwiftUI

/// Controle de contagem com botões – e +
struct ZodiakCounterControl: View {
    @Binding var value: Int
    let min: Int
    let max: Int
    var step: Int = 1
    var label: LocalizedStringKey = "catalog.counter.label_attempts"

    private var canDecrement: Bool { value > min }
    private var canIncrement: Bool { value < max }

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Button {
                if canDecrement { value -= step }
            } label: {
                ZodiakIconView(
                    .removeMinus,
                    size: .large,
                    color: canDecrement ? ZodiakColors.actionPrimary : ZodiakColors.borderPrimary
                )
            }
            .disabled(!canDecrement)
            .accessibilityLabel(Text("shared.action.decrease"))
            .zodiakA11yID("counter", role: "decrement")

            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakText(label, style: .caption())
                Text(verbatim: "\(value)")
                    .font(ZodiakTypography.titleMedium)
                    .foregroundColor(ZodiakColors.actionPrimary)
            }
            .frame(maxWidth: .infinity)

            Button {
                if canIncrement { value += step }
            } label: {
                ZodiakIconView(
                    .addPlus,
                    size: .large,
                    color: canIncrement ? ZodiakColors.actionPrimary : ZodiakColors.borderPrimary
                )
            }
            .disabled(!canIncrement)
            .accessibilityLabel(Text("shared.action.increase"))
            .zodiakA11yID("counter", role: "increment")
        }
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}

#Preview {
    ZodiakCounterControl(value: .constant(3), min: 0, max: 10)
        .padding(ZodiakSpacing.s16)
        .background(ZodiakColors.background)
}
