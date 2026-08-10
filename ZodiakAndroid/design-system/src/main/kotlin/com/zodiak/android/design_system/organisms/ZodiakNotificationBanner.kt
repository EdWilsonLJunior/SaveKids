@file:Suppress("FunctionNaming", "MatchingDeclarationName")

package com.zodiak.android.design_system.organisms

import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Snackbar
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.launch

// ─── ZodiakNotificationBanner ─────────────────────────────────────────────────
// Zodiak Design System – Organisms layer
// Transient notification banner shown at the bottom of the screen.
// Built on top of MD3 Snackbar / SnackbarHost so it integrates with Scaffold.
//
// Gap reference: G-038
//
// Two usage patterns:
//
// ── Pattern A — simple (unmanaged host) ──────────────────────────────────────
//   val bannerState = rememberZodiakBannerState()
//   Scaffold(
//       snackbarHost = { ZodiakNotificationBannerHost(bannerState) },
//       ...
//   )
//   // Trigger from ViewModel event:
//   LaunchedEffect(event) {
//       bannerState.show("Guardado com sucesso.", actionLabel = "Desfazer") { /* undo */ }
//   }
//
// ── Pattern B — standalone (no Scaffold) ─────────────────────────────────────
//   Box(Modifier.fillMaxSize()) {
//       Content()
//       ZodiakNotificationBannerHost(
//           state = bannerState,
//           modifier = Modifier.align(Alignment.BottomCenter),
//       )
//   }

// ─── State ────────────────────────────────────────────────────────────────────

/**
 * Holds state for a [ZodiakNotificationBannerHost].
 * Created with [rememberZodiakBannerState].
 */
class ZodiakBannerState internal constructor(
    internal val snackbarHostState: SnackbarHostState,
)

/** Creates and remembers a [ZodiakBannerState] bound to the composition. */
@Composable
fun rememberZodiakBannerState(): ZodiakBannerState {
    val hostState = remember { SnackbarHostState() }
    return remember(hostState) { ZodiakBannerState(hostState) }
}

// ─── Extension: imperatively show a banner ────────────────────────────────────

/**
 * Imperatively shows a banner from a coroutine scope (e.g. inside [LaunchedEffect]).
 *
 * @param message     Text displayed in the banner.
 * @param actionLabel Optional action button label. Pair with [onAction].
 * @param onAction    Invoked when the user taps the action button.
 */
suspend fun ZodiakBannerState.show(
    message: String,
    actionLabel: String? = null,
    onAction: (() -> Unit)? = null,
) {
    val result = snackbarHostState.showSnackbar(
        message = message,
        actionLabel = actionLabel,
    )
    if (result == androidx.compose.material3.SnackbarResult.ActionPerformed) {
        onAction?.invoke()
    }
}

// ─── Host composable ──────────────────────────────────────────────────────────

/**
 * Drop-in replacement for MD3 [SnackbarHost] that applies Zodiak visual overrides.
 *
 * Place inside [androidx.compose.material3.Scaffold]'s `snackbarHost` slot, or
 * position manually with [Modifier].
 *
 * @param state    The [ZodiakBannerState] produced by [rememberZodiakBannerState].
 * @param modifier Applied to the host container.
 */
@Composable
fun ZodiakNotificationBannerHost(
    state: ZodiakBannerState,
    modifier: Modifier = Modifier,
) {
    SnackbarHost(
        hostState = state.snackbarHostState,
        modifier = modifier,
    ) { snackbarData ->
        Snackbar(
            snackbarData = snackbarData,
            modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp),
        )
    }
}

// ─── Convenience composable (managed internally) ──────────────────────────────

/**
 * Self-contained notification banner with its own [ZodiakBannerState].
 * Use when you need a simple trigger without wiring a separate state object.
 *
 * The [content] lambda receives a `show` callback you can call from UI events.
 *
 * ```kotlin
 * ZodiakNotificationBanner { show ->
 *     ZodiakButton("Guardar") { show("Guardado!") }
 * }
 * ```
 *
 * @param modifier Applied to the host's [SnackbarHost].
 * @param content  Child composable; receives `show(message, actionLabel?, onAction?)`.
 */
@Composable
fun ZodiakNotificationBanner(
    modifier: Modifier = Modifier,
    content: @Composable (show: (message: String, actionLabel: String?, onAction: (() -> Unit)?) -> Unit) -> Unit,
) {
    val state = rememberZodiakBannerState()
    val scope = rememberCoroutineScope()

    val show: (String, String?, (() -> Unit)?) -> Unit = { message, actionLabel, onAction ->
        scope.launch { state.show(message, actionLabel, onAction) }
    }

    content(show)
    ZodiakNotificationBannerHost(state = state, modifier = modifier)
}
