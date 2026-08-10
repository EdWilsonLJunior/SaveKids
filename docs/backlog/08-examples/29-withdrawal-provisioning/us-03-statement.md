# Extrato

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.03
> **Tela nº**: 3 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista paginada de transações da conta corrente mock, com filtros por período. O usuário pode entender seu histórico de movimentações antes de decidir o valor a reservar. Os dados são carregados via URLSession a partir de `transactions_mock.json`.

---

## História de usuário

Como **correntista**, quero **ver meu extrato filtrado por período**, para que **eu entenda meu fluxo de caixa antes de reservar um valor para saque**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela Extrato
**Quando** a tela carrega com filtro padrão "30 dias"
**Então** exibo lista paginada de transações via `ZodiakShowMore` (máximo 10 por vez)
**E** cada item exibe: data, descrição, valor (positivo = crédito, negativo = débito) e tipo via `ZodiakStatusChip`

### Cenário 2 — Estados de carregamento
**Dado** que a tela está buscando `transactions_mock.json`
**Quando** a requisição está em andamento
**Então** exibo `ZodiakSkeletonLoader` no lugar da lista
**E** os chips de filtro ficam desabilitados até o carregamento completar

### Cenário 3 — Estado vazio
**Dado** que não há transações no período selecionado
**Então** exibo `ZodiakEmptyState` com ícone `"doc.text"`, título "Sem movimentações" e subtítulo "Tente selecionar um período maior"
**E** os chips de filtro permanecem ativos

### Cenário 4 — Estado de erro
**Dado** que a requisição para `transactions_mock.json` falha
**Então** exibo `ZodiakNotice` com variante `.error`, mensagem "Não foi possível carregar o extrato" e botão "Tentar novamente"
**Quando** o usuário toca "Tentar novamente"
**Então** reinicio a busca exibindo novamente o skeleton

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada linha de transação anuncia: data, descrição e valor com sinal ("Crédito R$ 1.200,00" ou "Débito R$ 350,00")
**E** `ZodiakChipGroup` anuncia o filtro selecionado ("7 dias, selecionado")
**E** em dark mode, os chips ativos usam `Zodiak.colors.actionPrimary` sem hardcode

---

## Spec de tela

### Navegação
- **Entrada**: push a partir de `WPDashboardScreen`
- **Saída**: ← back para Dashboard
- **Parâmetros recebidos**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Transações | `WPMockService.fetchTransactions()` via URLSession + `transactions_mock.json` | em memória |
| Filtro ativo | `@State var selectedPeriod: WPPeriod` (enum: `.days7`, `.days30`, `.days90`) | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakChipGroup` | Filtros de período: 7d, 30d, 90d |
| `ZodiakShowMore` | Paginação da lista de transações (10 por página) |
| `ZodiakSkeletonLoader` | Placeholder durante carregamento |
| `ZodiakEmptyState` | Estado sem transações no período |
| `ZodiakNotice` | Erro de carregamento com retry |
| `ZodiakStatusChip` | Tipo de transação (Crédito / Débito / Reserva) |
| `ZodiakDivider` | Separador entre itens da lista |
| `ZodiakText` | Data, descrição e valor de cada transação |

### Estados da tela
- `loading` — buscando dados
- `success(transactions)` — lista exibida
- `empty` — nenhuma transação no período
- `error(message)` — falha na requisição

### Validações
- Filtro por período: filtragem aplicada localmente após carregamento (não refaz request)
- Exibir no máximo 10 itens inicialmente; "Ver mais" carrega os próximos 10

---

## Boas práticas — iOS

- `WPStatementViewModel` expõe `@Published var state: LoadingState<[WPTransaction]>`
- A filtragem por período é um `var filteredTransactions: [WPTransaction]` computado a partir de `state`
- URLSession é chamado uma única vez no `onAppear`; filtros operam sobre o resultado em memória
- Usar `ZodiakShowMore` com `initialCount: 10` e `pageSize: 10`

---

## Referências

- [finalBacklog.md — Projeto 1](../../raw_pdf/finalBacklog.md)
- [US-29.02 — Dashboard](us-02-dashboard.md) — tela anterior
- `docs/backlog/03-molecules/notice.md` — spec do `ZodiakNotice`

---

## Gaps e dúvidas

- Definir o schema de `transactions_mock.json`: campos obrigatórios (id, date, description, amount, type).
- Confirmar se transações de reserva de saque devem aparecer no extrato com tipo especial.

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados
- [ ] Strings: `wp.statement.title`, `wp.statement.filter_7d`, `wp.statement.filter_30d`, `wp.statement.filter_90d`, `wp.statement.empty_title`, `wp.statement.empty_subtitle`, `wp.statement.error`, `wp.statement.retry`
- [ ] Schema de `transactions_mock.json` definido
- [ ] Implementação pode começar sem ambiguidades
