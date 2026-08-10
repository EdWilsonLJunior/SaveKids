# Viewport

> **Categoria**: Template · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Wrapper de viewport que gerencia safe areas, status bar style, splash transitions e configuração global de scroll/input (combina com `GlobalScrollInputConfigurator`).

## História de usuário
Como **desenvolvedor**, quero **um wrapper de viewport** que **handleie safe areas, status bar e scroll dismissive uniformemente**.

## Critérios de aceite

### Cenário 1 — Safe areas
**Dado** dispositivo com notch / barra gestos
**Então** padding correto aplicado.

### Cenário 2 — Status bar
**Dado** `statusBarStyle: .light/.dark/.auto`
**Então** estilo aplica; com `auto`, segue background.

### Cenário 3 — Scroll dismissive
**Dado** scroll
**Então** teclado dispensa em scroll (configurável).

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** zoom respeitado, foco inicial correto.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** background `surfacePrimary`.

## Spec técnica

### APIs públicas
- `ZodiakViewport(statusBarStyle: ZodiakStatusBarStyle = ZodiakStatusBarStyle.auto, dismissKeyboardOnScroll: Bool = true, content: Slot)`.

### Tokens
- Background: `surfacePrimary`.

## Boas práticas — iOS
- SwiftUI: `.statusBarHidden(...)` e `.preferredColorScheme(...)`.
- `.ignoresSafeArea(edges:)` controlado.

## Boas práticas — Android
- `WindowCompat.setDecorFitsSystemWindows(false)` para edge-to-edge.
- `Modifier.windowInsetsPadding(WindowInsets.systemBars)`.
- `Modifier.imePadding()` quando teclado.

## Referências
- [iOS `Templates/ZodiakViewport.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Templates/ZodiakViewport.swift)

## Gaps & dúvidas para o time de Design
- [ ] Política edge-to-edge default?

## DoD
- [ ] Safe areas + status bar.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
