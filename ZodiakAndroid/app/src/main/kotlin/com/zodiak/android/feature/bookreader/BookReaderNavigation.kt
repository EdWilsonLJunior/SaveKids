package com.zodiak.android.feature.bookreader

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import kotlinx.serialization.Serializable

@Serializable object BookReaderRoute

fun NavGraphBuilder.bookReaderScreen() {
    composable<BookReaderRoute> { BookReaderScreen() }
}
