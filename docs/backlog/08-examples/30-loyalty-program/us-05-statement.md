# Extrato de Pontos

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.05
> **Tela nº**: 5 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Listagem de todas as transações de pontos do usuário (entradas e saídas), filtradas por tipo via `ZodiakTabs`. As transações são lidas de `@AppStorage` e exibidas em ordem decrescente de data. Paginação via `ZodiakShowMore`.

---

## História de usuário

Como **cliente**, quero **ver o histórico de todas as movimentações de pontos**, para que **eu entenda como acumulei e usei meus pontos e verifique a integridade das operações**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que tenho transações em `@AppStorage("lp.statement")`
**Quando** acesso a tela Extrato
**Então** exibo a aba "Todos" com todas as transações em ordem decrescente de data
**E** cada item exibe: ícone de tipo, descrição, data e pontos com sinal (+ em verde, – em vermelho)

### Cenário 2 — Filtro por tipo
**Dado** que estou na aba "Todos"
**Quando** toco na aba "Entrada"
**Então** apenas transações com pontos > 0 são exibidas
**Quando** toco em "Saída"
**Então** apenas transações com pontos < 0 são exibidas

### Cenário 3 — Paginação
**Dado** que há mais de 10 transações no extrato
**Quando** visualizo os primeiros 10 itens
**Então** exibo `ZodiakShowMore` ao final
**Quando** toco
**Então** carrego mais 10 itens

### Cenário 4 — Estado vazio
**Dado** que não há transações no extrato
**Então** exibo `ZodiakEmptyState` com ícone `"list.bullet.rectangle"`, título "Nenhuma movimentação" e subtítulo "Realize uma troca ou envio de pontos para ver o histórico aqui"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada item anuncia: descrição, data, e "ganhou X pontos" ou "usou X pontos"
**E** `ZodiakTabs` anuncia aba selecionada e total de itens por aba
**E** em dark mode, pontos positivos usam `Zodiak.colors.success` e negativos `Zodiak.colors.error`

---

## Spec de tela

### Navegação
- **Entrada**: push de `LPHomeScreen` (ação "Extrato")
- **Saída**: ← back para Home
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Transações | `@AppStorage("lp.statement")` decoded como `[LPPointTransaction]` | UserDefaults |
| Aba ativa | `@State var selectedTab` | em memória |
| Página atual | `@State var page` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakTabs` | Filtros: Todos / Entrada / Saída |
| `ZodiakShowMore` | Paginação após 10 itens |
| `ZodiakEmptyState` | Nenhuma transação |
| `ZodiakStatusChip` | Tipo de transação (Ganho / Resgate / Envio / Recebido) |
| `ZodiakInfoRow` | Dados de cada transação |
| `ZodiakDivider` | Separação entre itens |
| `ZodiakText` | Valor de pontos com cor semântica |

### Estados da tela
- `loaded(transactions)` — lista exibida
- `empty` — sem transações

### Validações
- Nenhuma validação nesta tela

---

## Boas práticas — iOS

- `LPStatementViewModel` filtra `transactions` derivado via `computed property` (`selectedTab` + `page`)
- Tipos de `LPPointTransaction`: `.earned`, `.redeemed`, `.sent`, `.received`

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.02 — Home](us-02-home.md)

---

## Gaps e dúvidas

- Tipos de movimentação: ganho por uso de produto, por promoção, resgate, envio, recebimento — algum outro?

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.statement.title`, `lp.statement.tab_all`, `lp.statement.tab_earned`, `lp.statement.tab_spent`, `lp.statement.empty_title`, `lp.statement.empty_subtitle`, `lp.statement.type_earned`, `lp.statement.type_redeemed`, `lp.statement.type_sent`, `lp.statement.type_received`
- [ ] Schema de `LPPointTransaction` definido
- [ ] Implementação pode começar sem ambiguidades
