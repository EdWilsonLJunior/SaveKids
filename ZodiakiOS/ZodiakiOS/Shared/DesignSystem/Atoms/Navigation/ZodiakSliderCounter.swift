import SwiftUI

// MARK: - Zodiak Slider Counter
// Figma: "Slider counter" — navigation control for carousel/slider content.
// Anatomy:  ← chevron  |  progress bar  |  "1 / N" label (optional)  |  chevron →
// Supports 2–9 items. Circular navigation (wraps around at both ends).

struct ZodiakSliderCounter: View {
    let totalItems: Int
    @Binding var currentIndex: Int
    /// Show the "1 / N" numeric counter label. Defaults to true.
    var showCounter: Bool = true
    /// Show previous/next arrow buttons. Defaults to true.
    var showNavigationButtons: Bool = true

    @Environment(\.locale) private var locale

    private var progress: CGFloat {
        guard totalItems > 1 else { return 1 }
        return CGFloat(currentIndex + 1) / CGFloat(totalItems)
    }

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            // Previous chevron
            if showNavigationButtons {
                ZodiakCircularArrowButton(action: previous, direction: .left, style: .secondary)
            }

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(ZodiakColors.borderSecondary)
                    Capsule()
                        .fill(ZodiakColors.actionPrimary)
                        .frame(width: geo.size.width * progress)
                        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: currentIndex)
                }
            }
            .frame(height: 4)

            // Optional numeric counter
            if showCounter {
                Text(verbatim: "\(currentIndex + 1) / \(totalItems)")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .monospacedDigit()
                    .frame(minWidth: 40, alignment: .center)
            }

            // Next chevron
            if showNavigationButtons {
                ZodiakCircularArrowButton(action: next, direction: .right, style: .secondary)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("shared.label.slide_counter"))
        .accessibilityValue(
            Text(verbatim: String(
                format: String(localized: "shared.format.slide_of", locale: locale),
                currentIndex + 1,
                totalItems
            ))
        )
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: next()
            case .decrement: previous()
            @unknown default: break
            }
        }
        .zodiakA11yID("slider", role: "counter")
    }

    private func previous() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
            currentIndex = (currentIndex - 1 + totalItems) % totalItems
        }
    }

    private func next() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
            currentIndex = (currentIndex + 1) % totalItems
        }
    }
}

// MARK: - Preview

#Preview("Slider Counter") {
    @Previewable @State var index3 = 0
    @Previewable @State var index5 = 2
    @Previewable @State var index9 = 0

    VStack(spacing: ZodiakSpacing.s32) {
        // 3 items with counter
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text("3 itens — com contador")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
            ZodiakSliderCounter(totalItems: 3, currentIndex: $index3)
        }

        // 5 items without counter
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text("5 itens — sem contador")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
            ZodiakSliderCounter(totalItems: 5, currentIndex: $index5, showCounter: false)
        }

        // 9 items
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text("9 itens — máximo").font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)
            ZodiakSliderCounter(totalItems: 9, currentIndex: $index9)
        }
    }
    .padding()
    .background(ZodiakColors.background)
}
