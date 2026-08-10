# Registrar Pagamento

> **Épico**: SplitPay
> **US-ID**: US-32.05
> **Tela nº**: 5 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela de confirmação de pagamento de uma dívida. Os dados (devedor, credor, valor) são pré-preenchidos a partir da seleção em `SPDebtsScreen`. A confirmação via `ZodiakSlideToSubmit` cria uma despesa de compensação no SwiftData.

---

## História de usuário

Como **usuário**, quero **registrar o pagamento de uma dívida**, para que **o saldo do grupo seja atualizado e a dívida desapareça do resumo**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Confirmação de pagamento (happy path)
**Dado** que estou na tela com dívida "João deve R$ 50,00 a Maria"
**Quando** deslizo `ZodiakSlideToSubmit`
**Então** uma `SPExpense` de compensação é criada no SwiftData (João paga Maria R$ 50,00)
**E** exibo animação de confetti via `withAnimation` (emoji 🎉 + offset)
**E** exibo `ZodiakModal` "Pagamento registrado!" com botão "Voltar ao resumo"

### Cenário 2 — Editar valor antes de confirmar
**Dado** que o valor pré-preenchido é R$ 50,00
**Quando** edito para R$ 25,00 (pagamento parcial)
**E** confirmo
**Então** a despesa de compensação é criada com R$ 25,00
**E** a dívida restante (R$ 25,00) permanece no resumo

### Cenário 3 — Cancelamento
**Dado** que toco em "Cancelar"
**Então** retorno para `SPDebtsScreen` sem persistir nada

### Cenário 4 — Erro de persistência
**Dado** que o SwiftData falha ao salvar
**Então** exibo `ZodiakAlert` com "Erro ao registrar. Tente novamente."

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** os dados resumidos são lidos: "João deve cinquenta reais a Maria"
**E** `ZodiakSlideToSubmit` anuncia "Deslize para confirmar o pagamento"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SPDebtsScreen`
- **Saída**: ← back para Debts · `ZodiakModal` → popToRoot ou back
- **Parâmetros recebidos**: `debt: SPDebt` (devedor, credor, valor)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Dados da dívida | passado via navegação | em memória |
| Valor editado | `@State var amount: Double` | em memória |
| Despesa de compensação | SwiftData `insert(SPExpense)` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakInfoRow` | Devedor, credor e valor da dívida |
| `ZodiakLabelledNumericField` | Valor (pré-preenchido, editável) |
| `ZodiakAvatar` | Avatares do devedor e credor |
| `ZodiakSlideToSubmit` | Confirmação |
| `ZodiakModal` | Sucesso |
| `ZodiakAlert` | Erro de persistência |
| `ZodiakSecondaryButton` | "Cancelar" |
| `ZodiakEyebrow` | "Resumo do pagamento" |

### Validações
- Valor: obrigatório, maior que R$ 0,01 e menor ou igual ao valor original da dívida

---

## Definition of Done

- [ ] Strings: `sp.payment.title`, `sp.payment.eyebrow`, `sp.payment.field_amount`, `sp.payment.slide_label`, `sp.payment.success_title`, `sp.payment.action_cancel`, `sp.payment.error_title`
- [ ] Animação de confetti documentada (variante emoji vs Canvas)
- [ ] Implementação pode começar sem ambiguidades
