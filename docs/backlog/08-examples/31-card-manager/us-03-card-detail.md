# Detalhe do Cartão — Flip 3D

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.03
> **Tela nº**: 3 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela principal de um cartão específico, com destaque para a animação de flip 3D. A frente exibe número mascarado, nome e validade; o verso exibe a tarja preta, CVV e bandeira. O tap no card aciona a animação `rotation3DEffect`. Abaixo do card estão as informações de limite e fatura, e botões de ação.

---

## História de usuário

Como **correntista**, quero **visualizar os detalhes do meu cartão incluindo verso com CVV**, para que **eu possa usar as informações ao realizar compras online de forma conveniente**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Flip 3D (happy path)
**Dado** que estou na tela de detalhe de um cartão
**Quando** toco no card visual
**Então** a animação `rotation3DEffect` é executada em 0.5s
**E** o verso exibe CVV mascarado (***) inicialmente
**E** um botão "Revelar CVV" exibe o valor via long-press (mock: 3 dígitos)

### Cenário 2 — Informações de limite e fatura
**Dado** que estou no detalhe do cartão
**Então** exibo `ZodiakInfoRow` com: limite total, limite disponível, fatura atual, vencimento
**E** exibo `ZodiakKeyFigures` com limite disponível em destaque

### Cenário 3 — Cartão bloqueado
**Dado** que o cartão está bloqueado (`@AppStorage("cm.card_{id}.blocked") == true`)
**Quando** a tela é exibida
**Então** exibo `ZodiakStatusChip` "Bloqueado" no topo
**E** exibo `ZodiakNotice` "Este cartão está bloqueado. Acesse Controles para desbloquear."
**E** a animação de flip ainda funciona

### Cenário 4 — Ações de navegação
**Dado** que estou no detalhe
**Quando** toco em "Controles"
**Então** navego para `CMCardControlScreen`
**Quando** toco em "Compras"
**Então** navego para `CMPurchasesScreen`
**Quando** toco em "Cartão Virtual"
**Então** navego para `CMVirtualCardScreen`

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** o card anuncia "Cartão Visa terminado em 1234. Toque duas vezes para girar e ver o verso."
**E** o CVV mascarado anuncia "CVV oculto. Toque longo para revelar."
**E** em dark mode, o card usa tokens de gradiente corretos

---

## Spec de tela

### Navegação
- **Entrada**: push de `CMCardListScreen`
- **Saída**: → `CMCardControlScreen` · → `CMPurchasesScreen` · → `CMVirtualCardScreen` · ← back para CardList
- **Parâmetros recebidos**: `card: CMCard`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Dados do cartão | passado via navegação (`CMCard`) | em memória |
| Status de bloqueio | `@AppStorage("cm.card_{id}.blocked")` | UserDefaults |
| CVV | mock estático (3 dígitos) | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Limite disponível em destaque |
| `ZodiakInfoRow` | Limite total, fatura, vencimento |
| `ZodiakStatusChip` | Ativo / Bloqueado |
| `ZodiakNotice` | Aviso de bloqueio |
| `ZodiakArrowButton` | Ações: Controles, Compras, Cartão Virtual |
| `ZodiakEyebrow` | Seção "Informações" |
| `ZodiakDivider` | Separação de seções |

### Estados da tela
- `front` — mostrando frente do card
- `back` — mostrando verso com CVV
- `cvvRevealed` — CVV visível

### Validações
- CVV só revelado via long-press (prevenção de captura de tela)

---

## Boas práticas — iOS

- Flip implementado com `@State var isFlipped: Bool` + `rotation3DEffect(isFlipped ? .degrees(180) : .zero, axis: (0, 1, 0))`
- Verso usa `rotation3DEffect(.degrees(180), ...)` para aparecer correto após flip
- `scaleEffect` sutil na transição para efeito de perspectiva

---

## Definition of Done

- [ ] Strings: `cm.card_detail.action_controls`, `cm.card_detail.action_purchases`, `cm.card_detail.action_virtual`, `cm.card_detail.label_limit`, `cm.card_detail.label_available`, `cm.card_detail.label_invoice`, `cm.card_detail.label_due`, `cm.card_detail.cvv_hidden`, `cm.card_detail.cvv_reveal`, `cm.card_detail.blocked_notice`
- [ ] Animação de flip documentada (duração, easing, eixo)
- [ ] Implementação pode começar sem ambiguidades
