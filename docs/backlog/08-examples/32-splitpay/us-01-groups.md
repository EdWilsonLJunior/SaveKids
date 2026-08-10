# Lista de Grupos

> **Épico**: SplitPay
> **US-ID**: US-32.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela inicial do SplitPay. Lista todos os grupos do usuário via `@Query` SwiftData. No primeiro acesso, semeia grupos de exemplo de `groups_mock.json`. Cada grupo exibe emoji, nome, número de participantes e saldo líquido do usuário no grupo.

---

## História de usuário

Como **usuário**, quero **ver todos os meus grupos de divisão de despesas**, para que **eu identifique rapidamente qual grupo tem dívidas pendentes**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que tenho grupos no SwiftData
**Quando** a tela é exibida
**Então** exibo lista de grupos com emoji, nome, quantidade de participantes e saldo líquido
**E** grupos com dívidas pendentes exibem `ZodiakStatusChip` "Pendente" em vermelho

### Cenário 2 — Estado vazio
**Dado** que não há grupos
**Quando** a tela é exibida
**Então** exibo `ZodiakEmptyState` com ícone `"person.3"`, título "Nenhum grupo" e botão FAB "Criar grupo"

### Cenário 3 — Criar novo grupo
**Dado** que estou na lista de grupos
**Quando** toco no botão FAB "+"
**Então** navego para `SPNewGroupScreen`

### Cenário 4 — Excluir grupo
**Dado** que deslizo um grupo para a esquerda
**Então** revelo ação "Excluir" em vermelho
**Quando** toco em "Excluir"
**Então** exibo `ZodiakModal` com `ZodiakWarningButton` "Confirmar exclusão"
**Quando** confirmo
**Então** grupo e todas despesas/participantes são excluídos do SwiftData

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada grupo anuncia: nome, participantes, saldo líquido e status (quitado/pendente)
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: raiz do `NavigationStack`
- **Saída**: → `SPGroupDetailScreen` (tap) · → `SPNewGroupScreen` (FAB +)
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Grupos | `@Query var groups: [SPGroup]` | SwiftData |
| Saldo líquido por grupo | computado no ViewModel a partir das despesas | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakAvatar` | Emoji do grupo como avatar |
| `ZodiakStatusChip` | Pendente / Quitado |
| `ZodiakEmptyState` | Nenhum grupo |
| `ZodiakButton` | FAB "+" criar grupo |
| `ZodiakModal` | Confirmação de exclusão |
| `ZodiakWarningButton` | "Confirmar exclusão" |
| `ZodiakInfoRow` | Dados de cada grupo |

---

## Definition of Done

- [ ] Strings: `sp.groups.title`, `sp.groups.empty_title`, `sp.groups.action_create`, `sp.groups.participants_label`, `sp.groups.balance_label`, `sp.groups.status_pending`, `sp.groups.status_settled`, `sp.groups.swipe_delete`, `sp.groups.delete_confirm_title`
- [ ] Seed de `groups_mock.json` definido (proposto: 2 grupos com 3–4 participantes)
- [ ] Implementação pode começar sem ambiguidades
