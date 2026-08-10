package com.zodiak.android.design_system.theme

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import androidx.compose.ui.graphics.toArgb

// ─── Zodiak Color Parity Tests ────────────────────────────────────────────────
// Verifies that Android semantic tokens match the expected Zodiak DS hex values,
// ensuring parity with iOS ZodiakColors.swift (Cenário 5 of the user story).
//
// Expected values are the canonical Supernova spec hex values shared by both platforms.
// If a value changes here, update iOS ZodiakColors.swift / Assets.xcassets accordingly.

@DisplayName("Zodiak Color Parity — Android ↔ iOS Specification")
class ZodiakColorParityTest {

    private val light = ZodiakSemanticColors.light()
    private val dark  = ZodiakSemanticColors.dark()

    // ─── Helpers ─────────────────────────────────────────────────────────────

    /** Returns the RGB hex of a [androidx.compose.ui.graphics.Color] as an uppercase hex string, stripping alpha. */
    private fun androidx.compose.ui.graphics.Color.toHex(): String =
        String.format("#%06X", toArgb() and 0xFFFFFF)

    private fun assertHex(expected: String, actual: androidx.compose.ui.graphics.Color, label: String) {
        assertEquals(expected.uppercase(), actual.toHex().uppercase(), label)
    }

    // ─── Primitives ──────────────────────────────────────────────────────────

    @Nested
    @DisplayName("ZodiakColorTokens — Blue Ramp")
    inner class BlueRamp {
        @Test fun `shade500 is Capgemini Blue`() = assertHex("#0058AB", ZodiakColorTokens.Blue.shade500, "Blue.shade500")
        @Test fun `shade800 is dark blue`()      = assertHex("#1D365A", ZodiakColorTokens.Blue.shade800, "Blue.shade800")
        @Test fun `shade900 is ink`()             = assertHex("#121A38", ZodiakColorTokens.Blue.shade900, "Blue.shade900")
        @Test fun `shade50 is background`()       = assertHex("#EFF0F4", ZodiakColorTokens.Blue.shade50,  "Blue.shade50")
    }

    @Nested
    @DisplayName("ZodiakColorTokens — Neutral Ramp")
    inner class NeutralRamp {
        @Test fun `shade950 is textPrimary light`()  = assertHex("#171A22", ZodiakColorTokens.Neutral.shade950, "Neutral.shade950")
        @Test fun `shade50 is textPrimary dark`()    = assertHex("#F8FAFC", ZodiakColorTokens.Neutral.shade50,  "Neutral.shade50")
        @Test fun `shade1000 is surface dark`()      = assertHex("#12151D", ZodiakColorTokens.Neutral.shade1000,"Neutral.shade1000")
        @Test fun `shade850 is background dark`()    = assertHex("#21252D", ZodiakColorTokens.Neutral.shade850, "Neutral.shade850")
    }

    @Nested
    @DisplayName("ZodiakColorTokens — Red Ramp")
    inner class RedRamp {
        @Test fun `shade500 is action warning`()       = assertHex("#F64059", ZodiakColorTokens.Red.shade500, "Red.shade500")
        @Test fun `shade600 is warning pressed light`() = assertHex("#DD1D46", ZodiakColorTokens.Red.shade600, "Red.shade600")
        @Test fun `shade800 is text negative light`()  = assertHex("#9E0029", ZodiakColorTokens.Red.shade800, "Red.shade800")
        @Test fun `shade200 is text negative dark`()   = assertHex("#FFA7A9", ZodiakColorTokens.Red.shade200, "Red.shade200")
    }

    // ─── Semantic Tokens — Light ──────────────────────────────────────────────

    @Nested
    @DisplayName("ZodiakSemanticColors.light()")
    inner class LightSemanticTokens {

        @Test fun brand()           = assertHex("#0058AB", light.brand,           "brand")
        @Test fun brandOrange()     = assertHex("#F9A464", light.brandOrange,      "brandOrange")
        @Test fun background()      = assertHex("#EFF0F4", light.background,       "background")
        @Test fun surface()         = assertHex("#FFFFFF", light.surface,          "surface")
        @Test fun surfaceInk()      = assertHex("#121A38", light.surfaceInk,       "surfaceInk")
        @Test fun surfaceMarine()   = assertHex("#1C4076", light.surfaceMarine,    "surfaceMarine")
        @Test fun surfacePositive() = assertHex("#EFF7F5", light.surfacePositive,  "surfacePositive")
        @Test fun surfaceNegative() = assertHex("#FBF2F3", light.surfaceNegative,  "surfaceNegative")

        @Test fun textPrimary()     = assertHex("#171A22", light.textPrimary,      "textPrimary")
        @Test fun textSecondary()   = assertHex("#595E6A", light.textSecondary,    "textSecondary")
        @Test fun textLink()        = assertHex("#1D365A", light.textLink,         "textLink")
        @Test fun textLinkInverse() = assertHex("#FFFFFF", light.textLinkInverse,  "textLinkInverse")
        @Test fun textNegative()    = assertHex("#9E0029", light.textNegative,     "textNegative [GAP-02 fix]")
        @Test fun textDisabled()    = assertHex("#A6ACB5", light.textDisabled,     "textDisabled")
        @Test fun textAlwaysWhite() = assertHex("#FFFFFF", light.textAlwaysWhite,  "textAlwaysWhite")
        @Test fun textAlwaysBlack() = assertHex("#171A22", light.textAlwaysBlack,  "textAlwaysBlack")
        @Test fun textPositive()    = assertHex("#21B87D", light.textPositive,     "textPositive")

        @Test fun statusOnline()       = assertHex("#21B87D", light.statusOnline,       "statusOnline")
        @Test fun statusAway()         = assertHex("#FAB833", light.statusAway,         "statusAway")
        @Test fun statusDoNotDisturb() = assertHex("#F64059", light.statusDoNotDisturb, "statusDoNotDisturb")
        @Test fun statusOffline()      = assertHex("#A6ACB5", light.statusOffline,      "statusOffline")

        @Test fun surfaceAlwaysWhite()      = assertHex("#FFFFFF", light.surfaceAlwaysWhite,     "surfaceAlwaysWhite")
        @Test fun surfaceAlwaysBlack()      = assertHex("#000000", light.surfaceAlwaysBlack,     "surfaceAlwaysBlack")
        @Test fun surfaceDecorativeBrand()  = assertHex("#0058AB", light.surfaceDecorativeBrand, "surfaceDecorativeBrand")
        @Test fun surfaceDecorativeOrange() = assertHex("#F9A464", light.surfaceDecorativeOrange,"surfaceDecorativeOrange")
        @Test fun surfaceWarningTint()      = assertHex("#FFEDD1", light.surfaceWarningTint,     "surfaceWarningTint")

        @Test fun actionPrimary()     = assertHex("#1D365A", light.actionPrimary,     "actionPrimary")
        @Test fun actionWarning()     = assertHex("#F64059", light.actionWarning,     "actionWarning")
        // GAP-02 was a false alarm: light=#171a22 was always correct per official Supernova spec
        @Test fun actionWarningContent()       = assertHex("#171A22", light.actionWarningContent, "actionWarningContent light [spec-verified]")
        // GAP-03: actionWarningPressedOutline light must be #dd1d46 (Red-600, not Red-800)
        @Test fun actionWarningPressedOutline() = assertHex("#DD1D46", light.actionWarningPressedOutline, "actionWarningPressedOutline [GAP-03]")

        @Test fun borderPrimary()   = assertHex("#C7CCD3", light.borderPrimary,    "borderPrimary")
        @Test fun borderSecondary() = assertHex("#EFF0F4", light.borderSecondary,  "borderSecondary")
    }

    // ─── Semantic Tokens — Dark ───────────────────────────────────────────────

    @Nested
    @DisplayName("ZodiakSemanticColors.dark()")
    inner class DarkSemanticTokens {

        @Test fun brand()             = assertHex("#0058AB", dark.brand,            "brand [same in dark]")
        @Test fun background()        = assertHex("#21252D", dark.background,       "background dark")
        @Test fun surface()           = assertHex("#12151D", dark.surface,          "surface dark")
        @Test fun surfaceInk()        = assertHex("#121A38", dark.surfaceInk,       "surfaceInk [same in dark]")
        @Test fun surfacePositive()   = assertHex("#0F2E22", dark.surfacePositive,  "surfacePositive dark")
        @Test fun surfaceNegative()   = assertHex("#5D051A", dark.surfaceNegative,  "surfaceNegative dark")

        @Test fun textPrimary()       = assertHex("#F8FAFC", dark.textPrimary,      "textPrimary dark")
        @Test fun textSecondary()     = assertHex("#F1F4F7", dark.textSecondary,    "textSecondary dark")
        // GAP-04: textLinkInverse dark must be #1d365a (Blue.shade800) — was hardcoded #ffffff
        @Test fun textLinkInverse()   = assertHex("#1D365A", dark.textLinkInverse,  "textLinkInverse dark [GAP-04]")
        @Test fun textNegative()      = assertHex("#FFA7A9", dark.textNegative,     "textNegative dark")
        // actionWarningContent dark must be #9e0029 per official Supernova spec
        @Test fun actionWarningContent() = assertHex("#9E0029", dark.actionWarningContent, "actionWarningContent dark [spec-verified]")

        @Test fun actionPrimary()     = assertHex("#FFFFFF", dark.actionPrimary,    "actionPrimary dark (onHeavy)")
        @Test fun borderPrimary()     = assertHex("#3C414A", dark.borderPrimary,    "borderPrimary dark")
        @Test fun borderSecondary()   = assertHex("#2E323A", dark.borderSecondary,  "borderSecondary dark")
    }
}
