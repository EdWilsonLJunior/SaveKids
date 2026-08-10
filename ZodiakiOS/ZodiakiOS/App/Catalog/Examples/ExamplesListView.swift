import SwiftUI

// MARK: - Examples List View

struct ExamplesListView: View {
    @State private var pushedExampleID: Int?
    @State private var showLPMiniApp: Bool = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.home.tab_examples",
                subtitle: "catalog.examples.subtitle"
            )
            examplesList
        }
        .zodiakPage(title: "catalog.home.tab_examples")
        .fullScreenCover(isPresented: $showLPMiniApp) { LPRootView() }
        .navigationDestination(item: $pushedExampleID) { exampleID in
            if let item = ExampleItem.all.first(where: { $0.id == exampleID }) {
                destinationView(for: item)
            }
        }
    }

    private var examplesList: some View {
        ZodiakShowMore(items: ExampleItem.all, initialCount: 16) { item in
            ZodiakListingRow(item: ZodiakListingItem(
                eyebrow: nil,
                title: item.title,
                summary: item.description,
                meta: String(format: "%02d", item.id),
                imageSystemName: item.icon,
                action: {
                    if item.id == 30 { showLPMiniApp = true } else { pushedExampleID = item.id }
                }
            ))
        }
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }

    @ViewBuilder
    private func destinationView(for item: ExampleItem) -> some View {
        ExamplesDestinationHost {
            switch item.id {
            case 1:  GradeScreen()
            case 2:  PixDiscountScreen()
            case 3:  VotingScreen()
            case 4:  PalindromeScreen()
            case 5:  GuessGameScreen()
            default: featureDestinationView(for: item)
            }
        }
    }

    @ViewBuilder
    private func featureDestinationView(for item: ExampleItem) -> some View {
        switch item.id {
        case 6:  MultiplicationTableScreen()
        case 7:  PersonManagerScreen()
        case 8:  TemperatureConverterScreen()
        case 9:  TaskManagerScreen()
        case 10: QuizGameScreen()
        default: lateFeatureDestinationView(for: item)
        }
    }

    @ViewBuilder
    private func lateFeatureDestinationView(for item: ExampleItem) -> some View {
        switch item.id {
        case 11: StudentGradesScreen()
        case 12: ProductManagerScreen()
        case 13: CardManagerScreen()
        case 14: ShopMasterScreen()
        case 15: UserDefaultsLoginScreen()
        default: extraFeatureDestinationView(for: item)
        }
    }

    @ViewBuilder
    private func extraFeatureDestinationView(for item: ExampleItem) -> some View {
        switch item.id {
        case 16: BookReaderScreen()
        case 17: CurrencyConverterScreen()
        case 18: ExpenseManagerScreen()
        case 19: HangmanGameScreen()
        case 20: ContactsListScreen()
        default: recentFeatureDestinationView(for: item)
        }
    }

    @ViewBuilder
    private func recentFeatureDestinationView(for item: ExampleItem) -> some View {
        switch item.id {
        case 28: SolutionsCatalogScreen()
        default: EmptyView()
        }
    }
}

// MARK: - Examples Destination Host
/// Wrapper aplicado automaticamente a toda feature pushed a partir de ExamplesListView.
/// Garante que os botões de idioma e tema estejam sempre presentes na navigation bar,
/// sem que cada feature precise saber de sua existência.
private struct ExamplesDestinationHost<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .settingsToolbar()
    }
}

#Preview {
    NavigationStack {
        ExamplesListView()
    }
    .environmentObject(CatalogViewModel())
}
