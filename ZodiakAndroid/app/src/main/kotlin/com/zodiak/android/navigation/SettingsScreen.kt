package com.zodiak.android.navigation

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zodiak.android.feature.login.LoginRoute
import com.zodiak.android.feature.themeswitch.ThemeSwitchRoute

@Composable
fun SettingsScreen(navController: NavController) {
    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            Text("Configurações", style = MaterialTheme.typography.headlineLarge)
            Spacer(Modifier.height(8.dp))

            ElevatedCard(modifier = Modifier.fillMaxWidth(), onClick = { navController.navigate(ThemeSwitchRoute) }) {
                ListItem(
                    headlineContent  = { Text("🌙 Aparência") },
                    supportingContent = { Text("Alternar entre modo claro e escuro") },
                )
            }

            ElevatedCard(modifier = Modifier.fillMaxWidth(), onClick = { navController.navigate(LoginRoute) }) {
                ListItem(
                    headlineContent  = { Text("👤 Login") },
                    supportingContent = { Text("Entrar com e-mail e salvar preferências") },
                )
            }
        }
    }
}
