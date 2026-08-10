# Meu Portfólio

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Portfólio pessoal com os ativos simulados que o usuário comprou/vendeu. Exibe valor total em USD (calculado com cotação atual), variação do dia e lista de holdings com P&L (lucro/prejuízo).

---

## História de usuário

Como **usuário**, quero **ver o valor atual do meu portfólio simulado**, para que **acompanhe meu desempenho de investimentos fictícios**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Portfólio com ativos (happy path)
**Dado** que tenho holdings no SwiftData
**Quando** acesso a tela Portfólio
**Então** exibo `ZodiakKeyFigures` com valor total em USD
**E** exibo variação total do dia (%) com cor verde/vermelho
**E** listo cada holding com: logo, símbolo, quantidade, valor atual e P&L

### Cenário 2 — P&L por ativo
**Dado** que vejo um holding
**Então** exibo `ZodiakStatusChip` "Lucro" (verde) ou "Prejuízo" (vermelho)
**E** mostro porcentagem de P&L calculada como `(preçoAtual - preçoMédioCompra) / preçoMédioCompra * 100`

### Cenário 3 — Portfólio vazio
**Dado** que não tenho holdings
**Então** exibo `ZodiakEmptyState` "Comece comprando sua primeira cripto"
**E** botão "Ver mercado" navega para o Dashboard

### Cenário 4 — Atualização de cotação
**Dado** que a cotação foi atualizada pelo Timer do Dashboard
**Quando** a tela está visível
**Então** os valores do portfólio são recalculados e exibidos com `.animation(.default)`

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada holding anuncia: moeda, quantidade, valor e P&L
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: barra de abas ou push do Dashboard
- **Saída**: → CoinDetail (tap em holding)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Holdings | `@Query var holdings: [CWHolding]` | SwiftData |
| Cotações | Passadas via ViewModel compartilhado ou `EnvironmentObject` | In-memory |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Valor total e variação do dia |
| `ZodiakStatusChip` | Lucro / Prejuízo por ativo |
| `ZodiakEmptyState` | Portfólio vazio |
| `ZodiakEyebrow` | "Meus ativos" |
| `ZodiakInfoRow` | Dados de cada holding |
| `ZodiakDivider` | Separador de itens |

---

## Definition of Done

- [ ] Strings: `cw.portfolio.title`, `cw.portfolio.total_label`, `cw.portfolio.eyebrow`, `cw.portfolio.empty_title`, `cw.portfolio.empty_action`, `cw.portfolio.chip_profit`, `cw.portfolio.chip_loss`
- [ ] Fórmula de P&L documentada
- [ ] Estratégia de compartilhamento de cotações entre ViewModels definida
- [ ] Implementação pode começar sem ambiguidades
