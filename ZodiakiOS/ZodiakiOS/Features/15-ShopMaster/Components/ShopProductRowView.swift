import SwiftUI

// MARK: - ShopProductRowView

struct ShopProductRowView: View {
    let product: ShopProduct
    let onAdd: () -> Void

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakAvatar(
                systemImage: product.icon,
                size: .m,
                backgroundColor: ZodiakColors.surfaceSmoke
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(verbatim: product.name, style: .title3)
                ZodiakChip(
                    verbatim: NSLocalizedString(product.category.rawValue, comment: ""),
                    isActive: false
                )
                ZodiakText(
                    verbatim: product.price.formatted(.currency(code: "BRL")),
                    style: .body(bold: true)
                )
                .foregroundStyle(ZodiakColors.actionPrimary)
            }

            Spacer()

            ZodiakIconButton(
                icon: "plus",
                action: onAdd,
                size: .small,
                style: .primary,
                accessibilityLabel: String(localized: "feature.shop_master.add_to_cart")
            )
        }
        .padding(ZodiakSpacing.s16)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
        .hoverEffect(.lift)
    }
}
