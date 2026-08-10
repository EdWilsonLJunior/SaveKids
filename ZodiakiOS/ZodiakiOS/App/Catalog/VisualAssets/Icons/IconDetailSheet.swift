import SwiftUI

// MARK: - Icon Detail Sheet

struct IconDetailSheet: View {
    let icon: ZodiakIcon
    @State private var selectedSize: ZodiakIconSize = .xLarge
    @State private var selectedColorIndex: Int = 0 // default: actionPrimary
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.verticalSizeClass) private var vSizeClass
    @Environment(\.locale) private var locale

    private static let allSizes: [ZodiakIconSize] = [.small, .medium, .large, .xLarge]
    private static let colorVariants: [(color: Color, label: String)] = [
        (ZodiakColors.actionPrimary, "actionPrimary"),
        (ZodiakColors.brand, "brand"),
        (ZodiakColors.brandOrange, "brandOrange"),
        (ZodiakColors.textSecondary, "textSecondary")
    ]

    private var previewColor: Color {
        Self.colorVariants.indices.contains(selectedColorIndex)
            ? Self.colorVariants[selectedColorIndex].color
            : ZodiakColors.actionPrimary
    }

    private var isRegular: Bool { hSizeClass == .regular }
    private var isLandscape: Bool { vSizeClass == .compact && !isRegular }
    private var commonUses: [String] {
        let map = locale.identifier.hasPrefix("pt") ? iconCommonUsesMapPT : iconCommonUsesMapEN
        return map[icon] ?? []
    }

    var body: some View {
        Group {
            if isLandscape {
                phoneLandscapeLayout
            } else {
                phoneLayout
            }
        }
        .padding(ZodiakSpacing.s16)
    }

    // MARK: - Phone layout

    private var phoneLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            detailCard
            ZodiakDivider()
            usesRow
            copyButton
                .padding(.top, ZodiakSpacing.s16)
        }
        .padding(.bottom, ZodiakSpacing.s16)
    }

    // MARK: - Phone landscape layout

    private var phoneLandscapeLayout: some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            landscapePreviewStrip
            ZodiakDivider(axis: .vertical)
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    sizeRow.padding(.vertical, ZodiakSpacing.s8)
                    ZodiakDivider(hierarchy: .secondary)
                    specInfoRows.padding(.vertical, ZodiakSpacing.s8)
                    ZodiakDivider()
                    usesRow
                    copyButton.padding(.top, ZodiakSpacing.s8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, ZodiakSpacing.s8)
    }

    // MARK: - Landscape preview strip

    private var landscapePreviewStrip: some View {
        VStack(spacing: 0) {
            Spacer()
            ZodiakIconView(icon, size: selectedSize, color: previewColor)
                .frame(
                    width: ZodiakIconSize.xLarge.dimension,
                    height: ZodiakIconSize.xLarge.dimension
                )
                .animation(.spring(response: 0.35, dampingFraction: 0.75), value: selectedSize.dimension)
                .animation(.easeInOut(duration: 0.2), value: selectedColorIndex)
            ZodiakText(verbatim: icon.accessibilityLabel, style: .title2)
                .padding(.top, ZodiakSpacing.s8)
            ZodiakText(verbatim: "ZodiakIcon.\(icon.rawValue)", style: .caption(color: .secondary))
                .padding(.top, ZodiakSpacing.s4)
                .multilineTextAlignment(.center)
            colorCircles
                .padding(.top, ZodiakSpacing.s24)
            Spacer()
        }
        .frame(width: 170)
    }

    // MARK: - Detail card (portrait)

    private var detailCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            heroSection
            ZodiakDivider()
            sizeRow.padding(.vertical, ZodiakSpacing.s16)
            ZodiakDivider(hierarchy: .secondary)
            colorRow.padding(.vertical, ZodiakSpacing.s16)
            ZodiakDivider(hierarchy: .secondary)
            specInfoRows.padding(.vertical, ZodiakSpacing.s16)
        }
    }

    // MARK: - Hero section

    private var heroSection: some View {
        HStack {
            Spacer()
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakIconView(icon, size: selectedSize, color: previewColor)
                    .frame(
                        width: ZodiakIconSize.xLarge.dimension,
                        height: ZodiakIconSize.xLarge.dimension
                    )
                    .animation(.spring(response: 0.35, dampingFraction: 0.75), value: selectedSize.dimension)
                    .animation(.easeInOut(duration: 0.2), value: selectedColorIndex)
                    .padding(.top, ZodiakSpacing.s24)
                ZodiakText(verbatim: icon.accessibilityLabel, style: .title2)
                ZodiakText(verbatim: "ZodiakIcon.\(icon.rawValue)", style: .caption(color: .secondary))
                ZodiakIconButton(
                    icon: "doc.on.doc",
                    action: { UIPasteboard.general.string = icon.rawValue },
                    size: .small,
                    style: .tertiary,
                    accessibilityLabel: String(localized: "catalog.detail.copy_name_hint")
                )
                .padding(.bottom, ZodiakSpacing.s24)
            }
            Spacer()
        }
    }

    // MARK: - Size row

    private var sizeRow: some View {
        HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.spec.lbl.size", style: .caption(color: .secondary))
                .frame(width: 60, alignment: .leading)
            HStack(spacing: ZodiakSpacing.s4) {
                ForEach(Self.allSizes, id: \.dimension) { size in
                    ZodiakChip(
                        verbatim: "\(Int(size.dimension))pt",
                        isActive: size.dimension == selectedSize.dimension,
                        onTap: { withAnimation(.easeInOut(duration: 0.2)) { selectedSize = size } }
                    )
                }
            }
            Spacer()
        }
    }

    // MARK: - Color row

    private var colorRow: some View {
        HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.spec.lbl.cor", style: .caption(color: .secondary))
                .frame(width: 60, alignment: .leading)
            colorCircles
            Spacer()
        }
    }

    // MARK: - Color circles

    private var colorCircles: some View {
        HStack(spacing: ZodiakSpacing.s16) {
            ForEach(Self.colorVariants.indices, id: \.self) { index in
                let isSelected = index == selectedColorIndex
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) { selectedColorIndex = index }
                } label: {
                    Circle()
                        .fill(Self.colorVariants[index].color)
                        .frame(width: 24, height: 24)
                        .overlay(Circle().strokeBorder(
                            ZodiakColors.borderPrimary.opacity(0.4), lineWidth: 0.5
                        ))
                        .padding(2)
                        .overlay(
                            Circle()
                                .strokeBorder(
                                    isSelected ? ZodiakColors.actionPrimary : Color.clear,
                                    lineWidth: 2
                                )
                        )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Text(verbatim: Self.colorVariants[index].label))
                .accessibilityAddTraits(isSelected ? .isSelected : [])
            }
        }
    }

    // MARK: - Spec info rows

    private var specInfoRows: some View {
        VStack(spacing: ZodiakSpacing.s4) {
            ZodiakInfoRow(
                label: "catalog.spec.lbl.size",
                value: "\(Int(selectedSize.dimension))×\(Int(selectedSize.dimension))pt",
                style: .spec(labelWidth: 60)
            )
            ZodiakInfoRow(
                label: "catalog.spec.lbl.stroke",
                value: String(format: "%.1f", selectedSize.strokeWidth) + "pt",
                style: .spec(labelWidth: 60)
            )
            ZodiakInfoRow(
                label: "catalog.spec.lbl.token",
                value: "ZodiakIcon.\(icon.rawValue)",
                style: .spec(labelWidth: 60)
            )
        }
        .id(selectedSize.dimension)
        .transition(.opacity)
    }

    // MARK: - Uses row

    private var usesRow: some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.home.icon_common_uses", style: .caption(color: .secondary))
                .frame(width: 80, alignment: .leading)
                .padding(.top, ZodiakSpacing.s4)
            if commonUses.isEmpty {
                ZodiakText(verbatim: "—", style: .caption(color: .secondary))
                Spacer()
            } else {
                ZodiakFlowLayout(spacing: ZodiakSpacing.s4) {
                    ForEach(commonUses, id: \.self) { use in
                        ZodiakBadge(
                            text: LocalizedStringKey(use),
                            backgroundColor: ZodiakColors.actionPrimary.opacity(0.12),
                            foregroundColor: ZodiakColors.actionPrimary
                        )
                    }
                }
            }
        }
        .padding(.vertical, ZodiakSpacing.s16)
    }

    // MARK: - Copy CTA

    private var copyButton: some View {
        ZodiakButtonSecondary(
            title: "catalog.detail.copy_swift_action",
            action: { UIPasteboard.general.string = "ZodiakIcon.\(icon.rawValue)" }
        )
    }
}
