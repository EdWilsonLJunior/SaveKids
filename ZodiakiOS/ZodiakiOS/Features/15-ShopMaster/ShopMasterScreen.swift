import SwiftUI

// MARK: - ShopMasterScreen

// swiftlint:disable:next inclusive_language
struct ShopMasterScreen: View {
    @StateObject private var viewModel = ShopMasterViewModel()
    @State private var navigateToCart = false

    private let tabNames = [
        String(localized: "feature.shop_master.category_electronics"),
        String(localized: "feature.shop_master.category_food"),
        String(localized: "feature.shop_master.category_home")
    ]

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.shop_master.title",
            eyebrow: "feature.shop_master.eyebrow",
            intro: "feature.shop_master.intro",
            maxContentWidth: ShopMasterConstants.productListMaxWidth
        ) {
            catalogContent
            cartNavigationButton
        } edgeToEdgeContent: {
            ZodiakTabs(tabs: tabNames, selectedIndex: $viewModel.selectedTab)
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: String(localized: "feature.shop_master.search_placeholder")
        )
        .zodiakToast($viewModel.toast)
        .accessibilityIdentifier("screen.15.shop_master")
    }

    // MARK: - Catalog Content

    @ViewBuilder
    private var catalogContent: some View {
        if viewModel.filteredProducts.isEmpty {
            ZodiakEmptyState(
                icon: "magnifyingglass",
                title: "feature.shop_master.catalog_empty_title",
                description: "feature.shop_master.catalog_empty_desc"
            )
        } else {
            VStack(spacing: ZodiakSpacing.s8) {
                ForEach(viewModel.filteredProducts) { product in
                    ShopProductRowView(product: product) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            viewModel.addToCart(product)
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.filteredProducts.map(\.id))
        }
    }

    // MARK: - Cart Navigation Button

    private var cartNavigationButton: some View {
        ZodiakButtonPrimary(
            title: "feature.shop_master.cart_title",
            action: { navigateToCart = true },
            icon: "cart",
            iconPlacement: .leading
        )
        .overlay(alignment: .topTrailing) {
            if viewModel.cartItemCount > 0 {
                ZodiakBadge(
                    text: "\(viewModel.cartItemCount)",
                    backgroundColor: ZodiakColors.actionPrimary,
                    foregroundColor: ZodiakColors.textInverse
                )
                .offset(x: ZodiakSpacing.s4, y: -ZodiakSpacing.s4)
                .animation(
                    .spring(response: 0.3, dampingFraction: 0.6),
                    value: viewModel.cartItemCount
                )
            }
        }
        .navigationDestination(isPresented: $navigateToCart) {
            ShopCartView(viewModel: viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        ShopMasterScreen()
    }
}
