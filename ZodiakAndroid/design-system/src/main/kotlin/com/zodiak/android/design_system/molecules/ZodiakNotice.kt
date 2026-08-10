package com.zodiak.android.design_system.molecules

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.CheckCircle
import androidx.compose.material.icons.outlined.Error
import androidx.compose.material.icons.outlined.Info
import androidx.compose.material.icons.outlined.Warning
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.dp
import com.zodiak.android.design_system.theme.ZodiakTheme

// ─── ZodiakNotice ─────────────────────────────────────────────────────────────
// Zodiak Design System – Molecules layer
// Inline contextual notice — NOT a dialog. Use this for feedback that stays on
// screen: form errors, hints, success confirmations, and warnings.
//
// Spec: docs/zodiak-pdf/Guidelines - Notice.md
// Gap reference: G-021
//
// Usage:
//   ZodiakNotice(
//       message = "Os dados foram guardados com sucesso.",
//       type = ZodiakNoticeType.SUCCESS,
//   )
//   ZodiakNotice(
//       type = ZodiakNoticeType.ERROR,
//       title = "Falha na validação",
//       message = "O CPF informado é inválido.",
//       actionLabel = "Corrigir",
//       onAction = { /* focus field */ },
//   )

/** Semantic intent variants — determines icon, background and text colours. */
enum class ZodiakNoticeType {
    /** Neutral informational message. Blue/secondary colour scheme. */
    INFO,

    /** Positive outcome confirmation. Green scheme. */
    SUCCESS,

    /** Non-blocking caution. Amber/orange scheme. */
    WARNING,

    /** Blocking error or validation failure. Red scheme. */
    ERROR,
}

/**
 * Inline contextual notice strip.
 *
 * @param message     Body copy shown to the user.
 * @param modifier    Applied to the outermost layout box.
 * @param type        Semantic variant — controls colour + icon.
 * @param title       Optional bold title above the message.
 * @param actionLabel Optional CTA text; only shown when [onAction] is also set.
 * @param onAction    Invoked when the user taps the action link.
 */
@Composable
fun ZodiakNotice(
    message: String,
    modifier: Modifier = Modifier,
    type: ZodiakNoticeType = ZodiakNoticeType.INFO,
    title: String? = null,
    actionLabel: String? = null,
    onAction: (() -> Unit)? = null,
) {
    val colors = ZodiakTheme.colors
    val (backgroundColor, iconColor, icon) = noticeStyle(type, colors)

    Row(
        modifier = modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(8.dp))
            .background(backgroundColor)
            .padding(12.dp)
            .semantics(mergeDescendants = true) {},
        verticalAlignment = Alignment.Top,
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = iconColor,
            modifier = Modifier.size(20.dp),
        )
        Spacer(Modifier.width(12.dp))
        Column(modifier = Modifier.weight(1f)) {
            if (title != null) {
                Text(
                    text = title,
                    style = MaterialTheme.typography.labelMedium,
                    color = MaterialTheme.colorScheme.onSurface,
                )
                Spacer(Modifier.height(2.dp))
            }
            Text(
                text = message,
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurface,
            )
            if (actionLabel != null && onAction != null) {
                Spacer(Modifier.height(4.dp))
                TextButton(
                    onClick = onAction,
                    contentPadding = PaddingValues(horizontal = 0.dp, vertical = 2.dp),
                ) {
                    Text(
                        text = actionLabel,
                        style = MaterialTheme.typography.labelMedium,
                    )
                }
            }
        }
    }
}

// ─── Internal helpers ─────────────────────────────────────────────────────────

private data class NoticeStyle(
    val backgroundColor: Color,
    val iconColor: Color,
    val icon: ImageVector,
)

@Composable
private fun noticeStyle(
    type: ZodiakNoticeType,
    colors: com.zodiak.android.design_system.theme.ZodiakSemanticColors,
): NoticeStyle = when (type) {
    ZodiakNoticeType.INFO -> NoticeStyle(
        backgroundColor = MaterialTheme.colorScheme.secondaryContainer,
        iconColor = MaterialTheme.colorScheme.onSecondaryContainer,
        icon = Icons.Outlined.Info,
    )
    ZodiakNoticeType.SUCCESS -> NoticeStyle(
        backgroundColor = colors.surfacePositive,
        iconColor = colors.textPositive,
        icon = Icons.Outlined.CheckCircle,
    )
    ZodiakNoticeType.WARNING -> NoticeStyle(
        backgroundColor = colors.actionWarningTint,
        iconColor = MaterialTheme.colorScheme.onSurface,
        icon = Icons.Outlined.Warning,
    )
    ZodiakNoticeType.ERROR -> NoticeStyle(
        backgroundColor = colors.surfaceNegative,
        iconColor = colors.textNegative,
        icon = Icons.Outlined.Error,
    )
}
