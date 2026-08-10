package com.zodiak.android.design_system.theme

import androidx.compose.ui.graphics.Color

// ─── Material3 Color Scheme values for ZodiakTheme ───────────────────────────
// Built from ZodiakColorTokens primitives to ensure brand accuracy.
// These are used only by ZodiakTheme internally to feed MaterialTheme.
// For semantic tokens in components, use ZodiakTheme.colors.<token>.

private val Blue    = ZodiakColorTokens.Blue
private val Neutral = ZodiakColorTokens.Neutral
private val Overlay = ZodiakColorTokens.Overlay
private val Teal    = ZodiakColorTokens.Teal
private val Red     = ZodiakColorTokens.Red

// MARK: - Light scheme tokens

internal val ZodiakPrimary             = Blue.shade500      // Capgemini Blue #0058ab
internal val ZodiakOnPrimary           = Overlay.white
internal val ZodiakPrimaryContainer   = Blue.shade100       // #dfe1eb
internal val ZodiakOnPrimaryContainer = Blue.shade900       // #121a38

internal val ZodiakSecondary              = Neutral.shade550   // #595e6a
internal val ZodiakOnSecondary            = Overlay.white
internal val ZodiakSecondaryContainer     = Neutral.shade150  // #f1f4f7
internal val ZodiakOnSecondaryContainer   = Neutral.shade950  // #171a22

internal val ZodiakTertiary              = Teal.shade600       // #00d5d0
internal val ZodiakOnTertiary            = Neutral.shade950
internal val ZodiakTertiaryContainer     = Teal.shade900       // #29656f
internal val ZodiakOnTertiaryContainer   = Neutral.shade50

internal val ZodiakError              = Red.shade600           // #dd1d46
internal val ZodiakOnError            = Overlay.white
internal val ZodiakErrorContainer     = Red.shade50            // #fbf2f3
internal val ZodiakOnErrorContainer   = Red.shade800           // #9e0029

internal val ZodiakBackground         = Blue.shade50           // #eff0f4
internal val ZodiakOnBackground       = Neutral.shade950       // #171a22
internal val ZodiakSurface            = Overlay.white          // #ffffff
internal val ZodiakOnSurface          = Neutral.shade950
internal val ZodiakSurfaceVariant     = Neutral.shade200       // #e9edf3
internal val ZodiakOnSurfaceVariant   = Neutral.shade550       // #595e6a
internal val ZodiakOutline            = Neutral.shade350       // #c7ccd3
internal val ZodiakOutlineVariant     = Neutral.shade200
internal val ZodiakInverseSurface     = Neutral.shade1000      // #12151d
internal val ZodiakInverseOnSurface   = Neutral.shade100       // #f4f6f9
internal val ZodiakInversePrimary     = Blue.shade200          // #8ea6d5
internal val ZodiakScrim              = Overlay.black

// MARK: - Dark scheme tokens

internal val ZodiakPrimaryDark              = Overlay.white
internal val ZodiakOnPrimaryDark            = Blue.shade800    // #1d365a
internal val ZodiakPrimaryContainerDark     = Blue.shade700    // #1c4076
internal val ZodiakOnPrimaryContainerDark   = Neutral.shade200 // #e9edf3

internal val ZodiakSecondaryDark              = Neutral.shade150 // #f1f4f7
internal val ZodiakOnSecondaryDark            = Neutral.shade950 // #171a22
internal val ZodiakSecondaryContainerDark     = Neutral.shade700 // #343840
internal val ZodiakOnSecondaryContainerDark   = Neutral.shade200

internal val ZodiakTertiaryDark              = Teal.shade600
internal val ZodiakOnTertiaryDark            = Neutral.shade950
internal val ZodiakTertiaryContainerDark     = Teal.shade900
internal val ZodiakOnTertiaryContainerDark   = Neutral.shade50

internal val ZodiakErrorDark              = Red.shade200        // #ffa7a9
internal val ZodiakOnErrorDark            = Red.shade900        // #5d051a
internal val ZodiakErrorContainerDark     = Red.shade900
internal val ZodiakOnErrorContainerDark   = Red.shade200

internal val ZodiakBackgroundDark         = Neutral.shade850    // #21252d
internal val ZodiakOnBackgroundDark       = Neutral.shade50     // #f8fafc
internal val ZodiakSurfaceDark            = Neutral.shade1000   // #12151d
internal val ZodiakOnSurfaceDark          = Neutral.shade50
internal val ZodiakSurfaceVariantDark     = Neutral.shade650    // #3c414a
internal val ZodiakOnSurfaceVariantDark   = Neutral.shade150    // #f1f4f7
internal val ZodiakOutlineDark            = Neutral.shade650
internal val ZodiakOutlineVariantDark     = Neutral.shade750    // #2e323a
internal val ZodiakInverseSurfaceDark     = Neutral.shade150
internal val ZodiakInverseOnSurfaceDark   = Neutral.shade850
internal val ZodiakInversePrimaryDark     = Blue.shade500       // #0058ab


