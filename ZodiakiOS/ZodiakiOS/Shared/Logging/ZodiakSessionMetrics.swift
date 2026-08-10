import Foundation

// MARK: - Session Metrics

/// In-memory accumulator for discrete session-level metrics.
///
/// Counts are incremented throughout the session and emitted as a consolidated
/// log entry when the app moves to the background — providing a low-overhead
/// session summary for each foreground lifecycle.
///
/// External sinks registered on `ZodiakLogBus` will receive the summary entry,
/// enabling future integration with analytics providers.
final class ZodiakSessionMetrics {
    static let shared = ZodiakSessionMetrics()

    private let queue = DispatchQueue(
        label: "com.capgemini.zodiakios.session-metrics",
        qos: .utility
    )

    private var screenOpens: [String: Int] = [:]
    private var networkRequests: Int = 0
    private var networkErrors: Int = 0
    private var validationErrors: Int = 0
    private let sessionStart: Date

    private init() {
        sessionStart = Date()
    }

    // MARK: - Track

    /// Records a screen/feature open event.
    func trackScreenOpen(_ featureName: String) {
        queue.async { self.screenOpens[featureName, default: 0] += 1 }
    }

    /// Records a network request being initiated.
    func trackNetworkRequest() {
        queue.async { self.networkRequests += 1 }
    }

    /// Records a network request that failed.
    func trackNetworkError() {
        queue.async { self.networkErrors += 1 }
    }

    /// Records a user-triggered validation error.
    func trackValidationError() {
        queue.async { self.validationErrors += 1 }
    }

    // MARK: - Summary

    /// Emits a consolidated session-summary log entry.
    /// Call when the app transitions to background (`scenePhase == .background`).
    func emitSummary() {
        queue.async {
            let activeDurationSecs = Date().timeIntervalSince(self.sessionStart)
            let totalOpens = self.screenOpens.values.reduce(0, +)
            let topScreen = self.screenOpens.max(by: { $0.value < $1.value })?.key ?? "none"

            ZodiakLog.notice(
                .lifecycle,
                "Session summary [trace=\(ZodiakTrace.short)]",
                metadata: ["top_screen": topScreen],
                metrics: [
                    "screen_opens_total": Double(totalOpens),
                    "network_requests": Double(self.networkRequests),
                    "network_errors": Double(self.networkErrors),
                    "validation_errors": Double(self.validationErrors),
                    "active_duration_s": activeDurationSecs
                ]
            )
        }
    }
}
