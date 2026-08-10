# Dashboard de Mercado

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela principal com cotações ao vivo das top 10 criptomoedas. Refresh automático via `Timer` a cada 5 segundos. Cada moeda exibe `CWSparklineChart` (Canvas) com variação 7 dias e porcentagem de variação 24h.

---

## História de usuário

Como **usuário**, quero **ver as cotações ao vivo das principais criptomoedas**, para que **acompanhe o mercado em tempo real**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Cotações ao vivo (happy path)
**Dado** que a API CoinGecko está acessível
**Quando** a tela é exibida
**Então** listo as top 10 moedas com: logo, símbolo, nome, preço atual em USD e variação 24h (verde/vermelho)
**E** cada linha exibe o `CWSparklineChart` com a variação dos últimos 7 dias

### Cenário 2 — Refresh automático
**Dado** que a tela está visível
**Quando** o Timer de 5 segundos dispara
**Então** busco novas cotações e atualizo os preços com animação `.animation(.default)`
**E** exibo indicador "Atualizado agora" no cabeçalho

### Cenário 3 — Fallback offline
**Dado** que não há conexão com internet
**Quando** a busca falha
**Então** carrego `crypto_fallback.json` do bundle
**E** exibo `ZodiakNotice` "Dados offline — última atualização [data]"

### Cenário 4 — Carregamento inicial
**Dado** que é a primeira carga
**Então** exibo `ZodiakSkeletonLoader` para cada linha da lista

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada moeda anuncia: nome, preço e variação 24h
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: raiz do `NavigationStack`
- **Saída**: → CoinDetail (tap na moeda) · → Portfolio, Conversion, Watchlist, Alerts (barra de abas ou QuickAccess)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Cotações | CoinGecko API + fallback JSON | In-memory |
| Timer | `Timer.publish(every: 5, on: .main)` + `.onReceive` | Nenhuma |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakSkeletonLoader` | Carregamento inicial |
| `ZodiakNotice` | Modo offline |
| `ZodiakEyebrow` | "Mercado ao vivo" |
| `ZodiakStatusChip` | Variação positiva/negativa |
| `ZodiakSearchField` | Filtrar moedas |

### Componentes Customizados (a criar)
| Componente | Descrição |
|---|---|
| `CWSparklineChart` | Mini-gráfico de linha via `Canvas` SwiftUI com dados do campo `sparkline_in_7d.price` da API |

---

## Definition of Done

- [ ] Strings: `cw.dashboard.title`, `cw.dashboard.eyebrow`, `cw.dashboard.offline_notice`, `cw.dashboard.updated_now`
- [ ] Schema de resposta CoinGecko documentado (campos utilizados: `id`, `symbol`, `name`, `image`, `current_price`, `price_change_percentage_24h`, `sparkline_in_7d.price`)
- [ ] `CWSparklineChart` especificado (dimensões, cores por variação, sem eixos)
- [ ] Implementação pode começar sem ambiguidades
