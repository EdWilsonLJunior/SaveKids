import Combine
import SwiftUI

// MARK: - US-30.10 Earn Points ViewModel
final class LPEarnPointsViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.points) var points: Int = LPConstants.Defaults.initialPoints
    @AppStorage(LPConstants.Storage.statement) var statementData: Data = Data()

    @Published var opportunities: [LPEarnOpportunity] = LPEarnPointsViewModel.defaultOpportunities
    @Published var selectedOpportunity: LPEarnOpportunity?
    @Published var earnedPoints: Int?
    @Published var errorMessageKey: String?

    func submit() {
        guard earnedPoints == nil else { return }
        guard let selectedOpportunity else {
            errorMessageKey = "lp.earn_points.select_opportunity_error"
            earnedPoints = nil
            ZodiakSessionMetrics.shared.trackValidationError()
            LPAuditEvent.validationFailed(action: "earn_points", errorKey: "no_opportunity_selected").emit()
            return
        }

        let span = ZodiakSpan(name: "lp_earn_points", category: .service)
        let balanceBefore = points
        points += selectedOpportunity.points
        earnedPoints = selectedOpportunity.points
        errorMessageKey = nil

        let transaction = LPPointTransaction(
            id: UUID().uuidString,
            type: .earned,
            description: selectedOpportunity.title,
            date: Date(),
            points: selectedOpportunity.points
        )
        LPStatementService.appendTransaction(transaction, to: &statementData)
        span.end(status: "ok", metadata: ["feature": "LoyaltyProgram", "opportunity_id": selectedOpportunity.id])
        let auditEvent = LPAuditEvent.earnPoints(
            opportunityId: selectedOpportunity.id,
            delta: selectedOpportunity.points,
            balanceBefore: balanceBefore,
            balanceAfter: points
        )
        auditEvent.emit()
    }

    func reset() {
        selectedOpportunity = nil
        earnedPoints = nil
        errorMessageKey = nil
    }

    private static let defaultOpportunities: [LPEarnOpportunity] = [
        LPEarnOpportunity(
            id: "daily-checkin",
            title: String(localized: "lp.earn_points.opportunity_daily_title"),
            subtitle: String(localized: "lp.earn_points.opportunity_daily_subtitle"),
            points: 50,
            imageSystemName: "calendar.badge.plus"
        ),
        LPEarnOpportunity(
            id: "survey",
            title: String(localized: "lp.earn_points.opportunity_survey_title"),
            subtitle: String(localized: "lp.earn_points.opportunity_survey_subtitle"),
            points: 120,
            imageSystemName: "checklist"
        ),
        LPEarnOpportunity(
            id: "invite",
            title: String(localized: "lp.earn_points.opportunity_invite_title"),
            subtitle: String(localized: "lp.earn_points.opportunity_invite_subtitle"),
            points: 300,
            imageSystemName: "person.2.badge.plus"
        )
    ]
}
