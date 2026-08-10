import SwiftUI

// MARK: - US-30.09 Reward Detail Screen
struct LPRewardDetailScreen: View {
    let reward: LPReward
    @Binding var path: [LPRoute]
    @StateObject private var viewModel: LPRewardDetailViewModel

    init(reward: LPReward, path: Binding<[LPRoute]>) {
        self.reward = reward
        self._path = path
        self._viewModel = StateObject(wrappedValue: LPRewardDetailViewModel(reward: reward))
    }

    var body: some View {
        ZodiakActivityTemplate(
            title: reward.name,
            eyebrow: String(localized: "lp.reward_detail.eyebrow"),
            intro: String(localized: "lp.reward_detail.intro")
        ) {
            ZodiakCardGrid(
                items: [
                    ZodiakCardItem(
                        title: reward.name,
                        subtitle: reward.category.localizedName,
                        description: reward.description,
                        imageURL: reward.deterministicImageURL,
                        imageName: reward.imageSystemName,
                        tag: "\(viewModel.formattedCost) pts"
                    )
                ],
                columns: 1,
                initialCount: 1
            )

            ZodiakFormWrapper {
                ZodiakInfoRow(
                    label: "lp.reward_detail.current_balance_label",
                    value: "\(viewModel.formattedPoints) pts",
                    style: .data
                )
                ZodiakInfoRow(
                    label: "lp.reward_detail.reward_cost_label",
                    value: "\(viewModel.formattedCost) pts",
                    style: .data
                )
            }

            statusSection
            actionsSection
        }
        .navigationTitle(reward.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP reward detail screen appeared reward_id=\(reward.id)",
                             metadata: ["feature": "LoyaltyProgram", "reward_id": reward.id])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPRewardDetail")
        }
        .onChange(of: viewModel.showSuccessModal) { _, newValue in
            if newValue { UINotificationFeedbackGenerator().notificationOccurred(.success) }
        }
        .zodiakModal(
            isPresented: $viewModel.showSuccessModal,
            title: String(localized: "lp.redeem.success_title"),
            showCloseButton: true
        ) {
            successModalContent
        }
    }

    @ViewBuilder
    private var statusSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            if viewModel.isAffordable {
                ZodiakChip(text: "lp.reward_detail.affordable_tag", isActive: true)
                ZodiakNotice(
                    title: String(localized: "lp.reward_detail.affordable_title"),
                    message: String(localized: "lp.reward_detail.affordable_message"),
                    category: .success
                )
            } else {
                ZodiakChip(text: "lp.reward_detail.insufficient_tag", isActive: false)
                ZodiakNotice(
                    title: String(localized: "lp.reward_detail.insufficient_title"),
                    message: String(
                        format: String(localized: "lp.reward_detail.insufficient_message"),
                        viewModel.missingPoints
                    ),
                    category: .warning
                )
            }
        }
    }

    @ViewBuilder
    private var actionsSection: some View {
        VStack(spacing: ZodiakSpacing.s16) {
            if viewModel.isAffordable {
                ZodiakFormWrapper {
                    ZodiakInfoRow(
                        label: String(localized: "lp.redeem.confirm_reward"),
                        value: reward.name,
                        style: .data
                    )
                    ZodiakInfoRow(
                        label: String(localized: "lp.redeem.confirm_cost"),
                        value: "-\(viewModel.formattedCost) pts",
                        style: .data
                    )
                    ZodiakInfoRow(
                        label: String(localized: "lp.redeem.confirm_balance_after"),
                        value: "\(viewModel.remainingAfterRedeem) pts",
                        style: .data
                    )
                }

                ZodiakSlideToSubmit(
                    label: String(localized: "lp.redeem.slide_label"),
                    onSubmit: viewModel.redeem
                )
            } else {
                ZodiakButtonPrimary(title: "lp.reward_detail.earn_points_action") {
                    path.append(.earnPoints)
                }
            }

            ZodiakButtonSecondary(title: "shared.action.back") {
                path.removeLast()
            }
        }
    }

    @ViewBuilder
    private var successModalContent: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            ZodiakResultCard(
                title: "lp.redeem.success_card_title",
                value: reward.name,
                subtitle: String(
                    format: String(localized: "lp.redeem.success_card_subtitle"),
                    viewModel.formattedPoints
                )
            )
            ZodiakButtonPrimary(title: "shared.action.back") {
                path.removeLast()
            }
        }
    }
}

#Preview {
    LPRewardDetailScreen(
        reward: LPReward(
            id: "preview",
            name: "Fone Bluetooth",
            description: "Áudio estéreo com bateria de longa duração.",
            imageSystemName: "headphones",
            pointsCost: 1800,
            category: .products,
            type: .product
        ),
        path: .constant([])
    )
}
