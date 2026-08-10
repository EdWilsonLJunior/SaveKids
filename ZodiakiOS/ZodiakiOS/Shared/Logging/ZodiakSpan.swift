import Foundation
import OSLog

// MARK: - Span

/// A lightweight performance span backed by `OSSignposter`, visible in Instruments.
///
/// Records a named unit of work with start/end timestamps.
/// On `end()`, duration is logged via `ZodiakLogger` and metrics are forwarded to `ZodiakLogBus`.
///
/// ### Usage
/// ```swift
/// let span = ZodiakSpan(name: "cep_lookup", category: .network)
/// defer { span.end() }
/// let data = try await session.data(from: url)
/// ```
struct ZodiakSpan {
    let name: String
    let spanId: UUID
    let traceId: String

    private let category: ZodiakLogCategory
    private let startDate: Date
    private let signposter: OSSignposter
    private let intervalState: OSSignpostIntervalState

    init(name: String, category: ZodiakLogCategory) {
        let spanId = UUID()
        let traceShort = ZodiakTrace.short
        let spanShort = String(spanId.uuidString.prefix(8))
        let signposter = OSSignposter(subsystem: ZodiakLogger.subsystem, category: category.rawValue)
        // OSSignpost name must be a static string; dynamic info goes in the message body.
        let state = signposter.beginInterval(
            "span",
            "[\(traceShort, privacy: .public)/\(spanShort, privacy: .public)] \(name, privacy: .public)"
        )

        self.name = name
        self.spanId = spanId
        self.traceId = traceShort
        self.category = category
        self.startDate = Date()
        self.signposter = signposter
        self.intervalState = state

        ZodiakTrace.spanShortId = spanShort
        let ctx = "[trace=\(traceShort) span=\(spanShort)]"
        category.logger.info("\(ctx, privacy: .public) → \(name, privacy: .public) started")
    }

    /// Ends the span, logs duration, and emits metrics to `ZodiakLogBus`.
    ///
    /// - Parameters:
    ///   - status: `"ok"` on success, or a short error label (e.g. `"error"`, `"cancelled"`).
    ///   - metadata: Additional descriptive labels forwarded to external sinks.
    ///   - extraMetrics: Additional numeric metrics merged with `duration_ms`.
    func end(
        status: String = "ok",
        metadata: [String: String] = [:],
        extraMetrics: [String: Double] = [:]
    ) {
        let durationMs = Date().timeIntervalSince(startDate) * 1_000
        let shortSpan = String(spanId.uuidString.prefix(8))

        signposter.endInterval("span", intervalState)

        let ctx = "[trace=\(traceId) span=\(shortSpan)]"
        let durStr = "duration_ms=\(Int(durationMs))"
        category.logger.info("\(ctx, privacy: .public) \(durStr, privacy: .public) ← \(name, privacy: .public) \(status, privacy: .public)")
        ZodiakTrace.spanShortId = "-"

        var allMetrics = extraMetrics
        allMetrics["duration_ms"] = durationMs
        var allMetadata = metadata
        allMetadata["status"] = status

        ZodiakLogBus.shared.emit(ZodiakLogEntry(
            level: status == "ok" ? .info : .warning,
            category: category,
            message: "\(name) \(status)",
            traceId: traceId,
            spanId: shortSpan,
            metadata: allMetadata,
            metrics: allMetrics
        ))
    }
}
