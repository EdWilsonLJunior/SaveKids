import SwiftUI

// MARK: - Product Manager Screen
struct ProductManagerScreen: View {
    @StateObject private var viewModel: ProductManagerViewModel = ProductManagerViewModel()

    private let tabNames = [
        String(localized: "feature.product_manager.tab_stock"),
        String(localized: "feature.product_manager.tab_reports")
    ]

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.product_manager.title",
            eyebrow: "feature.product_manager.eyebrow",
            intro: "feature.product_manager.intro"
        ) {
            if viewModel.selectedTab == 0 {
                StockTabView(viewModel: viewModel)
            } else {
                ReportsTabView(viewModel: viewModel)
            }
        } edgeToEdgeContent: {
            ZodiakTabs(tabs: tabNames, selectedIndex: $viewModel.selectedTab)
        }
        .accessibilityIdentifier("screen.13.product_manager")
    }
}

#Preview {
    ProductManagerScreen()
}
