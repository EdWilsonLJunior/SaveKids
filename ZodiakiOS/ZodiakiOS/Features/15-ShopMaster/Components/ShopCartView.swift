import SwiftUI

// MARK: - ShopCartView

struct ShopCartView: View {
    @ObservedObject var viewModel: ShopMasterViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.shop_master.cart_title",
            eyebrow: "feature.shop_master.eyebrow",
            intro: "feature.shop_master.cart_intro"
        ) {
            cartContent
        }
        .navigationBarBackButtonHidden(false)
    }

    // MARK: - Cart Content

    @ViewBuilder
    private var cartContent: some View {
        if viewModel.cartItems.isEmpty {
            ZodiakEmptyState(
                icon: "cart",
                title: "feature.shop_master.cart_empty",
                description: "feature.shop_master.cart_empty_desc"
            )
        } else {
            VStack(spacing: ZodiakSpacing.s24) {
                itemsList
                ZodiakDivider(hierarchy: .primary)
                totalRow
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.cartItems.map(\.id))
        }
    }

    // MARK: - Items List

    private var itemsList: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            ForEach(viewModel.cartItems) { item in
                cartRow(item)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                viewModel.removeFromCart(item)
                            }
                        } label: {
                            Label(
                                String(localized: "feature.shop_master.remove_action"),
                                systemImage: "trash"
                            )
                        }
                    }
            }
        }
    }

    private func cartRow(_ item: CartItem) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakAvatar(
                systemImage: item.product.icon,
                size: .m,
                backgroundColor: ZodiakColors.surfaceSmoke
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(verbatim: item.product.name, style: .title3)
                ZodiakText(
                    verbatim: item.subtotal.formatted(.currency(code: "BRL")),
                    style: .body(bold: true)
                )
                .foregroundStyle(ZodiakColors.actionPrimary)
            }

            Spacer()

            quantityControls(item)
        }
        .padding(ZodiakSpacing.s16)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    private func quantityControls(_ item: CartItem) -> some View {
        HStack(spacing: ZodiakSpacing.s4) {
            ZodiakIconButton(
                icon: "minus",
                action: {
                    withAnimation(.spring(response: 0.25)) {
                        viewModel.decreaseQuantity(of: item)
                    }
                },
                size: .small,
                style: .tertiary,
                accessibilityLabel: String(localized: "shared.action.decrease")
            )

            ZodiakText(verbatim: "\(item.quantity)", style: .title1)
                .frame(minWidth: 32)
                .contentTransition(.numericText())
                .animation(.spring(response: 0.3), value: item.quantity)

            ZodiakIconButton(
                icon: "plus",
                action: {
                    withAnimation(.spring(response: 0.25)) {
                        viewModel.increaseQuantity(of: item)
                    }
                },
                size: .small,
                style: .tertiary,
                accessibilityLabel: String(localized: "shared.action.increase")
            )
        }
    }

    // MARK: - Total Row

    private var totalRow: some View {
        ZodiakResultCard(
            title: String(localized: "feature.shop_master.cart_total"),
            value: viewModel.cartTotal.formatted(.currency(code: "BRL")),
            subtitle: nil
        )
        .zodiakCardWidth()
    }
}
