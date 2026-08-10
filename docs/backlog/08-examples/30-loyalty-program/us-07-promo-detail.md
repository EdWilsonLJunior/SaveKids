# Detalhe de Promoção

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.07
> **Tela nº**: 7 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Página de detalhe de uma promoção selecionada no carrossel da Home. Exibe a imagem em destaque (hero), descrição completa, requisitos de pontos e prazo de validade. Permite navegar diretamente para o resgate da recompensa associada.

---

## História de usuário

Como **cliente**, quero **ver os detalhes de uma promoção**, para que **eu entenda os requisitos e decida se quero participar ou resgatar a recompensa**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que toquei em uma promoção no carrossel
**Quando** a tela Detalhe de Promoção é exibida
**Então** exibo imagem hero da promoção
**E** exibo título, descrição, custo em pontos, prazo de validade
**E** exibo botão "Resgatar agora" com custo de pontos visível

### Cenário 2 — Saldo insuficiente
**Dado** que o custo da promoção é maior que meu saldo de pontos
**Quando** a tela é exibida
**Então** o botão "Resgatar agora" fica desabilitado
**E** exibo `ZodiakNotice` com "Você precisa de mais X pontos para resgatar esta promoção"

### Cenário 3 — Promoção expirada
**Dado** que a promoção tem data de validade anterior a hoje
**Quando** a tela é exibida
**Então** exibo `ZodiakStatusChip` "Expirada" e o botão de resgate fica desabilitado

### Cenário 4 — Compartilhar promoção
**Dado** que estou na tela Detalhe
**Quando** toco no ícone de compartilhar na toolbar
**Então** `ZodiakShare` exibe a sheet nativa com título e link fictício da promoção

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** a imagem hero tem `accessibilityLabel` com título da promoção
**E** todos os `ZodiakInfoRow` anunciam label e valor
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `LPHomeScreen` (tap em `ZodiakTallCard` do carrossel)
- **Saída**: → `LPRedeemScreen` (push, com recompensa pré-selecionada) · ← back para Home
- **Parâmetros recebidos**: `promotion: LPPromotion`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Dados da promoção | passado via navegação (`LPPromotion`) | em memória |
| Saldo atual | `@AppStorage("lp.points")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakHero` | Imagem em destaque com título sobreposto |
| `ZodiakInfoRow` | Custo em pontos, prazo de validade |
| `ZodiakText` | Descrição completa da promoção |
| `ZodiakStatusChip` | Estado "Expirada" |
| `ZodiakNotice` | Saldo insuficiente |
| `ZodiakArrowButton` | "Resgatar agora" (com ação e custo visíveis) |
| `ZodiakShare` | Compartilhamento |
| `ZodiakDivider` | Separação de seções |

### Estados da tela
- `available` — saldo suficiente, não expirada
- `insufficientPoints` — saldo insuficiente
- `expired` — promoção expirada

### Validações
- `promotion.expiresAt` comparado com `Date.now`
- `promotion.pointsCost` comparado com `@AppStorage("lp.points")`

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.02 — Home](us-02-home.md) · [US-30.03 — Resgatar](us-03-redeem.md)

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.promo_detail.action_redeem`, `lp.promo_detail.label_cost`, `lp.promo_detail.label_expires`, `lp.promo_detail.status_expired`, `lp.promo_detail.notice_insufficient`, `lp.promo_detail.share_text`
- [ ] Implementação pode começar sem ambiguidades
