import SwiftUI

// MARK: - US-30.06 Profile Screen
struct LPProfileScreen: View {
    @Binding var path: [LPRoute]
    @StateObject private var viewModel = LPProfileViewModel()
    @State private var toast: ZodiakToastConfig?

    var body: some View {
        ZodiakActivityTemplate(
            title: String(localized: "lp.profile.short_title"),
            eyebrow: String(localized: "lp.profile.eyebrow"),
            intro: String(localized: "lp.profile.intro")
        ) {
            HStack {
                Spacer()
                ZodiakAvatar(initials: viewModel.name.avatarInitials, size: .xl)
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.name)
                Spacer()
            }
            .padding(.bottom, ZodiakSpacing.s8)

            formSection
            saveButton
            logoutButton
        }
        .navigationBarBackButtonHidden(viewModel.hasChanges)
        .interactiveDismissDisabled(viewModel.hasChanges)
        .toolbar {
            if viewModel.hasChanges {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.requestDiscard()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(ZodiakColors.actionPrimary)
                    }
                }
            }
        }
        .zodiakModal(
            isPresented: $viewModel.showDiscardModal,
            title: String(localized: "lp.profile.discard_title"),
            showCloseButton: true
        ) {
            discardModalContent
        }
        .zodiakToast($toast)
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP profile screen appeared", metadata: ["feature": "LoyaltyProgram"])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPProfile")
        }
        .onChange(of: viewModel.state) { _, newState in
            switch newState {
            case .success:
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                toast = ZodiakToastConfig(
                    message: String(localized: "lp.profile.success"),
                    variant: .success,
                    duration: 3.0
                )

            case .nameError, .emailError:
                UINotificationFeedbackGenerator().notificationOccurred(.error)

            default:
                break
            }
        }
    }

    // MARK: - Form Section

    private var formSection: some View {
        ZodiakFormContainer {
            ZodiakLabelledField(
                label: String(localized: "lp.profile.field_name"),
                placeholder: String(localized: "lp.profile.placeholder_name"),
                text: $viewModel.name,
                errorMessage: viewModel.nameError
            )
            ZodiakLabelledField(
                label: String(localized: "lp.profile.field_email"),
                placeholder: String(localized: "lp.profile.placeholder_email"),
                text: $viewModel.email,
                keyboardType: .emailAddress,
                errorMessage: viewModel.emailError
            )
            ZodiakSwitch(
                label: String(localized: "lp.profile.toggle_email_notif"),
                isOn: $viewModel.emailNotifications
            )
            ZodiakSwitch(
                label: String(localized: "lp.profile.toggle_push_notif"),
                isOn: $viewModel.pushNotifications
            )
        }
    }

    // MARK: - Save Button

    private var saveButton: some View {
        ZodiakButtonPrimary(
            title: "lp.profile.save_action",
            action: { Task { await viewModel.save() } },
            isEnabled: !viewModel.isSaving
        )
        .frame(maxWidth: .infinity)
    }

    // MARK: - Discard Modal Content

    private var discardModalContent: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            ZodiakText("lp.profile.discard_message", style: .body())
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: ZodiakSpacing.s8) {
                ZodiakDangerButton(
                    title: "lp.profile.discard_action"
                ) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    viewModel.confirmDiscard()
                    path.removeLast()
                }
                .frame(maxWidth: .infinity)

                ZodiakButtonSecondary(
                    title: "lp.profile.keep_editing_action"
                ) {
                    viewModel.reset()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Logout Button

    private var logoutButton: some View {
        ZodiakDangerButton(title: "lp.profile.logout_action") {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            viewModel.logout()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, ZodiakSpacing.s8)
    }
}

// MARK: - String extension

private extension String {
    var avatarInitials: String {
        let parts = components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        let initials = parts.prefix(2).compactMap { $0.first.map { String($0) } }
        return initials.joined().uppercased()
    }
}
