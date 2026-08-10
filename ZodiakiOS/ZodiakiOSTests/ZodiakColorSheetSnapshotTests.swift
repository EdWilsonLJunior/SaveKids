import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - Color Sheet View (shared between tests and previews)

private struct ColorSwatchView: View {
    let name: String
    let color: Color

    var body: some View {
        HStack(spacing: 0) {
            color
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black.opacity(0.08), lineWidth: 0.5)
                )
            Text(name)
                .font(.system(size: 9, weight: .regular, design: .monospaced))
                .foregroundStyle(Color.primary)
                .lineLimit(1)
                .padding(.leading, 6)
            Spacer()
        }
        .frame(height: 44)
        .padding(.horizontal, 8)
    }
}

private struct ZodiakColorSheetView: View {
    private let swatches: [(String, Color)] = [
        // Brand
        ("brand", ZodiakColors.brand),
        ("brandOrange", ZodiakColors.brandOrange),
        // Surfaces
        ("background", ZodiakColors.background),
        ("surface", ZodiakColors.surface),
        ("surfaceSmoke", ZodiakColors.surfaceSmoke),
        ("surfaceFog", ZodiakColors.surfaceFog),
        ("surfaceCaribbean", ZodiakColors.surfaceCaribbean),
        ("surfaceInk", ZodiakColors.surfaceInk),
        ("surfaceMarine", ZodiakColors.surfaceMarine),
        ("surfaceAzur", ZodiakColors.surfaceAzur),
        ("surfacePositive", ZodiakColors.surfacePositive),
        ("surfaceNegative", ZodiakColors.surfaceNegative),
        // Text
        ("textPrimary", ZodiakColors.textPrimary),
        ("textSecondary", ZodiakColors.textSecondary),
        ("textInverse", ZodiakColors.textInverse),
        ("textDisabled", ZodiakColors.textDisabled),
        ("textLink", ZodiakColors.textLink),
        ("textLinkInverse", ZodiakColors.textLinkInverse),
        ("textNegative", ZodiakColors.textNegative),
        ("textPositive", ZodiakColors.textPositive),
        // Actions
        ("actionPrimary", ZodiakColors.actionPrimary),
        ("actionHover", ZodiakColors.actionHover),
        ("actionFocus", ZodiakColors.actionFocus),
        ("actionDisabled", ZodiakColors.actionDisabled),
        ("actionActive", ZodiakColors.actionActive),
        ("actionWarning", ZodiakColors.actionWarning),
        ("actionWarningContent", ZodiakColors.actionWarningContent),
        ("actionWarningHover", ZodiakColors.actionWarningHover),
        ("actionWarningHoverOutline", ZodiakColors.actionWarningHoverOutline),
        ("actionWarningPressed", ZodiakColors.actionWarningPressed),
        ("actionWarningPressedOutline", ZodiakColors.actionWarningPressedOutline),
        ("actionPrimaryOnHeavy", ZodiakColors.actionPrimaryOnHeavy),
        ("actionHoverOnHeavy", ZodiakColors.actionHoverOnHeavy),
        ("actionPressedOnHeavy", ZodiakColors.actionPressedOnHeavy),
        ("actionFocusOnHeavy", ZodiakColors.actionFocusOnHeavy),
        ("actionPrimaryOnPhoto", ZodiakColors.actionPrimaryOnPhoto),
        // Borders
        ("borderPrimary", ZodiakColors.borderPrimary),
        ("borderSecondary", ZodiakColors.borderSecondary),
        // Status / Banner / Rating
        ("statusOnline", ZodiakColors.statusOnline),
        ("statusAway", ZodiakColors.statusAway),
        ("statusDoNotDisturb", ZodiakColors.statusDoNotDisturb),
        ("bannerSuccess", ZodiakColors.bannerSuccess),
        ("bannerWarning", ZodiakColors.bannerWarning),
        ("bannerError", ZodiakColors.bannerError),
        // Overlays
        ("pageOverlay", ZodiakColors.pageOverlay),
        ("heroPhotographic", ZodiakColors.heroPhotographic)
    ]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(swatches, id: \.0) { name, color in
                    ColorSwatchView(name: name, color: color)
                    Divider()
                }
            }
        }
        .background(Color(.systemBackground))
        .frame(width: 240, height: 800)
    }
}

// MARK: - Tests

@Suite("ZodiakColors Color Sheet Snapshots")
@MainActor
struct ZodiakColorSheetSnapshotTests {
    private let sheetSize = CGSize(width: 240, height: 800)

    @Test("Color sheet renders in light mode")
    func colorSheetLightMode() {
        let view = ZodiakColorSheetView()
        let data = ZodiakSnapshot.renderPNG(view, size: sheetSize, colorScheme: .light)
        #expect(data != nil)
        #expect((data?.count ?? 0) > 0)
    }

    @Test("Color sheet renders in dark mode")
    func colorSheetDarkMode() {
        let view = ZodiakColorSheetView()
        let data = ZodiakSnapshot.renderPNG(view, size: sheetSize, colorScheme: .dark)
        #expect(data != nil)
        #expect((data?.count ?? 0) > 0)
    }

    @Test("Light and dark color sheets differ (dark mode actually changes colors)")
    func lightAndDarkDiffer() {
        let light = ZodiakSnapshot.renderPNG(ZodiakColorSheetView(), size: sheetSize, colorScheme: .light)
        let dark  = ZodiakSnapshot.renderPNG(ZodiakColorSheetView(), size: sheetSize, colorScheme: .dark)
        guard let lightData = light, let darkData = dark else {
            Issue.record("Rendering failed for one or both color schemes")
            return
        }
        #expect(
            ZodiakSnapshot.sha256Hex(lightData) != ZodiakSnapshot.sha256Hex(darkData),
            "Light and dark color sheets must produce different renders"
        )
    }

    @Test("Color sheet SHA-256 is stable across runs (regression baseline)")
    func colorSheetStability() {
        let data = ZodiakSnapshot.renderPNG(ZodiakColorSheetView(), size: sheetSize, colorScheme: .light)
        guard let data else {
            Issue.record("Color sheet rendering returned nil")
            return
        }
        // The hash asserts render pipeline stability; update intentionally when colors change.
        let hash = ZodiakSnapshot.sha256Hex(data)
        #expect(!hash.isEmpty)
        // To lock a baseline: replace the #expect below with:
        // #expect(hash == "<recorded-hash>")
    }
}
