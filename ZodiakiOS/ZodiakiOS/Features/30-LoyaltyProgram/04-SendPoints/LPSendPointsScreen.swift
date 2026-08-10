import SwiftUI

// MARK: - US-30.04 Send Points Screen
struct LPSendPointsScreen: View {
    @Binding var path: [LPRoute]
    @StateObject private var viewModel = LPSendPointsViewModel()

    var body: some View {
        ZodiakInputWizard(
            title: "lp.send.title",
            steps: wizardSteps,
            onComplete: {
                viewModel.commitTransfer()
                path.removeLast()
            },
            onCancel: viewModel.requestCancel,
            submitLabel: "lp.send.confirm_action"
        )
        .navigationBarHidden(true)
        .onChange(of: viewModel.state) { _, newState in
            switch newState {
            case .cpfError, .selfCPFError, .pointsError, .minimumError, .multipleError:
                UINotificationFeedbackGenerator().notificationOccurred(.error)

            default:
                break
            }
        }
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP send points screen appeared", metadata: ["feature": "LoyaltyProgram"])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPSendPoints")
        }
        .zodiakModal(
            isPresented: $viewModel.showCancelModal,
            title: String(localized: "lp.send.cancel_modal_title"),
            showCloseButton: true
        ) {
            cancelModalContent()
        }
    }

    // MARK: - Wizard Steps

    private var wizardSteps: [ZodiakWizardStep] {
        [
            ZodiakWizardStep(
                title: "lp.send.step1_label",
                canProceed: viewModel.isStep0Valid
            ) {
                step0CPFView()
            },
            ZodiakWizardStep(
                title: "lp.send.step2_label",
                canProceed: viewModel.isStep1Valid
            ) {
                step1AmountView()
            },
            ZodiakWizardStep(
                title: "lp.send.step3_label",
                canProceed: true
            ) {
                step2ReviewView()
            }
        ]
    }

    // MARK: - Step 0: Recipient CPF

    @ViewBuilder
    private func step0CPFView() -> some View {
        ZodiakFormWrapper {
            ZodiakLabelledField(
                label: String(localized: "lp.send.field_cpf"),
                placeholder: "00000000000",
                text: $viewModel.recipientCPF,
                keyboardType: .numberPad,
                isRequired: true,
                errorMessage: cpfErrorMessage
            )
        }

        if viewModel.state == .cpfError || viewModel.state == .selfCPFError {
            errorNotice(for: viewModel.state)
        }
    }

    // MARK: - Step 1: Amount

    @ViewBuilder
    private func step1AmountView() -> some View {
        ZodiakKeyFigures(
            items: [
                ZodiakKeyFigureItem(
                    value: viewModel.formattedPoints,
                    label: "lp.send.balance_label"
                )
            ],
            columns: 1
        )

        ZodiakFormWrapper {
            ZodiakCounterControl(
                value: $viewModel.amount,
                min: LPConstants.Validation.minTransferPoints,
                max: viewModel.points,
                step: LPConstants.Validation.transferPointsMultiple,
                label: "lp.send.counter_label"
            )

            ZodiakInfoRow(
                label: String(localized: "lp.send.balance_label"),
                value: viewModel.formattedPoints
            )

            // Saldo restante após transferência — atualiza em real-time
            ZodiakInfoRow(
                label: String(localized: "lp.send.remaining_balance"),
                value: viewModel.formattedRemainingBalance
            )
        }

        if viewModel.state == .pointsError
            || viewModel.state == .minimumError
            || viewModel.state == .multipleError {
            errorNotice(for: viewModel.state)
        }
    }

    // MARK: - Step 2: Review & Confirm

    @ViewBuilder
    private func step2ReviewView() -> some View {
        ZodiakFormWrapper {
            ZodiakInfoRow(
                label: String(localized: "lp.send.recipient_label"),
                value: viewModel.maskedRecipient,
                style: .data
            )
            ZodiakInfoRow(
                label: String(localized: "lp.send.amount_label"),
                value: "\(viewModel.amount) pts",
                style: .data
            )
            ZodiakInfoRow(
                label: String(localized: "lp.send.remaining_balance"),
                value: viewModel.formattedRemainingBalance,
                style: .data
            )
        }
    }

    // MARK: - Cancel Modal

    @ViewBuilder
    private func cancelModalContent() -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            ZodiakText("lp.send.cancel_modal_message", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)

            ZodiakButtonPrimary(
                title: "lp.send.cancel_confirm_action",
                action: {
                    viewModel.confirmCancel()
                    path.removeLast()
                }
            )
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Error Helpers

    private var cpfErrorMessage: LocalizedStringKey? {
        switch viewModel.state {
        case .cpfError: return "lp.send.error_cpf_invalid"
        case .selfCPFError: return "lp.send.error_cpf_self"
        default: return nil
        }
    }

    @ViewBuilder
    private func errorNotice(for state: LPSendState) -> some View {
        switch state {
        case .cpfError:
            ZodiakNotice(
                title: String(localized: "lp.send.error_cpf_invalid"),
                category: .warning
            )

        case .selfCPFError:
            ZodiakNotice(
                title: String(localized: "lp.send.error_cpf_self"),
                category: .warning
            )

        case .pointsError:
            ZodiakNotice(
                title: String(localized: "lp.send.error_balance"),
                category: .warning
            )

        case .minimumError:
            ZodiakNotice(
                title: String(localized: "lp.send.error_minimum"),
                category: .warning
            )

        case .multipleError:
            ZodiakNotice(
                title: String(localized: "lp.send.error_multiple"),
                category: .warning
            )

        default:
            EmptyView()
        }
    }
}
