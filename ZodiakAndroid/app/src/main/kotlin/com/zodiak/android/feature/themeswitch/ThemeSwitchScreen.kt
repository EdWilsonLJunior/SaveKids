package com.zodiak.android.feature.themeswitch

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.design_system.molecules.ZodiakSwitch
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.R

@Composable
fun ThemeSwitchScreen(viewModel: ThemeSwitchViewModel = hiltViewModel()) {
    val isDark by viewModel.isDarkMode.collectAsStateWithLifecycle()

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            ZodiakFormContainer(stringResource(R.string.themeswitch_form_title_appearance)) {
                ZodiakSwitch(
                    label = if (isDark) stringResource(R.string.themeswitch_switch_label_dark_mode) else stringResource(R.string.themeswitch_switch_label_light_mode),
                    checked = isDark,
                    onCheckedChange = viewModel::toggle,
                )
                Spacer(Modifier.height(8.dp))
                Text(
                    stringResource(R.string.themeswitch_text_preference_saved),
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                )
            }
        }
    }
}
