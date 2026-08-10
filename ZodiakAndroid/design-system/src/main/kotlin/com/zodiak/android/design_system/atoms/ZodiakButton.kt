package com.zodiak.android.design_system.atoms

import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.height
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.zodiak.android.design_system.theme.ZodiakSizing

// ─── Primary ──────────────────────────────────────────────────────────────────

@Composable
fun ZodiakButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    contentPadding: PaddingValues = ButtonDefaults.ContentPadding,
) {
    Button(
        onClick = onClick,
        modifier = modifier.height(ZodiakSizing.Button.medium),
        enabled = enabled,
        contentPadding = contentPadding,
    ) {
        Text(text)
    }
}

// ─── Tonal ────────────────────────────────────────────────────────────────────

@Composable
fun ZodiakTonalButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
) {
    FilledTonalButton(
        onClick = onClick,
        modifier = modifier.height(ZodiakSizing.Button.medium),
        enabled = enabled,
    ) { Text(text) }
}

// ─── Outlined ─────────────────────────────────────────────────────────────────

@Composable
fun ZodiakOutlinedButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
) {
    OutlinedButton(
        onClick = onClick,
        modifier = modifier.height(ZodiakSizing.Button.medium),
        enabled = enabled,
    ) { Text(text) }
}

// ─── Text ─────────────────────────────────────────────────────────────────────

@Composable
fun ZodiakTextButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
) {
    TextButton(
        onClick = onClick,
        modifier = modifier,
        enabled = enabled,
    ) { Text(text) }
}

// ─── Destructive ──────────────────────────────────────────────────────────────

@Composable
fun ZodiakDestructiveButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
) {
    Button(
        onClick = onClick,
        modifier = modifier.height(ZodiakSizing.Button.medium),
        enabled = enabled,
        colors = ButtonDefaults.buttonColors(
            containerColor = androidx.compose.material3.MaterialTheme.colorScheme.error,
            contentColor   = androidx.compose.material3.MaterialTheme.colorScheme.onError,
        ),
    ) { Text(text) }
}
