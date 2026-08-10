# Global Scroll Input Configurator

> **Categoria**: Utils · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Configurador global que define comportamento padrão de scroll + input (dismiss keyboard on scroll, scroll indicators visibility, scroll bounce behavior).

## História de usuário
Como **desenvolvedor**, quero **configurar comportamentos globais de scroll/input** em **único lugar para todo o app**.

## Critérios de aceite

### Cenário 1 — Keyboard dismiss
**Dado** scroll inicia em view com keyboard aberto
**Então** keyboard dispensa.

### Cenário 2 — Indicators
**Dado** `showScrollIndicators: .never`
**Então** indicators escondidos globalmente.

### Cenário 3 — Bounce
**Dado** iOS: `bounce: .always`
**Então** scroll bounce mesmo com pouco conteúdo.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack ativo
**Então** indicators forçados visíveis (override).

### Cenário 5 — Light/Dark
**Dado** dark
**Então** indicators usam cor adequada.

## Spec técnica

### APIs públicas
- `ZodiakGlobalScrollInputConfigurator.configure(dismissKeyboardOnScroll: Bool, indicators: ScrollIndicatorVisibility, ...)`.

## Boas práticas — iOS
- SwiftUI: aplicar via Environment values custom; `.scrollDismissesKeyboard(.immediately)` (iOS 16+).

## Boas práticas — Android
- Compose: `LocalScrollConfiguration` (custom CompositionLocal); `Modifier.imeNestedScroll()`.

## Referências
- [iOS `Foundation/GlobalScrollInputConfigurator.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Foundation/GlobalScrollInputConfigurator.swift)

## Gaps & dúvidas para o time de Design
- [ ] Defaults oficiais (dismiss on scroll, indicators)?

## DoD
- [ ] Config global aplicada em viewport.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
