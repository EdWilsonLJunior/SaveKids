import SwiftUI

// MARK: - Zodiak Skeleton Loader
// Figma: "Skeleton" — primitive shapes for custom skeleton layouts.
//
// For component-level skeleton states, use .zodiakSkeleton(active:) on the real component:
//
//     ZodiakCard(item: item)
//         .zodiakSkeleton(active: isLoading)
//
// These primitives are intended for internal custom layouts where the automatic
// .redacted(reason: .placeholder) behavior needs structural building blocks.

// MARK: - Primitive Shapes

public struct ZodiakSkeletonLine: View {
    let width: CGFloat?
    let height: CGFloat

    public init(width: CGFloat? = nil, height: CGFloat = 14) {
        self.width = width
        self.height = height
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: height / 2, style: .continuous)
            .fill(ZodiakColors.borderPrimary)
            .frame(width: width, height: height)
            .shimmer()
    }
}

public struct ZodiakSkeletonCircle: View {
    let diameter: CGFloat

    public init(diameter: CGFloat = 40) {
        self.diameter = diameter
    }

    public var body: some View {
        Circle()
            .fill(ZodiakColors.borderPrimary)
            .frame(width: diameter, height: diameter)
            .shimmer()
    }
}

public struct ZodiakSkeletonRect: View {
    let height: CGFloat
    let cornerRadius: CGFloat

    public init(height: CGFloat = 120, cornerRadius: CGFloat = 8) {
        self.height = height
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(ZodiakColors.borderPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .shimmer()
    }
}
