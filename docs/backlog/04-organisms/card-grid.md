# CardGrid

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Grid responsivo de cards (de `ZodiakCardVariants`). Adapta colunas por breakpoint: 1 mobile, 2 tablet, 3-4 desktop.

## História de usuário
Como **usuário**, quero **navegar coleções visuais** em **grid responsivo**.

## Critérios de aceite

### Cenário 1 — Colunas
**Dado** breakpoint compact/medium/expanded
**Então** 1 / 2 / 3-4 colunas.

### Cenário 2 — Gap
**Dado** spacing entre cards
**Então** `spacing.s16` (mobile), `spacing.s24` (tablet+).

### Cenário 3 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** navegação linear (esquerda-direita-baixo).

### Cenário 4 — Light/Dark
**Dado** dark
**Então** cards seguem tokens.

### Cenário 5 — Loading
**Dado** isLoading
**Então** grid de skeletons.

## Spec técnica

### APIs públicas
- `ZodiakCardGrid<T>(items: [T], card: (T) -> View, columns: ZodiakGridColumns = ZodiakGridColumns.adaptive, isLoading: Bool = false)`.

### Tokens
- Ver [grid](../00-foundations/grid.md).

## Boas práticas — iOS
- `LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))])`.

## Boas práticas — Android
- `LazyVerticalGrid(columns = GridCells.Adaptive(160.dp))`.
- WindowSizeClass para colunas explícitas.

## Acessibilidade
- Cada card é um elemento.
- Order de leitura linear.

## Referências
- [iOS `Organisms/CardGrid/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardGrid/)

## Gaps & dúvidas para o time de Design
- [ ] Min width oficial por breakpoint?

## DoD
- [ ] Adaptive grid.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
