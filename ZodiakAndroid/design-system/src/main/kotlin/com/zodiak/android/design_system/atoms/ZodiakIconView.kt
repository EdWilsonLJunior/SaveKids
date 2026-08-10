package com.zodiak.android.design_system.atoms

import androidx.compose.foundation.layout.size
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalContentColor
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

// ─── ZodiakIconView ───────────────────────────────────────────────────────────
// Zodiak Design System – Atoms layer
// Thin wrapper over MD3 Icon that enforces Zodiak size tokens and consistent
// semantics. Accepts both ImageVector and Painter sources.
//
// Usage:
//   ZodiakIconView(
//       imageVector = Icons.Outlined.Star,
//       contentDescription = stringResource(R.string.icon_star_desc),
//   )
//   ZodiakIconView(
//       imageVector = Icons.Outlined.Delete,
//       contentDescription = null, // decorative
//       size = ZodiakIconSize.LARGE,
//       tint = ZodiakTheme.colors.actionWarning,
//   )
//
// When ZodiakIcons.kt is available, use ZodiakIcons.Xxx as the vector source.
// Gap reference: G-008

/**
 * Standard icon sizes aligned to the 4 dp grid.
 *
 * | Token   | dp | Typical context                             |
 * |---------|----|---------------------------------------------|
 * | SMALL   | 16 | Inline in dense text, metadata chips        |
 * | DEFAULT | 24 | Navigation, buttons, list rows (MD3 default) |
 * | MEDIUM  | 32 | Section headers, empty states               |
 * | LARGE   | 40 | Hero / promotional icons                    |
 */
enum class ZodiakIconSize(val dp: Dp) {
    SMALL(16.dp),
    DEFAULT(24.dp),
    MEDIUM(32.dp),
    LARGE(40.dp),
}

/**
 * Renders a vector icon at the specified [ZodiakIconSize].
 *
 * @param imageVector        The [ImageVector] to draw.
 * @param contentDescription Accessibility description, or `null` if the icon is decorative.
 * @param modifier           Applied after the size constraint.
 * @param tint               Icon tint; defaults to [LocalContentColor] (inherits from parent).
 * @param size               Size token; defaults to [ZodiakIconSize.DEFAULT] (24 dp).
 */
@Composable
fun ZodiakIconView(
    imageVector: ImageVector,
    contentDescription: String?,
    modifier: Modifier = Modifier,
    tint: Color = LocalContentColor.current,
    size: ZodiakIconSize = ZodiakIconSize.DEFAULT,
) {
    Icon(
        imageVector = imageVector,
        contentDescription = contentDescription,
        modifier = modifier.size(size.dp),
        tint = tint,
    )
}

/**
 * Overload that accepts a [Painter] — use for PNG/SVG drawable resources.
 *
 * @param painter            The [Painter] to draw.
 * @param contentDescription Accessibility description, or `null` if decorative.
 * @param modifier           Applied after the size constraint.
 * @param tint               Icon tint; defaults to [LocalContentColor].
 * @param size               Size token; defaults to [ZodiakIconSize.DEFAULT] (24 dp).
 */
@Composable
fun ZodiakIconView(
    painter: Painter,
    contentDescription: String?,
    modifier: Modifier = Modifier,
    tint: Color = LocalContentColor.current,
    size: ZodiakIconSize = ZodiakIconSize.DEFAULT,
) {
    Icon(
        painter = painter,
        contentDescription = contentDescription,
        modifier = modifier.size(size.dp),
        tint = tint,
    )
}
