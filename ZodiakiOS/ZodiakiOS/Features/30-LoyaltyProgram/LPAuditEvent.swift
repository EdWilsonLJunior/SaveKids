import Foundation

// MARK: - LP Audit Events

/// Typed audit events for the Loyalty Program feature.
///
/// Each case carries only non-PII data suitable for forwarding to external sinks via
/// `ZodiakLogBus`. PII (e.g. real CPF, email value, name) is **never** included.
///
/// ### Usage
/// ```swift
/// LPAuditEvent.redeemPoints(rewardId: reward.id, pointsCost: cost,
///                           balanceBefore: before, balanceAfter: after).emit()
/// ```
enum LPAuditEvent {
    /// User submitted login credentials.
    case loginAttempt(success: Bool)

    /// User successfully redeemed a reward.
    case redeemPoints(rewardId: String, pointsCost: Int, balanceBefore: Int, balanceAfter: Int)

    /// User successfully transferred points to another account.
    /// `recipientMasked` must be the already-masked value (e.g. `"***824"`), never the real CPF.
    case sendPoints(recipientMasked: String, amount: Int, balanceBefore: Int, balanceAfter: Int)

    /// User earned points from an opportunity.
    case earnPoints(opportunityId: String, delta: Int, balanceBefore: Int, balanceAfter: Int)

    /// User saved profile changes. `fieldsChanged` contains field *names* only, never values.
    case profileSaved(fieldsChanged: [String])

    /// User logged out, ending the LP session.
    case sessionEnded

    /// A user action failed input validation.
    case validationFailed(action: String, errorKey: String)

    // MARK: - Emit

    /// Emits this event to `ZodiakLog` with category `.audit`.
    /// The entry is dispatched to all sinks registered on `ZodiakLogBus`.
    func emit() {
        switch self {
        case .loginAttempt(let success): emitLoginAttempt(success: success)

        case .redeemPoints(let id, let cost, let before, let after):
            emitRedeemPoints(rewardId: id, pointsCost: cost, balanceBefore: before, balanceAfter: after)

        case .sendPoints(let recipient, let amount, let before, let after):
            emitSendPoints(recipientMasked: recipient, amount: amount, balanceBefore: before, balanceAfter: after)

        case .earnPoints(let id, let delta, let before, let after):
            emitEarnPoints(opportunityId: id, delta: delta, balanceBefore: before, balanceAfter: after)

        case .profileSaved(let fields): emitProfileSaved(fieldsChanged: fields)

        case .sessionEnded: emitSessionEnded()

        case .validationFailed(let action, let errorKey):
            emitValidationFailed(action: action, errorKey: errorKey)
        }
    }

    // MARK: - Private helpers

    private func emitLoginAttempt(success: Bool) {
        let status = success ? "success" : "failure"
        ZodiakLog.info(
            .audit,
            "LP login attempt status=\(status)",
            metadata: [
                "feature": "LoyaltyProgram",
                "action": "login",
                "status": status,
                "event.name": "lp.login.attempt"
            ]
        )
    }

    private func emitRedeemPoints(rewardId: String, pointsCost: Int, balanceBefore: Int, balanceAfter: Int) {
        ZodiakLog.info(
            .audit,
            "LP points redeemed reward_id=\(rewardId) points_cost=\(pointsCost)",
            metadata: [
                "feature": "LoyaltyProgram",
                "action": "redeem",
                "reward_id": rewardId,
                "event.name": "lp.points.redeemed"
            ],
            metrics: [
                "points_cost": Double(pointsCost),
                "balance_before": Double(balanceBefore),
                "balance_after": Double(balanceAfter),
                "delta": Double(balanceAfter - balanceBefore)
            ]
        )
    }

    private func emitSendPoints(recipientMasked: String, amount: Int, balanceBefore: Int, balanceAfter: Int) {
        ZodiakLog.info(
            .audit,
            "LP points sent recipient=\(recipientMasked) amount=\(amount)",
            metadata: [
                "feature": "LoyaltyProgram",
                "action": "send_points",
                "recipient_masked": recipientMasked,
                "event.name": "lp.points.sent"
            ],
            metrics: [
                "amount": Double(amount),
                "balance_before": Double(balanceBefore),
                "balance_after": Double(balanceAfter)
            ]
        )
    }

    private func emitEarnPoints(opportunityId: String, delta: Int, balanceBefore: Int, balanceAfter: Int) {
        ZodiakLog.info(
            .audit,
            "LP points earned opportunity=\(opportunityId) delta=+\(delta)",
            metadata: [
                "feature": "LoyaltyProgram",
                "action": "earn_points",
                "opportunity_id": opportunityId,
                "event.name": "lp.points.earned"
            ],
            metrics: [
                "delta": Double(delta),
                "balance_before": Double(balanceBefore),
                "balance_after": Double(balanceAfter)
            ]
        )
    }

    private func emitProfileSaved(fieldsChanged: [String]) {
        let fieldList = fieldsChanged.joined(separator: ",")
        ZodiakLog.info(
            .audit,
            "LP profile saved fields=[\(fieldList)]",
            metadata: [
                "feature": "LoyaltyProgram",
                "action": "profile_save",
                "fields_changed": fieldList,
                "event.name": "lp.profile.saved"
            ]
        )
    }

    private func emitSessionEnded() {
        ZodiakLog.notice(
            .audit,
            "LP session ended",
            metadata: ["feature": "LoyaltyProgram", "action": "logout", "event.name": "lp.logout"]
        )
    }

    private func emitValidationFailed(action: String, errorKey: String) {
        ZodiakLog.warning(
            .audit,
            "LP validation failed action=\(action) error=\(errorKey)",
            metadata: [
                "feature": "LoyaltyProgram",
                "action": action,
                "error_key": errorKey,
                "event.name": "lp.validation.failed"
            ]
        )
    }
}
