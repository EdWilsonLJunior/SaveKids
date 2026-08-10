import SwiftUI

// MARK: - Form Container Gallery View

struct FormContainerGalleryView: View {
    @State private var name = ""
    @State private var age: Double?

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.section.form_containers",
                subtitle: "catalog.form_container.subtitle",
                figmaRef: nil
            )
            formWrapperSection
            formContainerSection
            comparisonSection
        }
        .zodiakPage(title: "catalog.section.form_containers")
    }

    private var formWrapperSection: some View {
        gallerySectionCard(title: "catalog.section.zodiakformwrapper") {
            ZodiakText(
                "catalog.form_container.wrapper_desc",
                style: .body(color: .secondary)
            )
                .fixedSize(horizontal: false, vertical: true)
            ZodiakFormWrapper {
                ZodiakLabelledField(
                    label: "shared.label.name",
                    placeholder: "shared.placeholder.enter_name",
                    text: $name
                )
                ZodiakLabelledNumericField(
                    label: "shared.label.age",
                    placeholder: "shared.placeholder.ex_age",
                    value: $age,
                    minimum: 0,
                    maximum: 120
                )
                ZodiakSwitch(label: "shared.label.accept_terms", isOn: .constant(false))
            }
        }
    }

    private var formContainerSection: some View {
        gallerySectionCard(title: "catalog.section.zodiakformcontainer") {
            ZodiakText(
                "catalog.form_container.adaptive_desc",
                style: .body(color: .secondary)
            )
                .fixedSize(horizontal: false, vertical: true)
            ZodiakFormContainer {
                ZodiakLabelledField(
                    label: "Email",
                    placeholder: "shared.placeholder.email",
                    text: .constant("")
                )
                ZodiakLabelledField(
                    label: "Senha",
                    placeholder: "••••••••",
                    text: .constant("")
                )
                ZodiakButtonPrimary(title: "shared.action.login", action: {})
            }
        }
    }

    private var comparisonSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            VStack(spacing: ZodiakSpacing.s4) {
                ZodiakInfoRow(label: "FormWrapper spacing", value: "twoXSmall (8pt)")
                ZodiakInfoRow(label: "FormWrapper padding", value: "xs (16pt)")
                ZodiakInfoRow(label: "FormContainer (iPhone)", value: "xs (16pt)")
                ZodiakInfoRow(label: "FormContainer (iPad)", value: "m (32pt)")
                ZodiakInfoRow(label: "Background", value: "surface")
                ZodiakInfoRow(label: "Corner Radius", value: "s (16pt)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        FormContainerGalleryView()
    }
}
