package com.zodiak.android.feature.bookreader

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.automirrored.filled.ArrowForward
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.res.stringResource
import com.zodiak.android.design_system.atoms.ZodiakBody
import com.zodiak.android.design_system.atoms.ZodiakHeadline
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.R

@Composable
fun BookReaderScreen(viewModel: BookReaderViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()
    val page = state.currentPage

    Scaffold { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween,
        ) {
            ZodiakFormContainer(page.title) {
                Spacer(Modifier.height(8.dp))
                ZodiakBody(page.content)
            }

            Column {
                LinearProgressIndicator(
                    progress = { (state.currentPageIndex + 1).toFloat() / state.pages.size },
                    modifier = Modifier.fillMaxWidth(),
                )
                Spacer(Modifier.height(4.dp))
                Text(
                    stringResource(R.string.bookreader_page_indicator, state.currentPageIndex + 1, state.pages.size),
                    style = MaterialTheme.typography.labelMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.fillMaxWidth(),
                )
                Spacer(Modifier.height(12.dp))
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                ) {
                    FilledTonalIconButton(onClick = viewModel::previousPage, enabled = !state.isFirstPage) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, stringResource(R.string.bookreader_button_previous))
                    }
                    FilledTonalIconButton(onClick = viewModel::nextPage, enabled = !state.isLastPage) {
                        Icon(Icons.AutoMirrored.Filled.ArrowForward, stringResource(R.string.bookreader_button_next))
                    }
                }
            }
        }
    }
}
