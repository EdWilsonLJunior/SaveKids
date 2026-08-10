# Grid (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Layout grid responsivo — número de colunas, gutter (espaço entre colunas) e margin (espaço lateral) por **breakpoint**. Sustenta layouts adaptativos de telas.

## História de usuário
Como **desenvolvedor**, quero **resolver columns/gutter/margin via tokens por breakpoint** para que **layouts adaptem automaticamente entre celular compact, tablet portrait e tablet landscape**.

## Critérios de aceite

### Cenário 1 — Breakpoints
**Dado** [`ZodiakGridTokens.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakGridTokens.swift) e Supernova [`Overview - Layout grid.md`](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Layout%20grid.md)
**Então** existem ao menos 3 breakpoints (`compact`, `medium`, `expanded`) com columns/gutter/margin.

### Cenário 2 — Resolução
**Dado** o tamanho da janela atual
**Quando** uso `ZodiakGrid.current` / `ZodiakTheme.grid.current`
**Então** recebo o conjunto de tokens correto para o breakpoint.

### Cenário 3 — Text layout
**Dado** [`Text layout - Layout grid.md`](../../ZodiakiOS/docs/zodiak-pdf/Text%20layout%20-%20Layout%20grid.md)
**Então** larguras de coluna de texto (measure) respeitam 45–75 char por linha.

### Cenário 4 — RTL
**Dado** layout RTL
**Então** colunas e margins espelham.

### Cenário 5 — iPad / Foldable
**Dado** Stage Manager (iPad) ou foldable Android desdobrado
**Então** o grid recalcula em real-time conforme tamanho da janela.

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.grid` com método `breakpoint(for size: CGSize) -> ZodiakBreakpoint`. View modifier `.zodiakLayoutGrid()` aplica colunas automaticamente.
- **Android**: `ZodiakTheme.grid.from(windowSizeClass)` retorna `ZodiakGrid` (columns/gutter/margin). `WindowSizeClass` da `androidx.compose.material3.windowsizeclass`.

### Breakpoints (tokens)
- `Zodiak.grid.compact` — colunas `Zodiak.grid.columns.compact`, gutter `Zodiak.spacing.s16`, margin `Zodiak.spacing.s16`.
- `Zodiak.grid.medium` — colunas `Zodiak.grid.columns.medium`, gutter `Zodiak.spacing.s24`, margin `Zodiak.spacing.s32`.
- `Zodiak.grid.expanded` — colunas `Zodiak.grid.columns.expanded`, gutter `Zodiak.spacing.s24`, margin `Zodiak.spacing.s48`.

> Valores numéricos canonical — incluindo o limiar de cada breakpoint (`Zodiak.grid.threshold.compact/medium/expanded`) — vivem em [`Tokens/ZodiakGridTokens.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakGridTokens.swift). Histórias e código consumidor referenciam por **nome**.

## Boas práticas — iOS
- HIG: [Layout — Adaptivity](https://developer.apple.com/design/human-interface-guidelines/layout).
- `@Environment(\.horizontalSizeClass)` + `GeometryReader` ou `ViewThatFits` para resolver breakpoint.
- `LazyVGrid(columns:)` aceita `GridItem(.adaptive(...))`.

## Boas práticas — Android
- `androidx.compose.material3.windowsizeclass.WindowSizeClass.calculateFromSize`.
- `LazyVerticalGrid(columns = GridCells.Fixed(n))` ou `GridCells.Adaptive(minSize)`.
- Material 3 [Canonical Layouts](https://m3.material.io/foundations/layout/canonical-layouts/overview).

## Acessibilidade
- Conteúdo deve atingir o leitor de tela em ordem de leitura coerente — testar `accessibilitySortPriority` (iOS) / `Modifier.semantics { traversalIndex = ... }` (Android).

## Referências
- [iOS `ZodiakGridTokens.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakGridTokens.swift)
- [iOS `Templates/ZodiakLayoutGrid.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Templates/ZodiakLayoutGrid.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Layout%20grid.md)
- [Supernova: Text layout](../../ZodiakiOS/docs/zodiak-pdf/Text%20layout%20-%20Layout%20grid.md)

## Gaps & dúvidas para o time de Design
- [ ] Definir breakpoint para **foldables semi-desdobrados** (postura half-fold).
- [ ] Comportamento em **landscape compact** (telefone deitado).

## DoD
- [ ] Tokens expostos.
- [ ] Helper `current`/`from(windowSizeClass)` testado.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ZodiakLayout, ZodiakSection } from '@cg-groupit/zodiak-design-system';
```

### Props principais — ZodiakLayout
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `children` | `ReactNode` | — | Conteúdo da grade |
| `className` | `string` | — | Classe extra |

### Props principais — ZodiakSection
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `children` | `ReactNode` | — | Conteúdo da seção |
| `background` | `string` | `'page'` | Contexto de superfície |
| `className` | `string` | — | Classe extra |

### Acessibilidade
- `ZodiakSection` renderiza um `<section>` semântico; inclua um heading ou `aria-label` descritivo.

### Storybook
- `AllOptions`: exemplos de layouts de grade em breakpoints
- `Playground`: controles interativos de colunas e espaçamento
