import SwiftUI

// MARK: - Navigation Route
enum LPRoute: Hashable {
    case redeem
    case earnPoints
    case catalog
    case rewardDetail(LPReward)
    case sendPoints
    case statement
    case profile
    case promoDetail(LPPromotion)
}

// MARK: - Root
struct LPRootView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(LPConstants.Storage.isAuthenticated) private var isAuthenticated: Bool = false
    @State private var path: [LPRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            if isAuthenticated {
                lpHomeDestination()
                    .navigationDestination(for: LPRoute.self) { route in
                        lpDestination(for: route)
                    }
                    .toolbar { closeToolbarItem }
            } else {
                lpLoginDestination()
                    .toolbar { closeToolbarItem }
            }
        }
        .onAppear {
            ZodiakLog.info(.navigation, "LP feature opened", metadata: ["source": "catalog"])
        }
    }

    // MARK: - Close Button

    @ToolbarContentBuilder
    private var closeToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
            }
            .accessibilityLabel(String(localized: "shared.action.close"))
        }
    }

    // MARK: - Destinations (replaced by US branches)

    @ViewBuilder
    private func lpLoginDestination() -> some View {
        LPLoginScreen()
    }

    @ViewBuilder
    private func lpHomeDestination() -> some View {
        LPHomeScreen(path: $path)
    }

    @ViewBuilder
    private func lpDestination(for route: LPRoute) -> some View {
        switch route {
        case .redeem:
            LPRedeemScreen(path: $path)

        case .earnPoints:
            LPEarnPointsScreen(path: $path)

        case .catalog:
            LPCatalogScreen(path: $path)

        case .rewardDetail(let reward):
            LPRewardDetailScreen(reward: reward, path: $path)

        case .sendPoints:
            LPSendPointsScreen(path: $path)

        case .statement:
            LPStatementScreen()

        case .profile:
            LPProfileScreen(path: $path)

        case .promoDetail(let promotion):
            LPPromoDetailScreen(promotion: promotion, path: $path)
        }
    }
}
