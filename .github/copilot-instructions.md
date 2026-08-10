# Project Guidelines — Zodiak Monorepo

## Objective
Deliver changes with minimal diffs, preserving existing architecture, design system, and localization patterns.

## Repository Structure

| Folder | Platform |
|---|---|
| `ZodiakAndroid/` | Android (Jetpack Compose + Hilt + Gradle) |
| `ZodiakiOS/` | iOS (SwiftUI + MVVM + Swift Testing) |
| `ZodiakReact/` | React + TypeScript + SCSS component library |
| `docs/` | Design documentation and PDF exports |

---

## Android — ZodiakAndroid

### Quick Start
- Build: `./gradlew :app:assembleDebug`
- Test all: `./gradlew test`
- Test single module: `./gradlew :features:feature-grades:test`
- Install on device: `./gradlew :app:installDebug`

### Source of Truth
- Architecture: see this file and `.github/instructions/android-*.instructions.md`
- Design System: `ZodiakAndroid/design-system/src/main/kotlin/com/zodiak/android/design_system/`
- Build conventions: `ZodiakAndroid/build-logic/src/main/kotlin/`

### Codebase Map

| Path | Contents |
|---|---|
| `ZodiakAndroid/app/` | `MainActivity`, `ZodiakApp`, `ZodiakNavGraph`, `NavigationSuiteScaffold` |
| `ZodiakAndroid/features/feature-<name>/` | Each feature: ViewModel + Screen + Navigation + Test |
| `ZodiakAndroid/design-system/` | Atomic Design: atoms → molecules → organisms + ZodiakTheme |
| `ZodiakAndroid/core/models/` | Shared data classes and sealed classes |
| `ZodiakAndroid/core/services/` | Pure business logic (`object` Kotlin, stateless) |
| `ZodiakAndroid/core/datastore/` | `ZodiakPreferencesRepository` (DataStore Preferences) |
| `ZodiakAndroid/core/testing/` | `MainDispatcherExtension` (JUnit 5) |
| `ZodiakAndroid/build-logic/` | Convention plugins (`zodiak.android.feature`, etc.) |

### Feature Module Structure (4 files)
```
features/feature-<name>/src/main/kotlin/com/zodiak/android/feature/<name>/
├── FeatureNameViewModel.kt    — @HiltViewModel, StateFlow<XxxUiState>
├── FeatureNameScreen.kt       — @Composable, hiltViewModel(), collectAsStateWithLifecycle()
└── FeatureNameNavigation.kt   — @Serializable object XxxRoute + NavGraphBuilder extension

features/feature-<name>/src/test/kotlin/com/zodiak/android/feature/<name>/
└── FeatureNameViewModelTest.kt
```

### Android UI And Design Rules

<rules>
- Reuse components from `ZodiakAndroid/design-system/` before creating new UI primitives
- Avoid hardcoded colors — use `MaterialTheme.colorScheme.*`
- Avoid hardcoded spacing — use 4dp grid increments (4, 8, 16, 24, 32dp)
- **Visual quality is mandatory.** Token conformance is the floor — screens must reflect intentional typographic hierarchy, color anchoring, spatial variation, and animated state transitions
- Before writing any Compose code, scan `.github/instructions/android-design-system.instructions.md`
- Minimum quality bar: ≥ 2 distinct typography styles, 1 dominant surface + ≤ 1 accent color, spacing that varies, at least 1 animated transition
</rules>

### Android Localization Rules

<rules>
- Use `stringResource(R.string.*)` in Composables — never resolve strings in ViewModels
- Expose `ValidationError` types; resolve text in the Composable layer
- Feature strings: `features/feature-<name>/src/main/res/values/strings.xml` + `values-pt-BR/strings.xml`
- Full naming conventions: `.github/instructions/android-localization.instructions.md`
</rules>

### Android Code Quality
- Detekt is configured in `.idea/detekt.xml`
- After every code change, ensure zero new warnings

### Android Common Pitfalls

<pitfalls>
- Dark mode regressions from hardcoded `Color(0xFF...)` — always use `MaterialTheme.colorScheme.*`
- `ZodiakAlert` on Android is a **dialog** (not inline) — show/hide via boolean in `UiState`
- Missing `featureNameScreen()` registration in `ZodiakNavGraph.kt` after creating a new feature
- Using Compose `State` in ViewModel — all state must live in `StateFlow`
- Hardcoding `Modifier.fillMaxWidth()` inside Atom components — always pass through `modifier: Modifier = Modifier`
</pitfalls>

---

## iOS — ZodiakiOS

### Quick Start
- Open in Xcode: `open ZodiakiOS/ZodiakiOS.xcodeproj`
- Available scheme: `ZodiakiOS`
- Build (CLI): `xcodebuild -project ZodiakiOS/ZodiakiOS.xcodeproj -scheme ZodiakiOS -configuration Debug build`
- Test (CLI): `xcodebuild -project ZodiakiOS/ZodiakiOS.xcodeproj -scheme ZodiakiOS -destination 'platform=iOS Simulator,name=iPhone 17' test`

### Source of Truth
- Project overview: `ZodiakiOS/README.md`
- Keyboard fix documentation: `ZodiakiOS/docs/keyboard/index.md`
- Dark mode audit: `ZodiakiOS/docs/dark-mode-audit.md`

### Codebase Map
- App entry and navigation: `ZodiakiOS/ZodiakiOS/ZodiakiOSApp.swift`, `ZodiakiOS/ZodiakiOS/App/MainTabView.swift`
- Features (MVVM by folder): `ZodiakiOS/ZodiakiOS/Features/`
- Shared design system (Atomic Design): `ZodiakiOS/ZodiakiOS/Shared/DesignSystem/`
- Domain models: `ZodiakiOS/ZodiakiOS/Models/Models.swift`
- Business services: `ZodiakiOS/ZodiakiOS/Services/Services.swift`
- Tests: `ZodiakiOS/ZodiakiOSTests/`, `ZodiakiOS/ZodiakiOSUITests/`

### iOS Repository Conventions
- Keep feature folders in `ZodiakiOS/Features/NN-Name/` with `NameScreen.swift`, `NameViewModel.swift`, `NameConstants.swift`
- Prefer `final class` + `ObservableObject` + `@Published` for ViewModels
- Use Swift Testing (`import Testing`, `@Suite`, `@Test`) in unit tests
- Keep `// MARK: -` sections in long files

### iOS UI And Design Rules

<rules>
- Reuse components and tokens from `ZodiakiOS/Shared/DesignSystem/` before creating new primitives
- Avoid hardcoded colors — use semantic/theme colors from the design system
- Preserve keyboard dismissal behavior in input screens
- **Visual quality is mandatory.** Token conformance is the floor — screens must reflect intentional typographic hierarchy, color anchoring, spatial variation, and animated state transitions
- Before writing any SwiftUI code, run through the Design Thinking checklist in `.github/skills/ios-zodiak-ds/SKILL.md`
- Minimum quality bar: ≥ 2 distinct ZodiakTextStyle values, 1 dominant surface + ≤ 1 accent color, spacing that varies, at least 1 animated transition
</rules>

### iOS Localization Rules

<rules>
- Use `String(localized: ...)` and update `ZodiakiOS/Localizable.xcstrings` (both `en` and `pt-BR`)
- Full conventions: `.github/instructions/ios-localization.instructions.md`
</rules>

### SwiftLint
- Config: `ZodiakiOS/.swiftlint.yml`
- Run: `swiftlint lint --config ZodiakiOS/.swiftlint.yml`
- Auto-fix: `swiftlint lint --fix --config ZodiakiOS/.swiftlint.yml`
- **After every code change**, ensure 0 violations before finishing

### iOS Common Pitfalls

<pitfalls>
- Dark mode regressions from hardcoded foreground/background colors
- Keyboard constraint regressions in input screens
- SwiftLint violations — run lint after any Swift file edit
</pitfalls>

---

## React — ZodiakReact

### Quick Start
- Install: `npm install` (from monorepo root)
- Build: `npm run build`
- Test: `npm run test`
- Storybook: `npm run storybook` → http://localhost:6006

### Source of Truth
- Architecture: see this file and `.github/instructions/react-*.instructions.md`
- Design System: `ZodiakReact/packages/react-scss/src/components/`
- Dev rules: `ZodiakReact/packages/react-scss/CLAUDE.md`
- Full reference: `ZodiakReact/packages/react-scss/docs/conventions.md`
- AI infrastructure: `ZodiakReact/AI-INFRASTRUCTURE.md`

### Codebase Map

| Path | Contents |
|---|---|
| `ZodiakReact/packages/react-scss/` | Primary package — all component work happens here |
| `ZodiakReact/packages/react-scss/src/components/` | 26 components (Buttons, Hero, Forms, Layout, etc.) |
| `ZodiakReact/packages/react-scss/scss/tokens/` | Design tokens (CSS custom properties) — do not edit without approval |
| `ZodiakReact/packages/react-scss/scss/mixins/` | Typography + layout SCSS mixins |
| `ZodiakReact/packages/react-scss/docs/` | Reference docs: conventions, decision trees, anti-patterns |
| `ZodiakReact/packages/react-tailwind/` | Experimental — do not modify |
| `ZodiakReact/packages/tailwind-preset/` | Shared config — do not modify |

### Component Anatomy (6 files — all mandatory)
```
src/components/ComponentName/
├── ComponentName.tsx          — component + all types
├── component-name.scss        — styles (kebab-case)
├── ComponentName.test.tsx     — Vitest + vitest-axe
├── ComponentName.stories.tsx  — Storybook (AllOptions + Playground)
├── CHANGELOG.md               — per-component history
└── index.ts                   — re-exports with .js extensions
```

### React UI And Design Rules

<rules>
- Reuse components from `packages/react-scss/src/components/` before creating new UI primitives
- Avoid hardcoded colours — use `var(--zodiak-*)` semantic tokens directly (never alias them)
- **Visual quality is mandatory.** Token conformance is the floor — components must reflect intentional typographic hierarchy, colour anchoring, and verified light/dark behaviour
- Before writing any React/SCSS code, scan `.github/instructions/react-design-system.instructions.md`
- Layout: `Hero`, `HeroTypographic`, `VideoBanner`, `TextBlockSection` are GROUP A (self-managing) — never wrap inside `ZodiakLayout`/`ZodiakSection`; all other components are GROUP B
- Minimum quality bar: ≥ 2 typography styles, 1 dominant surface + ≤ 1 accent, spacing varies, verified in both themes
</rules>

### React Testing Rules

<rules>
- Framework: Vitest + @testing-library/react + vitest-axe (WCAG 2.1 AA required)
- Every component test must have 4 `describe` blocks: `rendering`, `behaviour`, `class names`, `accessibility`
- Run `axe` on every significant variant — not just the default render
- Full conventions: `.github/instructions/react-testing.instructions.md`
</rules>

### React Code Quality
- After every code change, run `npm run test` from the monorepo root — ensure 0 failures
- ESLint and TypeScript strict mode are enabled

### React Common Pitfalls

<pitfalls>
- `--zodiak-text-inverse` on fixed dark surfaces — becomes invisible in dark mode; use `--zodiak-text-always-white`
- Missing `box-sizing: border-box` — no global reset; declare on every sized bordered element
- Local token aliases (`--local-x: var(--zodiak-x)`) — silently break dark-mode overrides
- Manual font properties instead of `@include zt.type-style-*` — values drift from the type scale
- `ButtonMenu` with > 5 options — renders `null` silently
- `ButtonInteractive.icon` as JSX element — must be a component class, not `<Icon />`
- GROUP A components inside `ZodiakLayout` — breaks full-width layout
- Missing `.js` extension in `index.ts` exports — NodeNext resolution requires explicit extensions
- Generating code for unported components (Modal, Chips, Notice, Combobox, Dropdown, Multiselect, Toast) — these do not exist in React yet
</pitfalls>
