import SwiftUI

// MARK: - Pix Discount Screen
struct PixDiscountScreen: View {
    @StateObject private var viewModel: PixDiscountViewModel = PixDiscountViewModel()
    @Environment(\.locale) private var locale

    var body: some View {
        ZodiakActivityTemplate(
            title: "Desconto Pix",
            eyebrow: "feature.pix.eyebrow",
            intro: "feature.pix.intro"
        ) {
            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "shared.label.product",
                    placeholder: "shared.placeholder.product_name",
                    text: $viewModel.productName
                )

                ZodiakLabelledNumericField(
                    label: "feature.pix.amount_label",
                    placeholder: "shared.placeholder.decimal_zero",
                    value: $viewModel.productValue
                )

                ZodiakSwitch(
                    label: "feature.pix.pay_with_pix",
                    isOn: $viewModel.isPixSelected
                )
            }

            if viewModel.isPixSelected && (viewModel.productValue ?? 0) >= PixDiscountConstants.minValueForDiscount {
                ZodiakWarningBadge(text: "feature.pix.discount_applied")
            }

            ZodiakButtonPrimary(title: "shared.action.calculate", action: viewModel.submit)

            if let result: (finalValue: Double, discount: Double) = viewModel.result {
                VStack(spacing: ZodiakSpacing.s16) {
                    // swiftlint:disable:next line_length
                    let finalValueFormatted: String = String(format: PixDiscountConstants.currencyFormat, result.finalValue)
                    let discountFormatted: String = String(format: PixDiscountConstants.currencyFormat, result.discount)
                    let subtitle: String? = result.discount > 0
                        ? String(
                            format: String(localized: "feature.pix.discount_label", locale: locale),
                            discountFormatted)
                        : nil

                    ZodiakResultCard(
                        title: "feature.pix.final_amount",
                        value: finalValueFormatted,
                        subtitle: subtitle
                    )

                    ZodiakButtonSecondary(title: "shared.action.clear", action: viewModel.reset)
                }
            }
        }
        .accessibilityIdentifier("screen.02.pix_discount")
    }
}

#Preview {
    PixDiscountScreen()
}
