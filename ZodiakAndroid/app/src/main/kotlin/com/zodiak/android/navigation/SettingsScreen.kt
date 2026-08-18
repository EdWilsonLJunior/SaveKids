package com.zodiak.android.navigation

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.zodiak.android.feature.themeswitch.ThemeSwitchRoute

@Composable
fun SettingsScreen(
    navController: NavController,
    viewModel: SettingsViewModel = hiltViewModel(),
) {
    var showLogoutDialog by rememberSaveable { mutableStateOf(false) }

    if (showLogoutDialog) {
        AlertDialog(
            onDismissRequest = { showLogoutDialog = false },
            title = { Text("Sair") },
            text = { Text("Deseja sair do Save Kids?") },
            confirmButton = {
                TextButton(
                    onClick = {
                        showLogoutDialog = false
                        viewModel.logout {
                            navController.navigate(com.zodiak.android.feature.savekids.navigation.SaveKidsLoginRoute) {
                                popUpTo(navController.graph.id) { inclusive = true }
                                launchSingleTop = true
                            }
                        }
                    },
                ) {
                    Text("Sair")
                }
            },
            dismissButton = {
                TextButton(onClick = { showLogoutDialog = false }) {
                    Text("Cancelar")
                }
            },
        )
    }

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

            ElevatedCard(modifier = Modifier.fillMaxWidth(), onClick = { showLogoutDialog = true }) {
                ListItem(
                    headlineContent  = { Text("👤 Logout") },
                    supportingContent = { Text("Encerrar a sessão atual do Save Kids") },
                )
            }
        }
    }
}
