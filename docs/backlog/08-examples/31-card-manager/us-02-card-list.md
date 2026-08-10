# Lista de Cartões

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Exibe todos os cartões do usuário agrupados por tipo (crédito / débito). Cada cartão é representado por um `ZodiakTallCard` com gradiente correspondente à bandeira (Visa: azul, Mastercard: vermelho-laranja, Elo: amarelo). Swipe actions permitem acesso rápido a detalhes ou bloqueio.

---

## História de usuário

Como **correntista**, quero **ver todos os meus cartões em uma lista visual**, para que **eu identifique rapidamente o cartão desejado pelo seu visual e status**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou autenticado e `cards_mock.json` foi carregado
**Quando** a tela é exibida
**Então** exibo cards com `ZodiakTallCard` com gradiente por bandeira
**E** cada card exibe: últimos 4 dígitos, nome do titular, tipo (Crédito/Débito) e `ZodiakStatusChip` (Ativo/Bloqueado)

### Cenário 2 — Carregamento
**Dado** que `cards_mock.json` está sendo buscado
**Então** exibo `ZodiakSkeletonLoader` para cada card
**E** o botão "Solicitar" fica desabilitado

### Cenário 3 — Swipe actions
**Dado** que deslizo um cartão para a esquerda
**Então** revelo ações: "Ver detalhes" (azul) e "Bloquear" (vermelho)
**Quando** toco em "Ver detalhes"
**Então** navego para `CMCardDetailScreen`
**Quando** toco em "Bloquear"
**Então** exibo `ZodiakModal` de confirmação antes de bloquear

### Cenário 4 — Estado vazio
**Dado** que não há cartões no mock
**Então** exibo `ZodiakEmptyState` com título "Nenhum cartão cadastrado" e botão "Solicitar cartão"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada `ZodiakTallCard` anuncia: "Cartão Visa, terminado em 1234, Ativo, Crédito"
**E** em dark mode, gradientes são ajustados por token (sem hardcode de `Color`)

---

## Spec de tela

### Navegação
- **Entrada**: push de `CMLoginScreen`
- **Saída**: → `CMCardDetailScreen` (tap ou swipe "Detalhes") · → `CMRequestCardScreen` (botão "+") · → `CMSecuritySettingsScreen` (toolbar)
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Cartões | `CMMockService.fetchCards()` via `cards_mock.json` | em memória |
| Status de bloqueio | `@AppStorage("cm.card_{id}.blocked")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakTallCard` | Card visual por cartão |
| `ZodiakStatusChip` | Ativo / Bloqueado |
| `ZodiakSkeletonLoader` | Placeholder durante carregamento |
| `ZodiakEmptyState` | Nenhum cartão |
| `ZodiakModal` | Confirmação de bloqueio rápido |
| `ZodiakWarningButton` | "Bloquear" no modal |
| `ZodiakButton` | "Solicitar cartão" (toolbar e empty state) |
| `ZodiakEyebrow` | Separador de grupos (Crédito / Débito) |

### Estados da tela
- `loading`, `success(cards)`, `empty`, `error`

---

## Definition of Done

- [ ] Strings: `cm.card_list.title`, `cm.card_list.action_request`, `cm.card_list.group_credit`, `cm.card_list.group_debit`, `cm.card_list.empty_title`, `cm.card_list.empty_action`, `cm.card_list.swipe_details`, `cm.card_list.swipe_block`, `cm.card_list.block_confirm_title`, `cm.card_list.block_confirm_action`
- [ ] Schema de `cards_mock.json` definido (id, lastFour, holder, type, brand, isBlocked)
- [ ] Gradientes por bandeira documentados (sem hardcode)
- [ ] Implementação pode começar sem ambiguidades
