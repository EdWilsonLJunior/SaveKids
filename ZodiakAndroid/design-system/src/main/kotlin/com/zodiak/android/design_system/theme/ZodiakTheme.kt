package com.zodiak.android.design_system.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.ReadOnlyComposable
import androidx.compose.ui.platform.LocalContext

private val ZodiakLightColorScheme = lightColorScheme(
    primary              = ZodiakPrimary,
    onPrimary            = ZodiakOnPrimary,
    primaryContainer     = ZodiakPrimaryContainer,
    onPrimaryContainer   = ZodiakOnPrimaryContainer,
    secondary            = ZodiakSecondary,
    onSecondary          = ZodiakOnSecondary,
    secondaryContainer   = ZodiakSecondaryContainer,
    onSecondaryContainer = ZodiakOnSecondaryContainer,
    tertiary             = ZodiakTertiary,
    onTertiary           = ZodiakOnTertiary,
    tertiaryContainer    = ZodiakTertiaryContainer,
    onTertiaryContainer  = ZodiakOnTertiaryContainer,
    error                = ZodiakError,
    onError              = ZodiakOnError,
    errorContainer       = ZodiakErrorContainer,
    onErrorContainer     = ZodiakOnErrorContainer,
    background           = ZodiakBackground,
    onBackground         = ZodiakOnBackground,
    surface              = ZodiakSurface,
    onSurface            = ZodiakOnSurface,
    surfaceVariant       = ZodiakSurfaceVariant,
    onSurfaceVariant     = ZodiakOnSurfaceVariant,
    outline              = ZodiakOutline,
    outlineVariant       = ZodiakOutlineVariant,
    inverseSurface       = ZodiakInverseSurface,
    inverseOnSurface     = ZodiakInverseOnSurface,
    inversePrimary       = ZodiakInversePrimary,
    scrim                = ZodiakScrim,
)

private val ZodiakDarkColorScheme = darkColorScheme(
    primary              = ZodiakPrimaryDark,
    onPrimary            = ZodiakOnPrimaryDark,
    primaryContainer     = ZodiakPrimaryContainerDark,
    onPrimaryContainer   = ZodiakOnPrimaryContainerDark,
    secondary            = ZodiakSecondaryDark,
    onSecondary          = ZodiakOnSecondaryDark,
    secondaryContainer   = ZodiakSecondaryContainerDark,
    onSecondaryContainer = ZodiakOnSecondaryContainerDark,
    tertiary             = ZodiakTertiaryDark,
    onTertiary           = ZodiakOnTertiaryDark,
    tertiaryContainer    = ZodiakTertiaryContainerDark,
    onTertiaryContainer  = ZodiakOnTertiaryContainerDark,
    error                = ZodiakErrorDark,
    onError              = ZodiakOnErrorDark,
    errorContainer       = ZodiakErrorContainerDark,
    onErrorContainer     = ZodiakOnErrorContainerDark,
    background           = ZodiakBackgroundDark,
    onBackground         = ZodiakOnBackgroundDark,
    surface              = ZodiakSurfaceDark,
    onSurface            = ZodiakOnSurfaceDark,
    surfaceVariant       = ZodiakSurfaceVariantDark,
    onSurfaceVariant     = ZodiakOnSurfaceVariantDark,
    outline              = ZodiakOutlineDark,
    outlineVariant       = ZodiakOutlineVariantDark,
    inverseSurface       = ZodiakInverseSurfaceDark,
    inverseOnSurface     = ZodiakInverseOnSurfaceDark,
    inversePrimary       = ZodiakInversePrimaryDark,
)

/**
 * Accessor object for current Zodiak theme values inside a composition.
 *
 * Usage: `ZodiakTheme.colors.actionPrimary`
 */
object ZodiakTheme {
    /** The active [ZodiakSemanticColors] provided by the nearest [ZodiakTheme] composable. */
    val colors: ZodiakSemanticColors
        @Composable
        @ReadOnlyComposable
        get() = LocalZodiakColors.current
}

/**
 * Ponto de entrada do tema Zodiak.
 *
 * @param darkTheme       Forçar tema escuro. Por padrão segue o sistema.
 * @param dynamicColor    Habilitar Material You (Android 12+). Padrão: true.
 * @param content         Conteúdo composable filho.
 */
@Composable
fun ZodiakTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit,
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }
        darkTheme -> ZodiakDarkColorScheme
        else      -> ZodiakLightColorScheme
    }

    val zodiakColors = if (darkTheme) ZodiakSemanticColors.dark() else ZodiakSemanticColors.light()

    CompositionLocalProvider(LocalZodiakColors provides zodiakColors) {
        MaterialTheme(
            colorScheme = colorScheme,
            typography  = ZodiakTypography,
            shapes      = ZodiakShapes,
            content     = content,
        )
    }
}
