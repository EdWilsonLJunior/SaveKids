# Lista de Favoritos

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.06
> **Tela nº**: 6 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista personalizada de moedas favoritas do usuário. Favoritar/desfavoritar via `swipeActions` ou botão na tela de detalhe. Persiste a lista em `@AppStorage` como array de IDs.

---

## História de usuário

Como **usuário**, quero **criar uma watchlist com minhas criptomoedas favoritas**, para que **monitore facilmente as moedas de meu interesse**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de favoritos (happy path)
**Dado** que tenho moedas favoritadas
**Quando** acesso a tela Favoritos
**Então** exibo a lista filtrada pelas moedas favoritas com preço atual e variação 24h

### Cenário 2 — Favoritar via detalhe
**Dado** que estou na tela de detalhe de uma moeda
**Quando** toco no ícone de estrela ⭐
**Então** `coinId` é adicionado a `@AppStorage("cw.watchlist")`
**E** o ícone muda para preenchido

### Cenário 3 — Remover favorito
**Dado** que vejo um favorito na lista
**Quando** faço swipe para a esquerda
**Então** exibo ação "Remover" em vermelho
**Quando** confirmo
**Então** `coinId` é removido de `cw.watchlist`

### Cenário 4 — Lista vazia
**Dado** que não tenho favoritos
**Então** exibo `ZodiakEmptyState` "Adicione moedas aos favoritos para monitorá-las"
**E** botão "Explorar mercado" navega para o Dashboard

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada moeda anuncia nome, preço e variação 24h
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: barra de abas ou push do Dashboard
- **Saída**: → CoinDetail (tap em moeda)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| IDs favoritos | `@AppStorage("cw.watchlist")` (JSON array de strings) | UserDefaults |
| Cotações | In-memory (filtradas pelos IDs favoritos) | Nenhuma |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStatusChip` | Variação 24h positiva/negativa |
| `ZodiakEmptyState` | Sem favoritos |
| `ZodiakSecondaryButton` | "Explorar mercado" |
| `ZodiakEyebrow` | "Favoritos" |
| `ZodiakInfoRow` | Dados de cada moeda |

---

## Definition of Done

- [ ] Strings: `cw.watchlist.title`, `cw.watchlist.eyebrow`, `cw.watchlist.empty_title`, `cw.watchlist.empty_action`, `cw.watchlist.action_remove`
- [ ] Formato de `cw.watchlist` em UserDefaults (JSON array de strings)
- [ ] Implementação pode começar sem ambiguidades
