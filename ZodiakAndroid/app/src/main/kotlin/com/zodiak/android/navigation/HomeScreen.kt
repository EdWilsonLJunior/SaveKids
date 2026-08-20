package com.zodiak.android.navigation

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowForward
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.Icon
import androidx.compose.material3.ListItem
import androidx.compose.material3.ListItemDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zodiak.android.feature.savekids.navigation.SaveKidsLoginRoute

private data class FeatureItem(val emoji: String, val title: String, val description: String, val route: Any)

private val FEATURES = listOf(
    FeatureItem("🧒", "Save Kids",               "Acesso único ao app: login, avatar e fluxo completo", SaveKidsLoginRoute),
)

@Composable
fun HomeScreen(navController: NavController) {
    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(horizontal = 16.dp, vertical = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp),
        ) {
            item {
                Text(
                    "Zodiak Android",
                    style = MaterialTheme.typography.headlineLarge,
                    modifier = Modifier.padding(bottom = 8.dp),
                )
                Text(
                    "${FEATURES.size} funcionalidades educacionais",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                )
                Spacer(Modifier.height(8.dp))
            }

            items(FEATURES) { feature ->
                ElevatedCard(
                    modifier = Modifier.fillMaxWidth(),
                    onClick  = { navController.navigate(feature.route) },
                ) {
                    ListItem(
                        headlineContent  = { Text("${feature.emoji} ${feature.title}") },
                        supportingContent = { Text(feature.description) },
                        trailingContent  = { Icon(Icons.AutoMirrored.Filled.ArrowForward, null) },
                        colors = ListItemDefaults.colors(containerColor = MaterialTheme.colorScheme.surface),
                    )
                }
            }
        }
    }
}
