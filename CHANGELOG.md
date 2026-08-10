# Changelog

All notable changes to this project will be documented in this file.

This file is **automatically maintained** by [Release Please](https://github.com/googleapis/release-please).
Do not edit it manually — changes will be overwritten on the next release.

Commit messages follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

---

## [1.0.0] - 2026-05-15

### Features

- iOS Design System: 19 atoms, 18 molecules, 20+ organisms in `Shared/DesignSystem/`
- Android Design System (draft): 4 atoms, 4 molecules, 3 organisms in `design-system/`
- Full token system: colors (adaptive light/dark), Ubuntu typography, spacing (base 8pt), radii, sizing, borders, blurs, gradients
- 18+ feature mini-apps on iOS (SwiftUI) and Android (Jetpack Compose): Grades, Pix Discount, Voting, Palindrome, Guess the Number, Multiplication Table, Person Manager, Theme Switch, Temperature Converter, Task Manager, Quiz Game, Student Grades, Product Manager, Card Manager, ShopMaster, Login, Book Reader, Expense Manager, Currency Converter
- DS Catalog/Gallery app on both platforms
- `en` + `pt-BR` localization via `Localizable.xcstrings` (iOS) and per-feature `strings.xml` (Android)
- Dark mode: fully token-based, audited clean (0 critical violations)
- CI pipeline: SwiftLint → build → test → dark-mode audit (iOS); Detekt → build → test (Android)
- Automated versioning via Release Please + Conventional Commits

[1.0.0]: https://github.com/mflipe/zodiak-mobile/releases/tag/v1.0.0
