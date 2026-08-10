import SwiftUI

// MARK: - Zodiak Form In Drawer
// Figma: "Form in drawer" — form inside a slide-out drawer panel.
// Slides in from the trailing edge. Dimmed overlay behind.
// States: idle → submitting → success / error

public enum ZodiakFormDrawerState: Equatable {
    case idle
    case submitting
    case success
    case error(String)
}

public struct ZodiakFormInDrawer<Content: View>: View {
    let title: String
    var introText: String?
    var imageSystemName: String?
    let submitLabel: String
    @Binding var isPresented: Bool
    @Binding var state: ZodiakFormDrawerState
    /// When true, a mandatory compliance checkbox is shown before the submit button.
    var requiresCompliance: Bool = true
    let onSubmit: () -> Void
    @ViewBuilder let content: () -> Content

    @State private var complianceChecked = false

    public var body: some View {
        ZStack(alignment: .trailing) {
            if isPresented {
                // Dimmed overlay
                Color.black.opacity(ZodiakOpacity.overlay)
                    .ignoresSafeArea()
                    .onTapGesture { dismiss() }
                    .transition(.opacity)
                    .zIndex(0)

                drawerPanel
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }
        }
        .animation(.spring(response: 0.38, dampingFraction: 0.88), value: isPresented)
    }

    @ViewBuilder
    private var drawerPanel: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
                // Header row
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        if let img = imageSystemName {
                            Image(systemName: img)
                                .font(.system(size: 36, weight: .light))
                                .foregroundColor(ZodiakColors.actionPrimary)
                        }
                        Text(LocalizedStringKey(title))
                            .font(ZodiakTypography.titleMedium)
                            .foregroundColor(ZodiakColors.textPrimary)
                        if let intro = introText {
                            Text(LocalizedStringKey(intro))
                                .font(ZodiakTypography.bodyMedium)
                                .foregroundColor(ZodiakColors.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    Spacer()
                    ZodiakIconButton(
                        icon: "xmark",
                        action: dismiss,
                        style: .tertiary,
                        accessibilityLabel: "Fechar formulário"
                    )
                }

                ZodiakDivider(hierarchy: .secondary)

                // Form body
                if state == .success {
                    successView
                } else {
                    formBody
                }
            }
            .padding(ZodiakSpacing.s16)
        }
        .background(ZodiakColors.surface)
        .frame(maxWidth: 480)
        .frame(maxHeight: .infinity, alignment: .top)
        .shadow(color: .black.opacity(0.15), radius: 24, x: -4, y: 0)
    }

    @ViewBuilder
    private var formBody: some View {
        // Mandatory fields indicator
        Text("shared.validation.required_fields_notice")
            .font(ZodiakTypography.captionLarge)
            .foregroundColor(ZodiakColors.textSecondary)

        content()

        if requiresCompliance {
            ZodiakCheckbox(
                label: "Concordo com o uso dos meus dados conforme a política de privacidade. *",
                isChecked: $complianceChecked
            )
        }

        if case .error(let msg) = state {
            ZodiakAlert(
                title: "shared.state.send_error",
                message: LocalizedStringKey(msg),
                variant: .error
            )
        }

        ZodiakButtonPrimary(
            title: state == .submitting
                ? "shared.state.sending"
                : LocalizedStringKey(submitLabel),
            action: onSubmit,
            isEnabled: state != .submitting && (!requiresCompliance || complianceChecked)
        )
    }

    private var successView: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(ZodiakColors.textPositive)
            Text("shared.state.sent_success")
                .font(ZodiakTypography.titleSmall)
                .foregroundColor(ZodiakColors.textPrimary)
            Text("shared.state.contact_soon")
                .font(ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textSecondary)
                .multilineTextAlignment(.center)
            ZodiakButtonSecondary(title: "shared.action.close", action: dismiss)
        }
        .frame(maxWidth: .infinity)
        .padding(ZodiakSpacing.s32)
    }

    private func dismiss() {
        withAnimation(.spring(response: 0.38, dampingFraction: 0.88)) {
            isPresented = false
        }
    }
}

// MARK: - Preview

#Preview("Form In Drawer") {
    @Previewable @State var isPresented = false
    @Previewable @State var drawerState = ZodiakFormDrawerState.idle
    @Previewable @State var name = ""
    @Previewable @State var email = ""

    ZStack {
        VStack(spacing: ZodiakSpacing.s8) {
            ZodiakButtonPrimary(title: "shared.action.schedule_meeting", action: {
                drawerState = .idle
                isPresented = true
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ZodiakColors.background)

        ZodiakFormInDrawer(
            title: "shared.action.schedule_meeting",
            introText: "Preencha seus dados e entraremos em contato em até 2 dias úteis.",
            imageSystemName: "calendar",
            submitLabel: "Agendar",
            isPresented: $isPresented,
            state: $drawerState,
            onSubmit: {
                drawerState = .submitting
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    drawerState = .success
                }
            },
            content: {
                ZodiakTextField(
                    label: "Nome completo",
                    placeholder: "Seu nome",
                    text: $name,
                    isRequired: true
                )
                ZodiakTextField(
                    label: "E-mail corporativo",
                    placeholder: "nome@empresa.com",
                    text: $email,
                    keyboardType: .emailAddress,
                    isRequired: true
                )
            }
        )
    }
    .ignoresSafeArea()
}
