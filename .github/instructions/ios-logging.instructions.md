---
description: "Use when writing any logging call (ZodiakLog, ZodiakSpan, ZodiakTrace, audit events) in ZodiakiOS. Enforces message format, trace stability, PII safety, and SwiftLint compliance."
applyTo: "ZodiakiOS/**/*.swift"
---

# Logging Rules — ZodiakiOS

Full API reference and examples: `.github/skills/ios-logging/SKILL.md`

## Use ZodiakLog for All Events

<rules>
- Always use `ZodiakLog.*` — never call `category.logger.*` directly for standard events.
- Use `ZodiakLogger.*` (direct Logger) only when attaching a privacy-sensitive field via `privacy: .private(mask: .hash)`.
</rules>

## Message Format

<rules>
- Messages MUST be English prose — never localization dot-notation keys (`"lp.home.navigate"`) or localized strings (`String(localized:)`).
- Messages MUST NOT manually include `[trace=...]` or `[span=...]` — `ZodiakLog.*` prepends them automatically.
- Embed key context values inline in the message string: `"LP home navigated destination=redeem"`.
- Keep metadata as a parallel structured repeat of the same values for sink queries.
- For errors, use `(error as NSError).code` — never `error.localizedDescription` (system-locale string, unpredictable in logs).
</rules>

```swift
// ✅ Correct
ZodiakLog.info(.lifecycle, "LP home screen appeared", metadata: ["feature": "LoyaltyProgram"])
ZodiakLog.info(.navigation, "LP home navigated destination=redeem", metadata: ["destination": "redeem"])
ZodiakLog.error(.network, "fetch_promotions failed error_code=\((error as NSError).code)",
                metadata: ["feature": "LoyaltyProgram"])

// ❌ Wrong
ZodiakLog.info(.lifecycle, "lp.home_screen.appeared", ...)       // dot-notation key
ZodiakLog.error(.network, "error: \(error.localizedDescription)", ...) // localizedDescription
ZodiakLog.info(.lifecycle, "[trace=\(ZodiakTrace.short)] LP screen appeared", ...) // manual trace prefix
```

## Trace Stability

<rules>
- NEVER call `await ZodiakTrace.withNewTrace { }` inside a ViewModel method — it resets the trace UUID on every call.
- `withNewTrace` is reserved for app-level session entry points only (app launch, root navigation entry).
- Use `ZodiakSpan` to isolate per-operation timing and context — it does not change the trace.
</rules>

```swift
// ❌ Wrong — creates a new trace each invocation
func loadRewards() async {
    await ZodiakTrace.withNewTrace {
        let span = ZodiakSpan(name: "lp_load_rewards", category: .network)
        ...
    }
}

// ✅ Correct — trace is stable; span tracks the operation
func loadRewards() async {
    let span = ZodiakSpan(name: "lp_load_rewards", category: .network)
    ...
    span.end(status: rewards.isEmpty ? "error" : "ok", metadata: ["feature": "LoyaltyProgram"])
}
```

## Spans

<rules>
- Use `ZodiakSpan` for every async operation that has a meaningful start/end (network fetch, processing step, wizard confirmation).
- Always call `span.end()` on every code path — pass `status: "cancelled"` in Task catch blocks.
- Never include `duration_ms` manually — it is emitted automatically by `span.end()`.
</rules>

## Audit Events

<rules>
- Compliance-relevant actions (login, purchase, points transfer, logout, validation failure) MUST use a typed `<Feature>AuditEvent` enum, not inline `ZodiakLog.info(.audit, ...)` calls.
- `<Feature>AuditEvent.emit()` is the only call site for audit logs — call it from ViewModels, not from Screen views.
- NEVER include PII in any log field: no full CPF, email, phone, name value. Masked suffixes (e.g. `"***824"`) are acceptable.
</rules>

## Category Selection

<rules>
- `.lifecycle` — screen appeared, feature opened
- `.navigation` — user navigated to a destination
- `.viewModel` — ViewModel state changes, task cancellations
- `.network` — API / network failures
- `.service` — decode/encode failures, local storage issues
- `.audit` — compliance actions (via typed audit event only)
</rules>

## SwiftLint — Line Length

<rules>
- Max line length is **120 characters**. ZodiakLog calls with metadata MUST wrap the `metadata:` parameter onto the next line if the full call would exceed 120 chars.
</rules>

```swift
// ✅ — wrapped because > 120 chars
ZodiakLog.warning(.service, "LP statement transactions decode failed",
                  metadata: ["feature": "LoyaltyProgram"])

// ✅ — fits on one line
ZodiakLog.info(.lifecycle, "LP home screen appeared", metadata: ["feature": "LoyaltyProgram"])
```

## Screen Logging Checklist

<rules>
Every screen MUST log:
1. `.onAppear` → `ZodiakLog.info(.lifecycle, "<Feature> <screen> screen appeared", metadata: ["feature": "..."])`
2. Each navigation tap → `ZodiakLog.info(.navigation, "<Feature> navigated destination=<dest>", metadata: ["destination": "<dest>"])`

Every async operation MUST:
3. Create a `ZodiakSpan` at the start
4. Call `span.end(status:metadata:)` on every code path (success, error, cancel)
5. Log task cancellations as `.debug` / `.viewModel`

Every decode/encode failure MUST:
6. Use `ZodiakLog.warning(.service, "<Feature> <object> decode/encode failed", ...)`
</rules>
