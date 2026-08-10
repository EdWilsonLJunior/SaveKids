import SwiftUI

// MARK: - ColorTokenDetailView
// swiftlint:disable type_body_length
// Reason: Detail view with structured sections — hero, swatches, specs, usages, best practices, HIG.

struct ColorTokenDetailView: View {
    @EnvironmentObject private var catalog: CatalogViewModel
    @AppStorage("appLanguage") private var appLanguage: String = "system"
    let detail: ColorTokenDetail

    var body: some View {
        ZodiakGalleryShell {
            tokenHeroSection
            swatchSection
            tokenSpecsSection
            if !detail.usageKeys.isEmpty {
                usagesSection
            }
            if !detail.doKeys.isEmpty || !detail.dontKeys.isEmpty {
                dosDontsSection
            }
            higSection
        }
        .zodiakPage(title: LocalizedStringKey(detail.name))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("app.settings.follow_system") {
                        withAnimation(.easeInOut(duration: 0.3)) { appLanguage = "system" }
                    }
                    Button("app.settings.lang_pt_br") {
                        withAnimation(.easeInOut(duration: 0.3)) { appLanguage = "pt-BR" }
                    }
                    Button("app.settings.lang_en") {
                        withAnimation(.easeInOut(duration: 0.3)) { appLanguage = "en" }
                    }
                } label: {
                    ZodiakIconView(.globe, size: .small, color: ZodiakColors.actionPrimary)
                        .accessibilityHidden(true)
                }
                .accessibilityLabel(Text("catalog.home.select_language"))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation(.easeInOut(duration: 0.35)) { catalog.isDarkMode.toggle() }
                } label: {
                    ZodiakIconView(
                        catalog.isDarkMode ? .moon : .sun,
                        size: .small,
                        color: ZodiakColors.actionPrimary
                    )
                    .accessibilityHidden(true)
                }
                .accessibilityLabel(
                    catalog.isDarkMode
                        ? "catalog.home.switch_light_theme"
                        : "catalog.home.switch_dark_theme"
                )
            }
        }
    }

    // MARK: - Hex resolution

    private var hexLight: String { resolvedHex(style: .light) }
    private var hexDark: String { resolvedHex(style: .dark) }

    // Pre-resolved static Color values — bypasses SwiftUI theme propagation so
    // swatch tiles are always stable regardless of the current app colour scheme.
    private var swatchLightColor: Color {
        Color(UIColor(detail.color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)))
    }
    private var swatchDarkColor: Color {
        Color(UIColor(detail.color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)))
    }
    // Surface backdrop for each tile so semi-transparent tokens (overlays)
    // composite over the correct contextual background.
    private var swatchLightSurface: Color {
        Color(UIColor(ZodiakColors.surface).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)))
    }
    private var swatchDarkSurface: Color {
        Color(UIColor(ZodiakColors.surface).resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)))
    }
    /// Alpha channel of the token (light-mode resolved). Values < 0.99 indicate transparency.
    private var tokenAlpha: CGFloat {
        let uiColor = UIColor(detail.color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return alpha
    }
    private var isTransparent: Bool { tokenAlpha < 0.99 }

    private var rgbLight: String {
        let uiColor = UIColor(detail.color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        return "\(Int((r * 255).rounded())), \(Int((g * 255).rounded())), \(Int((b * 255).rounded()))"
    }

    private var hsbLight: String {
        let uiColor = UIColor(detail.color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0
        uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: nil)
        // swiftlint:disable:next line_length
        return String(format: "%d°  %d%%  %d%%", Int((h * 360).rounded()), Int((s * 100).rounded()), Int((b * 100).rounded()))
    }

    private var cmykLight: String {
        let uiColor = UIColor(detail.color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        let rN = Double(r), gN = Double(g), bN = Double(b)
        let k = 1 - max(rN, gN, bN)
        guard k < 1 else { return "0%  0%  0%  100%" }
        let cVal = Int(((1 - rN - k) / (1 - k) * 100).rounded())
        let mVal = Int(((1 - gN - k) / (1 - k) * 100).rounded())
        let yVal = Int(((1 - bN - k) / (1 - k) * 100).rounded())
        return "\(cVal)%  \(mVal)%  \(yVal)%  \(Int((k * 100).rounded()))%"
    }

    private func resolvedHex(style: UIUserInterfaceStyle) -> String {
        let traits = UITraitCollection(userInterfaceStyle: style)
        let uiColor = UIColor(detail.color).resolvedColor(with: traits)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return String(
            format: "#%02X%02X%02X",
            Int((red * 255).rounded()),
            Int((green * 255).rounded()),
            Int((blue * 255).rounded())
        )
    }

    // MARK: - Hero Section

    /// Strips the language-specific adaptive/fixed suffix from primitiveRef.
    /// e.g. "Blue.shade500 · adaptável" → "Blue.shade500"
    ///      "Orange.shade400 · #f9a464 (fixo)" → "Orange.shade400 · #f9a464"
    private var cleanPrimitiveRef: String {
        let ref = detail.primitiveRef
        if ref.hasSuffix("adaptável") {
            return ref
                .components(separatedBy: " · adaptável")
                .first
                .map { $0.trimmingCharacters(in: .whitespaces) } ?? ref
        }
        if ref.hasSuffix("(fixo)") {
            return ref
                .replacingOccurrences(of: " (fixo)", with: "")
                .trimmingCharacters(in: .whitespaces)
        }
        return ref
    }

    private var tokenHeroSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakEyebrow(text: detail.category.titleKey, size: .small)
            HStack(alignment: .firstTextBaseline, spacing: ZodiakSpacing.s8) {
                ZodiakText(verbatim: detail.name, style: .headline)
                    .fontDesign(.monospaced)
                Spacer()
                ZodiakBadge(
                    text: detail.isAdaptive
                        ? "catalog.color.detail_adaptive"
                        : "catalog.color.detail_fixed",
                    backgroundColor: ZodiakColors.surfaceFog,
                    foregroundColor: ZodiakColors.textSecondary
                )
                .zodiakTooltip(
                    detail.isAdaptive
                        ? "catalog.color.tooltip_adaptive"
                        : "catalog.color.tooltip_fixed",
                    placement: .bottom
                )
            }
            if !detail.descriptionKey.isEmpty {
                ZodiakText(LocalizedStringKey(detail.descriptionKey), style: .bodySmall(color: .secondary))
            }
            ZodiakText(verbatim: cleanPrimitiveRef, style: .caption(color: .secondary))
                .fontDesign(.monospaced)
        }
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }

    // MARK: - Swatch Section

    private var swatchSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            HStack(spacing: ZodiakSpacing.s8) {
                swatchTile(
                    labelKey: "catalog.color.detail_swatch_light",
                    hex: hexLight,
                    tileColor: swatchLightColor,
                    surfaceColor: swatchLightSurface
                )
                swatchTile(
                    labelKey: "catalog.color.detail_swatch_dark",
                    hex: hexDark,
                    tileColor: swatchDarkColor,
                    surfaceColor: swatchDarkSurface
                )
            }
            if isTransparent {
                ZodiakText(
                    "catalog.color.detail_swatch_overlay_note",
                    style: .caption(color: .secondary)
                )
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }

    private func swatchTile(
        labelKey: LocalizedStringKey,
        hex: String,
        tileColor: Color,
        surfaceColor: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            ZStack {
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .fill(surfaceColor)
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .fill(tileColor)
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
            }
            .frame(height: 120)
            HStack {
                ZodiakText(labelKey, style: .caption(color: .secondary))
                Spacer()
                ZodiakText(verbatim: hex, style: .caption(bold: true, color: .primary))
                    .fontDesign(.monospaced)
            }
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Token Specs

    private var tokenSpecsSection: some View {
        detailCard("catalog.color.detail_token_info") {
            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakInfoRow(
                    label: "catalog.color.detail_primitive",
                    value: cleanPrimitiveRef,
                    style: .spec(labelWidth: 88)
                )
                .zodiakTooltip("catalog.color.tooltip_primitive")
                ZodiakInfoRow(
                    label: "catalog.color.detail_hex_light",
                    value: hexLight,
                    style: .spec(labelWidth: 88)
                )
                ZodiakInfoRow(
                    label: "catalog.color.detail_hex_dark",
                    value: hexDark,
                    style: .spec(labelWidth: 88)
                )
                if isTransparent {
                    ZodiakInfoRow(
                        label: "catalog.color.detail_opacity",
                        value: "\(Int((tokenAlpha * 100).rounded()))%",
                        style: .spec(labelWidth: 88)
                    )
                    .zodiakTooltip("catalog.color.tooltip_opacity")
                }
                ZodiakInfoRow(
                    label: "catalog.color.detail_rgb",
                    value: rgbLight,
                    style: .spec(labelWidth: 88)
                )
                .zodiakTooltip("catalog.color.tooltip_rgb")
                ZodiakInfoRow(
                    label: "catalog.color.detail_hsb",
                    value: hsbLight,
                    style: .spec(labelWidth: 88)
                )
                .zodiakTooltip("catalog.color.tooltip_hsb")
                ZodiakInfoRow(
                    label: "catalog.color.detail_cmyk",
                    value: cmykLight,
                    style: .spec(labelWidth: 88)
                )
                .zodiakTooltip("catalog.color.tooltip_cmyk")
                ZodiakInfoRow(
                    label: "catalog.color.detail_mode",
                    value: detail.isAdaptive
                        ? "catalog.color.detail_adaptive"
                        : "catalog.color.detail_fixed",
                    style: .spec(labelWidth: 88)
                )
                ZodiakInfoRow(
                    label: "catalog.color.detail_category",
                    value: detail.category.titleKey,
                    style: .spec(labelWidth: 88)
                )
            }
        }
    }

    // MARK: - Usages

    private var usagesSection: some View {
        detailCard("catalog.color.detail_usages") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ForEach(detail.usageKeys, id: \.self) { key in
                    HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                        ZodiakText(verbatim: "›", style: .caption(bold: true, color: .link))
                        ZodiakText(LocalizedStringKey(key), style: .caption(color: .primary))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }

    // MARK: - Dos & Don'ts

    private var dosDontsSection: some View {
        detailCard("catalog.color.detail_best_practices") {
            HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                if !detail.doKeys.isEmpty {
                    dosDontsColumn(items: detail.doKeys, isDo: true)
                }
                if !detail.dontKeys.isEmpty {
                    dosDontsColumn(items: detail.dontKeys, isDo: false)
                }
            }
        }
    }

    private func dosDontsColumn(items: [String], isDo: Bool) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            HStack(spacing: ZodiakSpacing.s4) {
                ZodiakIconView(
                    isDo ? .circleCheck : .close,
                    size: .small,
                    color: isDo ? ZodiakColors.textPositive : ZodiakColors.textNegative
                )
                ZodiakText(
                    isDo ? "catalog.color.detail_do" : "catalog.color.detail_dont",
                    style: .bodySmall(bold: true)
                )
            }
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: ZodiakSpacing.s4) {
                    Circle()
                        .fill(isDo ? ZodiakColors.surfacePositive : ZodiakColors.surfaceNegative)
                        .frame(width: 5, height: 5)
                        .padding(.top, 7)
                    ZodiakText(LocalizedStringKey(item), style: .caption(color: .primary))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - HIG

    private var higSection: some View {
        detailCard("catalog.color.detail_hig") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                HStack(spacing: ZodiakSpacing.s8) {
                    ZodiakIconView(.apple, size: .small, color: ZodiakColors.textPrimary)
                    ZodiakText(LocalizedStringKey(detail.hig.sectionKey), style: .bodySmall(bold: true))
                }
                ZodiakText(LocalizedStringKey(detail.hig.excerptKey), style: .bodySmall(color: .secondary))
                    .fixedSize(horizontal: false, vertical: true)
                if let url = URL(string: detail.hig.url) {
                    Link(destination: url) {
                        HStack(spacing: ZodiakSpacing.s4) {
                            ZodiakText("catalog.color.detail_hig_link", style: .caption(color: .link))
                            ZodiakIconView(.arrowUpRight, size: .small, color: ZodiakColors.textLink)
                        }
                    }
                }
            }
        }
    }
    // MARK: - Section Card Helper
    // Standard screen padding respects the ZodiakSpacing.screenPad grid.

    @ViewBuilder
    private func detailCard<Content: View>(
        _ titleKey: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText(titleKey, style: .title2)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }
}
// swiftlint:enable type_body_length

// MARK: - Preview

#Preview {
    NavigationStack {
        if let detail = ColorTokenMetadata.all["brand"] ?? ColorTokenMetadata.all.values.first {
            ColorTokenDetailView(detail: detail)
                .environmentObject(CatalogViewModel())
        }
    }
}
