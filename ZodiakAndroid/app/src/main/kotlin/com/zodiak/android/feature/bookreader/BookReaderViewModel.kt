package com.zodiak.android.feature.bookreader

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.zodiak.android.core.datastore.ZodiakPreferencesRepository
import com.zodiak.android.core.models.BookPage
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

private val SAMPLE_PAGES = listOf(
    BookPage(index = 0, title = "O Início da Jornada", content = "Era uma vez um jovem desenvolvedor que sonhava criar aplicativos que mudariam o mundo. Ele acordava cedo todos os dias e estudava com afinco as melhores práticas de programação."),
    BookPage(index = 1, title = "Os Primeiros Desafios", content = "Os primeiros bugs eram desconcertantes. Horas se passavam tentando entender por que o código não compilava, até que a solução aparecia de forma inesperada — muitas vezes após uma xícara de café."),
    BookPage(index = 2, title = "A Descoberta do Kotlin", content = "Quando conheceu Kotlin, sua vida mudou. A concisão, a segurança de tipos e as corrotinas transformaram a forma como escrevia código Android. Nunca mais olhou para trás."),
    BookPage(index = 3, title = "Jetpack Compose", content = "Compose trouxe uma nova dimensão ao desenvolvimento de UI. Componentes declarativos, recomposição reativa e o poder do Material 3 tornavam cada tela um prazer de criar."),
    BookPage(index = 4, title = "O Fim e o Começo", content = "No final, o desenvolvedor percebeu que a jornada nunca terminava. Cada projeto concluído abria portas para novas tecnologias, novos padrões e novas histórias para contar."),
)

data class BookReaderUiState(
    val pages: List<BookPage> = SAMPLE_PAGES,
    val currentPageIndex: Int = 0,
) {
    val currentPage: BookPage get() = pages[currentPageIndex]
    val isFirstPage: Boolean get() = currentPageIndex == 0
    val isLastPage: Boolean get() = currentPageIndex == pages.size - 1
}

@HiltViewModel
class BookReaderViewModel @Inject constructor(
    private val preferences: ZodiakPreferencesRepository,
) : ViewModel() {

    private val _uiState = MutableStateFlow(BookReaderUiState())
    val uiState: StateFlow<BookReaderUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            val savedIndex = preferences.bookPageIndex.first()
            val clampedIndex = savedIndex.coerceIn(0, SAMPLE_PAGES.size - 1)
            _uiState.update { it.copy(currentPageIndex = clampedIndex) }
        }
    }

    fun nextPage() {
        if (_uiState.value.isLastPage) return
        val newIndex = _uiState.value.currentPageIndex + 1
        _uiState.update { it.copy(currentPageIndex = newIndex) }
        savePage(newIndex)
    }

    fun previousPage() {
        if (_uiState.value.isFirstPage) return
        val newIndex = _uiState.value.currentPageIndex - 1
        _uiState.update { it.copy(currentPageIndex = newIndex) }
        savePage(newIndex)
    }

    private fun savePage(index: Int) {
        viewModelScope.launch { preferences.setBookPageIndex(index) }
    }
}
