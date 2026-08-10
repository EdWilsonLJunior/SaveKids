import SwiftUI

// MARK: - Counter Gallery View

struct CounterGalleryView: View {
    @State private var selectedTab = 0
    @State private var value = 5
    @State private var minValue = 0
    @State private var maxValue = 10
    @State private var stepValue = 1

    private let tabs = ["catalog.tab.demo", "catalog.tab.specs"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.counter",
                subtitle: "catalog.counter.subtitle",
                figmaRef: nil
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component.counter")
    }
}

// MARK: - Demo Tab

private extension CounterGalleryView {
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakCounterControl(
                value: $value,
                min: minValue,
                max: maxValue,
                step: stepValue
            )
            ZodiakFormWrapper {
                ZodiakInfoRow("catalog.counter.lbl.current_value", value: LocalizedStringKey("\(value)"))
                ZodiakInfoRow("catalog.counter.lbl.min", value: LocalizedStringKey("\(minValue)"))
                ZodiakInfoRow("catalog.counter.lbl.max", value: LocalizedStringKey("\(maxValue)"))
                ZodiakInfoRow("catalog.counter.lbl.step", value: LocalizedStringKey("\(stepValue)"))
            }
        }

        gallerySectionCard(title: "catalog.section.configuracao") {
            ZodiakFormWrapper {
                sliderRow(
                    label: "catalog.counter.lbl.min",
                    currentValue: minValue,
                    range: -10...0,
                    binding: Binding(
                        get: { Double(minValue) },
                        set: { minValue = Int($0); if value < minValue { value = minValue } }
                    )
                )
                sliderRow(
                    label: "catalog.counter.lbl.max",
                    currentValue: maxValue,
                    range: 5...20,
                    binding: Binding(
                        get: { Double(maxValue) },
                        set: { maxValue = Int($0); if value > maxValue { value = maxValue } }
                    )
                )
                sliderRow(
                    label: "catalog.counter.lbl.step",
                    currentValue: stepValue,
                    range: 1...5,
                    binding: Binding(
                        get: { Double(stepValue) },
                        set: { stepValue = Int($0) }
                    )
                )
            }
        }

        gallerySectionCard(title: "catalog.section.uso_nos_exemplos") {
            ZodiakText("catalog.counter.usage_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    func sliderRow(
        label: LocalizedStringKey,
        currentValue: Int,
        range: ClosedRange<Double>,
        binding: Binding<Double>
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            ZodiakInfoRow(label, value: LocalizedStringKey("\(currentValue)"))
            Slider(value: binding, in: range, step: 1)
                .tint(ZodiakColors.actionPrimary)
        }
    }
}

// MARK: - Specs Tab

private extension CounterGalleryView {
    @ViewBuilder
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.componente",
                value: "catalog.counter.spec_val_component",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.parametros",
                value: "catalog.counter.spec_val_params",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.zodiak_ds",
                value: "catalog.counter.spec_val_ds",
                style: .spec()
            )
        }
    }
}

#Preview {
    NavigationStack {
        CounterGalleryView()
    }
}
