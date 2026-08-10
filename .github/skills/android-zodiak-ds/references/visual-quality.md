# Zodiak Visual Quality — Isolated Guidance (Android)

This file provides targeted guidance for improving individual design dimensions in Zodiak Compose screens. Use when a screen works but feels flat, generic, or lacks visual intent.

> Design intent is identical to iOS — the tokens and patterns differ, but the aesthetic goals are the same.

---

## Typography — Isolated

Apply when: the screen exists but all text looks the same size/weight.

**Diagnostic:**
- Count distinct DS text Atom types used → if only `ZodiakBody` everywhere, hierarchy is flat
- Identify the "hero value" (the answer the user came for) → must use `ZodiakHeadline`
- Identify metadata/labels → must use `ZodiakCaption` or `ZodiakLabel`

**Upgrade patterns:**

```kotlin
// Before: flat hierarchy — everything ZodiakBody
ZodiakBody(text = "Resultado")
ZodiakBody(text = "42.5 °F")
ZodiakBody(text = "Convertido de Celsius")

// After: intentional scale contrast
ZodiakCaption(
    text = stringResource(R.string.shared_label_result),
    color = MaterialTheme.colorScheme.onSurfaceVariant,  // label — small, muted
)
ZodiakHeadline(text = "42.5 °F")                         // hero value — 24sp dominant
ZodiakCaption(
    text = stringResource(R.string.feature_temp_converted_from_celsius),
)                                                         // context — small, normal weight
```

**Quick wins:**
- `ZodiakHeadline` → the primary numerical result, key statistic, or action confirmation
- `ZodiakTitle` → section titles on detail or summary screens (e.g., "Seu Resultado")
- `ZodiakBody` → standard descriptive text
- `ZodiakLabel` → field labels with emphasis
- `ZodiakCaption(color = MaterialTheme.colorScheme.onSurfaceVariant)` → timestamp, unit label, spec key

<never>
- Use `ZodiakHeadline` on more than 1 element per screen (it stops being headline)
- Use `ZodiakBody` for the primary result of a calculation — it deserves `ZodiakHeadline`
- Use raw `Text` with hardcoded `fontSize`/`fontWeight` in feature screens
</never>

---

## Color — Isolated

Apply when: the screen has no visual anchor or feels like a gray box.

**Diagnostic:**
- How many distinct background colors in use? → more than 2 = noise
- Does `MaterialTheme.colorScheme.primary` appear at all? → if not, there's no Zodiak identity
- Are status colors (`error`, `tertiaryContainer`) used only for state feedback?

**Upgrade patterns:**

```kotlin
// Pattern 1: Primary color accent on result
ZodiakHeadline(
    text = result,
    color = MaterialTheme.colorScheme.primary,  // single brand anchor
)

// Pattern 2: surfaceVariant for form section depth
ZodiakFormContainer(title = "Entrada") { /* inputs */ }   // surfaceVariant card
// Result below is on .background → visible depth separation

// Pattern 3: semantic colors for state feedback — ONLY for result states
ZodiakInfoRow(
    label = stringResource(R.string.feature_grades_situation_label),
    value = stringResource(if (passing) R.string.shared_state_passed else R.string.shared_state_failed),
    valueColor = if (passing) MaterialTheme.colorScheme.tertiary
                 else MaterialTheme.colorScheme.error,
)
```

**Token intent map:**

| Token | Correct use | Never use for |
|---|---|---|
| `primary` | Single visual anchor, CTA | Repeating decoration, all text |
| `surfaceVariant` | Form card background, alternate section | Error states |
| `tertiaryContainer` | Success state feedback | General backgrounds |
| `errorContainer` | Error state feedback | Warning states |
| `onSurfaceVariant` | Labels, hints, captions | Primary content text |
| `onPrimary` | Text on primary-filled backgrounds | Text on light surfaces |

---

## Motion — Isolated

Apply when: the screen is static — no visual feedback that state has changed.

**Diagnostic:**
- Is there a `result` in `UiState` that appears/disappears? → needs `AnimatedVisibility`
- Is there an `error` that appears? → needs `AnimatedVisibility` or `animateContentSize`
- Does `reset()` clear values? → a quick fade-out on result would feel clean

**Minimal motion kit:**

```kotlin
// 1. Result entrance — wrap result section in AnimatedVisibility
AnimatedVisibility(
    visible = uiState.result != null,
    enter = fadeIn() + scaleIn(initialScale = 0.94f),
    exit = fadeOut(),
) {
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        ZodiakHeadline(text = uiState.result ?: "")
        ZodiakCaption(text = stringResource(R.string.shared_label_result))
    }
}

// 2. Error appearance
AnimatedVisibility(
    visible = uiState.error != null,
    enter = fadeIn(),
    exit = fadeOut(),
) {
    ZodiakBadge(
        text = uiState.error?.let { stringResource(R.string.shared_validation_blank_field) } ?: "",
        variant = ZodiakBadgeVariant.ERROR,
    )
}

// 3. Button state (loading)
ZodiakButton(
    text = stringResource(R.string.shared_action_submit),
    onClick = viewModel::submit,
    enabled = !uiState.isLoading,
    modifier = Modifier.animateContentSize(),
)
```

**Timing reference:**

| Moment | Duration | Curve |
|---|---|---|
| Result appears | 300–400ms | `fadeIn() + scaleIn(0.94f)` |
| Error appears | 200ms | `fadeIn()` |
| Reset / clear | 150ms | `fadeOut()` (things leave faster than they arrive) |

---

## Spatial Composition — Isolated

Apply when: the screen feels cramped or floaty — spacing doesn't communicate structure.

**Diagnostic:**
- Is the same spacing value used everywhere? → no hierarchy
- Does the result section feel like it's on the same level as the input? → needs more distance

**Upgrade patterns:**

```kotlin
// Pattern 1: Vary spacing between input and result
LazyColumn(
    verticalArrangement = Arrangement.spacedBy(16.dp),  // standard within sections
    contentPadding = PaddingValues(16.dp),
) {
    item {
        ZodiakFormContainer(title = ...) {
            // inputs — internal spacing 8dp (form handles it)
        }
    }
    item { Spacer(Modifier.height(8.dp)) }  // extra breathing room before result
    item {
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            ZodiakHeadline(text = result)   // hero — tighter internal spacing
            ZodiakCaption(text = label)
        }
    }
}

// Pattern 2: Horizontal padding on inner content for visual layering
Column(
    modifier = Modifier.padding(horizontal = 16.dp),
    verticalArrangement = Arrangement.spacedBy(24.dp),  // 24dp between sections
) {
    formSection                                          // 8dp internal spacing
    HorizontalDivider()
    resultSection                                        // 8dp internal spacing
}
```
