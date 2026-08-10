package com.zodiak.android.design_system.molecules

import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource

enum class ZodiakAlertType { INFO, SUCCESS, WARNING, ERROR }

@Composable
fun ZodiakAlert(
    title: String,
    message: String,
    onDismiss: () -> Unit,
    type: ZodiakAlertType = ZodiakAlertType.INFO,
    confirmLabel: String = "OK",
    dismissLabel: String? = null,
    onConfirm: (() -> Unit)? = null,
    icon: ImageVector? = null,
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(title) },
        text  = { Text(message) },
        icon  = icon?.let { { Icon(it, contentDescription = null) } },
        confirmButton = {
            TextButton(onClick = { onConfirm?.invoke() ?: onDismiss() }) {
                Text(confirmLabel)
            }
        },
        dismissButton = dismissLabel?.let {
            { TextButton(onClick = onDismiss) { Text(it) } }
        },
    )
}
