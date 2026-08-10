# AdaptiveTemplate

> **Categoria**: Template · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Template adaptativo de tela inteira que detecta breakpoint e organiza conteúdo entre layouts (single-column mobile, two-column tablet master-detail, etc.).

## História de usuário
Como **desenvolvedor**, quero **um template adaptativo** que **maximize o uso da tela em todos os form factors**.

## Critérios de aceite

### Cenário 1 — Compact (mobile portrait)
**Dado** `compact`
**Então** layout single-column; navegação stack.

### Cenário 2 — Medium (mobile landscape, tablet portrait)
**Dado** `medium`
**Então** layout 1 ou 2 colunas conforme conteúdo.

### Cenário 3 — Expanded (tablet landscape)
**Dado** `expanded`
**Então** master-detail (NavigationSplitView).

### Cenário 4 — Acessibilidade
**Dado** muda orientação
**Então** foco preservado; ordem lógica.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens.

## Spec técnica

### APIs públicas
- `ZodiakAdaptiveTemplate(sidebar: Slot, content: Slot, detail: Slot? = none)` ou enum-based para padrões comuns.

### Tokens
- Ver [grid](../00-foundations/grid.md).

## Boas práticas — iOS
- `NavigationSplitView(sidebar: { ... }, detail: { ... })` (iOS 16+).
- `horizontalSizeClass` para customizar manualmente quando necessário.

## Boas práticas — Android
- WindowSizeClass (`calculateWindowSizeClass(activity)`) + branch por `widthSizeClass`.
- `androidx.compose.material3.adaptive.navigation-suite` para nav adaptativa.

## Referências
- [iOS `Templates/ZodiakAdaptiveTemplate.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Templates/ZodiakAdaptiveTemplate.swift)

## Gaps & dúvidas para o time de Design
- [ ] Padrões oficiais (single, list-detail, supporting-pane)?

## DoD
- [ ] Adaptive via size class.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
