# Catálogo Completo de Recompensas

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.08
> **Tela nº**: 8 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Merged → US-30.03

> **Nota**: Esta user story foi fundida com US-30.03 (Troca de Pontos). A entrada "Browse rewards catalog" na Home agora navega diretamente para `LPRedeemScreen`. Os arquivos `LPCatalogScreen.swift` e `LPCatalogViewModel.swift` foram removidos.

---

## Contexto

Visão completa do catálogo de recompensas, com filtro multi-seleção por categoria. Complementa a tela de Resgatar (US-30.03) permitindo explorar todo o catálogo antes de decidir o resgate. Usa grid adaptável com paginação.

---

## História de usuário

Como **cliente**, quero **explorar todas as recompensas disponíveis, filtrando por categoria**, para que **eu descubra novas opções de resgate que não estão visíveis na home**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que acesso o catálogo completo
**Quando** a tela carrega
**Então** exibo todos os itens de `rewards_mock.json` em grid 2 colunas
**E** exibo `ZodiakMultiselect` de categorias no topo (todas selecionadas por padrão)

### Cenário 2 — Filtro por categorias
**Dado** que estou no catálogo com todas categorias selecionadas
**Quando** desmarco "Produtos" e "Doações"
**Então** o grid exibe apenas recompensas de categorias "Descontos" e "Serviços"
**E** o total de itens visíveis é atualizado imediatamente

### Cenário 3 — Tap em recompensa
**Dado** que estou no catálogo
**Quando** toco em uma recompensa com pontos suficientes
**Então** navego para `LPRedeemScreen` com a recompensa pré-selecionada

### Cenário 4 — Estado vazio do filtro
**Dado** que todas as categorias são desmarcadas no `ZodiakMultiselect`
**Então** exibo `ZodiakEmptyState` com título "Nenhuma categoria selecionada" e subtítulo "Selecione ao menos uma categoria para ver recompensas"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakMultiselect` anuncia quais categorias estão selecionadas e o total
**E** cada card anuncia nome, custo e disponibilidade
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `LPHomeScreen` ("Ver catálogo completo")
- **Saída**: → `LPRedeemScreen` (tap em recompensa) · ← back para Home
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Recompensas | `LPMockService.fetchRewards()` via `rewards_mock.json` | em memória |
| Categorias selecionadas | `@State var selectedCategories: Set<String>` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakMultiselect` | Filtro de categorias no topo |
| `ZodiakCardGrid` | Grid 2 colunas de recompensas |
| `ZodiakSkeletonLoader` | Placeholder durante carregamento |
| `ZodiakEmptyState` | Nenhuma categoria selecionada ou sem resultados |
| `ZodiakStatusChip` | "Pontos insuficientes" |
| `ZodiakShowMore` | Paginação após 20 itens |

### Estados da tela
- `loading`, `success(rewards)`, `emptyFilter`, `error`

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.03 — Resgatar](us-03-redeem.md) · [US-30.02 — Home](us-02-home.md)

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.catalog.title`, `lp.catalog.filter_label`, `lp.catalog.empty_filter_title`, `lp.catalog.empty_filter_subtitle`, `lp.catalog.status_insufficient`
- [ ] Categorias definidas no schema de `rewards_mock.json`
- [ ] Implementação pode começar sem ambiguidades
