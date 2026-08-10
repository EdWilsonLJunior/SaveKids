# Criar Novo Grupo

> **Épico**: SplitPay
> **US-ID**: US-32.07
> **Tela nº**: 7 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Formulário para criação de um novo grupo. O usuário define nome, emoji e adiciona os participantes iniciais. Após confirmação, o grupo é salvo no SwiftData e o usuário é redirecionado para a tela de detalhes do grupo.

---

## História de usuário

Como **usuário**, quero **criar um novo grupo de divisão de despesas**, para que **eu possa registrar gastos compartilhados com outras pessoas**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Criar grupo (happy path)
**Dado** que preenchi nome, escolhi emoji e adicionei ao menos 1 participante
**Quando** toco em "Criar grupo"
**Então** `SPGroup` e seus `SPParticipant` são salvos no SwiftData
**E** navego para `SPGroupDetailScreen` do novo grupo

### Cenário 2 — Seleção de emoji
**Dado** que toco no seletor de emoji
**Então** exibo `ZodiakModal` com grid de emojis (ao menos 12 opções)
**Quando** seleciono um emoji
**Então** o avatar do grupo é atualizado na pré-visualização

### Cenário 3 — Adicionar participantes
**Dado** que toco em "+ Adicionar participante"
**Então** exibo campo `ZodiakLabelledField` para nome
**E** `ZodiakDropdown` para cor do avatar
**Quando** confirmo
**Então** participante aparece na lista com `ZodiakAvatar`

### Cenário 4 — Validações
**Dado** que o nome do grupo está vazio
**Quando** toco "Criar grupo"
**Então** `ZodiakNotice` exibe "Nome do grupo é obrigatório"
**Dado** que não há participantes
**Então** `ZodiakNotice` exibe "Adicione ao menos 1 participante"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** seletor de emoji anuncia "Selecionar emoji para o grupo"
**E** lista de participantes anuncia cada participante adicionado
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SPGroupsScreen` (FAB +)
- **Saída**: → `SPGroupDetailScreen` (após criação) · ← back (cancelamento)
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Novo grupo | SwiftData `insert(SPGroup)` | SwiftData |
| Participantes iniciais | SwiftData `insert(SPParticipant)` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakFormContainer` | Container do formulário |
| `ZodiakLabelledField` | Nome do grupo e nome de participante |
| `ZodiakAvatar` | Prévia do emoji escolhido (XL) e avatares de participantes |
| `ZodiakModal` | Grid de seleção de emoji |
| `ZodiakDropdown` | Cor do avatar do participante |
| `ZodiakNotice` | Erros de validação |
| `ZodiakButton` | "Criar grupo" e "+ Adicionar participante" |
| `ZodiakDivider` | Separação entre campos e lista de participantes |

### Validações
- Nome: obrigatório, mínimo 2 caracteres, máximo 30 caracteres
- Participantes: mínimo 1

---

## Definition of Done

- [ ] Strings: `sp.new_group.title`, `sp.new_group.field_name`, `sp.new_group.action_select_emoji`, `sp.new_group.participants_section`, `sp.new_group.action_add_participant`, `sp.new_group.action_create`, `sp.new_group.error_name`, `sp.new_group.error_participants`
- [ ] Lista de emojis definida (proposto: 12 opções de categorias variadas)
- [ ] Implementação pode começar sem ambiguidades
