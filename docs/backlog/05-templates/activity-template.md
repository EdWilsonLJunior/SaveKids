# ActivityTemplate

> **Categoria**: Template · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Template para "Activities" Zodiak — telas com header (cover), conteúdo scrollable, e ações fixas no rodapé. Comum em flows de checkout, formulários longos, etc.

## História de usuário
Como **usuário**, quero **realizar tarefas estruturadas** em **telas com cover + conteúdo + ações fixas**.

## Critérios de aceite

### Cenário 1 — Cover
**Dado** cover image/banner
**Então** scroll collapsa cover em top app bar.

### Cenário 2 — Footer fixo
**Dado** ações primárias
**Então** botões fixos no bottom respeitando safe area + keyboard insets.

### Cenário 3 — Conteúdo scrollable
**Dado** conteúdo longo
**Então** scroll preserva header colapsado.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** ordem: header → conteúdo → footer.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens.

## Spec técnica

### APIs públicas
- `ZodiakActivityTemplate(cover: Slot? = none, content: Slot, footer: Slot? = none, navTitle: String? = none)`.

### Tokens
- Padding: `spacing.s16`. Footer divider opcional.

## Boas práticas — iOS
- `ScrollView` + `.toolbar` + safe area.

## Boas práticas — Android
- `Scaffold(topBar = { LargeTopAppBar }, bottomBar = { ... })`.
- `imePadding()` no bottomBar.

## Referências
- [iOS `Templates/ZodiakActivityTemplate.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Templates/ZodiakActivityTemplate.swift)

## Gaps & dúvidas para o time de Design
- [ ] Colapsar cover — comportamento oficial (parallax, fade)?

## DoD
- [ ] Cover collapsible.
- [ ] Footer keyboard-aware.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
