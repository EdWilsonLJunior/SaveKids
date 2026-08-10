import SwiftUI

// MARK: - Zodiak Divider
// Fonte: Zodiak Design System – Capgemini | Página "Divider lines"
// Specs: Hierarchy (Primary / Secondary), Style (Thin 1pt / Thick 2pt),
//        Orientation (horizontal / vertical), Inset

// MARK: - Supporting types

/// Visual hierarchy of a Zodiak divider line.
enum ZodiakDividerHierarchy {
    case primary, secondary
}

/// Thickness preset for a Zodiak divider line.
enum ZodiakDividerStyle {
    case thin, thick

    var lineWidth: CGFloat {
        self == .thin ? 1 : 2
    }
}

/// Orientation of the divider.
enum ZodiakDividerOrientation {
    /// A horizontal rule that spans available width.
    case horizontal

    /// A vertical rule that spans available height.
    case vertical
}

/// Leading/trailing inset applied to the divider line.
enum ZodiakDividerInset {
    /// No inset — line extends to the container edge.
    case none

    /// Inset on the leading edge only.
    case leading(CGFloat = ZodiakSpacing.s16)

    /// Inset on the trailing edge only.
    case trailing(CGFloat = ZodiakSpacing.s16)

    /// Inset on both edges.
    case both(CGFloat = ZodiakSpacing.s16)

    var leadingValue: CGFloat {
        switch self {
            case .none:
                return 0
            case .leading(let value):
                return value
            case .trailing:
                return 0
            case .both(let value):
                return value
        }
    }

    var trailingValue: CGFloat {
        switch self {
            case .none:
                return 0
            case .leading:
                return 0
            case .trailing(let value):
                return value
            case .both(let value):
                return value
        }
    }
}

// MARK: - ZodiakDivider

struct ZodiakDivider: View {
    var hierarchy: ZodiakDividerHierarchy
    var style: ZodiakDividerStyle
    var orientation: ZodiakDividerOrientation
    var inset: ZodiakDividerInset

    init(
        hierarchy: ZodiakDividerHierarchy = .primary,
        style: ZodiakDividerStyle = .thin,
        orientation: ZodiakDividerOrientation = .horizontal,
        inset: ZodiakDividerInset = .none
    ) {
        self.hierarchy = hierarchy
        self.style = style
        self.orientation = orientation
        self.inset = inset
    }

    init(
        hierarchy: ZodiakDividerHierarchy = .primary,
        style: ZodiakDividerStyle = .thin,
        axis: Axis,
        inset: ZodiakDividerInset = .none
    ) {
        self.hierarchy = hierarchy
        self.style = style
        self.orientation = axis == .horizontal ? .horizontal : .vertical
        self.inset = inset
    }

    var body: some View {
        switch orientation {
        case .horizontal:
            Rectangle()
                .fill(lineColor)
                .frame(maxWidth: .infinity)
                .frame(height: style.lineWidth)
                .padding(.leading, leadingInset)
                .padding(.trailing, trailingInset)
                .accessibilityHidden(true)

        case .vertical:
            Rectangle()
                .fill(lineColor)
                .frame(maxHeight: .infinity)
                .frame(width: style.lineWidth)
                .padding(.top, leadingInset)
                .padding(.bottom, trailingInset)
                .accessibilityHidden(true)
        }
    }

    private var lineColor: Color {
        switch hierarchy {
        case .primary:
            return ZodiakColors.borderPrimary
        case .secondary:
            return ZodiakColors.borderSecondary
        }
    }

    private var leadingInset: CGFloat {
        switch inset {
        case .none:
            return 0
        case .leading(let value):
            return value
        case .trailing:
            return 0
        case .both(let value):
            return value
        }
    }

    private var trailingInset: CGFloat {
        switch inset {
        case .none:
            return 0
        case .leading:
            return 0
        case .trailing(let value):
            return value
        case .both(let value):
            return value
        }
    }
}

// MARK: - Previews

#Preview("Dividers") {
    VStack(spacing: ZodiakSpacing.s24) {
        ZodiakText("Horizontal", style: .title2)

        ZodiakDivider(hierarchy: .primary, style: .thin)
        ZodiakDivider(hierarchy: .primary, style: .thick)
        ZodiakDivider(hierarchy: .secondary, style: .thin)
        ZodiakDivider(hierarchy: .secondary, style: .thick)

        ZodiakText("Inset", style: .title2)

        ZodiakDivider(inset: .leading())
        ZodiakDivider(inset: .trailing())
        ZodiakDivider(inset: .both())

        ZodiakText("Vertical", style: .title2)

        HStack(spacing: ZodiakSpacing.s24) {
            ZodiakText("Esquerda", style: .body())

            ZodiakDivider(orientation: .vertical)
                .frame(height: 48)

            ZodiakText("Direita", style: .body())
        }
        .frame(height: 48)

        HStack(spacing: ZodiakSpacing.s24) {
            ZodiakText("Left", style: .body())

            ZodiakDivider(axis: .vertical)
                .frame(height: 24)

            ZodiakText("Right", style: .body())
        }
        .frame(height: 48)
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
