package com.zodiak.android.design_system.atoms

import androidx.compose.material3.ScrollableTabRow
import androidx.compose.material3.Tab
import androidx.compose.material3.TabRow
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics

// ─── ZodiakTabs ───────────────────────────────────────────────────────────────
// Zodiak Design System – Atoms layer
// Wraps MD3 TabRow / ScrollableTabRow with a consistent Zodiak API.
//
// Usage:
//   ZodiakTabs(
//       tabs = listOf("Notas", "Médias", "Faltas"),
//       selectedIndex = selectedTab,
//       onTabSelected = { index, _ -> selectedTab = index },
//       tabLabel = { it },
//   )
//
// For > 5 tabs or long labels, use style = ZodiakTabRowStyle.SCROLLABLE.
//
// Gap reference: G-014

/** Controls whether the tab row scrolls horizontally (SCROLLABLE) or fills the width evenly (FIXED). */
enum class ZodiakTabRowStyle {
    /** All tabs share equal width. Best for 2–5 short labels. */
    FIXED,

    /** Tabs scroll horizontally. Use when labels are long or count > 5. */
    SCROLLABLE,
}

/**
 * Tab row component for Zodiak screens.
 *
 * @param tabs          Ordered list of tab items.
 * @param selectedIndex Zero-based index of the currently selected tab.
 * @param onTabSelected Callback invoked when the user taps a tab.
 *                      Receives both the index and the item for convenience.
 * @param modifier      Applied to the outermost TabRow composable.
 * @param style         FIXED (default) or SCROLLABLE layout mode.
 * @param tabLabel      Maps a tab item to its display label string.
 */
@Composable
fun <T> ZodiakTabs(
    tabs: List<T>,
    selectedIndex: Int,
    onTabSelected: (index: Int, tab: T) -> Unit,
    modifier: Modifier = Modifier,
    style: ZodiakTabRowStyle = ZodiakTabRowStyle.FIXED,
    tabLabel: (T) -> String,
) {
    when (style) {
        ZodiakTabRowStyle.FIXED -> TabRow(
            selectedTabIndex = selectedIndex,
            modifier = modifier,
        ) {
            tabs.forEachIndexed { index, tab ->
                val label = tabLabel(tab)
                Tab(
                    selected = index == selectedIndex,
                    onClick = { onTabSelected(index, tab) },
                    modifier = Modifier.semantics { contentDescription = label },
                    text = { Text(label) },
                )
            }
        }

        ZodiakTabRowStyle.SCROLLABLE -> ScrollableTabRow(
            selectedTabIndex = selectedIndex,
            modifier = modifier,
        ) {
            tabs.forEachIndexed { index, tab ->
                val label = tabLabel(tab)
                Tab(
                    selected = index == selectedIndex,
                    onClick = { onTabSelected(index, tab) },
                    modifier = Modifier.semantics { contentDescription = label },
                    text = { Text(label) },
                )
            }
        }
    }
}
