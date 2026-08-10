import SwiftUI

// MARK: - Book Reader Screen

struct BookReaderScreen: View {
    @StateObject private var viewModel = BookReaderViewModel()

    var body: some View {
        ZodiakAdaptiveTemplate(
            title: "feature.book_reader.title",
            eyebrow: "feature.book_reader.eyebrow",
            intro: "feature.book_reader.intro"
        ) {
            VStack(spacing: ZodiakSpacing.s24) {
                pageContent
                pageControls
            }
        }
        .accessibilityIdentifier("screen.17.book_reader")
    }

    // MARK: - Private

    private var pageContent: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            ZodiakText(verbatim: viewModel.currentBookPage.title, style: .title2)
                .frame(maxWidth: .infinity, alignment: .leading)

            ZodiakDivider(hierarchy: .secondary)

            ZodiakText(verbatim: viewModel.currentBookPage.content, style: .body())
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(ZodiakSpacing.s16)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
        .id(viewModel.currentPage)
        .transition(.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        ))
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentPage)
    }

    private var pageControls: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            ZodiakText(
                verbatim: String(
                    format: String(localized: "feature.book_reader.page_indicator"),
                    viewModel.currentPage + 1,
                    viewModel.totalPages
                ),
                style: .caption()
            )
            .frame(maxWidth: .infinity, alignment: .center)

            HStack(spacing: ZodiakSpacing.s16) {
                ZodiakButtonSecondary(
                    title: "feature.book_reader.button.previous",
                    action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.previousPage()
                        }
                    },
                    isEnabled: viewModel.canGoPrevious
                )
                ZodiakButtonPrimary(
                    title: "feature.book_reader.button.next",
                    action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.nextPage()
                        }
                    },
                    isEnabled: viewModel.canGoNext
                )
            }
        }
    }
}

#Preview {
    BookReaderScreen()
}
