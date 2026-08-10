# Potencial de Economia

> **Épico**: PayFlow
> **US-ID**: US-36.07
> **Tela nº**: 7 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela de insights que identifica assinaturas candidatas ao cancelamento: pouco usadas, duplicadas por categoria ou com custo anual elevado. Calcula a economia potencial ao cancelar.

---

## História de usuário

Como **usuário**, quero **receber sugestões de assinaturas para cancelar**, para que **reduza gastos desnecessários com serviços que não uso**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de candidatas (happy path)
**Dado** que há assinaturas com heurística de pouco uso
**Quando** acesso a tela Economia
**Então** exibo `ZodiakKeyFigures` "Economia potencial mensal: R$ X"
**E** listo as assinaturas identificadas com motivo e valor de economia

### Cenário 2 — Motivos de sugestão
**Dado** que uma assinatura é listada
**Então** exibo `ZodiakStatusChip` com o motivo:
  - "Pouco usado" (lastUsedAt > 30 dias)
  - "Duplicado" (>1 assinatura na mesma categoria com o mesmo ciclo)
  - "Alto custo anual" (custo anual > R$ 600)

### Cenário 3 — Cancelar via tela de economia
**Dado** que toco em "Cancelar assinatura" em um item sugerido
**Então** exibo `ZodiakModal` de confirmação com `ZodiakWarningButton`
**Quando** confirmo
**Então** `subscription.isActive = false` no SwiftData
**E** `ZodiakKeyFigures` é atualizado

### Cenário 4 — Sem candidatas
**Dado** que não há assinaturas com padrões de ineficiência
**Então** exibo `ZodiakEmptyState` "Parabéns! Suas assinaturas estão otimizadas" com ícone ✅

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada item anuncia: nome, motivo da sugestão e economia mensal
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push da tela de Assinaturas
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Assinaturas | `@Query var subscriptions: [PFSubscription]` | SwiftData |

### Heurísticas
| Heurística | Critério |
|---|---|
| Pouco usado | `lastUsedAt == nil || lastUsedAt < Date.now - 30.days` |
| Duplicado | `subscriptions.filter { $0.categoryId == s.categoryId && $0.billingCycle == s.billingCycle }.count > 1` |
| Alto custo anual | `custoAnual > 600` (threshold configurável) |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Economia potencial total |
| `ZodiakStatusChip` | Motivo da sugestão |
| `ZodiakModal` | Confirmação de cancelamento |
| `ZodiakWarningButton` | Confirmar cancelamento |
| `ZodiakEmptyState` | Sem candidatas |
| `ZodiakEyebrow` | "Sugestões de economia" |

---

## Definition of Done

- [ ] Strings: `pf.savings.title`, `pf.savings.potential_label`, `pf.savings.chip_rarely_used`, `pf.savings.chip_duplicate`, `pf.savings.chip_high_cost`, `pf.savings.cancel_modal_title`, `pf.savings.cancel_action`, `pf.savings.empty_title`
- [ ] Threshold de alto custo anual definido e configurável
- [ ] Algoritmo de detecção de duplicados documentado
- [ ] Implementação pode começar sem ambiguidades
