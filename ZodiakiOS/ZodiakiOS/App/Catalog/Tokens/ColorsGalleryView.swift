import SwiftUI
import UIKit

// MARK: - Primitive Ramp Model

typealias RampEntry = (label: String, color: Color)

struct PrimitiveRamp: Identifiable, Hashable {
    let nameKey: String
    let entries: [RampEntry]
    var id: String { nameKey }

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.nameKey == rhs.nameKey }
    func hash(into hasher: inout Hasher) { hasher.combine(nameKey) }

    var shortName: String {
        switch nameKey {
        case "catalog.color.primitive_blue":    return "Blue"
        case "catalog.color.primitive_neutral": return "Neutral"
        case "catalog.color.primitive_green":   return "Green"
        case "catalog.color.primitive_red":     return "Red"
        case "catalog.color.primitive_yellow":  return "Yellow"
        case "catalog.color.primitive_orange":  return "Orange"
        case "catalog.color.primitive_teal":    return "Teal"
        default:                                return nameKey
        }
    }
}

// MARK: - Colors Gallery View
// swiftlint:disable type_body_length
// Reason: Gallery view with static semantic color data and primitive ramps — structurally exhaustive.

struct ColorsGalleryView: View {
    @EnvironmentObject private var catalog: CatalogViewModel
    @State private var selectedTab = 0
    @State private var containerSize: CGSize = .zero
    @State private var selectedToken: ColorTokenDetail?
    @State private var selectedRamp: PrimitiveRamp?

    private var isPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    private var isLandscape: Bool { containerSize.width > containerSize.height }

    /// iPhone portrait → 2 col, iPhone landscape → 3 col.
    /// iPad portrait → 4 col, iPad landscape → 6 col.
    /// Uses UIDevice idiom + containerSize (size classes are always .regular on iPad,
    /// and iPhone Plus/Max also gets .regular in landscape — so size class is unreliable here).
    private var colorGridColumns: Int? {
        if isPhone { return isLandscape ? 3 : 2 }
        return isLandscape ? 6 : 4
    }

    private let semanticGroups: [(
        titleKey: String,
        descKey: String,
        colors: [(name: String, color: Color, descriptionKey: String)]
    )] = [
        (titleKey: "catalog.color.brand_section", descKey: "catalog.color.brand_section_desc", colors: [
            ("brand", ZodiakColors.brand, "catalog.color.capgemini_blue_primary")
        ]),
        (titleKey: "catalog.color.surfaces_section", descKey: "catalog.color.surfaces_section_desc", colors: [
            ("background", ZodiakColors.background, "catalog.color.page_background"),
            ("surface", ZodiakColors.surface, "catalog.color.cards_modals"),
            ("surfaceSmoke", ZodiakColors.surfaceSmoke, "catalog.color.hover_states"),
            ("surfaceFog", ZodiakColors.surfaceFog, "catalog.color.surface_fog"),
            ("surfaceCaribbean", ZodiakColors.surfaceCaribbean, "catalog.color.surface_caribbean"),
            // swiftlint:disable:next line_length
            ("surfaceCaribbeanInverse", ZodiakColors.surfaceCaribbeanInverse, "catalog.color.surface_caribbean_inverse"),
            ("surfaceInk", ZodiakColors.surfaceInk, "catalog.color.dark_overlays"),
            ("surfaceMarine", ZodiakColors.surfaceMarine, "catalog.color.dark_blue"),
            ("surfaceAzur", ZodiakColors.surfaceAzur, "catalog.color.vibrant_blue"),
            ("surfaceAlwaysWhite", ZodiakColors.surfaceAlwaysWhite, "catalog.color.surface_always_white"),
            ("surfaceAlwaysBlack", ZodiakColors.surfaceAlwaysBlack, "catalog.color.surface_always_black"),
            ("surfacePositive", ZodiakColors.surfacePositive, "catalog.color.success_green"),
            ("surfaceNegative", ZodiakColors.surfaceNegative, "catalog.color.error_red"),
            ("surfaceDecorativeBrand", ZodiakColors.surfaceDecorativeBrand, "catalog.color.surface_decorative_brand"),
            ("surfaceDecorativeOrange", ZodiakColors.surfaceDecorativeOrange, "catalog.color.surface_decorative_orange")
        ]),
        (titleKey: "catalog.color.text_section", descKey: "catalog.color.text_section_desc", colors: [
            ("textPrimary", ZodiakColors.textPrimary, "catalog.color.primary_text"),
            ("textSecondary", ZodiakColors.textSecondary, "catalog.color.secondary_text"),
            ("textInverse", ZodiakColors.textInverse, "catalog.color.inverse_text"),
            ("textDisabled", ZodiakColors.textDisabled, "catalog.section.disabled"),
            ("textAlwaysWhite", ZodiakColors.textAlwaysWhite, "catalog.color.text_always_white"),
            ("textAlwaysBlack", ZodiakColors.textAlwaysBlack, "catalog.color.text_always_black"),
            ("textLink", ZodiakColors.textLink, "catalog.color.links"),
            ("textLinkHover", ZodiakColors.textLinkHover, "catalog.color.action_hover"),
            ("textLinkPressed", ZodiakColors.textLinkPressed, "catalog.color.action_pressed"),
            ("textLinkInverse", ZodiakColors.textLinkInverse, "catalog.color.text_link_inverse"),
            ("textNegative", ZodiakColors.textNegative, "catalog.color.error_warning"),
            ("textNegativeOnHeavy", ZodiakColors.textNegativeOnHeavy, "catalog.color.text_negative_on_heavy"),
            ("textPositive", ZodiakColors.textPositive, "catalog.color.text_positive")
        ]),
        (titleKey: "catalog.color.status_section", descKey: "catalog.color.status_section_desc", colors: [
            ("statusOnline", ZodiakColors.statusOnline, "catalog.color.status_online"),
            ("statusAway", ZodiakColors.statusAway, "catalog.color.status_away"),
            ("statusDoNotDisturb", ZodiakColors.statusDoNotDisturb, "catalog.color.status_busy"),
            ("statusOffline", ZodiakColors.statusOffline, "catalog.color.status_offline"),
            ("actionWarningTint", ZodiakColors.actionWarningTint, "catalog.color.action_warning_tint"),
            ("surfaceWarningTint", ZodiakColors.surfaceWarningTint, "catalog.color.surface_warning_tint"),
            ("bannerSuccess", ZodiakColors.bannerSuccess, "catalog.color.banner_success"),
            ("bannerWarning", ZodiakColors.bannerWarning, "catalog.color.banner_warning"),
            ("bannerError", ZodiakColors.bannerError, "catalog.color.banner_error")
        ]),
        (titleKey: "catalog.section.action_ribbons", descKey: "catalog.color.action_section_desc", colors: [
            ("actionPrimary", ZodiakColors.actionPrimary, "catalog.color.buttons_links_default"),
            ("actionHover", ZodiakColors.actionHover, "catalog.color.action_hover"),
            ("actionPressed", ZodiakColors.actionPressed, "catalog.color.action_pressed"),
            ("actionDisabled", ZodiakColors.actionDisabled, "catalog.section.disabled"),
            ("actionDisabledContent", ZodiakColors.actionDisabledContent, "catalog.color.disabled_content"),
            ("actionActive", ZodiakColors.actionActive, "catalog.color.active_selected"),
            ("actionFocus", ZodiakColors.actionFocus, "catalog.color.action_focus"),
            ("actionWarning", ZodiakColors.actionWarning, "catalog.color.warning_primary"),
            ("actionWarningContent", ZodiakColors.actionWarningContent, "catalog.color.action_warning_content"),
            ("actionWarningHover", ZodiakColors.actionWarningHover, "catalog.color.action_warning_hover"),
            // swiftlint:disable:next line_length
            ("actionWarningHoverOutline", ZodiakColors.actionWarningHoverOutline, "catalog.color.action_warning_hover_outline"),
            ("actionWarningPressed", ZodiakColors.actionWarningPressed, "catalog.color.action_warning_pressed"),
            // swiftlint:disable:next line_length
            ("actionWarningPressedOutline", ZodiakColors.actionWarningPressedOutline, "catalog.color.action_warning_pressed_outline"),
            ("actionWarningSecondary", ZodiakColors.actionWarningSecondary, "catalog.color.warning_secondary"),
            ("actionWarningSecondaryHover", ZodiakColors.actionWarningSecondaryHover, "catalog.color.warning_hover"),
            ("actionPrimaryOnHeavy", ZodiakColors.actionPrimaryOnHeavy, "catalog.color.action_primary_on_heavy"),
            ("actionHoverOnHeavy", ZodiakColors.actionHoverOnHeavy, "catalog.color.action_hover_on_heavy"),
            ("actionPressedOnHeavy", ZodiakColors.actionPressedOnHeavy, "catalog.color.action_pressed_on_heavy"),
            ("actionFocusOnHeavy", ZodiakColors.actionFocusOnHeavy, "catalog.color.action_focus_on_heavy"),
            ("actionPrimaryOnPhoto", ZodiakColors.actionPrimaryOnPhoto, "catalog.color.action_primary_on_photo")
        ]),
        (titleKey: "catalog.color.borders_section", descKey: "catalog.color.borders_section_desc", colors: [
            ("borderPrimary", ZodiakColors.borderPrimary, "catalog.color.default_borders"),
            ("borderSecondary", ZodiakColors.borderSecondary, "catalog.color.subtle_borders")
        ]),
        (titleKey: "catalog.color.overlays_section", descKey: "catalog.color.overlays_section_desc", colors: [
            ("pageOverlay", ZodiakColors.pageOverlay, "catalog.color.page_overlay"),
            ("heroPhotographic", ZodiakColors.heroPhotographic, "catalog.color.hero_photographic")
        ])
    ]

    /// Keys aligned with semanticGroups indices (0–6) + Primitives (7).
    private let tabKeys: [String] = [
        "catalog.color.brand_section",
        "catalog.color.surfaces_section",
        "catalog.color.text_section",
        "catalog.color.status_section",
        "catalog.section.action_ribbons",
        "catalog.color.borders_section",
        "catalog.color.overlays_section",
        "catalog.color.primitives_section"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.color.colors_token",
                subtitle: "catalog.color.token_count_desc",
                figmaRef: ""
            )
            ZodiakTabs(tabs: tabKeys, selectedIndex: $selectedTab, size: .small)
            selectedTabContent
                .padding(.top, ZodiakSpacing.s16)
        }
        .zodiakPage(title: "catalog.color.colors_token")
        .onGeometryChange(for: CGSize.self, of: { $0.size }, action: { containerSize = $0 })
        .navigationDestination(item: $selectedToken) { detail in
            ColorTokenDetailView(detail: detail)
                .environmentObject(catalog)
        }
        .navigationDestination(item: $selectedRamp) { ramp in
            PrimitiveRampDetailView(ramp: ramp)
        }
    }

    // MARK: - Tab Content

    @ViewBuilder
    private var selectedTabContent: some View {
        if selectedTab < semanticGroups.count {
            let group = semanticGroups[selectedTab]
            VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                ZodiakText(group.descKey, style: .body(color: .secondary))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, ZodiakSpacing.screenPad)
                colorSwatchGrid(entries: group.colors)
            }
        } else {
            primitiveRampsContent
        }
    }

    @ViewBuilder
    private func colorSwatchGrid(
        entries: [(name: String, color: Color, descriptionKey: String)]
    ) -> some View {
        ZodiakLayoutGrid(
            columns: colorGridColumns,
            horizontalSpacing: ZodiakSpacing.s8,
            verticalSpacing: ZodiakSpacing.s8,
            applyScreenPadding: false
        ) {
            ForEach(entries, id: \.name) { entry in
                Button {
                    if var detail = ColorTokenMetadata.all[entry.name] {
                        detail.descriptionKey = entry.descriptionKey
                        selectedToken = detail
                    }
                } label: {
                    colorSwatchCard(entry: entry)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }

    private func colorSwatchCard(
        entry: (name: String, color: Color, descriptionKey: String)
    ) -> some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                .fill(entry.color)
            LinearGradient(
                colors: [.clear, Color.black.opacity(0.55)],
                startPoint: .center,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(
                    verbatim: ColorTokenMetadata.all[entry.name]?.name ?? entry.name,
                    style: .caption(bold: true, color: .primary)
                )
                ZodiakText(entry.descriptionKey, style: .caption(color: .secondary))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .environment(\.colorScheme, .dark)
            .padding(ZodiakSpacing.s16)
        }
        .frame(height: 170)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
        .overlay {
            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                .stroke(ZodiakColors.borderSecondary, lineWidth: 0.5)
        }
    }

    // MARK: - Color Details Helper

    private func colorDetails(_ color: Color) -> [String] {
        let uiColor = UIColor(color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        var hue: CGFloat = 0, sat: CGFloat = 0, bri: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        uiColor.getHue(&hue, saturation: &sat, brightness: &bri, alpha: nil)

        let rInt = Int((red * 255).rounded())
        let gInt = Int((green * 255).rounded())
        let bInt = Int((blue * 255).rounded())

        let hex = String(format: "#%02X%02X%02X", rInt, gInt, bInt)
        let rgb = "RGB   \(rInt), \(gInt), \(bInt)"
        let hsb = String(
            format: "HSB   %d°  %d%%  %d%%",
            Int((hue * 360).rounded()),
            Int((sat * 100).rounded()),
            Int((bri * 100).rounded())
        )

        let rNorm = Double(rInt) / 255, gNorm = Double(gInt) / 255, bNorm = Double(bInt) / 255
        let kVal = 1 - max(rNorm, gNorm, bNorm)
        let cmyk: String
        if kVal >= 1 {
            cmyk = "CMYK  0%  0%  0%  100%"
        } else {
            let cVal = Int(((1 - rNorm - kVal) / (1 - kVal) * 100).rounded())
            let mVal = Int(((1 - gNorm - kVal) / (1 - kVal) * 100).rounded())
            let yVal = Int(((1 - bNorm - kVal) / (1 - kVal) * 100).rounded())
            let kPct = Int((kVal * 100).rounded())
            cmyk = "CMYK  \(cVal)%  \(mVal)%  \(yVal)%  \(kPct)%"
        }

        return [hex, rgb, hsb, cmyk]
    }

    // MARK: - Primitive Colors

    private var primitiveRampsContent: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            ZodiakText(
                "catalog.color.primitive_ramps_desc",
                style: .body(color: .secondary)
            )
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, ZodiakSpacing.screenPad)

            ZodiakLayoutGrid(
                columns: colorGridColumns,
                horizontalSpacing: ZodiakSpacing.s8,
                verticalSpacing: ZodiakSpacing.s8,
                applyScreenPadding: false
            ) {
                ForEach(primitiveRamps) { ramp in
                    primitiveRampCard(ramp)
                }
            }
            .padding(.horizontal, ZodiakSpacing.screenPad)
        }
    }

    private func primitiveRampCard(_ ramp: PrimitiveRamp) -> some View {
        Button {
            selectedRamp = ramp
        } label: {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(
                    colors: ramp.entries.map { $0.color },
                    startPoint: .leading,
                    endPoint: .trailing
                )
                LinearGradient(
                    colors: [.clear, Color.black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText(verbatim: ramp.shortName, style: .caption(bold: true, color: .primary))
                    ZodiakText(
                        verbatim: "\(ramp.entries.count) shades",
                        style: .caption(color: .secondary)
                    )
                }
                .environment(\.colorScheme, .dark)
                .padding(ZodiakSpacing.s16)
            }
            .frame(height: 170)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
            .overlay {
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .stroke(ZodiakColors.borderSecondary, lineWidth: 0.5)
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Primitive Ramp Data

    private var primitiveRamps: [PrimitiveRamp] {
        [
            PrimitiveRamp(nameKey: "catalog.color.primitive_blue", entries: [
                ("25", ZodiakPrimitives.Blue.shade25),
                ("100", ZodiakPrimitives.Blue.shade100),
                ("200", ZodiakPrimitives.Blue.shade200),
                ("300", ZodiakPrimitives.Blue.shade300),
                ("400", ZodiakPrimitives.Blue.shade400),
                ("500", ZodiakPrimitives.Blue.shade500),
                ("600", ZodiakPrimitives.Blue.shade600),
                ("700", ZodiakPrimitives.Blue.shade700),
                ("800", ZodiakPrimitives.Blue.shade800),
                ("900", ZodiakPrimitives.Blue.shade900),
                ("950", ZodiakPrimitives.Blue.shade950),
                ("1000", ZodiakPrimitives.Blue.shade1000)
            ]),
            PrimitiveRamp(nameKey: "catalog.color.primitive_neutral", entries: [
                ("50", ZodiakPrimitives.Neutral.shade50),
                ("100", ZodiakPrimitives.Neutral.shade100),
                ("150", ZodiakPrimitives.Neutral.shade150),
                ("200", ZodiakPrimitives.Neutral.shade200),
                ("250", ZodiakPrimitives.Neutral.shade250),
                ("300", ZodiakPrimitives.Neutral.shade300),
                ("350", ZodiakPrimitives.Neutral.shade350),
                ("400", ZodiakPrimitives.Neutral.shade400),
                ("450", ZodiakPrimitives.Neutral.shade450),
                ("500", ZodiakPrimitives.Neutral.shade500),
                ("550", ZodiakPrimitives.Neutral.shade550),
                ("600", ZodiakPrimitives.Neutral.shade600),
                ("650", ZodiakPrimitives.Neutral.shade650),
                ("700", ZodiakPrimitives.Neutral.shade700),
                ("750", ZodiakPrimitives.Neutral.shade750),
                ("800", ZodiakPrimitives.Neutral.shade800),
                ("850", ZodiakPrimitives.Neutral.shade850),
                ("900", ZodiakPrimitives.Neutral.shade900),
                ("950", ZodiakPrimitives.Neutral.shade950),
                ("1000", ZodiakPrimitives.Neutral.shade1000)
            ]),
            PrimitiveRamp(nameKey: "catalog.color.primitive_green", entries: [
                ("50", ZodiakPrimitives.Green.shade50),
                ("100", ZodiakPrimitives.Green.shade100),
                ("200", ZodiakPrimitives.Green.shade200),
                ("300", ZodiakPrimitives.Green.shade300),
                ("400", ZodiakPrimitives.Green.shade400),
                ("500", ZodiakPrimitives.Green.shade500),
                ("600", ZodiakPrimitives.Green.shade600),
                ("700", ZodiakPrimitives.Green.shade700),
                ("800", ZodiakPrimitives.Green.shade800),
                ("900", ZodiakPrimitives.Green.shade900)
            ]),
            PrimitiveRamp(nameKey: "catalog.color.primitive_red", entries: [
                ("50", ZodiakPrimitives.Red.shade50),
                ("100", ZodiakPrimitives.Red.shade100),
                ("200", ZodiakPrimitives.Red.shade200),
                ("300", ZodiakPrimitives.Red.shade300),
                ("400", ZodiakPrimitives.Red.shade400),
                ("500", ZodiakPrimitives.Red.shade500),
                ("600", ZodiakPrimitives.Red.shade600),
                ("700", ZodiakPrimitives.Red.shade700),
                ("800", ZodiakPrimitives.Red.shade800),
                ("900", ZodiakPrimitives.Red.shade900)
            ]),
            PrimitiveRamp(nameKey: "catalog.color.primitive_yellow", entries: [
                ("50", ZodiakPrimitives.Yellow.shade50),
                ("100", ZodiakPrimitives.Yellow.shade100),
                ("200", ZodiakPrimitives.Yellow.shade200),
                ("300", ZodiakPrimitives.Yellow.shade300),
                ("400", ZodiakPrimitives.Yellow.shade400),
                ("500", ZodiakPrimitives.Yellow.shade500),
                ("600", ZodiakPrimitives.Yellow.shade600),
                ("700", ZodiakPrimitives.Yellow.shade700),
                ("800", ZodiakPrimitives.Yellow.shade800),
                ("900", ZodiakPrimitives.Yellow.shade900)
            ]),
            PrimitiveRamp(nameKey: "catalog.color.primitive_orange", entries: [
                ("50", ZodiakPrimitives.Orange.shade50),
                ("100", ZodiakPrimitives.Orange.shade100),
                ("200", ZodiakPrimitives.Orange.shade200),
                ("300", ZodiakPrimitives.Orange.shade300),
                ("400", ZodiakPrimitives.Orange.shade400),
                ("500", ZodiakPrimitives.Orange.shade500),
                ("600", ZodiakPrimitives.Orange.shade600),
                ("700", ZodiakPrimitives.Orange.shade700),
                ("800", ZodiakPrimitives.Orange.shade800),
                ("900", ZodiakPrimitives.Orange.shade900)
            ]),
            PrimitiveRamp(nameKey: "catalog.color.primitive_teal", entries: [
                ("600", ZodiakPrimitives.Teal.shade600),
                ("900", ZodiakPrimitives.Teal.shade900)
            ])
        ]
    }
}
// swiftlint:enable type_body_length

#Preview {
    NavigationStack {
        ColorsGalleryView()
    }
    .environmentObject(CatalogViewModel())
}
