# Simular Compra/Venda

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.05
> **Tela nº**: 5 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Simulação de compra ou venda de cripto. Sem dinheiro real — saldo fictício em USD (`@AppStorage`). Registra `CWTransaction` e atualiza `CWHolding` no SwiftData.

---

## História de usuário

Como **usuário**, quero **simular compras e vendas de criptomoedas**, para que **pratique estratégias de investimento sem risco financeiro**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Comprar (happy path)
**Dado** que tenho saldo USD fictício disponível
**Quando** insiro um valor em USD e confirmo "Comprar"
**Então** calculo quantidade de cripto = valor / preçoAtual
**E** insiro `CWTransaction(type: .buy)` no SwiftData
**E** crio ou atualizo `CWHolding` com a nova quantidade e preço médio

### Cenário 2 — Vender
**Dado** que tenho `CWHolding` com quantidade > 0
**Quando** insiro quantidade a vender e confirmo "Vender"
**Então** insiro `CWTransaction(type: .sell)` no SwiftData
**E** atualizo ou removo `CWHolding`
**E** adiciono ao saldo USD fictício

### Cenário 3 — Saldo insuficiente
**Dado** que o valor em USD supera o saldo fictício
**Então** exibo `ZodiakAlert` "Saldo insuficiente" e desabilito o botão de confirmação

### Cenário 4 — Confirmação
**Dado** que os valores estão válidos
**Quando** toco em "Confirmar"
**Então** exibo `ZodiakModal` com resumo (moeda, quantidade, valor total, taxa de câmbio)
**Quando** confirmo no modal
**Então** executo a transação e exibo `ZodiakNotice` de sucesso

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** os campos anunciam rótulo, valor e unidade
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de CoinDetail com `coinId`, `currentPrice`
- **Saída**: ← back após transação

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Saldo fictício USD | `@AppStorage("cw.usd_balance")` (padrão: 10000.0) | UserDefaults |
| Holdings | SwiftData `CWHolding` | SwiftData |
| Transações | SwiftData `CWTransaction` | SwiftData |

### Cálculo de preço médio
`novoPreçoMédio = (quantAnterior * preçoMédioAnterior + novaQtd * preçoAtual) / totalQtd`

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakLabelledNumericField` | Campo de valor em USD / quantidade |
| `ZodiakTabs` | Comprar / Vender |
| `ZodiakModal` | Resumo de confirmação |
| `ZodiakButton` | "Confirmar" |
| `ZodiakAlert` | Saldo insuficiente |
| `ZodiakNotice` | Sucesso da transação |
| `ZodiakKeyFigures` | Saldo disponível |

---

## Definition of Done

- [ ] Strings: `cw.trade.title`, `cw.trade.tab_buy`, `cw.trade.tab_sell`, `cw.trade.field_amount_usd`, `cw.trade.field_quantity`, `cw.trade.confirm_modal_title`, `cw.trade.error_insufficient`, `cw.trade.success_buy`, `cw.trade.success_sell`
- [ ] Fórmula de preço médio documentada
- [ ] Saldo inicial fictício definido (padrão: $10.000 USD)
- [ ] Implementação pode começar sem ambiguidades
