package com.zodiak.android.design_system.atoms

import androidx.compose.material3.Badge
import androidx.compose.material3.BadgedBox
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color

enum class ZodiakBadgeVariant { SUCCESS, WARNING, ERROR, INFO, NEUTRAL }

@Composable
fun ZodiakBadge(
    text: String,
    variant: ZodiakBadgeVariant = ZodiakBadgeVariant.INFO,
    modifier: Modifier = Modifier,
) {
    val containerColor = when (variant) {
        ZodiakBadgeVariant.SUCCESS -> MaterialTheme.colorScheme.tertiaryContainer
        ZodiakBadgeVariant.WARNING -> MaterialTheme.colorScheme.secondaryContainer
        ZodiakBadgeVariant.ERROR   -> MaterialTheme.colorScheme.errorContainer
        ZodiakBadgeVariant.INFO    -> MaterialTheme.colorScheme.primaryContainer
        ZodiakBadgeVariant.NEUTRAL -> MaterialTheme.colorScheme.surfaceVariant
    }
    val contentColor = when (variant) {
        ZodiakBadgeVariant.SUCCESS -> MaterialTheme.colorScheme.onTertiaryContainer
        ZodiakBadgeVariant.WARNING -> MaterialTheme.colorScheme.onSecondaryContainer
        ZodiakBadgeVariant.ERROR   -> MaterialTheme.colorScheme.onErrorContainer
        ZodiakBadgeVariant.INFO    -> MaterialTheme.colorScheme.onPrimaryContainer
        ZodiakBadgeVariant.NEUTRAL -> MaterialTheme.colorScheme.onSurfaceVariant
    }
    Badge(
        containerColor = containerColor,
        contentColor   = contentColor,
        modifier       = modifier,
    ) {
        Text(text, style = MaterialTheme.typography.labelSmall)
    }
}
