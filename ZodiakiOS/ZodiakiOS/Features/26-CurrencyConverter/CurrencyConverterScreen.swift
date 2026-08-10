import SwiftUI

// MARK: - Currency Converter Screen

struct CurrencyConverterScreen: View {
    @StateObject private var viewModel: CurrencyConverterViewModel = CurrencyConverterViewModel()

    private var currencyOptions: [(value: Currency, label: String)] {
        viewModel.availableCurrencies.map { currency in
            (value: currency, label: "\(currency.flag)  \(currency.code) — \(currency.name)")
        }
    }

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.currency_converter.title",
            eyebrow: "feature.currency_converter.eyebrow",
            intro: "feature.currency_converter.intro"
        ) {
            inputForm
            resultSection
        }
        .accessibilityIdentifier("screen.26.currency_converter")
    }

    // MARK: - Private

    private var inputForm: some View {
        ZodiakFormWrapper {
            ZodiakDropdown(
                label: "feature.currency_converter.label.from",
                selection: $viewModel.fromCurrency,
                options: currencyOptions
            )

            swapRow

            ZodiakDropdown(
                label: "feature.currency_converter.label.to",
                selection: $viewModel.toCurrency,
                options: currencyOptions
            )

            ZodiakDivider(hierarchy: .secondary)

            ZodiakLabelledNumericField(
                label: "feature.currency_converter.label.amount",
                placeholder: "feature.currency_converter.placeholder.amount",
                value: $viewModel.amount,
                minimum: 0
            )
        }
    }

    private var swapRow: some View {
        HStack {
            Spacer()
            ZodiakIconButton(
                icon: "arrow.2.squarepath",
                action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.swap()
                    }
                },
                style: .tertiary,
                accessibilityLabel: String(localized: "feature.currency_converter.button.swap")
            )
            Spacer()
        }
    }

    @ViewBuilder
    private var resultSection: some View {
        if viewModel.result != nil {
            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakResultCard(
                    title: "feature.currency_converter.result.title",
                    value: viewModel.formattedResult ?? "",
                    subtitle: nil,
                    valueColor: ZodiakColors.brand
                )

                if let rateLabel = viewModel.exchangeRateLabel {
                    ZodiakText(verbatim: rateLabel, style: .caption())
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                ZodiakButtonSecondary(title: "shared.action.clear", action: viewModel.reset)
            }
            .transition(.opacity.combined(with: .scale(scale: 0.92, anchor: .top)))
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: viewModel.result)
        }
    }
}

#Preview {
    CurrencyConverterScreen()
}
