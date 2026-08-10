# Metas de Poupança

> **Épico**: PocketBank Kids
> **US-ID**: US-34.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de metas de poupança da criança. Cada meta tem um nome, emoji, valor alvo em moedas e progresso atual. O usuário pode criar novas metas e depositar moedas manualmente.

---

## História de usuário

Como **criança**, quero **criar e acompanhar metas de poupança**, para que **eu me motive a economizar moedas para algo que desejo**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de metas (happy path)
**Dado** que tenho metas criadas
**Quando** acesso a tela Metas
**Então** exibo cada meta com `PKProgressRing`, emoji, nome, progresso numérico e `ZodiakStatusChip` (Em progresso / Concluída)

### Cenário 2 — Criar nova meta
**Dado** que toco em "+ Nova meta"
**Então** exibo `ZodiakModal` com:
  - `ZodiakLabelledField` nome da meta
  - Seletor de emoji (grid em `ZodiakModal` interno)
  - `ZodiakLabelledNumericField` valor alvo em moedas
**Quando** confirmo
**Então** `PKGoal` é inserido no SwiftData

### Cenário 3 — Depositar moedas na meta
**Dado** que toco em "Depositar" em uma meta
**Então** exibo `ZodiakModal` com `ZodiakLabelledNumericField` e saldo disponível
**Quando** deposito X moedas
**Então** `pk.coins -= X` e `goal.currentAmount += X`
**E** exibo animação de progresso no `PKProgressRing`

### Cenário 4 — Meta concluída
**Dado** que `goal.currentAmount >= goal.targetAmount`
**Então** exibo `ZodiakStatusChip` "Concluída" com cor de sucesso
**E** executo animação de confetti emoji

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada meta anuncia nome, progresso (ex: "60 de 100 moedas, 60%") e status
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `PKPiggyBankScreen`
- **Saída**: ← back
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Metas | `@Query(sort: \.createdAt) var goals: [PKGoal]` | SwiftData |
| Saldo | `@AppStorage("pk.coins")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStatusChip` | Em progresso / Concluída |
| `ZodiakModal` | Criar meta e depositar |
| `ZodiakLabelledField` | Nome da meta |
| `ZodiakLabelledNumericField` | Valor alvo e valor a depositar |
| `ZodiakButton` | "+ Nova meta" e "Depositar" |
| `ZodiakEmptyState` | Nenhuma meta |
| `ZodiakEyebrow` | "Suas metas" |

### Componentes Customizados
| Componente | Uso |
|---|---|
| `PKProgressRing` | Progresso visual por meta |

---

## Definition of Done

- [ ] Strings: `pk.goals.title`, `pk.goals.action_new`, `pk.goals.modal_title`, `pk.goals.field_name`, `pk.goals.field_target`, `pk.goals.status_in_progress`, `pk.goals.status_completed`, `pk.goals.deposit_modal_title`, `pk.goals.field_deposit`, `pk.goals.error_insufficient`, `pk.goals.empty_title`
- [ ] Regras de depósito (mínimo: 1, máximo: saldo disponível)
- [ ] Implementação pode começar sem ambiguidades
