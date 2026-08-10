import Foundation

// MARK: - Book Page Model

struct BookPage {
    let titleKey: String
    let contentKey: String

    var title: String { NSLocalizedString(titleKey, comment: "") }
    var content: String { NSLocalizedString(contentKey, comment: "") }
}

// MARK: - Constants

enum BookReaderConstants {
    static let appStorageKeyPage: String = "lastReadPage"

    static let pages: [BookPage] = [
        BookPage(
            titleKey: "feature.book_reader.page_1.title",
            contentKey: "feature.book_reader.page_1.content"
        ),
        BookPage(
            titleKey: "feature.book_reader.page_2.title",
            contentKey: "feature.book_reader.page_2.content"
        ),
        BookPage(
            titleKey: "feature.book_reader.page_3.title",
            contentKey: "feature.book_reader.page_3.content"
        ),
        BookPage(
            titleKey: "feature.book_reader.page_4.title",
            contentKey: "feature.book_reader.page_4.content"
        ),
        BookPage(
            titleKey: "feature.book_reader.page_5.title",
            contentKey: "feature.book_reader.page_5.content"
        )
    ]
}
