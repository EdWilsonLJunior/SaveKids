# Participantes

> **Épico**: SplitPay
> **US-ID**: US-32.03
> **Tela nº**: 3 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de participantes do grupo com saldo líquido individual (credor, devedor ou quitado). Permite adicionar novos participantes e removê-los via swipe (desde que não tenham despesas ativas).

---

## História de usuário

Como **usuário**, quero **gerenciar os participantes do grupo**, para que **as despesas sejam divididas corretamente entre as pessoas certas**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de participantes
**Dado** que estou na tela Participantes
**Então** exibo lista com `ZodiakAvatar` (iniciais + cor), nome e `ZodiakStatusChip` (Deve / Credor / Quitado)
**E** o valor do saldo de cada participante é exibido ao lado (negativo para devedores, positivo para credores)

### Cenário 2 — Adicionar participante
**Dado** que toco em "+ Adicionar"
**Então** exibo `ZodiakModal` com `ZodiakLabelledField` nome e `ZodiakDropdown` cor do avatar
**Quando** confirmo
**Então** `SPParticipant` é inserido no SwiftData e a lista atualiza

### Cenário 3 — Remover participante (sem despesas)
**Dado** que deslizo um participante sem despesas para a esquerda
**Então** revelo ação "Remover"
**Quando** confirmo no modal
**Então** `SPParticipant` é excluído do SwiftData

### Cenário 4 — Remover participante (com despesas)
**Dado** que deslizo um participante que tem despesas registradas
**Então** a ação "Remover" está desabilitada
**E** exibo `ZodiakNotice` "Participante tem despesas associadas e não pode ser removido"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada participante anuncia: nome, estado (Deve R$ X / Credor R$ X / Quitado)
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
| Participantes | `group.participants` via SwiftData | SwiftData |
| Saldo líquido | computado no ViewModel a partir de `group.expenses` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakAvatar` | Iniciais + cor por participante |
| `ZodiakStatusChip` | Deve / Credor / Quitado |
| `ZodiakModal` | Adicionar participante |
| `ZodiakLabelledField` | Nome no modal |
| `ZodiakDropdown` | Cor do avatar |
| `ZodiakNotice` | Erro ao tentar remover com despesas |
| `ZodiakWarningButton` | "Remover" (confirmação) |
| `ZodiakButton` | "+ Adicionar" |

### Validações
- Nome: obrigatório, mínimo 2 caracteres
- Não permitir remover participante com despesas vinculadas

---

## Definition of Done

- [ ] Strings: `sp.participants.title`, `sp.participants.action_add`, `sp.participants.add_modal_title`, `sp.participants.field_name`, `sp.participants.field_color`, `sp.participants.status_owes`, `sp.participants.status_creditor`, `sp.participants.status_settled`, `sp.participants.remove_error`
- [ ] Cores disponíveis para avatar definidas (proposto: 6 cores via token DS)
- [ ] Implementação pode começar sem ambiguidades
