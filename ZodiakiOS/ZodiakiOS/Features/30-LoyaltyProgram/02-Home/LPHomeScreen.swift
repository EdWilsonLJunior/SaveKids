import SwiftUI

// MARK: - US-30.02 Home Screen
struct LPHomeScreen: View {
    @Binding var path: [LPRoute]
    @StateObject private var viewModel = LPHomeViewModel()

    var body: some View {
        ZodiakActivityTemplate(
            title: String(localized: "lp.home.title"),
            eyebrow: String(localized: "lp.home.eyebrow")
        ) {
            // MARK: Saldo de pontos
            ZodiakKeyFigures(items: [
                ZodiakKeyFigureItem(
                    value: viewModel.formattedPoints,
                    label: String(localized: "lp.home.balance_label")
                )
            ])
            .contentTransition(.numericText())
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: viewModel.points)

            // MARK: Progresso de tier
            tierProgressSection

            // MARK: Banner de promoção expirando
            if case .ready(let promotions) = viewModel.promoState,
               let expiring = viewModel.expiringPromotion(from: promotions) {
                ZodiakBanner(
                    message: String(
                        format: String(localized: "lp.home.banner_expiring"),
                        expiring.title
                    ),
                    variant: .warning,
                    isDismissible: true
                )
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.spring(response: 0.35, dampingFraction: 0.85), value: expiring.id)
            }

            // MARK: Carrossel de promoções
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakHeadlineSection(
                    title: "lp.home.promotions_eyebrow",
                    style: .plain
                )

                promotionsSection
            }
        }
        .navigationTitle(String(localized: "lp.home.title"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { homeToolbarItems }
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP home screen appeared", metadata: ["feature": "LoyaltyProgram"])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPHome")
        }
        .task { await viewModel.loadPromotions() }
    }

    // MARK: - Tier Progress

    @ViewBuilder
    private var tierProgressSection: some View {
        let tier = viewModel.membershipTier
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            HStack {
                ZodiakText(verbatim: tier.name, style: .caption(bold: true))
                Spacer()
                if let next = tier.nextTierName {
                    ZodiakText(
                        verbatim: String(localized: "lp.home.tier_progress_label") + ": \(next)",
                        style: .caption()
                    )
                }
            }
            ZodiakProgressBar(progress: tier.progress, showLabel: true)
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: tier.progress)
    }

    // MARK: - Promotions Section

    @ViewBuilder
    private var promotionsSection: some View {
        switch viewModel.promoState {
        case .loading:
            carouselSkeleton

        case .ready(let promotions):
            ZodiakCarousel(
                items: promotions.map { promotion in
                    ZodiakImageTile(
                        id: promotion.id,
                        title: promotion.title,
                        subtitle: promotion.description,
                        artworkSystemName: promotion.imageSystemName,
                        imageURL: URL(string: "https://picsum.photos/seed/\(promotion.id)/640/360")
                    )
                },
                showCounter: true,
                showNavigationButtons: false,
                onSelect: { tile in
                    guard let promotion = promotions.first(where: { $0.id == tile.id }) else { return }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    ZodiakLog.info(.navigation, "LP home navigated destination=promoDetail promo_id=\(tile.id)",
                           metadata: ["destination": "promoDetail", "promo_id": tile.id])
                    path.append(.promoDetail(promotion))
                }
            )

        case .error:
            ZodiakNotice(
                title: String(localized: "lp.home.error_title"),
                message: String(localized: "lp.home.error_message"),
                category: .warning,
                action: viewModel.retryPromotions,
                actionLabel: String(localized: "lp.home.error_retry")
            )
        }
    }

    // MARK: - Skeleton

    private var carouselSkeleton: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: ZodiakSpacing.s8) {
                ForEach(0..<3, id: \.self) { _ in
                    ZodiakSkeletonRect(height: 220, cornerRadius: ZodiakRadii.s)
                        .frame(width: 260)
                }
            }
            .padding(.horizontal, ZodiakSpacing.s16)
        }
        .padding(.horizontal, -ZodiakSpacing.s16)
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var homeToolbarItems: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            ZodiakMenuButton(
                title: "lp.home.menu_button",
                icon: "line.3.horizontal",
                variant: .secondary,
                size: .small
            ) {
                Button("lp.home.action_redeem") {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    ZodiakLog.info(.navigation, "LP home navigated destination=redeem",
                                   metadata: ["destination": "redeem"])
                    path.append(.redeem)
                }
                Button("lp.home.action_send") {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    ZodiakLog.info(.navigation, "LP home navigated destination=sendPoints",
                                   metadata: ["destination": "sendPoints"])
                    path.append(.sendPoints)
                }
                Button("lp.home.action_statement") {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    ZodiakLog.info(.navigation, "LP home navigated destination=statement",
                                   metadata: ["destination": "statement"])
                    path.append(.statement)
                }
                Button("lp.home.action_earn_points") {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    ZodiakLog.info(.navigation, "LP home navigated destination=earnPoints",
                                   metadata: ["destination": "earnPoints"])
                    path.append(.earnPoints)
                }
                Button("lp.home.catalog_cta") {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    ZodiakLog.info(.navigation, "LP home navigated destination=catalog",
                                   metadata: ["destination": "catalog"])
                    path.append(.catalog)
                }
            }

            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                path.append(.profile)
            } label: {
                ZodiakIconView(.user, size: .medium, color: ZodiakColors.actionPrimary)
            }
            .accessibilityLabel(String(localized: "lp.home.profile_button_label"))
        }
    }
}
