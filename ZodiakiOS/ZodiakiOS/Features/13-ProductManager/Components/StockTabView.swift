import SwiftUI

// MARK: - Stock Tab View
struct StockTabView: View {
    @ObservedObject var viewModel: ProductManagerViewModel

    var body: some View {
        VStack(spacing: ZodiakSpacing.s24) {
            formSection
            if let error = viewModel.errorMessage {
                ZodiakAlert(title: error, variant: .error)
            }
            productListSection
        }
    }

    // MARK: - Form

    private var formSection: some View {
        ZodiakFormWrapper {
            ZodiakLabelledField(
                label: "feature.product_manager.label_name",
                placeholder: "feature.product_manager.placeholder_name",
                text: $viewModel.newName
            )
            ZodiakLabelledField(
                label: "feature.product_manager.label_brand",
                placeholder: "feature.product_manager.placeholder_brand",
                text: $viewModel.newBrand
            )
            ZodiakDropdown(
                label: String(localized: "feature.product_manager.label_segment"),
                selection: $viewModel.newSegment,
                options: ProductSegment.allCases.map { seg in
                    (value: seg, label: NSLocalizedString(seg.rawValue, comment: ""))
                },
                placeholder: String(localized: "feature.product_manager.placeholder_segment")
            )
            ZodiakLabelledNumericField(
                label: String(localized: "feature.product_manager.label_price"),
                placeholder: "feature.product_manager.placeholder_price",
                value: $viewModel.newPrice,
                minimum: 0.01,
                maximum: 999_999
            )
        }
    }

    // MARK: - Actions + List

    private var productListSection: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            ZodiakButtonPrimary(title: "feature.product_manager.add_action", action: viewModel.addProduct)

            if !viewModel.products.isEmpty {
                ZodiakDivider(hierarchy: .secondary)
                ForEach(viewModel.products) { product in
                    ZodiakInfoRow(
                        label: product.name,
                        value: String(format: "R$ %.2f", product.price)
                    )
                }
            }
        }
    }
}
