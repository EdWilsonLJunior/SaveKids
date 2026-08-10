# Despesas do Grupo

> **Épico**: SplitPay
> **US-ID**: US-32.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de despesas de um grupo específico. O usuário pode adicionar novas despesas via `ZodiakModal` com formulário embutido. Cada despesa exibe descrição, quem pagou, valor total e como foi dividida.

---

## História de usuário

Como **usuário**, quero **ver e adicionar despesas ao grupo**, para que **o saldo de dívidas seja calculado automaticamente**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela Despesas de um grupo
**Quando** a tela carrega
**Então** exibo lista de despesas em ordem decrescente de data
**E** cada despesa exibe: descrição, nome de quem pagou, valor, data e quantidade de participantes

### Cenário 2 — Adicionar despesa
**Dado** que toco no FAB "+"
**Então** exibo `ZodiakModal` com formulário:
  - `ZodiakLabelledField` descrição
  - `ZodiakLabelledNumericField` valor
  - `ZodiakDropdown` quem pagou (participantes do grupo)
  - `ZodiakMultiselect` dividido entre (participantes do grupo)
**Quando** preencho todos os campos e toco "Adicionar"
**Então** `SPExpense` é inserido no SwiftData
**E** a lista atualiza automaticamente via `@Query`

### Cenário 3 — Excluir despesa
**Dado** que deslizo uma despesa para a esquerda
**Então** revelo ação "Excluir"
**Quando** confirmo
**Então** `SPExpense` é excluído do SwiftData
**E** a lista atualiza automaticamente

### Cenário 4 — Estado vazio
**Dado** que o grupo não tem despesas
**Então** exibo `ZodiakEmptyState` "Nenhuma despesa" com subtítulo "Toque em + para adicionar a primeira despesa"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada despesa anuncia: descrição, quem pagou, valor, data
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SPGroupDetailScreen`
- **Saída**: ← back
- **Parâmetros recebidos**: `group: SPGroup`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Despesas | `@Query(filter: #Predicate { $0.group == group }) var expenses: [SPExpense]` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakModal` | Formulário de nova despesa |
| `ZodiakLabelledField` | Descrição |
| `ZodiakLabelledNumericField` | Valor |
| `ZodiakDropdown` | Pagador |
| `ZodiakMultiselect` | Dividido entre |
| `ZodiakEmptyState` | Nenhuma despesa |
| `ZodiakButton` | FAB "+" e "Adicionar" no modal |
| `ZodiakInfoRow` | Dados de cada despesa |
| `ZodiakDivider` | Separação entre itens |

### Validações
- Valor: obrigatório, maior que R$ 0,01
- Pagador: obrigatório
- Dividido entre: obrigatório, mínimo 1 participante

---

## Definition of Done

- [ ] Strings: `sp.expenses.title`, `sp.expenses.empty_title`, `sp.expenses.empty_subtitle`, `sp.expenses.add_title`, `sp.expenses.field_description`, `sp.expenses.field_amount`, `sp.expenses.field_paid_by`, `sp.expenses.field_split_among`, `sp.expenses.action_add`
- [ ] Implementação pode começar sem ambiguidades
