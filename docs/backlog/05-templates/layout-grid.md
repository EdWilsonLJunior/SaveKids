# LayoutGrid

> **Categoria**: Template · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Sistema de grid responsivo Zodiak. Define gutters, margens e colunas por breakpoint. Compõe layouts de tela inteira.

## História de usuário
Como **desenvolvedor**, quero **um grid responsivo padronizado** para que **layouts respeitem breakpoints e gutters do DS**.

## Critérios de aceite

### Cenário 1 — Breakpoints
**Dado** width compact/medium/expanded
**Então** colunas 4 / 8 / 12; gutter 16 / 24 / 24.

### Cenário 2 — Span
**Dado** child com `span: 6`
**Então** ocupa 6 colunas; em compact (4 col), wrap para próxima linha (overflow).

### Cenário 3 — Margens
**Dado** breakpoint expanded
**Então** padding lateral `spacing.s24`.

### Cenário 4 — Acessibilidade
**Dado** layout
**Então** ordem de leitura linear top-to-bottom.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** nenhum efeito (estrutura não tem cor).

## Spec técnica

### APIs públicas
- `ZodiakLayoutGrid(spacing: ZodiakGridSpacing = ZodiakGridSpacing.auto, content: Slot)` com itens `ZodiakGridItem(span: Int)`.

### Tokens
- Ver [grid foundation](../00-foundations/grid.md).

## Boas práticas — iOS
- `LazyVGrid(columns: GridItem)` adapta dinamicamente.

## Boas práticas — Android
- `LazyVerticalGrid(columns = GridCells.Fixed(cols))` + WindowSizeClass.

## Referências
- [iOS `Templates/ZodiakLayoutGrid.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Templates/ZodiakLayoutGrid.swift)

## Gaps & dúvidas para o time de Design
- [ ] Spec oficial de colunas/gutters?

## DoD
- [ ] Adaptive grid.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
