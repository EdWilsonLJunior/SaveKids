package com.zodiak.android.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.zodiak.android.feature.bookreader.bookReaderScreen
import com.zodiak.android.feature.cardmanager.cardManagerScreen
import com.zodiak.android.feature.catalog.catalogScreen
import com.zodiak.android.feature.catalog.colorTokenDetailScreen
import com.zodiak.android.feature.catalog.ColorTokenDetailRoute
import com.zodiak.android.feature.currencyconverter.currencyConverterScreen
import com.zodiak.android.feature.grades.gradesScreen
import com.zodiak.android.feature.guessgame.guessGameScreen
import com.zodiak.android.feature.login.loginScreen
import com.zodiak.android.feature.multiplication.multiplicationScreen
import com.zodiak.android.feature.palindrome.palindromeScreen
import com.zodiak.android.feature.personmanager.personManagerScreen
import com.zodiak.android.feature.pixdiscount.pixDiscountScreen
import com.zodiak.android.feature.productmanager.productManagerScreen
import com.zodiak.android.feature.quizgame.quizGameScreen
import com.zodiak.android.feature.savekids.navigation.SaveKidsLoginRoute
import com.zodiak.android.feature.savekids.navigation.saveKidsScreens
import com.zodiak.android.feature.shopmaster.shopMasterScreen
import com.zodiak.android.feature.studentgrades.studentGradesScreen
import com.zodiak.android.feature.taskmanager.taskManagerScreen
import com.zodiak.android.feature.temperatureconverter.temperatureConverterScreen
import com.zodiak.android.feature.themeswitch.themeSwitchScreen
import com.zodiak.android.feature.voting.votingScreen

@Composable
fun ZodiakNavGraph(navController: NavHostController) {
    NavHost(navController = navController, startDestination = SaveKidsLoginRoute) {
        composable<SettingsRoute> { SettingsScreen(navController) }
        themeSwitchScreen()
        saveKidsScreens(navController)
    }
}
