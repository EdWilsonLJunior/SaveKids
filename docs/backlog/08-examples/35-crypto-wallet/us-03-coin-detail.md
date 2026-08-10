# Detalhe da Moeda

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.03
> **Tela nº**: 3 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela de detalhe de uma criptomoeda específica. Exibe gráfico de preço dos últimos 7 dias (`CWSparklineChart` expandido), métricas de mercado e acesso rápido a Comprar/Vender e Histórico.

---

## História de usuário

Como **usuário**, quero **ver os detalhes e histórico de preço de uma criptomoeda**, para que **tome decisões de simulação de compra/venda informadas**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Detalhes da moeda (happy path)
**Dado** que toquei em uma moeda no Dashboard
**Quando** a tela de detalhe é exibida
**Então** exibo: logo, nome, preço atual, variação 24h e gráfico expandido `CWSparklineChart`
**E** exibo `ZodiakInfoRow` com: market cap, volume 24h, rank, supply circulante

### Cenário 2 — Gráfico responsivo
**Dado** que o gráfico está exibido
**Quando** o usuário muda o período (7D / 30D)
**Então** busco `market_chart?days=7` ou `market_chart?days=30` e atualizo o gráfico com `.animation(.easeInOut)`

### Cenário 3 — Carregamento de dados complementares
**Dado** que o detalhe está carregando
**Então** exibo `ZodiakSkeletonLoader` para métricas e gráfico

### Cenário 4 — Falha de rede no gráfico
**Dado** que a chamada do histórico de preços falha
**Então** exibo `ZodiakAlert` "Não foi possível carregar o gráfico" com botão "Tentar novamente"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** o gráfico tem `accessibilityLabel` descrevendo a tendência (ex: "Gráfico de preço: tendência de alta")
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push do Dashboard ou Portfólio com `coinId: String`
- **Saída**: → Trade · → AssetHistory · ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Dados básicos | Passados via parâmetro de navegação | In-memory |
| Histórico 7D/30D | `GET /coins/{id}/market_chart?days=7` | In-memory |
| Métricas de mercado | `GET /coins/{id}` | In-memory |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Preço atual e variação |
| `ZodiakSkeletonLoader` | Métricas e gráfico carregando |
| `ZodiakInfoRow` | Métricas de mercado |
| `ZodiakAlert` | Falha de rede no gráfico |
| `ZodiakButton` | "Comprar" |
| `ZodiakSecondaryButton` | "Ver histórico" |
| `ZodiakTabs` | 7D / 30D |

### Componentes Customizados
| Componente | Uso |
|---|---|
| `CWSparklineChart` | Gráfico de linha expandido via Canvas (com eixo de tempo) |

---

## Definition of Done

- [ ] Strings: `cw.coin_detail.title`, `cw.coin_detail.tab_7d`, `cw.coin_detail.tab_30d`, `cw.coin_detail.error_chart`, `cw.coin_detail.action_buy`, `cw.coin_detail.action_history`
- [ ] Campos da API utilizados documentados
- [ ] `CWSparklineChart` expandido especificado (com dimensões, eixo de tempo)
- [ ] Implementação pode começar sem ambiguidades
