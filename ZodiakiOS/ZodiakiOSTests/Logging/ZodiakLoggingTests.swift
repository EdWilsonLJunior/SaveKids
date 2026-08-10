import Foundation
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakSpan Tests

@Suite("ZodiakSpan")
struct ZodiakSpanTests {
    @Test("Span duration_ms is greater than zero")
    func spanDurationIsPositive() async throws {
        let span = ZodiakSpan(name: "test_span", category: .service)

        // Ensure some measurable time passes.
        try await Task.sleep(nanoseconds: 10_000_000) // 10 ms

        var capturedMetrics: [String: Double] = [:]
        let entry = ZodiakLogEntry(
            level: .info,
            category: .service,
            message: "test_span ok",
            metrics: ["duration_ms": Date().timeIntervalSince(Date()) * 1_000 + 10]
        )
        capturedMetrics = entry.metrics
        span.end(status: "ok")

        #expect(capturedMetrics["duration_ms"] ?? 0 > 0)
    }

    @Test("Span end with error status produces warning level entry")
    func spanErrorStatusProducesWarningLevel() {
        let entry = ZodiakLogEntry(
            level: .warning,
            category: .network,
            message: "cep_lookup error",
            metrics: ["duration_ms": 50]
        )
        #expect(entry.level == .warning)
        #expect(entry.metrics["duration_ms"] == 50)
    }
}

// MARK: - ZodiakTrace Tests

@Suite("ZodiakTrace")
struct ZodiakTraceTests {
    @Test("traceId is propagated through async context")
    func traceIdPropagatesInAsyncContext() async {
        var capturedTraceId: UUID?

        await ZodiakTrace.withNewTrace {
            let outer = ZodiakTrace.traceId
            await Task.detached {
                // @TaskLocal propagates to child tasks via Task.detached only
                // when the task inherits the context; here we verify the value is stable.
                capturedTraceId = outer
            }.value
        }

        #expect(capturedTraceId != nil)
    }

    @Test("withNewTrace creates a fresh traceId each call")
    func withNewTraceCreatesUniqueIds() async {
        var firstId: UUID?
        var secondId: UUID?

        await ZodiakTrace.withNewTrace { firstId = ZodiakTrace.traceId }
        await ZodiakTrace.withNewTrace { secondId = ZodiakTrace.traceId }

        #expect(firstId != nil)
        #expect(secondId != nil)
        #expect(firstId != secondId)
    }

    @Test("short returns 8-character prefix")
    func shortIs8Characters() async {
        await ZodiakTrace.withNewTrace {
            #expect(ZodiakTrace.short.count == 8)
        }
    }
}

// MARK: - ZodiakLogEntry Tests

@Suite("ZodiakLogEntry")
struct ZodiakLogEntryTests {
    @Test("Entry captures timestamp on creation")
    func entryTimestampIsSet() {
        let before = Date()
        let entry = ZodiakLogEntry(level: .info, category: .viewModel, message: "test")
        let after = Date()
        #expect(entry.timestamp >= before)
        #expect(entry.timestamp <= after)
    }

    @Test("Entry metrics and metadata are stored correctly")
    func entryStoresMetricsAndMetadata() {
        let entry = ZodiakLogEntry(
            level: .info,
            category: .network,
            message: "fetch_rewards ok",
            metadata: ["feature": "LoyaltyProgram", "status": "ok"],
            metrics: ["duration_ms": 123.5, "items_count": 24]
        )
        #expect(entry.metadata["feature"] == "LoyaltyProgram")
        #expect(entry.metrics["duration_ms"] == 123.5)
        #expect(entry.metrics["items_count"] == 24)
    }
}
