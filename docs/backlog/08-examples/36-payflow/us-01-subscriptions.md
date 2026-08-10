# Lista de Assinaturas

> **Épico**: PayFlow
> **US-ID**: US-36.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela principal com todas as assinaturas ativas e inativas do usuário. Resumo de gasto mensal total no topo. Heurística de "pouco usado" exibe badge de alerta. Acesso rápido para adicionar nova assinatura.

---

## História de usuário

Como **usuário**, quero **ver todas as minhas assinaturas e o gasto total mensal**, para que **tenha controle dos meus gastos recorrentes**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista com assinaturas (happy path)
**Dado** que tenho assinaturas cadastradas
**Quando** acesso a tela principal
**Então** exibo `ZodiakKeyFigures` com total mensal calculado
**E** listo assinaturas com: logo, nome, valor formatado, ciclo e próximo vencimento

### Cenário 2 — Heurística "pouco usado"
**Dado** que `subscription.lastUsedAt < Date.now - 30.days` (ou nunca registrado)
**Então** exibo `ZodiakStatusChip` "Pouco usado" com cor de aviso

### Cenário 3 — Adicionar nova assinatura
**Dado** que toco em "+ Nova assinatura"
**Então** navego para a tela SubscriptionDetail em modo de criação
**Quando** salvo
**Então** a lista é atualizada automaticamente pelo `@Query`

### Cenário 4 — Assinatura inativa
**Dado** que `subscription.isActive == false`
**Então** exibo com `.opacity(0.5)` e `ZodiakStatusChip` "Inativa"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada assinatura anuncia: nome, valor, próximo vencimento
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: raiz do `NavigationStack`
- **Saída**: → SubscriptionDetail · → DueDates, MonthlySummary, Savings, History, Categories, Notifications

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Assinaturas | `@Query(sort: \.nextDueDate) var subscriptions: [PFSubscription]` | SwiftData |

### Cálculo de total mensal
| Ciclo | Fórmula |
|---|---|
| Mensal | valor |
| Trimestral | valor / 3 |
| Anual | valor / 12 |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Total mensal em destaque |
| `ZodiakStatusChip` | Pouco usado / Inativa |
| `ZodiakButton` | "+ Nova assinatura" |
| `ZodiakEmptyState` | Sem assinaturas |
| `ZodiakEyebrow` | "Suas assinaturas" |
| `ZodiakInfoRow` | Dados de cada assinatura |

---

## Definition of Done

- [ ] Strings: `pf.subscriptions.title`, `pf.subscriptions.total_label`, `pf.subscriptions.action_new`, `pf.subscriptions.chip_rarely_used`, `pf.subscriptions.chip_inactive`, `pf.subscriptions.empty_title`
- [ ] Fórmula de totalização mensal documentada
- [ ] Critério de "pouco usado" (>30 dias sem `lastUsedAt`) definido
- [ ] Implementação pode começar sem ambiguidades
