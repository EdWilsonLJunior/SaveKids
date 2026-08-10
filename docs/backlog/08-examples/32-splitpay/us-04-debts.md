# Resumo de Dívidas

> **Épico**: SplitPay
> **US-ID**: US-32.04
> **Tela nº**: 4 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Exibe as dívidas calculadas pelo algoritmo de balanceamento com mínimo de transações. Cada dívida mostra devedor → credor com o valor exato. O usuário pode registrar um pagamento direto desta tela.

---

## Algoritmo de balanceamento

**Entrada**: saldos líquidos de cada participante (positivo = credor, negativo = devedor)
**Saída**: lista mínima de transações `(devedor → credor, valor)`

```
1. Calcular saldo líquido de cada participante
2. Separar em lista de credores (saldo > 0) e devedores (saldo < 0)
3. Enquanto houver devedores e credores:
   a. Pegar maior credor C e maior devedor D
   b. min_amount = min(|D|, C)
   c. Registrar transação: D paga C, min_amount
   d. Atualizar saldos: D += min_amount, C -= min_amount
   e. Remover quem chegou a zero
```

---

## História de usuário

Como **usuário**, quero **ver exatamente quem deve quanto a quem**, para que **eu faça os pagamentos corretos com o mínimo de transferências**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Dívidas calculadas (happy path)
**Dado** que há despesas registradas com saldos pendentes
**Quando** acesso a tela Dívidas
**Então** exibo lista de transações com: nome do devedor, seta →, nome do credor, valor
**E** o algoritmo garante o número mínimo de transações

### Cenário 2 — Grupo quitado
**Dado** que todos os saldos são zero
**Quando** acesso a tela Dívidas
**Então** exibo `ZodiakEmptyState` com ícone `"checkmark.circle"`, título "Tudo quitado!" e subtítulo "Nenhuma dívida pendente neste grupo"

### Cenário 3 — Registrar pagamento
**Dado** que vejo uma dívida "João deve R$ 50,00 a Maria"
**Quando** toco em "Pagar"
**Então** navego para `SPPaymentScreen` com os dados da dívida pré-preenchidos

### Cenário 4 — Atualização em tempo real
**Dado** que registro um pagamento em `SPPaymentScreen` e retorno
**Quando** retorno para Dívidas
**Então** a lista é recalculada automaticamente via `@Query` SwiftData

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada dívida anuncia: "João deve cinquenta reais a Maria"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SPGroupDetailScreen`
- **Saída**: → `SPPaymentScreen` (tap "Pagar") · ← back
- **Parâmetros recebidos**: `group: SPGroup`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Despesas do grupo | `group.expenses` via SwiftData | SwiftData |
| Dívidas calculadas | `SPDebtCalculator.calculate(expenses:)` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakAvatar` | Avatar do devedor e credor |
| `ZodiakInfoRow` | Linha de dívida (devedor → credor, valor) |
| `ZodiakButton` | "Pagar" por dívida |
| `ZodiakEmptyState` | Grupo quitado |
| `ZodiakEyebrow` | Rótulo "Transações necessárias" |
| `ZodiakDivider` | Separação entre dívidas |

---

## Boas práticas — iOS

- `SPDebtCalculator` é um `struct` puro (stateless) — não usa SwiftData, recebe array de `SPExpense`
- O algoritmo é documentado com `// MARK: - Debt Minimization Algorithm`

---

## Definition of Done

- [ ] Algoritmo de balanceamento documentado (pseudocódigo + exemplo)
- [ ] Strings: `sp.debts.title`, `sp.debts.eyebrow`, `sp.debts.action_pay`, `sp.debts.empty_title`, `sp.debts.empty_subtitle`
- [ ] Testes unitários para `SPDebtCalculator` planejados
- [ ] Implementação pode começar sem ambiguidades
