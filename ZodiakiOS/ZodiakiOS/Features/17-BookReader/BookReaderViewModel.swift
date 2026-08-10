import Combine
import SwiftUI

// MARK: - Activity 17: Book Reader

/// ViewModel da Atividade 17 — leitor de livro digital com persistência da última página lida.
final class BookReaderViewModel: ObservableObject {
    @AppStorage(BookReaderConstants.appStorageKeyPage) var currentPage: Int = 0

    var totalPages: Int { BookReaderConstants.pages.count }

    var currentBookPage: BookPage { BookReaderConstants.pages[currentPage] }

    var canGoNext: Bool { currentPage < totalPages - 1 }

    var canGoPrevious: Bool { currentPage > 0 }

    func nextPage() {
        guard canGoNext else { return }
        currentPage += 1
    }

    func previousPage() {
        guard canGoPrevious else { return }
        currentPage -= 1
    }
}
