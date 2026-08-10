import SwiftUI

// MARK: - Grid Mode

private enum GridMode: Hashable {
    case iPhonePortrait, iPhoneLandscape, iPadPortrait, iPadLandscape

    var columns: Int {
        switch self {
        case .iPhonePortrait:  return ZodiakGridTokens.Columns.iPhonePortrait
        case .iPhoneLandscape: return ZodiakGridTokens.Columns.iPhoneLandscape
        case .iPadPortrait:    return ZodiakGridTokens.Columns.iPadPortrait
        case .iPadLandscape:   return ZodiakGridTokens.Columns.iPadLandscape
        }
    }

    var horizontalSpacing: CGFloat {
        switch self {
        case .iPhonePortrait, .iPhoneLandscape: return ZodiakGridTokens.Gutter.iPhone
        case .iPadPortrait, .iPadLandscape:     return ZodiakGridTokens.Gutter.iPad
        }
    }

    var margin: CGFloat {
        switch self {
        case .iPhonePortrait, .iPhoneLandscape: return ZodiakGridTokens.Margin.iPhone
        case .iPadPortrait, .iPadLandscape:     return ZodiakGridTokens.Margin.iPad
        }
    }

    var sectionTitle: String {
        switch self {
        case .iPhonePortrait:  return "iPhone · Portrait"
        case .iPhoneLandscape: return "iPhone · Landscape"
        case .iPadPortrait:    return "iPad · Portrait"
        case .iPadLandscape:   return "iPad · Landscape"
        }
    }

    var descKey: String {
        switch self {
        case .iPhonePortrait:  return "catalog.layout_grid.desc_iphone"
        case .iPhoneLandscape: return "catalog.layout_grid.desc_iphone_landscape"
        case .iPadPortrait:    return "catalog.layout_grid.desc_ipad_portrait"
        case .iPadLandscape:   return "catalog.layout_grid.desc_ipad"
        }
    }

    var icon: String {
        switch self {
        case .iPhonePortrait, .iPhoneLandscape: return "iphone"
        case .iPadPortrait:                     return "ipad"
        case .iPadLandscape:                    return "ipad.landscape"
        }
    }

    var iconRotation: Angle {
        self == .iPhoneLandscape ? .degrees(-90) : .zero
    }

    var isLandscape: Bool { self == .iPhoneLandscape || self == .iPadLandscape }
}

// MARK: - Layout Grid Gallery

// swiftlint:disable type_body_length
// Reason: Gallery view with diagram, specs, tokens and nomenclature cards — structurally large by design.
struct LayoutGridGalleryView: View {
    @Environment(\.verticalSizeClass) private var vSizeClass
    @State private var isLandscape: Bool = {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        return scene.effectiveGeometry.interfaceOrientation.isLandscape
    }()

    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }

    private var currentMode: GridMode {
        if isIPad { return isLandscape ? .iPadLandscape : .iPadPortrait }
        return vSizeClass == .compact ? .iPhoneLandscape : .iPhonePortrait
    }

    private var portraitMode: GridMode { isIPad ? .iPadPortrait : .iPhonePortrait  }
    private var landscapeMode: GridMode { isIPad ? .iPadLandscape : .iPhoneLandscape }

    private var screenBounds: CGRect {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds
            ?? CGRect(origin: .zero, size: CGSize(width: 390, height: 844))
    }

    private var devicePortraitWidth: CGFloat {
        min(screenBounds.width, screenBounds.height)
    }

    private var deviceLandscapeWidth: CGFloat {
        max(screenBounds.width, screenBounds.height)
    }

    // MARK: - Body

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.layout_grid.title",
                subtitle: "catalog.layout_grid.subtitle",
                figmaRef: "FOUNDATIONS · LAYOUT GRID"
            )
            currentDeviceCard
            gridSection(mode: portraitMode, isCurrent: currentMode == portraitMode)
            gridSection(mode: landscapeMode, isCurrent: currentMode == landscapeMode)
            tokensCard
            globalSpecsCard
            nomenclatureCard
        }
        .zodiakPage(title: "catalog.layout_grid.title")
        .onReceive(
            NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        ) { _ in
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            isLandscape = scene.effectiveGeometry.interfaceOrientation.isLandscape
        }
    }

    // MARK: - Current Device Card

    private var currentDeviceCard: some View {
        gallerySectionCard(title: "catalog.section.layout_grid_atual") {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(systemName: currentMode.icon)
                    .font(.system(size: 32, weight: .light))
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .rotationEffect(currentMode.iconRotation)
                    .animation(.spring(duration: 0.3), value: currentMode)
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    Text(verbatim: currentMode.sectionTitle)
                        .font(ZodiakTypography.labelLarge)
                        .foregroundColor(ZodiakColors.textPrimary)
                    Text(verbatim:
                        "\(currentMode.columns) col · \(Int(currentMode.horizontalSpacing))pt gutter" +
                        " · \(Int(currentMode.margin))pt margem"
                    )
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                }
            }
            .padding(ZodiakSpacing.s8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
        }
    }

    // MARK: - Grid Section

    private func gridSection(mode: GridMode, isCurrent: Bool) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            gridSectionHeader(mode: mode, isCurrent: isCurrent)
            diagramView(mode: mode)
                .padding(.horizontal, -ZodiakSpacing.s16)
            gridSectionSpecs(mode: mode)
        }
    }

    private func gridSectionHeader(mode: GridMode, isCurrent: Bool) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack(alignment: .firstTextBaseline, spacing: ZodiakSpacing.s4) {
                Text(verbatim: mode.sectionTitle)
                    .font(ZodiakTypography.titleSmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                if isCurrent {
                    Text("shared.state.active")
                        .font(ZodiakTypography.captionLarge.bold())
                        .foregroundColor(ZodiakColors.actionPrimary)
                        .padding(.horizontal, ZodiakSpacing.s4)
                        .padding(.vertical, 2)
                        .background(ZodiakColors.actionPrimary.opacity(0.1))
                        .cornerRadius(ZodiakRadii.xs)
                }
                Spacer()
            }
            Text(LocalizedStringKey(mode.descKey))
                .font(ZodiakTypography.bodySmall)
                .foregroundColor(ZodiakColors.textSecondary)
        }
        .cardStyle()
    }

    private func gridSectionSpecs(mode: GridMode) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ZodiakInfoRow(label: "catalog.spec.lbl.colunas",
                          value: "\(mode.columns)", style: .spec())
            Divider()
            ZodiakInfoRow(label: "catalog.spec.lbl.gutter",
                          value: "\(Int(mode.horizontalSpacing))pt", style: .spec())
            Divider()
            ZodiakInfoRow(label: "catalog.spec.lbl.margem",
                          value: "\(Int(mode.margin))pt", style: .spec())
        }
        .cardStyle()
    }

    // MARK: - Diagram

    private func diagramView(mode: GridMode) -> some View {
        let screenW = screenBounds.width
        let refWidth = mode.isLandscape ? deviceLandscapeWidth : devicePortraitWidth
        // Cap diagram at refWidth so portrait diagrams appear narrower than landscape ones
        let diagramW = min(screenW, refWidth)
        let scale = diagramW / refWidth
        let scaledMargin = mode.margin * scale
        let scaledHorizontalSpacing = mode.horizontalSpacing * scale
        let totalSpacing = scaledHorizontalSpacing * CGFloat(mode.columns - 1)
        let colWidth = max((diagramW - scaledMargin * 2 - totalSpacing) / CGFloat(mode.columns), 2)
        return VStack(spacing: 0) {
            diagramHeader(label: mode.sectionTitle, cols: mode.columns, margin: scaledMargin)
            Divider()
            diagramBars(columns: mode.columns, colWidth: colWidth,
                        horizontalSpacing: scaledHorizontalSpacing, margin: scaledMargin)
            Divider()
            diagramLegend(realMargin: mode.margin, realHorizontalSpacing: mode.horizontalSpacing,
                          scaledMargin: scaledMargin, colWidth: colWidth)
        }
        .frame(width: diagramW)
        .overlay(Rectangle().stroke(ZodiakColors.borderSecondary, lineWidth: 0.5))
    }

    private func diagramHeader(label: String, cols: Int, margin: CGFloat) -> some View {
        HStack {
            Text(verbatim: label)
                .font(.system(size: 11, weight: .medium).monospaced())
                .foregroundColor(ZodiakColors.textSecondary)
                .padding(.leading, margin)
            Spacer()
            Text(verbatim: "\(cols) col")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.trailing, margin)
        }
        .padding(.vertical, ZodiakSpacing.s4)
        .background(ZodiakColors.surface)
    }

    private func diagramBars(
        columns: Int, colWidth: CGFloat,
        horizontalSpacing: CGFloat, margin: CGFloat
    ) -> some View {
        HStack(spacing: 0) {
            Rectangle().fill(ZodiakColors.actionWarning.opacity(0.2)).frame(width: margin, height: 48)
            ForEach(0..<columns, id: \.self) { index in
                Rectangle()
                    .fill(ZodiakColors.actionPrimary.opacity(0.18))
                    .frame(width: colWidth, height: 48)
                if index < columns - 1 {
                    Rectangle()
                        .fill(ZodiakColors.brand.opacity(0.1))
                        .frame(width: horizontalSpacing, height: 48)
                }
            }
            Rectangle().fill(ZodiakColors.actionWarning.opacity(0.2)).frame(width: margin, height: 48)
        }
        .frame(maxWidth: .infinity)
        .background(ZodiakColors.background)
    }

    private func diagramLegend(
        realMargin: CGFloat, realHorizontalSpacing: CGFloat,
        scaledMargin: CGFloat, colWidth: CGFloat
    ) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            legendDot(color: ZodiakColors.actionPrimary.opacity(0.5),
                      label: "Col \(String(format: "%.0f", colWidth))pt")
            legendDot(color: ZodiakColors.brand.opacity(0.3), label: "Gutter \(Int(realHorizontalSpacing))pt")
            legendDot(color: ZodiakColors.actionWarning.opacity(0.5),
                      label: "Margem \(Int(realMargin))pt")
            Spacer()
        }
        .padding(.leading, scaledMargin)
        .padding(.vertical, ZodiakSpacing.s4)
        .background(ZodiakColors.surface)
    }

    private func legendDot(color: Color, label: String) -> some View {
        HStack(spacing: 4) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(verbatim: label)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
        }
    }

    // MARK: - Tokens Card

    private var tokensCard: some View {
        gallerySectionCard(title: "catalog.section.tokens_de_grid") {
            gridTokenRow(label: "screenPad", value: "16pt",
                         description: String(localized: "catalog.layout_grid.token_screenPad_desc"))
            Divider()
            gridTokenRow(label: "screenPadLarge", value: "32pt",
                         description: String(localized: "catalog.layout_grid.token_screenPadLarge_desc"))
            Divider()
            gridTokenRow(label: "xs", value: "16pt",
                         description: String(localized: "catalog.layout_grid.token_xs_desc"))
            Divider()
            gridTokenRow(label: "m", value: "24pt",
                         description: String(localized: "catalog.layout_grid.token_m_desc"))
        }
    }

    // MARK: - Global Specs Card

    private var globalSpecsCard: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.sistema",
                value: "catalog.spec.val.grid_sistema_12_colunas",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.breakpoints",
                value: "catalog.spec.val.grid_breakpoints_compact_regular",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.api",
                value: "catalog.spec.val.grid_device_api",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.swiftui",
                value: "catalog.spec.val.grid_zodiak_layout_grid",
                style: .spec()
            )
        }
    }

    // MARK: - Nomenclature Card

    private var nomenclatureCard: some View {
        gallerySectionCard(title: "catalog.section.nomenclatura") {
            ZodiakInfoRow(
                "catalog.spec.lbl.zodiak_term",
                value: "catalog.spec.val.grid_term_zodiak",
                style: .spec()
            )
            Divider()
            ZodiakInfoRow(
                "catalog.spec.lbl.swift_term",
                value: "catalog.spec.val.grid_term_swift",
                style: .spec()
            )
            Divider()
            Text("catalog.layout_grid.nomenclature_disclaimer")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, ZodiakSpacing.s4)
        }
    }

    // MARK: - Token Row Helper

    private func gridTokenRow(label: String, value: String, description: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(verbatim: label)
                    .font(ZodiakTypography.bodySmall.monospaced())
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(verbatim: description)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
            Spacer()
            Text(verbatim: value)
                .font(ZodiakTypography.captionLarge.monospaced())
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s4)
                .padding(.vertical, 2)
                .background(ZodiakColors.actionPrimary.opacity(0.1))
                .cornerRadius(ZodiakRadii.xs)
        }
    }
}
// swiftlint:enable type_body_length

// MARK: - Preview

#Preview("Layout Grid — iPhone") {
    NavigationStack { LayoutGridGalleryView() }
}

#Preview("Layout Grid — Dark") {
    NavigationStack { LayoutGridGalleryView() }
        .preferredColorScheme(.dark)
}
