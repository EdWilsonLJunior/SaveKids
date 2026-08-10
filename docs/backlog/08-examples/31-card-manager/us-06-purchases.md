# Compras por Período

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.06
> **Tela nº**: 6 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Extrato de compras do cartão selecionado, organizado por mês via `ZodiakTabs` e filtrável por categoria via `ZodiakChipGroup`. Dados carregados de `purchases_mock.json`. Paginação via `ZodiakShowMore`.

---

## História de usuário

Como **correntista**, quero **ver minhas compras por período e categoria**, para que **eu monitore meus gastos e identifique padrões de consumo**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela Compras
**Quando** a tela carrega
**Então** exibo as compras do mês atual via `ZodiakTabs` (mês anterior / mês atual)
**E** exibo `ZodiakChipGroup` com categorias derivadas das compras
**E** cada compra exibe: estabelecimento, categoria, data, valor e `ZodiakStatusChip` (Aprovada / Pendente / Estornada)

### Cenário 2 — Filtro por categoria
**Dado** que estou na aba do mês atual
**Quando** seleciono a categoria "Alimentação"
**Então** apenas compras dessa categoria são exibidas
**E** o total do filtro é exibido no topo

### Cenário 3 — Paginação
**Dado** que há mais de 10 compras
**Então** exibo `ZodiakShowMore` ao final
**E** ao tocar, carrego mais 10 itens

### Cenário 4 — Estado vazio
**Dado** que não há compras no período
**Então** exibo `ZodiakEmptyState` com ícone `"creditcard"` e título "Nenhuma compra neste período"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada compra anuncia: estabelecimento, categoria, data, valor, status
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `CMCardDetailScreen`
- **Saída**: ← back para CardDetail
- **Parâmetros recebidos**: `cardId: String`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Compras | `CMMockService.fetchPurchases(cardId:)` via `purchases_mock.json` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakTabs` | Meses (mês anterior / mês atual) |
| `ZodiakChipGroup` | Filtro por categoria |
| `ZodiakShowMore` | Paginação |
| `ZodiakStatusChip` | Aprovada / Pendente / Estornada |
| `ZodiakEmptyState` | Nenhuma compra |
| `ZodiakInfoRow` | Dados de cada compra |
| `ZodiakKeyFigures` | Total do período / filtro ativo |
| `ZodiakSkeletonLoader` | Placeholder durante carregamento |

---

## Definition of Done

- [ ] Strings: `cm.purchases.title`, `cm.purchases.tab_previous`, `cm.purchases.tab_current`, `cm.purchases.filter_all`, `cm.purchases.empty_title`, `cm.purchases.total_label`, `cm.purchases.status_approved`, `cm.purchases.status_pending`, `cm.purchases.status_reversed`
- [ ] Schema de `purchases_mock.json` definido
- [ ] Implementação pode começar sem ambiguidades
