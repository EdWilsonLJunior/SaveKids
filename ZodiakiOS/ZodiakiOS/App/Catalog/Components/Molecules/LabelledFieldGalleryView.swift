import SwiftUI

// MARK: - Labelled Field Gallery View

struct LabelledFieldGalleryView: View {
    @State private var selectedTab = 0
    @State private var textValue = ""
    @State private var numValue: Double?
    @State private var isChecked = false

    private let tabs = ["catalog.tab.demo", "catalog.tab.variants", "catalog.tab.specs"]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.labelled_fields",
                subtitle: "catalog.labelled_field.subtitle",
                figmaRef: nil
            )
            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
            switch selectedTab {
            case 1:  variantsTab
            case 2:  specsTab
            default: demoTab
            }
        }
        .zodiakPage(title: "catalog.component.labelled_fields")
    }
}

// MARK: - Demo Tab

private extension LabelledFieldGalleryView {
    @ViewBuilder
    var demoTab: some View {
        gallerySectionCard(title: "catalog.section.playground_validacao") {
            ZodiakText("catalog.labelled_field.text_field_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)

            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "catalog.labelled_field.label_validation",
                    placeholder: "shared.placeholder.min_chars",
                    text: $textValue,
                    errorMessage: textValue.count < 3 && !textValue.isEmpty
                        ? "shared.validation.min_3_chars"
                        : nil
                )
            }

            if !textValue.isEmpty {
                ZodiakText(
                    verbatim: String(
                        format: NSLocalizedString("catalog.labelled_field.char_count", comment: ""),
                        textValue.count
                    ),
                    style: .caption(color: .secondary)
                )
            }
        }
    }
}

// MARK: - Variants Tab

private extension LabelledFieldGalleryView {
    @ViewBuilder
    var variantsTab: some View {
        gallerySectionCard(title: "catalog.section.labelledfield") {
            ZodiakText("catalog.labelled_field.text_field_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "catalog.labelled_field.label_name",
                    placeholder: "shared.placeholder.ex_name",
                    text: $textValue
                )
                ZodiakLabelledField(
                    label: "catalog.labelled_field.label_email",
                    placeholder: "shared.placeholder.email",
                    text: .constant(""),
                    isRequired: true,
                    errorMessage: "shared.validation.required"
                )
            }
        }

        gallerySectionCard(title: "catalog.section.labellednumericfield") {
            ZodiakText("catalog.labelled_field.numeric_field_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakFormWrapper {
                ZodiakLabelledNumericField(
                    label: "catalog.labelled_field.label_score",
                    placeholder: "shared.placeholder.ex_decimal",
                    value: $numValue,
                    minimum: 0,
                    maximum: 10,
                    isRequired: true
                )
                ZodiakLabelledNumericField(
                    label: "shared.label.age",
                    placeholder: "shared.placeholder.ex_age",
                    value: .constant(nil),
                    minimum: 0,
                    maximum: 120,
                    errorMessage: "shared.validation.value_out_of_range"
                )
            }
        }

        gallerySectionCard(title: "catalog.section.labelledcheckbox") {
            ZodiakText("catalog.labelled_field.checkbox_desc", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
            ZodiakFormWrapper {
                ZodiakLabelledCheckbox(
                    label: "shared.label.accept_terms",
                    isChecked: $isChecked
                )
                ZodiakLabelledCheckbox(
                    label: "feature.pix.pay_with_pix_toggle",
                    isChecked: .constant(true)
                )
                ZodiakLabelledCheckbox(
                    label: "shared.label.receive_notifications",
                    isChecked: .constant(false)
                )
            }
        }
    }
}

// MARK: - Specs Tab

private extension LabelledFieldGalleryView {
    @ViewBuilder
    var specsTab: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow(
                "catalog.spec.lbl.componente",
                value: "catalog.labelled_field.spec_val_components",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.parametros",
                value: "catalog.labelled_field.spec_val_params_text",
                style: .spec()
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.errormessage",
                value: "catalog.labelled_field.spec_val_error",
                style: .spec()
            )
        }
    }
}

#Preview {
    NavigationStack {
        LabelledFieldGalleryView()
    }
}
