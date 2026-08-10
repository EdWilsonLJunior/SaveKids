import SwiftUI

// MARK: - Zodiak Radio Button
// Figma: "Radio" — single selection control
// Spec sizes: small = 18×18px, large = 24×24px

// MARK: - ZodiakRadioState

/// Combined interaction state for a Zodiak radio button.
public enum ZodiakRadioState {
    /// Normal interactive state.
    case normal

    /// Input is disabled and cannot be selected.
    case disabled
}

/// Size variants for `ZodiakRadioButton` per Zodiak spec.
public enum ZodiakRadioSize {
    /// Compact size (18×18px) — suited for dense layouts.
    case small

    /// Standard size (24×24px) — default, suited for spacious layouts.
    case large

    var outerDiameter: CGFloat {
        self == .small ? 18 : 24
    }

    var innerDiameter: CGFloat {
        self == .small ? 9 : 12
    }
}

public struct ZodiakRadioButton: View {
    let label: String
    let isSelected: Bool

    /// Preferred way to set radio state. When provided, `isDisabled` is ignored.
    var state: ZodiakRadioState?

    /// Deprecated: use `state: .disabled` instead.
    @available(*, deprecated, renamed: "state")
    var isDisabled: Bool

    var size: ZodiakRadioSize
    let onTap: () -> Void

    public init(
        label: String,
        isSelected: Bool,
        state: ZodiakRadioState? = nil,
        isDisabled: Bool = false,
        size: ZodiakRadioSize = .large,
        onTap: @escaping () -> Void
    ) {
        self.label = label
        self.isSelected = isSelected
        self.state = state
        self.isDisabled = isDisabled
        self.size = size
        self.onTap = onTap
    }

    // MARK: - Resolved state helper

    private var effectiveIsDisabled: Bool {
        if let state {
            return state == .disabled
        }

        return isDisabled
    }

    public var body: some View {
        Button(
            action: {
                if !effectiveIsDisabled {
                    onTap()
                }
            },
            label: {
                HStack(spacing: ZodiakSpacing.s8) {
                    ZStack {
                        Circle()
                            .stroke(
                                effectiveIsDisabled
                                    ? ZodiakColors.actionDisabledContent
                                    : isSelected
                                        ? ZodiakColors.actionPrimary
                                        : ZodiakColors.borderPrimary,
                                lineWidth: isSelected ? 2 : 1.5
                            )
                            .frame(width: size.outerDiameter, height: size.outerDiameter)

                        if isSelected {
                            Circle()
                                .fill(
                                    effectiveIsDisabled
                                        ? ZodiakColors.actionDisabledContent
                                        : ZodiakColors.actionPrimary
                                )
                                .frame(width: size.innerDiameter, height: size.innerDiameter)
                        }
                    }

                    Text(LocalizedStringKey(label))
                        .font(ZodiakTypography.bodyMedium)
                        .foregroundColor(effectiveIsDisabled ? ZodiakColors.textDisabled : ZodiakColors.textPrimary)

                    Spacer(minLength: 0)
                }
                .contentShape(Rectangle())
            }
        )
        .buttonStyle(.plain)
        .disabled(effectiveIsDisabled)
        .animation(.spring(response: 0.2, dampingFraction: 0.75), value: isSelected)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
        .accessibilityLabel(label)
        .accessibilityValue(Text(isSelected ? "shared.state.selected" : "shared.state.not_selected"))
        .accessibilityHint(effectiveIsDisabled ? Text("shared.state.unavailable") : Text(verbatim: ""))
        .zodiakA11yID("radio", role: isSelected ? "selected" : "unselected", context: label)
    }
}

// MARK: - ZodiakRadioGroup

public struct ZodiakRadioGroup<T: Hashable>: View {
    let title: String?
    let options: [(label: String, value: T)]
    @Binding var selection: T?
    let isDisabled: Bool
    var size: ZodiakRadioSize

    public init(
        title: String? = nil,
        options: [(label: String, value: T)],
        selection: Binding<T?>,
        isDisabled: Bool = false,
        size: ZodiakRadioSize = .large
    ) {
        self.title = title
        self.options = options
        self._selection = selection
        self.isDisabled = isDisabled
        self.size = size
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            if let title {
                Text(LocalizedStringKey(title))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(isDisabled ? ZodiakColors.textDisabled : ZodiakColors.textSecondary)
            }

            ForEach(options, id: \.value) { option in
                ZodiakRadioButton(
                    label: option.label,
                    isSelected: selection == option.value,
                    state: isDisabled ? .disabled : .normal,
                    size: size
                ) {
                    withAnimation {
                        selection = option.value
                    }
                }
            }
        }
    }
}
