package com.zodiak.android.navigation

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowForward
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.zodiak.android.feature.bookreader.BookReaderRoute
import com.zodiak.android.feature.cardmanager.CardManagerRoute
import com.zodiak.android.feature.currencyconverter.CurrencyConverterRoute
import com.zodiak.android.feature.grades.GradesRoute
import com.zodiak.android.feature.guessgame.GuessGameRoute
import com.zodiak.android.feature.multiplication.MultiplicationRoute
import com.zodiak.android.feature.palindrome.PalindromeRoute
import com.zodiak.android.feature.personmanager.PersonManagerRoute
import com.zodiak.android.feature.pixdiscount.PixDiscountRoute
import com.zodiak.android.feature.productmanager.ProductManagerRoute
import com.zodiak.android.feature.quizgame.QuizGameRoute
import com.zodiak.android.feature.savekids.navigation.SaveKidsLoginRoute
import com.zodiak.android.feature.shopmaster.ShopMasterRoute
import com.zodiak.android.feature.studentgrades.StudentGradesRoute
import com.zodiak.android.feature.taskmanager.TaskManagerRoute
import com.zodiak.android.feature.temperatureconverter.TemperatureConverterRoute
import com.zodiak.android.feature.voting.VotingRoute

private data class FeatureItem(val emoji: String, val title: String, val description: String, val route: Any)

private val FEATURES = listOf(
    FeatureItem("📊", "Calculadora de Notas",   "Calcule médias e aprovação",              GradesRoute),
    FeatureItem("💳", "Desconto Pix",            "Calcule descontos com Pix",               PixDiscountRoute),
    FeatureItem("🗳️", "Votação",                 "Simulação de votação com segundo turno",  VotingRoute),
    FeatureItem("🔤", "Palíndromo",              "Verifique se uma palavra é palíndromo",   PalindromeRoute),
    FeatureItem("🎯", "Adivinhe o Número",       "Jogo de adivinhação 1-100",               GuessGameRoute),
    FeatureItem("✖️", "Tabuada",                 "Gere a tabuada de qualquer número",       MultiplicationRoute),
    FeatureItem("👥", "Gerenciar Pessoas",       "Cadastro de pessoas",                     PersonManagerRoute),
    FeatureItem("🌡️", "Converter Temperatura",  "Celsius ↔ Fahrenheit",                   TemperatureConverterRoute),
    FeatureItem("✅", "Gerenciar Tarefas",       "Lista de tarefas com busca",              TaskManagerRoute),
    FeatureItem("🧠", "Quiz",                    "Teste seus conhecimentos",                QuizGameRoute),
    FeatureItem("🎓", "Notas de Alunos",         "Gestão de alunos e matérias",             StudentGradesRoute),
    FeatureItem("📦", "Gerenciar Produtos",      "Cadastro e agrupamento de produtos",      ProductManagerRoute),
    FeatureItem("💳", "Gerenciar Cartões",       "Visualize seus cartões de crédito",       CardManagerRoute),
    FeatureItem("🛒", "ShopMaster",              "Loja com carrinho de compras",            ShopMasterRoute),
    FeatureItem("📚", "Leitor de Livro",         "Leia com progresso salvo",                BookReaderRoute),
    FeatureItem("💱", "Converter Moeda",         "Converta entre 8 moedas mundiais",        CurrencyConverterRoute),
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
