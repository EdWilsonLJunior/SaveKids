import SwiftUI

// MARK: - Checkbox Gallery View

struct CheckboxGalleryView: View {
    @State private var checked1 = true
    @State private var checked2 = false
    @State private var checked3 = false
    @State private var groupSelections: Set<String> = ["catalog.checkbox.option.email"]

    private let options = [
        "catalog.checkbox.option.email",
        "catalog.checkbox.option.push",
        "catalog.checkbox.option.weekly",
        "catalog.checkbox.option.security"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.checkbox",
                subtitle: "catalog.checkbox.subtitle",
                figmaRef: "Checkbox"
            )
            statesSection
            sizesSection
            playgroundSection
            groupSection
            specsSection
        }
        .zodiakPage(title: "catalog.component_name.checkbox")
    }
}

// MARK: - Sections

private extension CheckboxGalleryView {
    var statesSection: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            ZodiakCheckbox(label: "catalog.checkbox.label.checked", isChecked: .constant(true))
            ZodiakCheckbox(label: "catalog.checkbox.label.unchecked", isChecked: .constant(false))
            ZodiakCheckbox(
                label: "catalog.checkbox.label.indeterminate",
                isChecked: .constant(false),
                isIndeterminate: true
            )
            ZodiakCheckbox(label: "catalog.checkbox.label.error", isChecked: .constant(false), isError: true)
            ZodiakCheckbox(
                label: "catalog.checkbox.label.disabled_checked",
                isChecked: .constant(true),
                isEnabled: false
            )
            ZodiakCheckbox(
                label: "catalog.checkbox.label.disabled_unchecked",
                isChecked: .constant(false),
                isEnabled: false
            )
        }
    }

    var sizesSection: some View {
        gallerySectionCard(title: "catalog.section.tamanhos") {
            ZodiakInfoRow("catalog.spec.lbl.l", value: "24×24pt", style: .spec())
            ZodiakCheckbox(
                label: "catalog.checkbox.label.large_desc",
                isChecked: .constant(true),
                size: .large
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.s", value: "18×18pt", style: .spec())
            ZodiakCheckbox(
                label: "catalog.checkbox.label.small_desc",
                isChecked: .constant(true),
                size: .small
            )
        }
    }

    var playgroundSection: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakCheckbox(label: "catalog.checkbox.option.email", isChecked: $checked1)
            ZodiakCheckbox(label: "catalog.checkbox.option.push", isChecked: $checked2)
            ZodiakCheckbox(label: "catalog.checkbox.option.weekly", isChecked: $checked3)
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.selected",
                value: "\([checked1, checked2, checked3].filter { $0 }.count)/3",
                style: .spec()
            )
        }
    }

    var groupSection: some View {
        gallerySectionCard(title: "catalog.section.grupo") {
            ZodiakCheckboxGroup(
                headline: "catalog.checkbox.group.headline",
                selections: $groupSelections,
                options: options
            )
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                "catalog.spec.lbl.selected",
                value: "\(groupSelections.count)/\(options.count)",
                style: .spec()
            )
        }
    }

    var specsSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow("catalog.spec.lbl.l", value: "24×24pt", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.s", value: "18×18pt", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.radius", value: "ZodiakRadii.xs (4pt)", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.fill_ativo", value: "actionPrimary", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.icon", value: "checkmark / minus (bold, 60% box)", style: .spec())
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow("catalog.spec.lbl.group_spacing", value: "ZodiakSpacing.s16 (16pt)", style: .spec())
        }
    }
}

#Preview { NavigationStack { CheckboxGalleryView() } }
