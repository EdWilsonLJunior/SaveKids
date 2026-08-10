# Vencimentos

> **Épico**: PayFlow
> **US-ID**: US-36.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Calendário ou lista de assinaturas agrupadas por vencimento nos próximos 30 dias. Destaca vencimentos de hoje e amanhã. Permite marcar pagamento diretamente da lista.

---

## História de usuário

Como **usuário**, quero **ver quais assinaturas vencem em breve**, para que **me planeje financeiramente e não perca prazos**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Vencimentos próximos (happy path)
**Dado** que tenho assinaturas com datas futuras
**Quando** acesso a tela Vencimentos
**Então** exibo lista agrupada por data (hoje, amanhã, próximos dias)
**E** vencimentos de hoje exibem `ZodiakStatusChip` "Hoje" em cor de urgência

### Cenário 2 — Marcar como pago
**Dado** que vejo uma assinatura na lista
**Quando** toco em "Pagar"
**Então** exibo `ZodiakModal` de confirmação com valor
**Quando** confirmo
**Então** `PFPayment` é inserido e `nextDueDate` avança pelo ciclo de cobrança

### Cenário 3 — Sem vencimentos nos próximos 30 dias
**Dado** que não há vencimentos próximos
**Então** exibo `ZodiakEmptyState` "Nenhum vencimento nos próximos 30 dias" com ícone 🎉

### Cenário 4 — Assinatura atrasada
**Dado** que `nextDueDate < Date.now`
**Então** exibo `ZodiakStatusChip` "Atrasada" com cor de erro
**E** posiciono no topo da lista

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada item anuncia: nome da assinatura, valor e data de vencimento
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push da tela de Assinaturas
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Vencimentos | `@Query` filtrado por `nextDueDate <= Date.now + 30.days` | SwiftData |

### Agrupamento
```
Seção "Atrasadas" → nextDueDate < hoje
Seção "Hoje" → nextDueDate == hoje
Seção "Amanhã" → nextDueDate == hoje + 1
Seção "Próximos 30 dias" → resto
```

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStatusChip` | Hoje / Amanhã / Atrasada |
| `ZodiakModal` | Confirmação de pagamento |
| `ZodiakButton` | "Pagar" por assinatura |
| `ZodiakEmptyState` | Sem vencimentos |
| `ZodiakEyebrow` | Rótulo de cada seção de data |
| `ZodiakDivider` | Separador de seções |

---

## Definition of Done

- [ ] Strings: `pf.due_dates.title`, `pf.due_dates.section_overdue`, `pf.due_dates.section_today`, `pf.due_dates.section_tomorrow`, `pf.due_dates.section_upcoming`, `pf.due_dates.action_pay`, `pf.due_dates.confirm_title`, `pf.due_dates.empty_title`, `pf.due_dates.chip_today`, `pf.due_dates.chip_overdue`
- [ ] Lógica de avanço de data por ciclo documentada
- [ ] Implementação pode começar sem ambiguidades
