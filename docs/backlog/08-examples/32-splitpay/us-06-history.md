# Histórico de Transações

> **Épico**: SplitPay
> **US-ID**: US-32.06
> **Tela nº**: 6 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Visão histórica de todas as despesas e pagamentos do grupo, com filtros por tipo (Despesa / Pagamento / Todos) via `ZodiakTabs` e por período via `ZodiakChipGroup`. Ordenação decrescente por data.

---

## História de usuário

Como **usuário**, quero **ver o histórico completo de transações do grupo**, para que **eu audite o que foi registrado e identifique eventuais erros**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Histórico completo (happy path)
**Dado** que o grupo tem despesas e pagamentos registrados
**Quando** acesso o histórico
**Então** exibo todas as transações em `ZodiakTabs` "Todos" em ordem decrescente de data
**E** cada item exibe: ícone de tipo, descrição, participantes envolvidos, data e valor

### Cenário 2 — Filtro por tipo
**Quando** seleciono a aba "Despesas"
**Então** exibo apenas `SPExpense` que não são compensações
**Quando** seleciono "Pagamentos"
**Então** exibo apenas `SPExpense` que são compensações

### Cenário 3 — Filtro por período
**Dado** que seleciono "Este mês" no `ZodiakChipGroup`
**Então** o histórico é filtrado para exibir apenas transações do mês atual

### Cenário 4 — Paginação
**Dado** que há mais de 10 transações
**Então** exibo `ZodiakShowMore` ao final
**Quando** toco
**Então** carrego mais 10 itens

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada transação anuncia tipo, descrição, valor e data
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SPGroupDetailScreen`
- **Saída**: ← back
- **Parâmetros recebidos**: `group: SPGroup`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Transações | `group.expenses` via SwiftData, filtrado e paginado | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakTabs` | Todos / Despesas / Pagamentos |
| `ZodiakChipGroup` | Período: Tudo / Este mês / Últimos 3 meses |
| `ZodiakShowMore` | Paginação |
| `ZodiakInfoRow` | Dados de cada transação |
| `ZodiakStatusChip` | Tipo: Despesa / Pagamento |
| `ZodiakEmptyState` | Nenhuma transação no filtro |
| `ZodiakDivider` | Separação entre itens |

---

## Definition of Done

- [ ] Strings: `sp.history.title`, `sp.history.tab_all`, `sp.history.tab_expenses`, `sp.history.tab_payments`, `sp.history.filter_all_time`, `sp.history.filter_this_month`, `sp.history.filter_3_months`, `sp.history.empty_title`
- [ ] Implementação pode começar sem ambiguidades
