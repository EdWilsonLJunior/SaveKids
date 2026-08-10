import SwiftUI

// MARK: - Zodiak Progress Indicator
// Figma: "Progress" — linear progress bar + circular progress ring

// MARK: - ZodiakProgressKind

/// The visual kind of a ``ZodiakProgressIndicator``.
enum ZodiakProgressKind {
    /// A horizontal bar that fills from left to right.
    case linear
    /// A circular ring that fills clockwise.
    case circular
}

// MARK: - ZodiakProgressIndicator (unified entry point)

/// A unified Zodiak progress indicator.
///
/// Pass `value: nil` for an indeterminate/spinning state.
///
/// ## Usage
/// ```swift
/// ZodiakProgressIndicator(value: 0.6, kind: .linear)
/// ZodiakProgressIndicator(value: nil, kind: .circular)
/// ```
struct ZodiakProgressIndicator: View {
    /// 0.0–1.0 progress value, or `nil` for indeterminate.
    let value: Double?
    /// Visual kind of the indicator.
    var kind: ZodiakProgressKind
    /// Size in points. For `.linear` this is the track height (default 6).
    /// For `.circular` this is the diameter (default 56).
    var size: CGFloat?
    /// Accent colour override. Defaults to `ZodiakColors.actionPrimary`.
    var color: Color?

    init(
        value: Double?,
        kind: ZodiakProgressKind = .linear,
        size: CGFloat? = nil,
        color: Color? = nil
    ) {
        self.value = value.map { max(0, min(1, $0)) }
        self.kind = kind
        self.size = size
        self.color = color
    }

    var body: some View {
        switch kind {
        case .linear:
            if let value {
                ZodiakProgressBar(progress: value, color: color)
            } else {
                ZodiakSpinner(size: size ?? 24, color: color)
            }

        case .circular:
            if let value {
                ZodiakProgressRing(
                    progress: value,
                    size: size ?? 56,
                    color: color,
                    showLabel: false
                )
            } else {
                ZodiakSpinner(size: size ?? 24, color: color)
            }
        }
    }
}

public struct ZodiakProgressBar: View {
    let progress: Double   // 0.0 – 1.0
    let color: Color?
    let showLabel: Bool

    public init(progress: Double, color: Color? = nil, showLabel: Bool = false) {
        self.progress = max(0, min(1, progress))
        self.color = color
        self.showLabel = showLabel
    }

    public var body: some View {
        VStack(alignment: .trailing, spacing: ZodiakSpacing.s4) {
            if showLabel {
                Text(verbatim: "\(Int(progress * 100))%")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: ZodiakRadii.l, style: .continuous)
                        .fill(ZodiakColors.borderPrimary.opacity(0.5))
                        .frame(height: 6)

                    RoundedRectangle(cornerRadius: ZodiakRadii.l, style: .continuous)
                        .fill(color ?? ZodiakColors.actionPrimary)
                        .frame(width: geo.size.width * progress, height: 6)
                        .animation(.spring(response: 0.5, dampingFraction: 0.85), value: progress)
                }
            }
            .frame(height: 6)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("shared.label.progress"))
        .accessibilityValue(Text(verbatim: "\(Int(progress * 100))%"))
        .accessibilityAddTraits(.updatesFrequently)
        .zodiakA11yID("progress", role: "bar")
    }
}

// MARK: Circular Progress Ring

public struct ZodiakProgressRing: View {
    let progress: Double   // 0.0 – 1.0
    let size: CGFloat
    let lineWidth: CGFloat
    let color: Color?
    let showLabel: Bool

    public init(
        progress: Double,
        size: CGFloat = 56,
        lineWidth: CGFloat = 5,
        color: Color? = nil,
        showLabel: Bool = true
    ) {
        self.progress = max(0, min(1, progress))
        self.size = size
        self.lineWidth = lineWidth
        self.color = color
        self.showLabel = showLabel
    }

    public var body: some View {
        ZStack {
            Circle()
                .stroke(ZodiakColors.borderPrimary.opacity(0.4), lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color ?? ZodiakColors.actionPrimary,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)

            if showLabel {
                Text(verbatim: "\(Int(progress * 100))%")
                    .font(.system(size: size * 0.22, weight: .semibold))
                    .foregroundColor(ZodiakColors.textPrimary)
            }
        }
        .frame(width: size, height: size)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("shared.label.progress"))
        .accessibilityValue(Text(verbatim: "\(Int(progress * 100))%"))
        .accessibilityAddTraits(.updatesFrequently)
        .zodiakA11yID("progress", role: "ring")
    }
}

// MARK: Indeterminate Spinner

public struct ZodiakSpinner: View {
    let size: CGFloat
    let color: Color?
    @State private var rotation = 0.0

    public init(size: CGFloat = 24, color: Color? = nil) {
        self.size = size
        self.color = color
    }

    public var body: some View {
        Circle()
            .trim(from: 0.1, to: 0.9)
            .stroke(
                color ?? ZodiakColors.actionPrimary,
                style: StrokeStyle(lineWidth: size * 0.13, lineCap: .round)
            )
            .frame(width: size, height: size)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(.linear(duration: 0.9).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
            .accessibilityLabel(Text("shared.state.loading"))
            .accessibilityAddTraits(.updatesFrequently)
            .zodiakA11yID("progress", role: "spinner")
    }
}
