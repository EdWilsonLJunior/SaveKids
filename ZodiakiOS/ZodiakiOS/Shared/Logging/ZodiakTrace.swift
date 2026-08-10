import Foundation

// MARK: - Trace Context

/// OpenTelemetry-inspired trace context propagated automatically through async task trees.
///
/// A new trace scope is created per user action via `ZodiakTrace.withNewTrace { }`.
/// Within that scope — including all `await` calls — `ZodiakTrace.traceId` resolves to
/// the same UUID without manual threading.
///
/// ### Usage
/// ```swift
/// func loadCatalog() async {
///     await ZodiakTrace.withNewTrace {
///         ZodiakLog.info(.viewModel, "loadCatalog() started [trace=\(ZodiakTrace.short)]")
///         let data = await fetch()
///         ZodiakLog.info(.viewModel, "loadCatalog() done [trace=\(ZodiakTrace.short)]")
///     }
/// }
/// ```
enum ZodiakTrace {
    /// Current trace identifier, scoped to the active async task tree via `@TaskLocal`.
    @TaskLocal static var traceId: UUID = UUID()

    /// First 8 characters of the current trace ID — compact and readable in logs.
    static var short: String { String(traceId.uuidString.prefix(8)) }

    /// Short ID of the currently active `ZodiakSpan`, or `"-"` if no span is active.
    /// Set synchronously by `ZodiakSpan.init` and cleared by `ZodiakSpan.end()`.
    nonisolated(unsafe) static var spanShortId: String = "-"

    /// Executes `operation` within a fresh trace scope (new `traceId`).
    /// The UUID is automatically propagated to all `await` calls inside the closure.
    @discardableResult
    static func withNewTrace<T: Sendable>(
        _ operation: @Sendable () async throws -> T
    ) async rethrows -> T {
        try await Self.$traceId.withValue(UUID()) {
            try await operation()
        }
    }
}
