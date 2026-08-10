package com.zodiak.android.design_system.theme

import androidx.compose.runtime.Immutable
import androidx.compose.runtime.ReadOnlyComposable
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.ui.graphics.Color

// ─── ZodiakSemanticColors ─────────────────────────────────────────────────────
// Mirrors: iOS ZodiakColors.swift
// All consumer code must access tokens via ZodiakTheme.colors.<token>.

@Immutable
data class ZodiakSemanticColors(
    // Brand
    val brand: Color,
    val brandOrange: Color,
    // Surfaces
    val background: Color,
    val surface: Color,
    val surfaceSmoke: Color,
    val surfaceFog: Color,
    val surfaceCaribbean: Color,
    val surfaceCaribbeanInverse: Color,
    val surfaceInk: Color,
    val surfaceMarine: Color,
    val surfaceAzur: Color,
    val surfaceAlwaysWhite: Color,
    val surfaceAlwaysBlack: Color,
    val surfacePositive: Color,
    val surfaceNegative: Color,
    val surfaceDecorativeBrand: Color,
    val surfaceDecorativeOrange: Color,
    val surfaceWarningTint: Color,
    // Text
    val textPrimary: Color,
    val textSecondary: Color,
    val textInverse: Color,
    val textDisabled: Color,
    val textAlwaysWhite: Color,
    val textAlwaysBlack: Color,
    val textLink: Color,
    val textLinkHover: Color,
    val textLinkPressed: Color,
    val textLinkInverse: Color,
    val textNegative: Color,
    val textNegativeOnHeavy: Color,
    val textPositive: Color,
    // Status
    val statusOnline: Color,
    val statusAway: Color,
    val statusDoNotDisturb: Color,
    val statusOffline: Color,
    // Warning / Banner
    val actionWarningTint: Color,
    val bannerSuccess: Color,
    val bannerWarning: Color,
    val bannerError: Color,
    // Actions (onLite)
    val actionPrimary: Color,
    val actionHover: Color,
    val actionPressed: Color,
    val actionDisabled: Color,
    val actionDisabledContent: Color,
    val actionActive: Color,
    val actionFocus: Color,
    val actionWarning: Color,
    val actionWarningContent: Color,
    val actionWarningHover: Color,
    val actionWarningHoverOutline: Color,
    val actionWarningPressed: Color,
    val actionWarningPressedOutline: Color,
    val actionWarningSecondary: Color,
    val actionWarningSecondaryHover: Color,
    // Actions (onHeavy)
    val actionFocusOnHeavy: Color,
    val actionPrimaryOnHeavy: Color,
    val actionPrimaryOnPhoto: Color,
    val actionHoverOnHeavy: Color,
    val actionPressedOnHeavy: Color,
    // Borders
    val borderPrimary: Color,
    val borderSecondary: Color,
    // Overlays
    val pageOverlay: Color,
    val heroPhotographic: Color,
    val isDark: Boolean,
) {
    companion object {
        private val Blue    = ZodiakColorTokens.Blue
        private val Green   = ZodiakColorTokens.Green
        private val Neutral = ZodiakColorTokens.Neutral
        private val Orange  = ZodiakColorTokens.Orange
        private val Overlay = ZodiakColorTokens.Overlay
        private val Red     = ZodiakColorTokens.Red
        private val Teal    = ZodiakColorTokens.Teal
        private val Yellow  = ZodiakColorTokens.Yellow

        fun light() = ZodiakSemanticColors(
            isDark = false,
            // Brand — same in both modes
            brand             = Blue.shade500,
            brandOrange       = Orange.shade400,
            // Surfaces
            background        = Blue.shade50,               // #eff0f4
            surface           = Overlay.white,              // #ffffff
            surfaceSmoke      = Neutral.shade50,            // #f8fafc
            surfaceFog        = Neutral.shade50,            // #f8fafc
            surfaceCaribbean  = Teal.shade600,              // #00d5d0
            surfaceCaribbeanInverse = Teal.shade900,        // #29656f
            surfaceInk        = Blue.shade900,              // #121a38 (fixed)
            surfaceMarine     = Blue.shade700,              // #1c4076
            surfaceAzur       = Blue.shade500,              // #0058ab
            surfaceAlwaysWhite = Overlay.white,             // #ffffff (fixo)
            surfaceAlwaysBlack = Overlay.black,             // #000000 (fixo)
            surfacePositive   = Green.shade50,              // #eff7f5
            surfaceNegative   = Red.shade50,                // #fbf2f3
            surfaceDecorativeBrand   = Blue.shade500,       // alias: brand
            surfaceDecorativeOrange  = Orange.shade400,     // alias: brandOrange
            surfaceWarningTint = Yellow.shade75,            // #ffedd1
            // Text
            textPrimary       = Neutral.shade950,           // #171a22
            textSecondary     = Neutral.shade550,           // #595e6a
            textInverse       = Overlay.white,
            textDisabled      = Neutral.shade400,           // #a6acb5
            textAlwaysWhite   = Overlay.white,              // #ffffff (fixo)
            textAlwaysBlack   = Neutral.shade950,           // #171a22 (fixo)
            textLink          = Blue.shade800,              // #1d365a
            textLinkHover     = Blue.shade900,              // #121a38
            textLinkPressed   = Blue.shade950,              // #070a16
            textLinkInverse   = Overlay.white,
            textNegative      = Red.shade800,               // #9e0029
            textNegativeOnHeavy = Red.shade200,             // #ffa7a9
            textPositive      = Green.shade650,             // #21b87d
            // Status
            statusOnline      = Green.shade650,             // #21b87d
            statusAway        = Yellow.shade750,            // #fab833
            statusDoNotDisturb = Red.shade500,
            statusOffline     = Neutral.shade400,           // #a6acb5
            // Warning / Banner
            actionWarningTint = Orange.shade625,            // #f2991a
            bannerSuccess     = Green.shade750,             // #0f664a
            bannerWarning     = Orange.shade810,            // #9e6100
            bannerError       = Red.shade800,
            // Actions (onLite)
            actionPrimary     = Blue.shade800,              // #1d365a
            actionHover       = Blue.shade900,              // #121a38
            actionPressed     = Blue.shade950,              // #070a16
            actionDisabled    = Neutral.shade400,           // #a6acb5
            actionDisabledContent = Neutral.shade300,       // #d9dde3
            actionActive      = Blue.shade400,              // #3573c0
            actionFocus       = Neutral.shade750,           // #2e323a
            actionWarning     = Red.shade500,               // #f64059
            actionWarningContent = Neutral.shade950,        // #171a22
            actionWarningHover   = Red.shade400,            // #ff6270
            actionWarningHoverOutline   = Red.shade500,
            actionWarningPressed = Red.shade600,            // #dd1d46
            actionWarningPressedOutline = Red.shade600,
            actionWarningSecondary      = Red.shade800,     // #9e0029
            actionWarningSecondaryHover = Red.shade700,     // #c00036
            // Actions (onHeavy)
            actionFocusOnHeavy    = Overlay.white,
            actionPrimaryOnHeavy  = Overlay.white,
            actionPrimaryOnPhoto  = Color.Transparent,
            actionHoverOnHeavy    = Neutral.shade100,       // #f4f6f9
            actionPressedOnHeavy  = Neutral.shade200,       // #e9edf3
            // Borders
            borderPrimary     = Neutral.shade350,           // #c7ccd3
            borderSecondary   = Blue.shade50,               // #eff0f4
            // Overlays
            pageOverlay       = Overlay.black40,
            heroPhotographic  = Overlay.black55,
        )

        fun dark() = ZodiakSemanticColors(
            isDark = true,
            // Brand — same in both modes
            brand             = Blue.shade500,
            brandOrange       = Orange.shade400,
            // Surfaces
            background        = Neutral.shade850,           // #21252d
            surface           = Neutral.shade1000,          // #12151d
            surfaceSmoke      = Neutral.shade800,           // #272b33
            surfaceFog        = Neutral.shade900,           // #1b1f27
            surfaceCaribbean  = Teal.shade900,              // #29656f
            surfaceCaribbeanInverse = Teal.shade600,        // #00d5d0
            surfaceInk        = Blue.shade900,              // #121a38 (fixed)
            surfaceMarine     = Blue.shade800,              // #1d365a
            surfaceAzur       = Blue.shade800,              // #1d365a
            surfaceAlwaysWhite = Overlay.white,             // #ffffff (fixo)
            surfaceAlwaysBlack = Overlay.black,             // #000000 (fixo)
            surfacePositive   = Green.shade900,             // #0f2e22
            surfaceNegative   = Red.shade900,               // #5d051a
            surfaceDecorativeBrand   = Blue.shade500,       // alias: brand (fixo)
            surfaceDecorativeOrange  = Orange.shade400,     // alias: brandOrange (fixo)
            surfaceWarningTint = Yellow.shade75,            // #ffedd1 (pending dark variant)
            // Text
            textPrimary       = Neutral.shade50,            // #f8fafc
            textSecondary     = Neutral.shade150,           // #f1f4f7
            textInverse       = Neutral.shade950,           // #171a22
            textDisabled      = Neutral.shade450,           // #888f9a
            textAlwaysWhite   = Overlay.white,              // #ffffff (fixo)
            textAlwaysBlack   = Neutral.shade950,           // #171a22 (fixo)
            textLink          = Overlay.white,
            textLinkHover     = Neutral.shade100,           // #f4f6f9
            textLinkPressed   = Neutral.shade200,           // #e9edf3
            textLinkInverse   = Blue.shade800,              // #1d365a
            textNegative      = Red.shade200,               // #ffa7a9
            textNegativeOnHeavy = Red.shade200,
            textPositive      = Green.shade650,             // #21b87d
            // Status
            statusOnline      = Green.shade650,             // #21b87d
            statusAway        = Yellow.shade750,            // #fab833
            statusDoNotDisturb = Red.shade500,
            statusOffline     = Neutral.shade400,           // #a6acb5
            // Warning / Banner
            actionWarningTint = Orange.shade625,            // #f2991a
            bannerSuccess     = Green.shade750,             // #0f664a
            bannerWarning     = Orange.shade810,            // #9e6100
            bannerError       = Red.shade800,
            // Actions (onLite becomes onHeavy-style in dark)
            actionPrimary     = Overlay.white,
            actionHover       = Neutral.shade350,           // #c7ccd3
            actionPressed     = Neutral.shade200,           // #e9edf3
            actionDisabled    = Neutral.shade650,           // #3c414a
            actionDisabledContent = Neutral.shade400,       // #a6acb5
            actionActive      = Blue.shade400,              // #3573c0
            actionFocus       = Overlay.white,
            actionWarning     = Overlay.white,
            actionWarningContent = Red.shade800,            // #9e0029
            actionWarningHover        = Neutral.shade350,
            actionWarningHoverOutline = Neutral.shade350,
            actionWarningPressed = Neutral.shade200,
            actionWarningPressedOutline = Neutral.shade200,
            actionWarningSecondary      = Red.shade300,     // #ff848b
            actionWarningSecondaryHover = Red.shade200,     // #ffa7a9
            // Actions (onHeavy — same across modes)
            actionFocusOnHeavy    = Overlay.white,
            actionPrimaryOnHeavy  = Overlay.white,
            actionPrimaryOnPhoto  = Color.Transparent,
            actionHoverOnHeavy    = Neutral.shade350,       // #c7ccd3
            actionPressedOnHeavy  = Neutral.shade200,       // #e9edf3
            // Borders
            borderPrimary     = Neutral.shade650,           // #3c414a
            borderSecondary   = Neutral.shade750,           // #2e323a
            // Overlays
            pageOverlay       = Overlay.black40,
            heroPhotographic  = Overlay.black55,
        )
    }
}

/** CompositionLocal that provides the active [ZodiakSemanticColors]. */
val LocalZodiakColors = compositionLocalOf { ZodiakSemanticColors.light() }
