# Resumo do Grupo

> **Épico**: SplitPay
> **US-ID**: US-32.08
> **Tela nº**: 8 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Hub de navegação do grupo. Exibe métricas resumidas (total gasto, pendente e quitado) e botões de acesso às sub-telas (Despesas, Participantes, Dívidas, Histórico).

---

## História de usuário

Como **usuário**, quero **ver um resumo visual do grupo com acesso às funcionalidades**, para que **eu tenha uma visão consolidada antes de decidir minha próxima ação**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Resumo do grupo (happy path)
**Dado** que estou na tela de resumo
**Então** exibo `ZodiakKeyFigures` com: total gasto, total pendente e total quitado
**E** exibo lista de `ZodiakInfoRow` com saldo individual de cada participante
**E** exibo `ZodiakArrowButton` para: Despesas, Participantes, Dívidas, Histórico

### Cenário 2 — Grupo sem despesas
**Dado** que o grupo não tem despesas
**Então** `ZodiakKeyFigures` exibe todos os valores zerados
**E** `ZodiakNotice` com ".info" exibe "Adicione despesas para ver os saldos"

### Cenário 3 — Exclusão do grupo
**Dado** que toco em "Excluir grupo" (botão destrutivo na toolbar)
**Então** exibo `ZodiakModal` com `ZodiakWarningButton` "Confirmar exclusão"
**Quando** confirmo
**Então** grupo e todos os dados são excluídos do SwiftData
**E** retorno para `SPGroupsScreen`

### Cenário 4 — Atualização automática
**Dado** que registro uma nova despesa em `SPExpensesScreen` e retorno
**Quando** estou no resumo
**Então** `ZodiakKeyFigures` é atualizado automaticamente via observação do SwiftData

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakKeyFigures` anuncia cada métrica com seu rótulo
**E** cada `ZodiakInfoRow` anuncia nome do participante e saldo
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SPGroupsScreen` (tap em grupo)
- **Saída**: → Expenses, Participants, Debts, History · ← back para Groups
- **Parâmetros recebidos**: `group: SPGroup`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Grupo | SwiftData (referência ao `SPGroup` via `@Observable`) | SwiftData |
| Métricas | computadas no ViewModel a partir de `group.expenses` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Total gasto, pendente, quitado |
| `ZodiakInfoRow` | Saldo por participante |
| `ZodiakArrowButton` | Navegação para sub-telas |
| `ZodiakNotice` | Info: sem despesas |
| `ZodiakModal` | Confirmação de exclusão |
| `ZodiakWarningButton` | "Confirmar exclusão" |
| `ZodiakEyebrow` | "Participantes" e "Navegação" |
| `ZodiakDivider` | Separação de seções |

---

## Definition of Done

- [ ] Strings: `sp.group_detail.section_summary`, `sp.group_detail.label_total`, `sp.group_detail.label_pending`, `sp.group_detail.label_settled`, `sp.group_detail.section_participants`, `sp.group_detail.action_expenses`, `sp.group_detail.action_participants`, `sp.group_detail.action_debts`, `sp.group_detail.action_history`, `sp.group_detail.notice_empty`, `sp.group_detail.delete_confirm_title`
- [ ] Fórmulas de cálculo de métricas documentadas
- [ ] Implementação pode começar sem ambiguidades
