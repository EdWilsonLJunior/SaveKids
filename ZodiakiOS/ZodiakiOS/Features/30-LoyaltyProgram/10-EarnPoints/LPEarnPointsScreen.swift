import SwiftUI

// MARK: - US-30.10 Earn Points Screen
struct LPEarnPointsScreen: View {
    @Binding var path: [LPRoute]
    @StateObject private var viewModel = LPEarnPointsViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: String(localized: "lp.earn_points.short_title"),
            eyebrow: String(localized: "lp.earn_points.eyebrow"),
            intro: String(localized: "lp.earn_points.intro")
        ) {
            VStack(spacing: ZodiakSpacing.s8) {
                ForEach(viewModel.opportunities) { opportunity in
                    ZodiakCard(item: cardItem(for: opportunity))
                        .overlay(
                            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                                .stroke(ZodiakColors.actionPrimary, lineWidth: 2)
                                .opacity(viewModel.selectedOpportunity?.id == opportunity.id ? 1 : 0)
                        )
                        .animation(.easeInOut(duration: 0.15), value: viewModel.selectedOpportunity?.id)
                }
            }

            if let errorMessage = viewModel.errorMessageKey {
                ZodiakNotice(
                    title: String(localized: "lp.earn_points.error_title"),
                    message: String(localized: String.LocalizationValue(errorMessage)),
                    category: .warning
                )
            }

            if let earnedPoints = viewModel.earnedPoints {
                ZodiakResultCard(
                    title: "lp.earn_points.result_title",
                    value: "+\(earnedPoints)",
                    subtitle: String(localized: "lp.earn_points.result_subtitle")
                )
            }

            VStack(spacing: ZodiakSpacing.s16) {
                if viewModel.selectedOpportunity != nil && viewModel.earnedPoints == nil {
                    ZodiakButtonPrimary(title: "lp.earn_points.earn_action") {
                        viewModel.submit()
                    }
                }

                if viewModel.earnedPoints != nil {
                    ZodiakButtonSecondary(title: "lp.earn_points.reset_action") {
                        viewModel.reset()
                    }
                }

                ZodiakButtonSecondary(title: "lp.earn_points.back_to_home_action") {
                    path.removeAll()
                }
            }
        }
        .navigationTitle(String(localized: "lp.earn_points.short_title"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP earn points screen appeared", metadata: ["feature": "LoyaltyProgram"])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPEarnPoints")
        }
    }

    private func cardItem(for opportunity: LPEarnOpportunity) -> ZodiakCardItem {
        ZodiakCardItem(
            title: opportunity.title,
            subtitle: opportunity.subtitle,
            imageName: opportunity.imageSystemName,
            tag: "+\(opportunity.points) pts",
            onTap: {
                viewModel.selectedOpportunity = opportunity
                viewModel.errorMessageKey = nil
            }
        )
    }
}

#Preview {
    LPEarnPointsScreen(path: .constant([]))
}
