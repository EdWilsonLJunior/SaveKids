import SwiftUI

// MARK: - Temperature Converter Screen
struct TemperatureConverterScreen: View {
    @StateObject private var viewModel: TemperatureConverterViewModel = TemperatureConverterViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: "catalog.examples.temperature.name",
            eyebrow: "feature.temperature.eyebrow",
            intro: "feature.temperature.intro"
        ) {
            ZodiakFormWrapper {
                ZodiakLabelledNumericField(
                    label: "Celsius (\(TemperatureConverterConstants.celsiusSymbol))",
                    placeholder: "feature.temperature.placeholder",
                    value: Binding(
                        get: { viewModel.celsius },
                        set: { newValue in viewModel.updateCelsius(newValue) }
                    )
                )

                HStack {
                    Spacer()
                    Image(systemName: "arrow.left.arrow.right")
                        .font(ZodiakTypography.titleSmall)
                        .foregroundColor(ZodiakColors.actionPrimary)
                    Spacer()
                }
                .padding(ZodiakSpacing.s8)

                ZodiakLabelledNumericField(
                    label: "Fahrenheit (\(TemperatureConverterConstants.fahrenheitSymbol))",
                    placeholder: "feature.temperature.placeholder",
                    value: Binding(
                        get: { viewModel.fahrenheit },
                        set: { newValue in viewModel.updateFahrenheit(newValue) }
                    )
                )
            }

            if let c: Double = viewModel.celsius, let f: Double = viewModel.fahrenheit {
                // swiftlint:disable:next line_length
                let conversionText: String = "\(String(format: "%.1f", c))\(TemperatureConverterConstants.celsiusSymbol) = \(String(format: "%.1f", f))\(TemperatureConverterConstants.fahrenheitSymbol)"

                ZodiakResultCard(
                    title: "feature.temperature.conversion_section",
                    value: conversionText,
                    subtitle: "feature.temperature.realtime_desc"
                )
            }

            ZodiakButtonSecondary(title: "shared.action.clear", action: viewModel.reset)
        }
        .accessibilityIdentifier("screen.09.temperature_converter")
    }
}

#Preview {
    TemperatureConverterScreen()
}
