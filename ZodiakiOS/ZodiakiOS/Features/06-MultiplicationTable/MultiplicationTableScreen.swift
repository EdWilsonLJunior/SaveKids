import SwiftUI

// MARK: - Multiplication Screen
struct MultiplicationTableScreen: View {
    @StateObject private var viewModel: MultiplicationTableViewModel = MultiplicationTableViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: "catalog.examples.multiplication.name",
            eyebrow: "feature.multiplication.eyebrow",
            intro: "feature.multiplication.intro"
        ) {
            ZodiakFormWrapper {
                ZodiakLabelledNumericField(
                    label: "shared.label.number",
                    placeholder: "shared.placeholder.enter_number",
                    value: $viewModel.number
                )
            }

            ZodiakButtonPrimary(title: "feature.multiplication.generate_action", action: viewModel.generateTable)

            if let table: [(multiplier: Int, result: Int)] = viewModel.table {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    let tableNumber: Int = Int(viewModel.number ?? 0)
                    ZodiakText("feature.multiplication.table_title \(tableNumber)", style: .title2)

                    ForEach(table, id: \.multiplier) { item in
                        let operation: String = "\(tableNumber) × \(item.multiplier)"
                        let value: String = "= \(item.result)"

                        ZodiakInfoRow(
                            label: operation,
                            value: value
                        )
                    }
                }

                ZodiakButtonSecondary(title: "shared.action.clear", action: viewModel.reset)
            }

            if let error: LocalizedStringKey = viewModel.errorMessage {
                ZodiakAlert(title: error, variant: .error)
            }
        }
        .accessibilityIdentifier("screen.06.multiplication_table")
    }
}

#Preview {
    MultiplicationTableScreen()
}
