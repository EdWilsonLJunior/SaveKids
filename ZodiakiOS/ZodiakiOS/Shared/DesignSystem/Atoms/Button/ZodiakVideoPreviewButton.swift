import SwiftUI

// MARK: - Zodiak Video Preview Button
// Figma: "Video preview button" — pause/resume auto-played video previews.
// Placed at bottom-right corner of the video container.
// Background: rgba(0,0,0,0.20) + ultraThin blur (onPhoto spec).
// Stroke: 1px mobile · 1.4px desktop.
//
// Two operating modes:
//   Manual  — pass `progress: Double?` and manage the value externally.
//   Auto    — pass `duration: TimeInterval` and let the component manage its own
//             timer, pause/resume, and fire `onComplete` when it reaches 100%.

struct ZodiakVideoPreviewButton: View {
    @Binding var isPlaying: Bool

    // MARK: Manual mode
    /// External progress 0.0–1.0. Ignored when `duration` is set. Pass nil to hide the ring.
    var progress: Double?

    // MARK: Auto mode
    /// When set, the component owns a timer that drives the progress ring for this duration.
    var duration: TimeInterval?
    /// Called once when auto-mode playback reaches 100%. Not called in manual mode.
    var onComplete: (() -> Void)?

    let action: () -> Void
    var size: ZodiakIconButtonSize = .large
    /// When false the progress ring is hidden but the button size stays constant.
    var showRing: Bool = true
    /// Ring stroke weight: 1px (mobile), 1.4px (desktop). Default 1px.
    var strokeWidth: CGFloat = 1.0

    // MARK: Internal auto-mode state
    @State private var internalProgress: Double = 0.0
    @State private var timer: Timer?
    @State private var elapsed: Double = 0.0

    // The progress value actually rendered by the ring.
    private var displayProgress: Double? {
        guard showRing else { return nil }
        if duration != nil { return internalProgress > 0 || isPlaying ? internalProgress : nil }
        return progress
    }

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                isPlaying.toggle()
            }
            if duration != nil {
                if isPlaying { startTimer() } else { pauseTimer() }
            }
            action()
        } label: {
            ZStack {
                // Progress ring — behind icon
                if let displayProgress {
                    Circle()
                        .stroke(Color.white.opacity(0.25), lineWidth: strokeWidth)
                        .frame(width: size.diameter + 10, height: size.diameter + 10)

                    Circle()
                        .trim(from: 0, to: CGFloat(max(0, min(1, displayProgress))))
                        .stroke(
                            Color.white,
                            style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                        )
                        .frame(width: size.diameter + 10, height: size.diameter + 10)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 0.05), value: displayProgress)
                }

                // Icon — blurred onPhoto background
                ZodiakIconView(isPlaying ? .pauseFilled : .playFilled, size: .medium, color: .white)
                    .frame(width: size.diameter, height: size.diameter)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .overlay(Circle().fill(Color.black.opacity(0.20)))
                    )
            }
        }
        .buttonStyle(ZodiakVideoPreviewPressedStyle())
        .expandedTouchTarget()
        .accessibilityLabel(isPlaying ? Text("shared.action.pause_preview") : Text("shared.action.play_preview"))
        .accessibilityAddTraits(.isButton)
        .onAppear {
            // Auto-start when component appears with isPlaying = true and a duration set.
            if duration != nil && isPlaying { startTimer() }
        }
        .onDisappear { stopTimer() }
        .onChange(of: isPlaying) { _, playing in
            guard duration != nil else { return }
            if playing { startTimer() } else { pauseTimer() }
        }
    }

    // MARK: - Timer helpers

    private func startTimer() {
        guard timer == nil, let duration else { return }
        let tickInterval: Double = 0.05
        timer = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true) { _ in
            elapsed += tickInterval
            internalProgress = min(1.0, elapsed / duration)
            if internalProgress >= 1.0 {
                stopTimer()
                withAnimation(.easeInOut(duration: 0.15)) { isPlaying = false }
                onComplete?()
            }
        }
    }

    private func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        elapsed = 0.0
        internalProgress = 0.0
    }
}

// MARK: - Pressed Style

private struct ZodiakVideoPreviewPressedStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview("Manual mode") {
    @Previewable @State var isPlaying = true
    @Previewable @State var progress = 0.35

    VStack(spacing: ZodiakSpacing.s32) {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                .fill(ZodiakColors.surfaceMarine)
                .frame(height: 200)
            ZodiakVideoPreviewButton(isPlaying: $isPlaying, progress: progress, action: {})
                .padding(ZodiakSpacing.s8)
        }
        HStack(spacing: ZodiakSpacing.s8) {
            Button("catalog.spec.decrement_10pct") { progress = max(0, progress - 0.1) }
            Button("catalog.spec.increment_10pct") { progress = min(1, progress + 0.1) }
        }
        .font(ZodiakTypography.captionLarge)
    }
    .padding()
    .background(ZodiakColors.background)
}

#Preview("Auto mode — 5s") {
    @Previewable @State var isPlaying = false

    VStack(spacing: ZodiakSpacing.s32) {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                .fill(ZodiakColors.surfaceInk)
                .frame(height: 200)
            ZodiakVideoPreviewButton(
                isPlaying: $isPlaying,
                duration: 5.0,
                onComplete: { ZodiakLog.debug(.service, "ZodiakVideoPreviewButton preview ended") },
                action: {}
            )
            .padding(ZodiakSpacing.s8)
        }
        ZodiakText("Tap the button to play/pause", style: .caption())
    }
    .padding()
    .background(ZodiakColors.background)
}
