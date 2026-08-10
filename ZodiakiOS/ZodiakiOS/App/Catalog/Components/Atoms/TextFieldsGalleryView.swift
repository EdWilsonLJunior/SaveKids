import SwiftUI

// MARK: - TextFields Gallery View

struct TextFieldsGalleryView: View {
    @State private var text1 = ""
    @State private var text2 = ""
    @State private var text3 = ""
    @State private var text4 = ""
    @State private var numericValue: Double?
    @State private var selectedState: HelperState = .none

    enum HelperState: String, CaseIterable {
        case none         = "Nenhum"
        case informational = "catalog.spec.label_info"
        case warning      = "Warning"
        case error        = "catalog.spec.label_error"
        case success      = "catalog.spec.label_success"
    }

    private func helperType(for state: HelperState) -> ZodiakTextFieldHelperType {
        switch state {
        case .none:          return .informational
        case .informational: return .informational
        case .warning:       return .warning
        case .error:         return .error
        case .success:       return .success
        }
    }

    private func helperMessage(for state: HelperState) -> LocalizedStringKey? {
        switch state {
        case .none:          return nil
        case .informational: return "shared.validation.enter_valid_value"
        case .warning:       return "shared.validation.attention_check_value"
        case .error:         return "shared.validation.required_or_invalid"
        case .success:       return "shared.validation.value_accepted"
        }
    }

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.text_fields",
                subtitle: "catalog.text_fields.subtitle",
                figmaRef: nil
            )
            playgroundSection
            textFieldSection
            numericSection
            helperStatesSection
            disabledSection
        }
        .zodiakPage(title: "catalog.component_name.text_fields")
    }

    private var playgroundSection: some View {
        gallerySectionCard(title: "catalog.section.playground_helper_state") {
            ZodiakFormWrapper {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakText("catalog.text_field.select_helper_state", style: .title3)
                    HStack(spacing: ZodiakSpacing.s8) {
                        ForEach(HelperState.allCases, id: \.self) { state in
                            Button {
                                selectedState = state
                            } label: {
                                Text(state.rawValue)
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(selectedState == state ? .white : ZodiakColors.textSecondary)
                                    .padding(.horizontal, ZodiakSpacing.s8)
                                    .padding(.vertical, ZodiakSpacing.s4)
                                    // swiftlint:disable:next line_length
                                    .background(selectedState == state ? ZodiakColors.actionPrimary : ZodiakColors.background)
                                    .cornerRadius(ZodiakRadii.l)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    ZodiakTextField(
                        label: "Campo de texto",
                        placeholder: "shared.placeholder.type_here",
                        text: $text1,
                        helperText: helperMessage(for: selectedState),
                        helperType: helperType(for: selectedState)
                    )
                }
            }
        }
    }

    private var textFieldSection: some View {
        gallerySectionCard(title: "catalog.section.zodiaktextfield") {
            ZodiakFormWrapper {
                ZodiakTextField(
                    label: "Nome completo",
                    placeholder: "shared.placeholder.ex_name",
                    text: $text2,
                    isRequired: true
                )
            }
        }
    }

    private var numericSection: some View {
        gallerySectionCard(title: "catalog.section.zodiaknumericfield") {
            ZodiakFormWrapper {
                ZodiakNumericField(
                    label: "Nota (0 – 10)",
                    placeholder: "shared.placeholder.ex_decimal",
                    value: $numericValue,
                    minimum: 0,
                    maximum: 10,
                    isRequired: true
                )
            }
        }
    }

    private var helperStatesSection: some View {
        gallerySectionCard(title: "catalog.section.todos_os_helper_states") {
            ZodiakFormWrapper {
                ZodiakTextField(
                    label: "Informational",
                    placeholder: "catalog.text_field.helper_text",
                    text: $text3,
                    helperText: "catalog.spec.helper_guidance",
                    helperType: .informational
                )
                ZodiakTextField(
                    label: "catalog.spec.label_warning",
                    placeholder: "catalog.text_field.warning_state",
                    text: .constant("valor incorreto"),
                    helperText: "shared.validation.check_format",
                    helperType: .warning
                )
                ZodiakTextField(
                    label: "catalog.spec.label_error",
                    placeholder: "catalog.text_field.required_state",
                    text: .constant(""),
                    helperText: "shared.validation.this_field_required",
                    helperType: .error
                )
                ZodiakTextField(
                    label: "catalog.spec.label_success",
                    placeholder: "catalog.text_field.valid_state",
                    text: .constant("shared.placeholder.email"),
                    helperText: "shared.validation.email_valid",
                    helperType: .success
                )
            }
        }
    }

    private var disabledSection: some View {
        gallerySectionCard(title: "catalog.section.estado_desabilitado") {
            ZodiakFormWrapper {
                ZodiakTextField(
                    label: "Campo desabilitado",
                    placeholder: "catalog.text_field.readonly_state",
                    text: .constant("Valor somente leitura"),
                    isDisabled: true
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        TextFieldsGalleryView()
    }
}
