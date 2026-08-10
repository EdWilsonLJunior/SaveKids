# Histórico do Ativo

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.08
> **Tela nº**: 8 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Histórico completo de transações (compras e vendas) de um ativo específico ou de todo o portfólio. Permite filtrar por moeda e período. Exibe P&L realizado por operação.

---

## História de usuário

Como **usuário**, quero **ver o histórico de transações de um ativo**, para que **analise meu desempenho em cada operação simulada**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Histórico de um ativo (happy path)
**Dado** que navego de CoinDetail com um `coinId`
**Quando** a tela é exibida
**Então** listo todas as `CWTransaction` com esse `coinId`, ordenadas por data decrescente
**E** cada item exibe: tipo (Compra/Venda), quantidade, preço por unidade, valor total e data

### Cenário 2 — P&L realizado por venda
**Dado** que uma transação é do tipo `.sell`
**Então** exibo P&L realizado: `(preçoVenda - preçoMédioCompra) * quantidade`
**E** `ZodiakStatusChip` "Lucro" (verde) ou "Prejuízo" (vermelho)

### Cenário 3 — Filtrar por período
**Dado** que seleciono um período (`ZodiakDropdown`: 7D / 30D / Todos)
**Então** filtro as transações pelo período selecionado

### Cenário 4 — Histórico vazio
**Dado** que não há transações para o ativo
**Então** exibo `ZodiakEmptyState` "Nenhuma transação realizada"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada transação anuncia: tipo, quantidade, preço e data
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de CoinDetail com `coinId: String` (ou sem parâmetro para portfólio completo)
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Transações | `@Query(filter: #Predicate { $0.coinId == coinId }) var transactions: [CWTransaction]` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakDropdown` | Filtro de período |
| `ZodiakStatusChip` | Compra (azul) / Venda (vermelho) / Lucro / Prejuízo |
| `ZodiakEmptyState` | Sem transações |
| `ZodiakShowMore` | Paginação |
| `ZodiakInfoRow` | Dados de cada transação |
| `ZodiakDivider` | Separador de itens |
| `ZodiakEyebrow` | Rótulo de data agrupada |

---

## Definition of Done

- [ ] Strings: `cw.history.title`, `cw.history.filter_7d`, `cw.history.filter_30d`, `cw.history.filter_all`, `cw.history.type_buy`, `cw.history.type_sell`, `cw.history.empty_title`, `cw.history.chip_profit`, `cw.history.chip_loss`
- [ ] Fórmula de P&L realizado documentada
- [ ] Predicado SwiftData para filtro por coinId documentado
- [ ] Implementação pode começar sem ambiguidades
