# Component Defaults (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não (gap)

## Contexto
Agrupa **valores de comportamento padrão por componente** (não tokens visuais). Substitui literais como `maxValue = 5`, `step = 1`, `collapsedLines = 3`, `visibleRange = 5`, `min = 0` que apareceriam diretamente em assinaturas de componentes.

Esses defaults seguem a mesma regra de referência por nome do que tokens visuais — **nunca um literal inline**.

## História de usuário
Como **desenvolvedor**, quero **defaults de comportamento centralizados** para que **componentes não exponham números mágicos em suas APIs**.

## Critérios de aceite

### Cenário 1 — Estrutura
**Dado** `Zodiak.defaults.<componente>.<campo>`
**Então** existe um namespace por componente que tenha parâmetros com default numérico.

### Cenário 2 — Refatoração
**Dado** `ZodiakRating(maxValue: Int = 5)`
**Então** a assinatura passa a ser `ZodiakRating(maxValue: Int = Zodiak.defaults.rating.maxValue)`.

### Cenário 3 — Override
**Dado** consumidor passa valor customizado
**Então** o token é apenas um default — overridable por chamada explícita.

### Cenário 4 — Acessibilidade
**Sem impacto direto.**

### Cenário 5 — Light/Dark
**Sem impacto.**

## Spec técnica

### Namespace
- iOS: `Zodiak.defaults.<componente>.<campo>`.
- Android: `ZodiakTheme.defaults.<componente>.<campo>`.

### Catálogo (mínimo)
- `Zodiak.defaults.rating.maxValue`
- `Zodiak.defaults.rating.step`
- `Zodiak.defaults.counter.minValue`
- `Zodiak.defaults.counter.step`
- `Zodiak.defaults.showMore.collapsedLines`
- `Zodiak.defaults.pagination.visibleRange`
- `Zodiak.defaults.filter.activeCount`
- `Zodiak.defaults.toast.autoDismissMs` (resolve via `Zodiak.motion.duration`)
- `Zodiak.defaults.banner.autoDismissMs`

> Lista evolui conforme novos componentes pedirem defaults.

## Boas práticas — iOS
- Definir como `static let` em struct `ZodiakDefaults` agrupada por componente.
- Documentar com DocC indicando origem da decisão (Supernova ou heurística).

## Boas práticas — Android
- `object ZodiakDefaults { object Rating { const val maxValue = 5 } }` ou expor via `CompositionLocal`.

## Acessibilidade
- N/A direto.

## Referências
- Não existe hoje no iOS — gap G-061.
- Consumidores: [rating](../02-atoms/rating.md), [counter-control](../03-molecules/counter-control.md), [show-more](../04-organisms/show-more.md), [breadcrumb-pagination](../02-atoms/breadcrumb-pagination.md), [button-filter](../02-atoms/button-filter.md), [toast](../04-organisms/toast.md), [banner](../04-organisms/banner.md).

## Gaps & dúvidas para o time de Design
- [ ] G-061 — Centralizar defaults de comportamento numérico em namespace dedicado.
- [ ] Valores oficiais para cada default (hoje heurísticos).

## DoD
- [ ] Namespace exposto.
- [ ] Todos componentes refatorados para consumir defaults via token (sem literais nas assinaturas).
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.
> **Nota:** Defaults como `box-sizing: border-box` e `font-family` são aplicados globalmente pelo `ThemeProvider`.


### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-default-border-box fica disponível em todo o subárvore */}
  <div style={{ box-sizing: 'var(--zodiak-default-border-box)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
