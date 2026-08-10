# ZodiakiOS Logging Infrastructure

## Overview

The logging stack has four layers that always work together:

| Type | Role |
|---|---|
| `ZodiakLog` | Unified API — write here for all standard events |
| `ZodiakLogCategory` | Category enum — selects the OSLog subsystem |
| `ZodiakTrace` | `@TaskLocal` trace UUID propagated through `async/await` trees |
| `ZodiakSpan` | Named operation span with OSSignpost + auto-duration |
| `ZodiakLogBus` | Fan-out to external sinks (Datadog, Firebase, etc.) |
| `LPAuditEvent` | Typed audit event pattern — replicate for each feature |

All files live in `ZodiakiOS/ZodiakiOS/Shared/Logging/`.

### Architecture Note — OSLog vs. OpenTelemetry

ZodiakiOS uses OSLog natively (not the OTel SDK) because:
- OSLog is the Apple-native telemetry layer with zero runtime overhead when a level is disabled
- `.debug` and `.info` messages have autoclosure evaluation, so they don't allocate if the level is off
- OSLog integrates with Xcode Organizer, `sysdiagnose`, and crash reports

`ZodiakLog` produces records that map to the OpenTelemetry Log Data Model:
- `message` → `Body` (human-readable, stable)
- `metadata` → `Attributes` (structured key-value context, queryable by sinks)
- `ZodiakTrace.traceId` → `TraceId`
- `ZodiakSpan.spanId` → `SpanId`

The trace/span IDs are short UUID strings (not W3C 128-bit hex format). If a sink requires W3C Trace Context, it must adapt them at the export layer.

---

## ZodiakLog — Unified API

**Always use `ZodiakLog.*` for standard events.** It writes to OSLog and dispatches to `ZodiakLogBus` in one call.

```swift
// Signature (same for all six levels):
ZodiakLog.debug(_ category: ZodiakLogCategory, _ message: String,
                metadata: [String: String] = [:], metrics: [String: Double] = [:])
```

### Available Levels

| Level | When | OTel SeverityNumber |
|---|---|---|
| `.debug` | Task cancellations, internal branch taken, fine-grained state | DEBUG (5–8) |
| `.info` | Screen appeared, navigation, operation complete (happy path) | INFO (9–12) |
| `.notice` | Session lifecycle (open, close, logout) — lowest level persisted by OSLog by default | INFO (9–12) |
| `.warning` | Recoverable failures — decode error, encode error, missing data | WARN (13–16) |
| `.error` | API call failed, unrecoverable condition | ERROR (17–20) |
| `.fault` | Programmer error, invariant violation, data corruption | FATAL (21–24) |

### Deliberate choice: `.info` for screen lifecycle events

Swift.org guidance says "avoid using `info` for normal operations" (e.g., logging every request in a server). For iOS/OSLog, the constraint is different:

- **`.debug` events are ephemeral** — they are never stored to disk and disappear when streaming stops. In production, you will never see them.
- **`.info` and above are retained** by OSLog briefly (hours/days) and appear in crash `sysdiagnose` and Xcode Organizer.

**Decision**: Use `.info(.lifecycle)` for screen appearances because diagnostics after a crash REQUIRE the navigation trail to survive. This is an intentional deviation from the server-side `info` discipline.

### Exception severity guide (OTel-aligned)

| Situation | Level |
|---|---|
| `Task.checkCancellation()` threw, task cancelled | `.debug` |
| Network timeout, server 4xx/5xx, decode failure | `.warning` |
| Unhandled exception not crashing the app | `.error` |
| Programmer invariant violated / data corruption | `.fault` |

### Error rate discipline

Before logging at `.error`, ask: **"Will this fire for every operation during a widespread outage?"**
A network `.error` that fires 1000 times/minute during a backend incident can overwhelm alerting systems. Prefer `.warning` for failures that are expected in some contexts (timeouts, retries exhausted). Reserve `.error` for failures that should always be investigated.

---

## ZodiakLogCategory — Category Selection Guide

| Category | Use for |
|---|---|
| `.lifecycle` | Screen appeared, feature opened, app foregrounded |
| `.navigation` | User navigated to a destination |
| `.viewModel` | ViewModel state changes, task cancellations |
| `.network` | API calls, network errors |
| `.service` | Data decode/encode, local persistence, service-level failures |
| `.error` | Unrecoverable errors |
| `.audit` | Compliance-relevant user actions (login, purchase, transfer, logout) |

---

## Log Message Format Rules

`ZodiakLog.*` **automatically prepends** `[trace=XXXXXXXX span=YYYYYYYY]` to every
OSLog entry. You never include that prefix in your message string.

### Body vs. Attributes principle (OTel-aligned)

| Field | Purpose | Our equivalent |
|---|---|---|
| **Body** | Stable, human-readable description of what happened | `message` string |
| **Attributes** | Variable context for structured querying by log backends | `metadata: [String: String]` |

The **message (Body)** should be stable enough that you could write an alerting rule against it.
The **metadata (Attributes)** is the queryable payload — put all variable context there.

```swift
// ✅ Clean separation — body is stable, variables in metadata
ZodiakLog.info(.navigation, "LP home navigated",
               metadata: ["destination": "redeem", "feature": "LoyaltyProgram"])

// ⚠️ Semi-structured — acceptable for Console.app readability, harder for backends
ZodiakLog.info(.navigation, "LP home navigated destination=redeem",
               metadata: ["destination": "redeem"])
```

Both patterns are accepted in this codebase. When a backend sink (Datadog, Firebase) needs to query logs, it uses the `metadata` dictionary — not the message body. Always duplicate key-value context in `metadata` even if you also embed it inline.

### Message format
```
"<Subject> <verb phrase> [key=value ...]"
```

- **English prose only** — no dot-notation keys, no localization strings
- Embed inline context directly in the message string (readable in Console.app without expanding metadata)
- Metadata repeats the same values in structured form (for sink queries)
- **Never embed `\n` in messages** — log aggregators (Datadog, CloudWatch) treat each line as a separate log record; newlines in messages corrupt the log stream

#### ✅ Correct
```swift
ZodiakLog.info(.lifecycle, "LP home screen appeared",
               metadata: ["feature": "LoyaltyProgram"])

ZodiakLog.info(.navigation, "LP home navigated destination=redeem",
               metadata: ["destination": "redeem"])

ZodiakLog.warning(.service, "LP statement transactions decode failed",
                  metadata: ["feature": "LoyaltyProgram"])

ZodiakLog.error(.network, "fetch_promotions failed error_code=\((error as NSError).code)",
                metadata: ["feature": "LoyaltyProgram"])
```

#### ❌ Wrong
```swift
// Dot-notation key — shows as opaque string in Console
ZodiakLog.info(.lifecycle, "lp.home_screen.appeared", ...)

// Localized string — may show translated text instead of a log key
ZodiakLog.error(.network, "fetch_promotions failed: \(error.localizedDescription)", ...)

// Manually embedding trace prefix — already done by ZodiakLog
ZodiakLog.info(.lifecycle, "[trace=\(ZodiakTrace.short)] LP home screen appeared", ...)
```

### Errors: use NSError.code, never localizedDescription
`localizedDescription` returns a system-locale string — unpredictable in logs.
```swift
// ✅
ZodiakLog.error(.network, "fetch_rewards failed error_code=\((error as NSError).code)", ...)

// ❌
ZodiakLog.error(.network, "fetch_rewards failed: \(error.localizedDescription)", ...)
```

### Exception attributes (OTel semconv)

For `.warning` and `.error` calls that catch an exception, add `exception.type` to metadata.
This maps to the OTel `exception.type` semantic convention (fully-qualified type name):

```swift
// ✅ — backend can filter/group by exception.type
ZodiakLog.warning(.service, "LP statement transactions decode failed",
                  metadata: [
                      "feature": "LoyaltyProgram",
                      "exception.type": String(describing: type(of: error))
                  ])

ZodiakLog.error(.network, "fetch_rewards failed error_code=\((error as NSError).code)",
                metadata: [
                    "feature": "LoyaltyProgram",
                    "exception.type": String(describing: type(of: error))
                ])
```

`String(describing: type(of: error))` gives the Swift type name (e.g., `"DecodingError"`, `"URLError"`).
For `NSError`, also consider `"exception.domain": (error as NSError).domain`.

---

## ZodiakTrace — Trace Stability Rules

`ZodiakTrace.traceId` is a `@TaskLocal UUID`. It propagates automatically to all
`await` calls within the same task tree.

### When to use `withNewTrace`

`withNewTrace` creates a **new UUID** — it changes the trace for everything inside the closure.

| ✅ Appropriate | ❌ Wrong |
|---|---|
| App-level entry point (`ZodiakiOSApp`, `MainTabView`) per user session | ViewModel `func loadXxx() async { await withNewTrace { } }` |
| Top-level user action (e.g. tapping a tab) | Per-operation wrapping inside ViewModels |

**Rule**: Never call `withNewTrace` inside a ViewModel method. The trace must be stable for the duration of the feature session. Spans (see below) are the right tool for per-operation tracking.

```swift
// ❌ BAD — creates a new trace each time loadPromotions() is called
func loadPromotions() async {
    await ZodiakTrace.withNewTrace {
        promoState = .loading
        ...
    }
}

// ✅ GOOD — trace is inherited; span tracks the operation
func loadPromotions() async {
    let span = ZodiakSpan(name: "fetch_promotions", category: .network)
    promoState = .loading
    let promotions = await fetchPromotions()
    span.end(status: promotions.isEmpty ? "error" : "ok",
             metadata: ["feature": "LoyaltyProgram"])
}
```

### Trace vs. Session ID

`ZodiakTrace.traceId` is an **operation-level propagation ID** — it's created for a user action and propagates through that task tree. It is NOT a user session ID.

| Concept | ZodiakiOS mapping | OTel concept |
|---|---|---|
| Operation trace | `ZodiakTrace.traceId` (task-local UUID) | `TraceId` |
| Named sub-operation | `ZodiakSpan` (spanShortId) | `SpanId` |
| User session | ❌ Not yet implemented | `session.id` |

If a future feature requires correlating logs across an entire user session (e.g., "all logs from the time the user opened the app to the time they closed it"), add `session.id` to metadata using a UUID generated at app launch. This is separate from the task-local trace.

---

## ZodiakSpan — Operation Tracking

`ZodiakSpan` tracks a named unit of work. On `init`, it logs `→ name started`.
On `end()`, it logs `duration_ms=N ← name status`. Both log lines include `[trace=X span=Y]` automatically.

### Anatomy

```swift
struct ZodiakSpan {
    init(name: String, category: ZodiakLogCategory)

    func end(
        status: String = "ok",               // "ok" | "error" | "cancelled"
        metadata: [String: String] = [:],
        extraMetrics: [String: Double] = [:]  // merged with duration_ms
    )
}
```

### Usage patterns

```swift
// Simple async operation
func loadRewards() async {
    let span = ZodiakSpan(name: "lp_load_rewards", category: .network)
    let rewards = await fetchRewards()
    span.end(
        status: rewards.isEmpty ? "error" : "ok",
        metadata: ["feature": "LoyaltyProgram"],
        extraMetrics: ["reward_count": Double(rewards.count)]
    )
}

// Task with cancellation
func confirm() {
    confirmTask = Task { @MainActor in
        let span = ZodiakSpan(name: "lp_send_points", category: .service)
        do {
            try await Task.sleep(for: processingDelay)
            ...
            span.end(status: "ok", metadata: ["feature": "LoyaltyProgram"])
        } catch {
            ZodiakLog.debug(.viewModel, "LP send points task cancelled",
                            metadata: ["feature": "LoyaltyProgram"])
            span.end(status: "cancelled", metadata: ["feature": "LoyaltyProgram"])
        }
    }
}
```

### span.end() placement
- Call `end()` on every code path (do + catch for Tasks)
- Pass `status: "cancelled"` in catch blocks for `Task.sleep` cancellation
- Prefer `extraMetrics` for result counts, byte sizes, item counts

---

## Audit Event Pattern (LPAuditEvent)

Compliance-relevant actions (login, purchase, transfer, logout, validation failure) must use typed audit events — never inline `ZodiakLog.info(.audit, ...)` calls in screens or ViewModels.

### Pattern to replicate

```swift
// In <Feature>AuditEvent.swift:
enum LPAuditEvent {
    case loginAttempt(success: Bool)
    case sendPoints(recipientMasked: String, amount: Int, ...)

    func emit() {
        switch self {
        case .loginAttempt(let success): emitLoginAttempt(success: success)
        ...
        }
    }

    private func emitLoginAttempt(success: Bool) {
        let status = success ? "success" : "failure"
        ZodiakLog.info(
            .audit,
            "LP login attempt status=\(status)",
            metadata: [
                "feature": "LoyaltyProgram",
                "action": "login",
                "status": status,
                "event.name": "lp.login.attempt"   // OTel EventName convention
            ]
        )
    }
}

// At call site:
LPAuditEvent.loginAttempt(success: true).emit()
```

### PII rules for audit events
| ✅ Safe to log | ❌ Never log |
|---|---|
| Masked CPF suffix (`"***824"`) | Full CPF, email, phone |
| Reward ID, opportunity ID | Real user name |
| Field names changed (`["name", "email"]`) | Field values |
| Point amounts, counts | Account balances of other users |

### Audit event naming (OTel EventName convention)

Add `"event.name"` to every audit event's metadata following the pattern `"<feature-domain>.<action>"`. This makes audit events queryable in log backends by event type without parsing the message body.

```
"lp.login.attempt"
"lp.points.sent"
"lp.points.redeemed"
"lp.statement.viewed"
"lp.logout"
```

The `LPAuditEvent` enum case name already encodes this — map it to the metadata key in `emit()`.

---

## ZodiakLogBus — External Sinks

Sinks are registered at app startup:
```swift
// In ZodiakiOSApp.init():
ZodiakLogBus.shared.register(MyAnalyticsSink())
```

`ZodiakLogEntry` received by sinks contains: `level`, `category`, `message`, `traceId`, `spanId?`, `metadata`, `metrics`, `timestamp`. It never contains PII — PII stays in OSLog (native layer) only.

---

## Metadata Key Naming Convention

Metadata keys should be **dot-namespaced and camelCase-prefixed** within each namespace. This mirrors OTel Attribute naming conventions and enables log backends to treat them as structured nested fields.

| Pattern | Example | Status |
|---|---|---|
| `<namespace>.<name>` (preferred for exportable fields) | `"exception.type"`, `"app.feature"`, `"event.name"` | Preferred for OTel-compatible fields |
| Simple flat key (acceptable for internal-only fields) | `"feature"`, `"status"`, `"destination"` | Acceptable |
| Avoid: PascalCase, snake_case, mixed styles | `"FeatureName"`, `"feature_name"` | Avoid |

### Well-known keys in this codebase

| Key | Values | Notes |
|---|---|---|
| `"feature"` | `"LoyaltyProgram"` | Present on every LP log |
| `"exception.type"` | `String(describing: type(of: error))` | On every `.warning`/`.error` that catches an exception |
| `"exception.domain"` | `(error as NSError).domain` | For NSError-based failures |
| `"event.name"` | e.g., `"lp.login.attempt"` | On every `.audit` event |
| `"destination"` | route/screen name | On navigation events |
| `"status"` | `"success"` / `"failure"` | On result events |
| `"action"` | verb name | On audit events |

---

## SwiftLint Compliance

Max line length: **120 characters** (`ZodiakiOS/.swiftlint.yml`).

For `ZodiakLog` calls with metadata, wrap the metadata parameter if the line would exceed 120 chars:

```swift
// ✅ — wrapped when > 120 chars
ZodiakLog.warning(.service, "LP statement transactions decode failed",
                  metadata: ["feature": "LoyaltyProgram"])

// ✅ — fits on one line (≤ 120 chars)
ZodiakLog.info(.lifecycle, "LP home screen appeared", metadata: ["feature": "LoyaltyProgram"])
```

---

## Quick Reference — Screen Logging Checklist

Every screen must log:

| Event | Level | Category | Message pattern |
|---|---|---|---|
| `.onAppear` | `.info` | `.lifecycle` | `"<Feature> <screen name> screen appeared"` |
| Navigation tap | `.info` | `.navigation` | `"<Feature> navigated destination=<dest>"` |
| Async operation start | span init | — | handled by `ZodiakSpan` |
| Async operation end | span end | — | handled by `ZodiakSpan.end()` |
| Task cancelled | `.debug` | `.viewModel` | `"<Feature> <action> task cancelled"` |
| Decode/encode failure | `.warning` | `.service` | `"<Feature> <object> decode/encode failed"` |
| API error | `.error` | `.network` | `"<operation> failed error_code=\((error as NSError).code)"` |
| Audit action | typed enum | `.audit` | via `<Feature>AuditEvent.emit()` |
