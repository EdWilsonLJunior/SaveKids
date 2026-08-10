import SwiftUI

// MARK: - US-30.07 Promo Detail Screen
// LPPromotion passed via navigationDestination(for:), then linked to its redeemable reward.
struct LPPromoDetailScreen: View {
    let promotion: LPPromotion
    @Binding var path: [LPRoute]

    @AppStorage(LPConstants.Storage.points) private var points: Int = LPConstants.Defaults.initialPoints
    @StateObject private var viewModel = LPPromoDetailViewModel()
    @State private var isShowingShareSheet = false

    // MARK: - Computed

    private static let expiryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        return formatter
    }()

    private var isExpired: Bool {
        guard let expiresAt = promotion.expiresAt else { return false }
        return expiresAt < Date()
    }

    private var canAfford: Bool {
        points >= redeemCost
    }

    private var associatedReward: LPReward? {
        viewModel.associatedReward
    }

    private var redeemCost: Int {
        associatedReward?.pointsCost ?? promotion.pointsCost
    }

    private var formattedExpiry: String {
        guard let expiresAt = promotion.expiresAt else {
            return String(localized: "lp.promo_detail.label_no_expiry")
        }
        return Self.expiryDateFormatter.string(from: expiresAt)
    }

    private var missingPoints: Int {
        max(0, redeemCost - points)
    }

    private var daysUntilExpiry: Int? {
        guard let expiresAt = promotion.expiresAt else { return nil }
        let diff = Calendar.current.dateComponents([.day], from: Date(), to: expiresAt)
        return diff.day
    }

    private var expiryUrgencyLabel: String? {
        guard let days = daysUntilExpiry else { return nil }
        if days < 0 { return nil } // isExpired lida com isso
        if days == 0 { return String(localized: "lp.promo_detail.expires_today") }
        if days == 1 { return String(localized: "lp.promo_detail.expires_tomorrow") }
        if days <= 7 {
            return String(format: String(localized: "lp.promo_detail.expires_in_days"), days)
        }
        return nil
    }

    // MARK: - Body

    var body: some View {
        ZodiakActivityTemplate(
            title: promotion.title,
            eyebrow: String(localized: "lp.promo_detail.eyebrow")
        ) {
            heroSection
            infoSection
            if !promotion.benefits.isEmpty {
                benefitsSection
            }
            accordionSection
            if isExpired {
                expiredBadge
            } else if let urgency = expiryUrgencyLabel {
                ZodiakChip(verbatim: urgency, isActive: false)
                    .transition(.opacity.combined(with: .scale(scale: 0.92)))
            }
            if !canAfford && !isExpired {
                insufficientNotice
            }
            if !isExpired, associatedReward != nil {
                redeemButton
            }
            shareSection
        }
        .navigationTitle(promotion.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingShareSheet) {
            ActivityShareSheet(
                items: ["\(promotion.title)\n\(String(localized: "lp.promo_detail.share_text"))"]
            )
            .presentationDetents([.medium, .large])
        }
        .onAppear {
            ZodiakLog.info(.lifecycle, "LP promo detail screen appeared promo_id=\(promotion.id)",
                             metadata: ["feature": "LoyaltyProgram", "promo_id": promotion.id])
            ZodiakSessionMetrics.shared.trackScreenOpen("LPPromoDetail")
        }
        .task(id: promotion.id) {
            await viewModel.loadAssociatedReward(for: promotion)
        }
    }

    // MARK: - Sections

    @ViewBuilder
    private var heroSection: some View {
        ZodiakHero(
            eyebrow: nil,
            title: promotion.title,
            summary: promotion.description,
            style: .large,
            background: ZodiakGradients.brand,
            mediaSystemImage: promotion.imageSystemName
        )
    }

    @ViewBuilder
    private var infoSection: some View {
        ZodiakFormWrapper {
            ZodiakInfoRow(
                label: String(localized: "lp.promo_detail.label_cost"),
                value: "\(redeemCost) pts"
            )
            ZodiakInfoRow(
                label: String(localized: "lp.promo_detail.label_expires"),
                value: formattedExpiry
            )
        }
    }

    @ViewBuilder
    private var benefitsSection: some View {
        ZodiakList(
            items: promotion.benefits,
            headline: String(localized: "lp.promo_detail.benefits_headline"),
            variant: .unordered
        )
    }

    @ViewBuilder
    private var accordionSection: some View {
        ZodiakAccordion(title: "lp.promo_detail.how_to_redeem_title", leadingIcon: "questionmark.circle") {
            ZodiakList(
                items: [
                    String(localized: "lp.promo_detail.how_to_redeem_step1"),
                    String(localized: "lp.promo_detail.how_to_redeem_step2"),
                    String(localized: "lp.promo_detail.how_to_redeem_step3")
                ],
                variant: .ordered
            )
            .padding(.vertical, ZodiakSpacing.s8)
        }

        ZodiakAccordion(title: "lp.promo_detail.terms_title", leadingIcon: "doc.text") {
            ZodiakText("lp.promo_detail.terms_text", style: .body(color: .secondary))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, ZodiakSpacing.s8)
        }
    }

    @ViewBuilder
    private var shareSection: some View {
        ZodiakShare(
            options: [
                ZodiakShareOption(title: String(localized: "lp.promo_detail.share_action"), icon: .shareiOSExport) {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    isShowingShareSheet = true
                }
            ],
            label: "shared.action.share"
        )
        .padding(.top, ZodiakSpacing.s8)
    }

    @ViewBuilder
    private var expiredBadge: some View {
        ZodiakChip(text: "lp.promo_detail.status_expired", isActive: false)
    }

    @ViewBuilder
    private var insufficientNotice: some View {
        ZodiakNotice(
            title: String(
                format: String(localized: "lp.promo_detail.notice_insufficient"),
                missingPoints
            ),
            category: .warning
        )
    }

    @ViewBuilder
    private var redeemButton: some View {
        ZodiakButtonPrimary(
            title: "lp.promo_detail.action_redeem",
            action: {
                guard let associatedReward else { return }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                path.append(.rewardDetail(associatedReward))
            },
            isEnabled: canAfford
        )
        .frame(maxWidth: .infinity)
        .padding(.bottom, ZodiakSpacing.s24)
    }
}

// MARK: - UIActivityViewController wrapper

private struct ActivityShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
