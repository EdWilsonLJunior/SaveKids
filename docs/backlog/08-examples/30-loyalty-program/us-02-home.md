# Home — Pontos e Promoções

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela principal após autenticação. Apresenta o saldo de pontos com destaque visual, carrossel horizontal de promoções em destaque (carregado da API mock) e barra de ações rápidas para as funcionalidades principais. É o hub central de navegação do mini-app.

---

## História de usuário

Como **cliente**, quero **ver meu saldo de pontos e as promoções disponíveis logo ao entrar**, para que **eu identifique rapidamente oportunidades de resgate e ganho de pontos**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou autenticado e na Home
**Quando** a tela carrega
**Então** exibo saldo via `ZodiakKeyFigures` ("1.250 pontos")
**E** exibo carrossel horizontal de promoções via scroll de `ZodiakTallCard`
**E** exibo `ZodiakQuickAccessBar` com ações: Trocar, Enviar, Extrato
**E** exibo link "Ver catálogo completo" via `ZodiakArrowButton`

### Cenário 2 — Estados de carregamento das promoções
**Dado** que `promotions_mock.json` está sendo buscado
**Quando** a tela é exibida
**Então** exibo `ZodiakSkeletonLoader` no espaço do carrossel
**E** o `ZodiakKeyFigures` e a `ZodiakQuickAccessBar` são exibidos imediatamente (dados locais)

### Cenário 3 — Erro no carregamento de promoções
**Dado** que o fetch de `promotions_mock.json` falha
**Então** o carrossel é substituído por `ZodiakNotice` com mensagem "Promoções indisponíveis" e botão "Tentar novamente"
**E** as ações rápidas permanecem disponíveis

### Cenário 4 — Tap em promoção
**Dado** que o carrossel está carregado
**Quando** toco em uma promoção
**Então** navego para `LPPromoDetailScreen` com os dados da promoção selecionada

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** o carrossel anuncia "Promoções em destaque, 5 itens, deslize para navegar"
**E** `ZodiakKeyFigures` anuncia "Seu saldo: 1.250 pontos"
**E** `ZodiakQuickAccessBar` anuncia cada ação com label descritivo
**E** em dark mode, `ZodiakTallCard` usa tokens corretos para fundo e texto

---

## Spec de tela

### Navegação
- **Entrada**: push de `LPLoginScreen`
- **Saída(s)**: → Redeem, SendPoints, Statement (via QuickAccessBar) · → PromoDetail (tap no carrossel) · → Catalog (arrow button) · → Profile (toolbar)
- **Parâmetros recebidos**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Saldo de pontos | `@AppStorage("lp.points")` (padrão: 1250) | UserDefaults |
| Promoções | `LPMockService.fetchPromotions()` via URLSession + `promotions_mock.json` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Saldo de pontos em destaque |
| `ZodiakTallCard` | Card por promoção no carrossel |
| `ZodiakQuickAccessBar` | Ações rápidas: Trocar, Enviar, Extrato |
| `ZodiakArrowButton` | "Ver catálogo completo" |
| `ZodiakSkeletonLoader` | Placeholder do carrossel |
| `ZodiakNotice` | Erro de carregamento de promoções |
| `ZodiakEyebrow` | Rótulo "Promoções em destaque" |

### Estados da tela
- `loading` — promoções sendo carregadas
- `ready` — todos os dados disponíveis
- `promoError` — falha no carregamento de promoções (UI parcialmente funcional)

### Validações
- Nenhuma validação nesta tela

---

## Boas práticas — iOS

- Carrossel implementado como `ScrollView(.horizontal, showsIndicators: false)` com `HStack` de `ZodiakTallCard`
- Saldo via `@AppStorage` é reativo — atualiza automaticamente após troca ou envio de pontos

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.01 — Login](us-01-login.md) · [US-30.03 — Trocar](us-03-redeem.md) · [US-30.04 — Enviar](us-04-send-points.md) · [US-30.05 — Extrato](us-05-statement.md)

---

## Gaps e dúvidas

- Schema de `LPPromotion`: id, title, description, imageURL (ou SF Symbol), pointsRequired, expiresAt?
- Quantas promoções no carrossel? Proposto: 5.

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.home.title`, `lp.home.balance_label`, `lp.home.promotions_eyebrow`, `lp.home.action_redeem`, `lp.home.action_send`, `lp.home.action_statement`, `lp.home.action_full_catalog`, `lp.home.promo_error`
- [ ] Schema de `promotions_mock.json` definido
- [ ] Implementação pode começar sem ambiguidades
