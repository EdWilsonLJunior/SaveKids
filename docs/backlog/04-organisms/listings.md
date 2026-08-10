# Listings

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Listagem rica com header (título + count + filtros), lista virtualizada, empty state, pagination/infinite scroll, loading skeleton. Diferente de `ZodiakList` (atom simples).

## História de usuário
Como **usuário**, quero **explorar coleções grandes** com **filtros, busca e paginação**.

## Critérios de aceite

### Cenário 1 — Header + filtros
**Dado** filterButton + searchField + sort
**Então** apresentados no topo; sticky opcional.

### Cenário 2 — Estados
**Dado** loading/empty/error/success
**Então** componentes corretos (skeleton / `ZodiakEmptyState` / alert / lista).

### Cenário 3 — Paginação
**Dado** chega ao fim da lista
**Então** carrega próxima página automaticamente (infinite) ou mostra botão "Carregar mais".

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** rota através de filtros, lista, paginação; loading anunciado.

### Cenário 5 — Pull to refresh
**Dado** swipe down no topo
**Então** dispara `onRefresh`.

## Spec técnica

### APIs públicas
- `ZodiakListings<T>(items: [T], header: Slot, row: (T) -> View, state: ZodiakListingsState, onRefresh: (() async -> Void)? = none, onLoadMore: (() async -> Void)? = none)`.

### Tokens
- Herda atoms internos.

## Boas práticas — iOS
- `ScrollView` + `LazyVStack` ou `List`.
- `.refreshable { ... }` (iOS 15+).
- `.task(id:)` para load more.

## Boas práticas — Android
- `LazyColumn(state)` + `LaunchedEffect(state) { detect end → loadMore }`.
- `PullToRefreshBox` (Material 3 Expressive).
- Paging 3 quando dataset grande.

## Acessibilidade
- LiveRegion para loading.
- Cada item é elemento navegável.

## Referências
- [iOS `Organisms/Listings/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Listings/)

## Gaps & dúvidas para o time de Design
- [ ] Padrão oficial pull-to-refresh visual?

## DoD
- [ ] Estados + paginação + refresh.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
