import Foundation
import OSLog

// MARK: - Log Level

/// Severity levels aligned with `os.Logger` levels for consistent filtering.
enum ZodiakLogLevel: String, Sendable {
    case debug
    case info
    case notice
    case warning
    case error
    case fault
}

// MARK: - Log Entry

/// Public log payload forwarded to external sinks.
///
/// Does **not** contain PII — privacy-sensitive fields are kept in the native
/// `Logger` (OSLog) layer only and never reach `ZodiakLogBus`.
struct ZodiakLogEntry: Sendable {
    /// Severity of the event.
    let level: ZodiakLogLevel
    /// Logging category (lifecycle, navigation, network, etc.)
    let category: ZodiakLogCategory
    /// Human-readable description of the event (English, no PII).
    let message: String
    /// First 8 chars of the active trace UUID.
    let traceId: String
    /// First 8 chars of the span UUID, if emitted from a `ZodiakSpan`.
    let spanId: String?
    /// Descriptive labels: feature name, status, error type, etc.
    let metadata: [String: String]
    /// Numeric measurements: duration_ms, items_count, response_bytes, etc.
    let metrics: [String: Double]
    /// Wall-clock time when the entry was created.
    let timestamp: Date

    init(
        level: ZodiakLogLevel,
        category: ZodiakLogCategory,
        message: String,
        traceId: String = ZodiakTrace.short,
        spanId: String? = nil,
        metadata: [String: String] = [:],
        metrics: [String: Double] = [:]
    ) {
        self.level = level
        self.category = category
        self.message = message
        self.traceId = traceId
        self.spanId = spanId
        self.metadata = metadata
        self.metrics = metrics
        self.timestamp = Date()
    }
}

// MARK: - Log Sink Protocol

/// Implement to integrate an external logging or analytics provider.
///
/// Register instances via `ZodiakLogBus.shared.register(_:)` at app startup.
/// Entries received here contain only public, non-PII data.
///
/// ```swift
/// // Example — not implemented yet:
/// // ZodiakLogBus.shared.register(FirebaseLogSink())
/// // ZodiakLogBus.shared.register(DatadogLogSink())
/// ```
protocol ZodiakLogSink: AnyObject {
    func emit(_ entry: ZodiakLogEntry)
}

// MARK: - Log Bus

/// Dispatches `ZodiakLogEntry` values to all registered external sinks.
///
/// OSLog is always active regardless of how many sinks are registered.
/// The bus is a no-op until the first `register(_:)` call.
final class ZodiakLogBus {
    static let shared = ZodiakLogBus()

    private var sinks: [any ZodiakLogSink] = []
    private let queue = DispatchQueue(
        label: "com.capgemini.zodiakios.logbus",
        qos: .utility
    )

    private init() {}

    /// Registers a sink to receive all future log entries.
    /// Call from app startup before the first log event.
    func register(_ sink: any ZodiakLogSink) {
        queue.async { self.sinks.append(sink) }
    }

    /// Removes all registered sinks. Intended for test isolation only.
    func removeAllSinks() {
        queue.sync { sinks.removeAll() }
    }

    func emit(_ entry: ZodiakLogEntry) {
        queue.async {
            for sink in self.sinks {
                sink.emit(entry)
            }
        }
    }
}

// MARK: - Unified Log API

/// Unified logging API: writes to native `Logger` (OSLog) **and** forwards to
/// `ZodiakLogBus` in a single call.
///
/// Use `ZodiakLog.*` for all events that carry only public data.
/// Call `ZodiakLogger.*` directly when a field requires `privacy: .private(mask: .hash)` —
/// those calls intentionally bypass the bus to avoid PII leakage to external sinks.
enum ZodiakLog {
    static func debug(
        _ category: ZodiakLogCategory,
        _ message: String,
        metadata: [String: String] = [:],
        metrics: [String: Double] = [:]
    ) {
        let ctx = "[trace=\(ZodiakTrace.short) span=\(ZodiakTrace.spanShortId)]"
        category.logger.debug("\(ctx, privacy: .public) \(message, privacy: .public)")
        ZodiakLogBus.shared.emit(
            ZodiakLogEntry(level: .debug, category: category, message: message,
                           metadata: metadata, metrics: metrics)
        )
    }

    static func info(
        _ category: ZodiakLogCategory,
        _ message: String,
        metadata: [String: String] = [:],
        metrics: [String: Double] = [:]
    ) {
        let ctx = "[trace=\(ZodiakTrace.short) span=\(ZodiakTrace.spanShortId)]"
        category.logger.info("\(ctx, privacy: .public) \(message, privacy: .public)")
        ZodiakLogBus.shared.emit(
            ZodiakLogEntry(level: .info, category: category, message: message,
                           metadata: metadata, metrics: metrics)
        )
    }

    static func notice(
        _ category: ZodiakLogCategory,
        _ message: String,
        metadata: [String: String] = [:],
        metrics: [String: Double] = [:]
    ) {
        let ctx = "[trace=\(ZodiakTrace.short) span=\(ZodiakTrace.spanShortId)]"
        category.logger.notice("\(ctx, privacy: .public) \(message, privacy: .public)")
        ZodiakLogBus.shared.emit(
            ZodiakLogEntry(level: .notice, category: category, message: message,
                           metadata: metadata, metrics: metrics)
        )
    }

    static func warning(
        _ category: ZodiakLogCategory,
        _ message: String,
        metadata: [String: String] = [:],
        metrics: [String: Double] = [:]
    ) {
        let ctx = "[trace=\(ZodiakTrace.short) span=\(ZodiakTrace.spanShortId)]"
        category.logger.warning("\(ctx, privacy: .public) \(message, privacy: .public)")
        ZodiakLogBus.shared.emit(
            ZodiakLogEntry(level: .warning, category: category, message: message,
                           metadata: metadata, metrics: metrics)
        )
    }

    static func error(
        _ category: ZodiakLogCategory,
        _ message: String,
        metadata: [String: String] = [:],
        metrics: [String: Double] = [:]
    ) {
        let ctx = "[trace=\(ZodiakTrace.short) span=\(ZodiakTrace.spanShortId)]"
        category.logger.error("\(ctx, privacy: .public) \(message, privacy: .public)")
        ZodiakLogBus.shared.emit(
            ZodiakLogEntry(level: .error, category: category, message: message,
                           metadata: metadata, metrics: metrics)
        )
    }

    static func fault(
        _ category: ZodiakLogCategory,
        _ message: String,
        metadata: [String: String] = [:],
        metrics: [String: Double] = [:]
    ) {
        let ctx = "[trace=\(ZodiakTrace.short) span=\(ZodiakTrace.spanShortId)]"
        category.logger.fault("\(ctx, privacy: .public) \(message, privacy: .public)")
        ZodiakLogBus.shared.emit(
            ZodiakLogEntry(level: .fault, category: category, message: message,
                           metadata: metadata, metrics: metrics)
        )
    }
}
