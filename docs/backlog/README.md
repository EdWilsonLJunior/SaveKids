# Zodiak Design System — Backlog cross-platform (iOS + Android)

Backlog de histórias para (re)implementação completa do Zodiak Design System em **iOS (SwiftUI)** e **Android (Jetpack Compose)**. Cada história descreve o **contrato esperado** do componente, é independente de plataforma e referencia tanto o fonte iOS atual quanto a documentação oficial do Supernova.

> **Pressuposto**: o que existe hoje no `ZodiakAndroid/design-system` é considerado incorreto/rascunho. As implementações iOS atuais (`ZodiakiOS/.../Shared/DesignSystem/...`) servem como **referência de comportamento**, mas também são revisadas — gaps encontrados vão para [GAPS.md](GAPS.md).

---

## Como usar

1. Leia [ARCHITECTURE.md](ARCHITECTURE.md) para entender as convenções (primitivo interno + APIs públicas dedicadas, tokens-only, naming, documentação no código, previews/snapshots).
2. Consulte [DEPENDENCIES.md](DEPENDENCIES.md) para o cronograma em ondas e os diagramas Mermaid de composição (foundations → theme → atoms → molecules → organisms → templates).
3. Escolha uma história pela prioridade (P0 → P1 → P2) e categoria.
4. Implemente em **ambas** as plataformas seguindo a Definition of Done da história.
5. Atualize [GAPS.md](GAPS.md) com qualquer inconsistência ou dúvida levantada para o time de Design.

---

## Convenções

- **Idioma**: português (pt-BR).
- **Formato**: História de usuário + Critérios de aceite (Gherkin) + Spec técnica + Boas práticas iOS + Boas práticas Android + Acessibilidade + Referências + Gaps + DoD.
- **Prioridade**:
  - **P0** — Fundacional / bloqueia tudo (foundations, theme, button, text-field, modal, icon).
  - **P1** — Alta (formulários, cards, navegação, listings, share).
  - **P2** — Média (composições, blocos tipográficos, utils, decorativos).
- **Sem código de implementação** nas histórias. Apenas contrato, parâmetros, tokens, referências.
- **Notação neutra cross-platform**: contratos, critérios e cenários usam a **DSL neutra** definida em [ARCHITECTURE §3.1](ARCHITECTURE.md#31-contrato-neutro--notação-cross-platform). Sintaxe Swift/Kotlin aparece **apenas** em `Boas práticas — iOS` / `Boas práticas — Android` / `Referências`. Valide com `python3 scripts/lint-neutrality.py` (CI-pronto).
- **APIs públicas vs primitivo interno**: cada história lista nominalmente as APIs públicas a expor e o primitivo `internal` compartilhado. Ver [ARCHITECTURE.md](ARCHITECTURE.md).
- **Superfícies** (`onLite`/`onHeavy`/`onPhoto`) são **parâmetro** `surface:`, não compõem o nome da função.
- **Famílias compostas** (MediaBlocks, ImageCompositions, ActionCompositions, Typographic, CardVariants) têm história **guarda-chuva** + sub-histórias por variante.

---

## Índice

### 00 — Foundations (tokens)
- [Colors](00-foundations/colors.md) · **P0**
- [Typography](00-foundations/typography.md) · **P0**
- [Spacing](00-foundations/spacing.md) · **P0**
- [Sizing](00-foundations/sizing.md) · **P0**
- [Radii](00-foundations/radii.md) · **P0**
- [Borders](00-foundations/borders.md) · **P0**
- [Shadows](00-foundations/shadows.md) · **P0**
- [Blurs](00-foundations/blurs.md) · **P1**
- [Grid](00-foundations/grid.md) · **P0**
- [Icons](00-foundations/icons.md) · **P0**
- [Flags](00-foundations/flags.md) · **P1**
- [Logo](00-foundations/logo.md) · **P1**
- [Gradients](00-foundations/gradients.md) · **P1**
- [Hit-target](00-foundations/hit-target.md) · **P0**
- [Aspect Ratios](00-foundations/aspect-ratios.md) · **P1**
- [Opacity](00-foundations/opacity.md) · **P1**
- [Motion](00-foundations/motion.md) · **P1**
- [Defaults](00-foundations/defaults.md) · **P1**

### 01 — Theme
- [ZodiakTheme (light/dark + ColorScheme)](01-theme/zodiak-theme.md) · **P0**

### 02 — Atoms
- [Text](02-atoms/text.md) · **P0**
- [TextLink](02-atoms/text-link.md) · **P1**
- [Badge](02-atoms/badge.md) · **P1**
- [Divider](02-atoms/divider.md) · **P0**
- [List](02-atoms/list.md) · **P1**
- [Eyebrow](02-atoms/eyebrow.md) · **P1**
- [Avatar](02-atoms/avatar.md) · **P1**
- [Checkbox](02-atoms/checkbox.md) · **P0**
- [RadioButton](02-atoms/radio-button.md) · **P0**
- [Tabs](02-atoms/tabs.md) · **P0**
- [Rating](02-atoms/rating.md) · **P2**
- [FlagView](02-atoms/flag-view.md) · **P1**
- [LogoView](02-atoms/logo-view.md) · **P1**
- [Tooltip](02-atoms/tooltip.md) · **P1**
- [IconView](02-atoms/icon-view.md) · **P0**
- [ProgressIndicator](02-atoms/progress-indicator.md) · **P0**
- [TextField](02-atoms/text-field.md) · **P0**
- [PasswordField](02-atoms/password-field.md) · **P0**
- [SearchField](02-atoms/search-field.md) · **P1**
- [Button (Regular)](02-atoms/button-regular.md) · **P0**
- [ArrowButton](02-atoms/button-arrow.md) · **P1**
- [IconButton](02-atoms/button-icon.md) · **P0**
- [MediaButton](02-atoms/button-media.md) · **P1**
- [FilterButton](02-atoms/button-filter.md) · **P1**
- [MenuButton](02-atoms/button-menu.md) · **P1**
- [NavButtons](02-atoms/button-nav.md) · **P1**
- [SystemButton](02-atoms/button-system.md) · **P1**
- [SystemWarningButton](02-atoms/button-system-warning.md) · **P1**
- [WarningButtons](02-atoms/button-warning.md) · **P1**
- [VideoPreviewButton](02-atoms/button-video-preview.md) · **P2**
- [SliderCounter](02-atoms/slider-counter.md) · **P2**
- [MiniMenu](02-atoms/mini-menu.md) · **P2**
- [BreadcrumbPagination](02-atoms/breadcrumb-pagination.md) · **P2**

### 03 — Molecules
- [Alert](03-molecules/alert.md) · **P1**
- [Author](03-molecules/author.md) · **P1**
- [Notice](03-molecules/notice.md) · **P0**
- [ChipGroup](03-molecules/chip-group.md) · **P1**
- [StatusChip](03-molecules/status-chip.md) · **P1**
- [Combobox](03-molecules/combobox.md) · **P1**
- [Dropdown](03-molecules/dropdown.md) · **P1**
- [Multiselect](03-molecules/multiselect.md) · **P1**
- [Switch](03-molecules/switch.md) · **P0**
- [PhoneInput](03-molecules/phone-input.md) · **P1**
- [StepIndicator](03-molecules/step-indicator.md) · **P1**
- [Accordion](03-molecules/accordion.md) · **P1**
- [CounterControl](03-molecules/counter-control.md) · **P2**
- [QuickAccessBar](03-molecules/quick-access-bar.md) · **P2**
- [ResultCard](03-molecules/result-card.md) · **P2**
- [SlideToSubmit](03-molecules/slide-to-submit.md) · **P2**
- [LabelledField (InputField)](03-molecules/labelled-field.md) · **P0**
- [InputWizard](03-molecules/input-wizard.md) · **P2**

### 04 — Organisms
- [Banner](04-organisms/banner.md) · **P1**
- [Toast](04-organisms/toast.md) · **P1**
- [Modal](04-organisms/modal.md) · **P0**
- [Hero](04-organisms/hero.md) · **P1**
- [Pin](04-organisms/pin.md) · **P1**
- [LoginForm](04-organisms/login-form.md) · **P1**
- [Share](04-organisms/share.md) · **P1**
- [NotificationBanner](04-organisms/notification-banner.md) · **P0**
- [Listings](04-organisms/listings.md) · **P1**
- [EmptyState](04-organisms/empty-state.md) · **P1**
- [FormContainer](04-organisms/form-container.md) · **P1**
- [FormInDrawer](04-organisms/form-in-drawer.md) · **P1**
- [InfoRow](04-organisms/info-row.md) · **P2**
- [ShowMore](04-organisms/show-more.md) · **P2**
- [DownloadButton](04-organisms/download-button.md) · **P2**
- [SkeletonLoader](04-organisms/skeleton-loader.md) · **P1**
- [CardGrid](04-organisms/card-grid.md) · **P1**

#### Famílias — guarda-chuva + sub-histórias
- [ImageCompositions (guarda-chuva)](04-organisms/image-compositions/README.md) · **P2**
- [ActionCompositions (guarda-chuva)](04-organisms/action-compositions/README.md) · **P2**
- [MediaBlocks (guarda-chuva)](04-organisms/media-blocks/README.md) · **P1**
- [Typographic blocks (guarda-chuva)](04-organisms/typographic/README.md) · **P1**
  - [Quote](04-organisms/typographic/quote.md)
  - [TextBlock](04-organisms/typographic/text-block.md)
  - [Preamble](04-organisms/typographic/preamble.md)
  - [KeyFigures](04-organisms/typographic/key-figures.md)
  - [HeadlineSection](04-organisms/typographic/headline-section.md)
- [Card variants (guarda-chuva)](04-organisms/card-variants/README.md) · **P1**
  - [Horizontal](04-organisms/card-variants/horizontal.md)
  - [Typographic](04-organisms/card-variants/typographic.md)
  - [Author](04-organisms/card-variants/author.md)
  - [Reveal](04-organisms/card-variants/reveal.md)
  - [Tall](04-organisms/card-variants/tall.md)
  - [ShortFacts](04-organisms/card-variants/short-facts.md)

### 05 — Templates
- [LayoutGrid](05-templates/layout-grid.md) · **P0**
- [AdaptiveTemplate](05-templates/adaptive-template.md) · **P0**
- [ActivityTemplate](05-templates/activity-template.md) · **P1**
- [Viewport](05-templates/viewport.md) · **P1**

### 06 — Utils / Foundation
- [FontModifier](06-utils/font-modifier.md) · **P0**
- [Accessibility helpers](06-utils/accessibility-helpers.md) · **P0**
- [ViewModifiers](06-utils/view-modifiers.md) · **P1**
- [Extensions](06-utils/extensions.md) · **P1**
- [GlobalScrollInputConfigurator](06-utils/global-scroll-input-configurator.md) · **P2**
- [Preview helpers](06-utils/preview-helpers.md) · **P1**

### 07 — Audit

- [HIG Review — iOS Design System](07-audit/hig-review-ios.md) · **P1**

### 08 — Examples (Projetos Finais iOS)

Backlog de projetos de exemplo completos para o curso iOS. Cada épico cobre 8 telas com persistência, componentes do DS e padrões de navegação.

| Épico | Projeto | Persistência |
|---|---|---|
| [29 — Withdrawal Provisioning](08-examples/29-withdrawal-provisioning/README.md) | Provisionamento de Saque | `@AppStorage` |
| [30 — Loyalty Program](08-examples/30-loyalty-program/README.md) | Programa de Fidelidade | `@AppStorage` |
| [31 — Card Manager](08-examples/31-card-manager/README.md) | Gerenciador de Cartões | `@AppStorage` |
| [32 — SplitPay](08-examples/32-splitpay/README.md) | Divisão de Despesas | SwiftData |
| [33 — SafeVault](08-examples/33-safevault/README.md) | Cofre Digital | SwiftData |
| [34 — PocketBank Kids](08-examples/34-pocketbank-kids/README.md) | Banco Infantil Gamificado | SwiftData |
| [35 — Crypto Wallet](08-examples/35-crypto-wallet/README.md) | Carteira Crypto (fake) | SwiftData + CoinGecko API |
| [36 — PayFlow](08-examples/36-payflow/README.md) | Gerenciador de Assinaturas | SwiftData |

---

## Estado atual da implementação Android DS

> Atualizado em: 2026-05-17 (Wave 1 + Wave 3–5 agent tasks concluídas)

### Theme / Foundations implementados (`design-system/theme/`)

| Arquivo | Descrição | Branch |
|---|---|---|
| `Color.kt` | Esquemas MD3 light/dark | main (fix Kotlin 2.1 aplicado) |
| `Typography.kt` | ZodiakTypography + mapeamento DS→MD3 | `feature/ds-foundation-typography-android` |
| `Shape.kt` | ZodiakShapes | main |
| `ZodiakColorTokens.kt` | Primitivos internos (Blue/Neutral/Teal/Red/Green/Yellow/Orange/Overlay) | `feature/ds-foundation-colors-android` |
| `ZodiakSemanticColors.kt` | Tokens semânticos light() + dark() | `feature/ds-foundation-colors-android` |
| `ZodiakTheme.kt` | Ponto de entrada DynamicColor + CompositionLocal | main |
| `ZodiakGrid.kt` | Grid 4/8/12 colunas por breakpoint (G-007) | `feature/ds-foundation-grid-android` |
| `ZodiakHitTarget.kt` | Tokens 48/40/56dp + `Modifier.zodiakHitTarget()` (G-060) | `feature/ds-foundation-hit-target-android` |

### Atoms implementados (`design-system/atoms/`)

| Arquivo | Descrição | Branch |
|---|---|---|
| `ZodiakButton.kt` | Primary/Tonal/Outlined/Text/Destructive | main |
| `ZodiakBadge.kt` | SUCCESS/WARNING/ERROR/INFO/NEUTRAL | main |
| `ZodiakText.kt` | Headline/Title/Body/Label/Caption | main |
| `ZodiakTextField.kt` | Primitivo de input | main |
| `ZodiakTabs.kt` | FIXED/SCROLLABLE TabRow (G-014) | `feature/ds-atom-tabs-android` |
| `ZodiakProgressIndicator.kt` | Linear + Circular, determinate/indeterminate (G-020) | `feature/ds-atom-progress-indicator-android` |
| `ZodiakIconView.kt` | Icon wrapper com ZodiakIconSize, ImageVector + Painter (G-008) | `feature/ds-atom-icon-view-android` |

### Molecules implementados (`design-system/molecules/`)

| Arquivo | Descrição | Branch |
|---|---|---|
| `ZodiakAlert.kt` | Modal alert dialog INFO/SUCCESS/WARNING/ERROR | main |
| `ZodiakChipGroup.kt` | Single-select chip strip | main |
| `ZodiakInputField.kt` | TextField com label + error | main |
| `ZodiakSwitch.kt` | Toggle com label | main |
| `ZodiakNotice.kt` | Notice inline INFO/SUCCESS/WARNING/ERROR (G-021) | `feature/ds-molecule-notice-android` |

### Organisms implementados (`design-system/organisms/`)

| Arquivo | Descrição | Branch |
|---|---|---|
| `ZodiakEmptyState.kt` | Empty/error state com ícone e CTA | main |
| `ZodiakFormContainer.kt` | Card agrupador de formulários | main |
| `ZodiakInfoRow.kt` | Label + value row | main |
| `ZodiakNotificationBanner.kt` | Transient banner sobre MD3 Snackbar (G-038) | `feature/ds-organism-notification-banner-android` |

### Pendente (User tasks — Wave 1/2/3/4/5)

| Componente | Branch | Prioridade |
|---|---|---|
| `ZodiakSpacing.kt` | `feature/ds-foundation-spacing-android` | P0 (G-004) |
| `ZodiakSizing.kt` | `feature/ds-foundation-sizing-android` | P1 |
| `ZodiakShadows.kt` | `feature/ds-foundation-shadows-android` | P1 (G-005) |
| `ZodiakIcons.kt` | `feature/ds-foundation-icons-android` | P1 (G-008) |
| `ZodiakTheme.kt` validation | `feature/ds-theme-android` | P0 |
| `ZodiakDivider.kt` | `feature/ds-atom-divider-android` | P0 |
| `ZodiakCheckbox.kt` | `feature/ds-atom-checkbox-android` | P0 |
| `ZodiakRadioButton.kt` | `feature/ds-atom-radio-button-android` | P0 |
| `ZodiakLabelledField.kt` | `feature/ds-molecule-labelled-field-android` | P0 |
| `ZodiakModal.kt` | `feature/ds-organism-modal-android` | P0 (G-033, G-022) |

### Auditoria MD3/Stitch

| Wave | Branch | Estado |
|---|---|---|
| Wave 1 — ZodiakAlert | `feat/backlog-stitch-audit-android` | ✅ 4 findings: G-071..G-074 |

---

## Documentos de apoio

- [ARCHITECTURE.md](ARCHITECTURE.md) — racional da arquitetura primitivo+APIs, naming, KDoc/DocC, preview/snapshot, tokens-only.
- [GAPS.md](GAPS.md) — consolidação dos gaps do DS para o time de UI/UX.
- [_template/COMPONENT_TEMPLATE.md](_template/COMPONENT_TEMPLATE.md) — template padrão usado em todas as histórias.
- [07-audit/stitch-review-android.md](07-audit/stitch-review-android.md) — metodologia de auditoria MD3/Stitch para Android.
- [07-audit/android-execution-plan.md](07-audit/android-execution-plan.md) — plano de execução completo das waves Android.

---

## Mapa de referências externas (boas práticas nativas)

- **iOS / Apple HIG**: https://developer.apple.com/design/human-interface-guidelines
- **SwiftUI**: https://developer.apple.com/documentation/swiftui
- **DocC**: https://www.swift.org/documentation/docc/
- **Material 3 (Compose)**: https://m3.material.io/develop/android/jetpack-compose
- **Material 3 Expressive**: https://m3.material.io/blog/building-with-m3-expressive
- **Compose Modifier semantics**: https://developer.android.com/develop/ui/compose/accessibility/semantics
- **KDoc**: https://kotlinlang.org/docs/kotlin-doc.html
