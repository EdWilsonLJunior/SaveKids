# Accessibility Helpers

> **Categoria**: Utils · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Conjunto de helpers e modifiers que padronizam acessibilidade em todo o DS (heading levels, hit-target padding, RTL mirror, focus management).

## História de usuário
Como **desenvolvedor**, quero **APIs padronizadas para acessibilidade** para **não reinventar conformidade WCAG em cada componente**.

## Critérios de aceite

### Cenário 1 — Hit-target helper
**Dado** `.zodiakHitTarget(.standard)` (`Zodiak.hitTarget.minimum`)
**Então** padding mínimo aplicado para alcançar tamanho.

### Cenário 2 — Heading helper
**Dado** `.zodiakHeading(level: 2)`
**Então** traits/heading semantics aplicados.

### Cenário 3 — RTL mirror
**Dado** `.zodiakMirrorRTL()`
**Então** scaleX = -1 em RTL.

### Cenário 4 — Focus
**Dado** `.zodiakFocus(...)` ou `ZodiakFocusManager`
**Então** programmatic focus consistente.

### Cenário 5 — Reduce Motion
**Dado** modifier que dispara animação condicional
**Então** respeita `accessibilityReduceMotion` automaticamente.

## Spec técnica

### APIs públicas
Conjunto de extensões/modifiers (forma nativa por plataforma) aplicáveis a qualquer view-host:
- `zodiakHitTarget(size: ZodiakHitTargetSize = ZodiakHitTargetSize.standard)` — garante padding mínimo para `Zodiak.hitTarget.minimum`.
- `zodiakHeading(level: Int)` — marca como heading semântico (níveis 1–6).
- `zodiakMirrorRTL()` — espelha conteúdo em locales RTL.
- `zodiakAnnouncement(message: String)` — dispara anuúncio live-region polite.

## Boas práticas — iOS
- `.accessibilityHeading(.h1...h6)`, `.accessibilityAction`, `.accessibilityRotor`.
- `@Environment(\.accessibilityReduceMotion)`, `\.accessibilityReduceTransparency`.

## Boas práticas — Android
- `Modifier.semantics { heading(); liveRegion = LiveRegionMode.Polite }`.
- `AccessibilityManager.isReduceMotionEnabled`.

## Referências
- [iOS `Utils/ZodiakAccessibility.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Utils/ZodiakAccessibility.swift)

## DoD
- [ ] Helpers documentados e usados nos componentes.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
