package com.zodiak.android.feature.catalog

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.clickable
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.luminance
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.zodiak.android.R
import com.zodiak.android.design_system.theme.LocalZodiakColors
import com.zodiak.android.design_system.theme.ZodiakColorTokens
import com.zodiak.android.design_system.theme.ZodiakSemanticColors
import com.zodiak.android.design_system.theme.ZodiakTheme

// ─── Data model ──────────────────────────────────────────────────────────────

private data class ColorEntry(
    val name: String,
    val primitiveRef: String,
    val isAdaptive: Boolean,
    val resolve: (ZodiakSemanticColors) -> Color,
)

private data class ColorFamily(
    val titleRes: Int,
    val tokens: List<ColorEntry>,
)

// ─── Semantic families ────────────────────────────────────────────────────────

private val SEMANTIC_FAMILIES: List<ColorFamily> = listOf(
    ColorFamily(R.string.catalog_color_family_brand, listOf(
        ColorEntry("brand",       "Blue.500 · adaptável",  true)  { it.brand },
        ColorEntry("brandOrange", "Orange.400 · #f9a464",  false) { it.brandOrange },
    )),
    ColorFamily(R.string.catalog_color_family_surface, listOf(
        ColorEntry("background",              "Blue.50 / Neutral.850",  true)  { it.background },
        ColorEntry("surface",                 "White / Neutral.1000",   true)  { it.surface },
        ColorEntry("surfaceSmoke",            "Neutral.50 / Neutral.800", true) { it.surfaceSmoke },
        ColorEntry("surfaceFog",              "Neutral.50 / Neutral.900", true) { it.surfaceFog },
        ColorEntry("surfaceCaribbean",        "Teal.600 / Teal.900",    true)  { it.surfaceCaribbean },
        ColorEntry("surfaceCaribbeanInverse", "Teal.900 / Teal.600",    true)  { it.surfaceCaribbeanInverse },
        ColorEntry("surfaceInk",              "Blue.900 (fixo)",         false) { it.surfaceInk },
        ColorEntry("surfaceMarine",           "Blue.700 / Blue.800",    true)  { it.surfaceMarine },
        ColorEntry("surfaceAzur",             "Blue.500 / Blue.800",    true)  { it.surfaceAzur },
        ColorEntry("surfaceAlwaysWhite",      "White (fixo)",            false) { it.surfaceAlwaysWhite },
        ColorEntry("surfaceAlwaysBlack",      "Black (fixo)",            false) { it.surfaceAlwaysBlack },
        ColorEntry("surfacePositive",         "Green.50 / Green.900",   true)  { it.surfacePositive },
        ColorEntry("surfaceNegative",         "Red.50 / Red.900",       true)  { it.surfaceNegative },
        ColorEntry("surfaceDecorativeBrand",  "Blue.500 (fixo)",         false) { it.surfaceDecorativeBrand },
        ColorEntry("surfaceDecorativeOrange", "Orange.400 (fixo)",       false) { it.surfaceDecorativeOrange },
    )),
    ColorFamily(R.string.catalog_color_family_text, listOf(
        ColorEntry("textPrimary",         "Neutral.950 / Neutral.50",  true)  { it.textPrimary },
        ColorEntry("textSecondary",       "Neutral.550 / Neutral.150", true)  { it.textSecondary },
        ColorEntry("textInverse",         "White / Neutral.950",       true)  { it.textInverse },
        ColorEntry("textDisabled",        "Neutral.400 / Neutral.450", true)  { it.textDisabled },
        ColorEntry("textAlwaysWhite",     "White (fixo)",              false) { it.textAlwaysWhite },
        ColorEntry("textAlwaysBlack",     "Neutral.950 (fixo)",        false) { it.textAlwaysBlack },
        ColorEntry("textLink",            "Blue.800 / White",          true)  { it.textLink },
        ColorEntry("textLinkHover",       "Blue.900 / Neutral.100",    true)  { it.textLinkHover },
        ColorEntry("textLinkPressed",     "Blue.950 / Neutral.200",    true)  { it.textLinkPressed },
        ColorEntry("textLinkInverse",     "White / Blue.800",          true)  { it.textLinkInverse },
        ColorEntry("textNegative",        "Red.800 / Red.200",         true)  { it.textNegative },
        ColorEntry("textNegativeOnHeavy", "Red.200 (fixo)",            false) { it.textNegativeOnHeavy },
        ColorEntry("textPositive",        "Green.650 · #21b87d",       false) { it.textPositive },
    )),
    ColorFamily(R.string.catalog_color_family_status, listOf(
        ColorEntry("statusOnline",       "Green.650 · #21b87d", false) { it.statusOnline },
        ColorEntry("statusAway",         "Yellow.750 · #fab833",false) { it.statusAway },
        ColorEntry("statusDoNotDisturb", "Red.500 · #f64059",   false) { it.statusDoNotDisturb },
        ColorEntry("statusOffline",      "Neutral.400 · #a6acb5",false){ it.statusOffline },
        ColorEntry("actionWarningTint",  "Orange.625 · #f2991a",false) { it.actionWarningTint },
        ColorEntry("surfaceWarningTint", "Yellow.75 · #ffedd1", false) { it.surfaceWarningTint },
        ColorEntry("bannerSuccess",      "Green.750 · #0f664a", false) { it.bannerSuccess },
        ColorEntry("bannerWarning",      "Orange.810 · #9e6100",false) { it.bannerWarning },
        ColorEntry("bannerError",        "Red.800 · #9e0029",   false) { it.bannerError },
    )),
    ColorFamily(R.string.catalog_color_family_action, listOf(
        ColorEntry("actionPrimary",               "Blue.800 / White",          true)  { it.actionPrimary },
        ColorEntry("actionHover",                 "Blue.900 / Neutral.350",    true)  { it.actionHover },
        ColorEntry("actionPressed",               "Blue.950 / Neutral.200",    true)  { it.actionPressed },
        ColorEntry("actionDisabled",              "Neutral.400 / Neutral.650", true)  { it.actionDisabled },
        ColorEntry("actionDisabledContent",       "Neutral.300 / Neutral.400", true)  { it.actionDisabledContent },
        ColorEntry("actionActive",                "Blue.400 (fixo)",           false) { it.actionActive },
        ColorEntry("actionFocus",                 "Neutral.750 / White",       true)  { it.actionFocus },
        ColorEntry("actionWarning",               "Red.500 / White",           true)  { it.actionWarning },
        ColorEntry("actionWarningContent",        "Neutral.950 / Red.800",     true)  { it.actionWarningContent },
        ColorEntry("actionWarningHover",          "Red.400 / Neutral.350",     true)  { it.actionWarningHover },
        ColorEntry("actionWarningHoverOutline",   "Red.500 / Neutral.350",     true)  { it.actionWarningHoverOutline },
        ColorEntry("actionWarningPressed",        "Red.600 / Neutral.200",     true)  { it.actionWarningPressed },
        ColorEntry("actionWarningPressedOutline", "Red.600 / Neutral.200",     true)  { it.actionWarningPressedOutline },
        ColorEntry("actionWarningSecondary",      "Red.800 / Red.300",         true)  { it.actionWarningSecondary },
        ColorEntry("actionWarningSecondaryHover", "Red.700 / Red.200",         true)  { it.actionWarningSecondaryHover },
        ColorEntry("actionPrimaryOnHeavy",        "White (fixo)",              false) { it.actionPrimaryOnHeavy },
        ColorEntry("actionHoverOnHeavy",          "Neutral.100 / Neutral.350", true)  { it.actionHoverOnHeavy },
        ColorEntry("actionPressedOnHeavy",        "Neutral.200 (fixo)",        false) { it.actionPressedOnHeavy },
        ColorEntry("actionFocusOnHeavy",          "White (fixo)",              false) { it.actionFocusOnHeavy },
        ColorEntry("actionPrimaryOnPhoto",        "Transparent",               false) { it.actionPrimaryOnPhoto },
    )),
    ColorFamily(R.string.catalog_color_family_border, listOf(
        ColorEntry("borderPrimary",   "Neutral.350 / Neutral.650", true) { it.borderPrimary },
        ColorEntry("borderSecondary", "Blue.50 / Neutral.750",     true) { it.borderSecondary },
    )),
    ColorFamily(R.string.catalog_color_family_overlay, listOf(
        ColorEntry("pageOverlay",      "Black 40%", false) { it.pageOverlay },
        ColorEntry("heroPhotographic", "Black 55%", false) { it.heroPhotographic },
    )),
)

// ─── Primitive ramps ──────────────────────────────────────────────────────────

private data class RampShade(val label: String, val color: Color)
private data class PrimitiveRamp(val nameRes: Int, val shades: List<RampShade>)

private fun buildPrimitiveRamps(): List<PrimitiveRamp> {
    val Blue    = ZodiakColorTokens.Blue
    val Neutral = ZodiakColorTokens.Neutral
    val Green   = ZodiakColorTokens.Green
    val Red     = ZodiakColorTokens.Red
    val Yellow  = ZodiakColorTokens.Yellow
    val Orange  = ZodiakColorTokens.Orange
    val Teal    = ZodiakColorTokens.Teal
    return listOf(
        PrimitiveRamp(R.string.catalog_color_primitive_blue, listOf(
            RampShade("25",   Blue.shade25),
            RampShade("50",   Blue.shade50),
            RampShade("100",  Blue.shade100),
            RampShade("200",  Blue.shade200),
            RampShade("300",  Blue.shade300),
            RampShade("400",  Blue.shade400),
            RampShade("500",  Blue.shade500),
            RampShade("600",  Blue.shade600),
            RampShade("700",  Blue.shade700),
            RampShade("800",  Blue.shade800),
            RampShade("900",  Blue.shade900),
            RampShade("950",  Blue.shade950),
            RampShade("1000", Blue.shade1000),
        )),
        PrimitiveRamp(R.string.catalog_color_primitive_neutral, listOf(
            RampShade("50",   Neutral.shade50),
            RampShade("100",  Neutral.shade100),
            RampShade("150",  Neutral.shade150),
            RampShade("200",  Neutral.shade200),
            RampShade("250",  Neutral.shade250),
            RampShade("300",  Neutral.shade300),
            RampShade("350",  Neutral.shade350),
            RampShade("400",  Neutral.shade400),
            RampShade("450",  Neutral.shade450),
            RampShade("500",  Neutral.shade500),
            RampShade("550",  Neutral.shade550),
            RampShade("600",  Neutral.shade600),
            RampShade("650",  Neutral.shade650),
            RampShade("700",  Neutral.shade700),
            RampShade("750",  Neutral.shade750),
            RampShade("800",  Neutral.shade800),
            RampShade("850",  Neutral.shade850),
            RampShade("900",  Neutral.shade900),
            RampShade("950",  Neutral.shade950),
            RampShade("1000", Neutral.shade1000),
        )),
        PrimitiveRamp(R.string.catalog_color_primitive_green, listOf(
            RampShade("50",  Green.shade50),
            RampShade("100", Green.shade100),
            RampShade("200", Green.shade200),
            RampShade("300", Green.shade300),
            RampShade("400", Green.shade400),
            RampShade("500", Green.shade500),
            RampShade("600", Green.shade600),
            RampShade("650", Green.shade650),
            RampShade("700", Green.shade700),
            RampShade("750", Green.shade750),
            RampShade("800", Green.shade800),
            RampShade("900", Green.shade900),
        )),
        PrimitiveRamp(R.string.catalog_color_primitive_red, listOf(
            RampShade("50",  Red.shade50),
            RampShade("100", Red.shade100),
            RampShade("200", Red.shade200),
            RampShade("300", Red.shade300),
            RampShade("400", Red.shade400),
            RampShade("500", Red.shade500),
            RampShade("600", Red.shade600),
            RampShade("700", Red.shade700),
            RampShade("800", Red.shade800),
            RampShade("900", Red.shade900),
        )),
        PrimitiveRamp(R.string.catalog_color_primitive_yellow, listOf(
            RampShade("50",  Yellow.shade50),
            RampShade("75",  Yellow.shade75),
            RampShade("100", Yellow.shade100),
            RampShade("200", Yellow.shade200),
            RampShade("300", Yellow.shade300),
            RampShade("400", Yellow.shade400),
            RampShade("500", Yellow.shade500),
            RampShade("600", Yellow.shade600),
            RampShade("700", Yellow.shade700),
            RampShade("750", Yellow.shade750),
            RampShade("800", Yellow.shade800),
            RampShade("900", Yellow.shade900),
        )),
        PrimitiveRamp(R.string.catalog_color_primitive_orange, listOf(
            RampShade("50",  Orange.shade50),
            RampShade("100", Orange.shade100),
            RampShade("200", Orange.shade200),
            RampShade("300", Orange.shade300),
            RampShade("400", Orange.shade400),
            RampShade("500", Orange.shade500),
            RampShade("600", Orange.shade600),
            RampShade("625", Orange.shade625),
            RampShade("700", Orange.shade700),
            RampShade("800", Orange.shade800),
            RampShade("810", Orange.shade810),
            RampShade("900", Orange.shade900),
        )),
        PrimitiveRamp(R.string.catalog_color_primitive_teal, listOf(
            RampShade("600", Teal.shade600),
            RampShade("900", Teal.shade900),
        )),
    )
}

// ─── Main composable ──────────────────────────────────────────────────────────

@Composable
fun ZodiakColorGallery(onNavigateToToken: (String) -> Unit = {}) {
    var selectedTab by remember { mutableStateOf(0) }
    var isDarkPreview by remember { mutableStateOf(false) }
    val previewColors = remember(isDarkPreview) {
        if (isDarkPreview) ZodiakSemanticColors.dark() else ZodiakSemanticColors.light()
    }

    Column {
        TabRow(selectedTabIndex = selectedTab) {
            Tab(
                selected = selectedTab == 0,
                onClick  = { selectedTab = 0 },
                text     = { Text(stringResource(R.string.catalog_color_tab_semantic)) },
            )
            Tab(
                selected = selectedTab == 1,
                onClick  = { selectedTab = 1 },
                text     = { Text(stringResource(R.string.catalog_color_tab_primitives)) },
            )
        }

        when (selectedTab) {
            0 -> CompositionLocalProvider(LocalZodiakColors provides previewColors) {
                SemanticColorsTab(
                    isDarkPreview = isDarkPreview,
                    onToggleDark  = { isDarkPreview = !isDarkPreview },
                    onNavigateToToken = onNavigateToToken
                )
            }
            1 -> PrimitivesTab()
        }
    }
}

// ─── Semantic tab ─────────────────────────────────────────────────────────────

@Composable
private fun SemanticColorsTab(isDarkPreview: Boolean, onToggleDark: () -> Unit, onNavigateToToken: (String) -> Unit) {
    val colors = ZodiakTheme.colors

    Column(
        modifier = Modifier.padding(horizontal = 16.dp, vertical = 12.dp),
        verticalArrangement = Arrangement.spacedBy(24.dp),
    ) {
        Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Text(
                    text     = stringResource(R.string.catalog_color_preview_label),
                    style    = MaterialTheme.typography.labelMedium,
                    color    = MaterialTheme.colorScheme.onSurfaceVariant,
                    modifier = Modifier.weight(1f),
                )
                FilterChip(
                    selected = isDarkPreview,
                    onClick  = onToggleDark,
                    label    = {
                        Text(
                            if (isDarkPreview) stringResource(R.string.catalog_color_mode_dark)
                            else stringResource(R.string.catalog_color_mode_light)
                        )
                    },
                )
            }

        SEMANTIC_FAMILIES.forEach { family ->
            AnimatedVisibility(visible = true, enter = fadeIn(), exit = fadeOut()) {
                ColorFamilySection(family = family, colors = colors, onNavigateToToken = onNavigateToToken)
            }
        }

        Text(
            text  = stringResource(R.string.catalog_color_total_count),
            style = MaterialTheme.typography.labelSmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
        )
    }
}

@Composable
private fun ColorFamilySection(family: ColorFamily, colors: ZodiakSemanticColors, onNavigateToToken: (String) -> Unit = {}) {
    Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(8.dp),
        ) {
            HorizontalDivider(modifier = Modifier.weight(1f))
            Text(
                text  = stringResource(family.titleRes),
                style = MaterialTheme.typography.labelMedium.copy(fontWeight = FontWeight.SemiBold),
                color = ZodiakTheme.colors.brand,
            )
            HorizontalDivider(modifier = Modifier.weight(1f))
        }
        family.tokens.forEach { entry ->
            ColorTokenRow(
                name         = entry.name,
                primitiveRef = entry.primitiveRef,
                isAdaptive   = entry.isAdaptive,
                color        = entry.resolve(colors),
                onNavigateToToken = onNavigateToToken
            )
        }
    }
}

@Composable
private fun ColorTokenRow(
    name: String,
    primitiveRef: String,
    isAdaptive: Boolean,
    color: Color,
    onNavigateToToken: (String) -> Unit = {}
) {
    val hexStr  = "#%06X".format(color.toArgb() and 0xFFFFFF)
    val alphaStr = if (color.alpha < 0.99f) " ${(color.alpha * 100).toInt()}%" else ""
    val onColor = if (color.luminance() > 0.35f) Color(0xFF171A22) else Color.White

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onNavigateToToken(name) }
            .clip(RoundedCornerShape(8.dp))
            .border(1.dp, MaterialTheme.colorScheme.outlineVariant, RoundedCornerShape(8.dp)),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(
            modifier = Modifier
                .size(56.dp)
                .background(color),
            contentAlignment = Alignment.Center,
        ) {
            if (isAdaptive) {
                Text(text = "↕", color = onColor, fontSize = 13.sp)
            }
        }
        Column(
            modifier = Modifier
                .weight(1f)
                .padding(horizontal = 12.dp, vertical = 8.dp),
            verticalArrangement = Arrangement.spacedBy(2.dp),
        ) {
            Text(
                text  = name,
                style = MaterialTheme.typography.bodyMedium.copy(fontWeight = FontWeight.Medium),
                color = MaterialTheme.colorScheme.onSurface,
            )
            Text(
                text  = primitiveRef,
                style = MaterialTheme.typography.labelSmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
            )
        }
        Text(
            text     = hexStr + alphaStr,
            style    = MaterialTheme.typography.labelSmall.copy(
                fontFamily = FontFamily.Monospace,
                fontWeight = FontWeight.Medium,
            ),
            color    = MaterialTheme.colorScheme.onSurfaceVariant,
            modifier = Modifier.padding(end = 12.dp),
        )
    }
}

// ─── Primitives tab ───────────────────────────────────────────────────────────

@Composable
private fun PrimitivesTab() {
    val ramps = remember { buildPrimitiveRamps() }

    Column(
        modifier = Modifier.padding(horizontal = 16.dp, vertical = 12.dp),
        verticalArrangement = Arrangement.spacedBy(24.dp),
    ) {
        ramps.forEach { ramp ->
            PrimitiveRampCard(ramp)
        }
    }
}

@Composable
private fun PrimitiveRampCard(ramp: PrimitiveRamp) {
    Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
        Text(
            text  = stringResource(ramp.nameRes),
            style = MaterialTheme.typography.titleSmall.copy(fontWeight = FontWeight.SemiBold),
            color = MaterialTheme.colorScheme.onSurface,
        )
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .height(48.dp)
                .clip(RoundedCornerShape(8.dp)),
        ) {
            ramp.shades.forEach { shade ->
                val onColor = if (shade.color.luminance() > 0.35f) Color(0xFF171A22) else Color.White
                Box(
                    modifier = Modifier
                        .weight(1f)
                        .fillMaxHeight()
                        .background(shade.color),
                    contentAlignment = Alignment.BottomCenter,
                ) {
                    Text(
                        text     = shade.label,
                        fontSize = 7.sp,
                        color    = onColor,
                        modifier = Modifier.padding(bottom = 3.dp),
                    )
                }
            }
        }
        Row(modifier = Modifier.fillMaxWidth()) {
            ramp.shades.forEach { shade ->
                Text(
                    text     = "%06X".format(shade.color.toArgb() and 0xFFFFFF),
                    modifier = Modifier.weight(1f),
                    fontSize = 6.sp,
                    color    = MaterialTheme.colorScheme.onSurfaceVariant,
                    maxLines = 1,
                )
            }
        }
    }
}
