# Cartões Armazenados

> **Épico**: SafeVault
> **US-ID**: US-33.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de cartões armazenados no cofre. Dados sensíveis (número, CVV) são mascarados por padrão. O usuário revela cada campo via long-press. Swipe para excluir com confirmação.

---

## História de usuário

Como **usuário**, quero **ver meus cartões armazenados com dados protegidos por padrão**, para que **eu acesse os números quando precisar, sem exposição acidental**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de cartões (happy path)
**Dado** que tenho cartões no SwiftData (type == .card)
**Quando** acesso a tela Cartões
**Então** exibo lista com título, campos mascarados (•••• •••• •••• 1234) e bandeira

### Cenário 2 — Revelar campo via long-press
**Dado** que vejo um número de cartão mascarado
**Quando** faço long-press no campo
**Então** o valor é revelado por 5 segundos e depois mascarado novamente
**E** um `ZodiakNotice` discreto aparece "Campo visível por 5 segundos"

### Cenário 3 — Copiar número
**Dado** que o número está revelado
**Quando** toco em "Copiar"
**Então** o número sem espaços é copiado para o clipboard
**E** exibo `ZodiakNotice` "Copiado — limpar clipboard em 30s"

### Cenário 4 — Excluir cartão
**Dado** que deslizo um cartão para a esquerda
**Então** revelo ação "Excluir"
**Quando** confirmo no modal
**Então** `SVVaultItem` é excluído do SwiftData

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** campos mascarados anunciam "Número de cartão, oculto. Toque longo para revelar."
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SVHomeScreen` (tab "Cartões")
- **Saída**: → `SVAddItemScreen` (FAB +) · ← back
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Cartões | `@Query(filter: #Predicate { $0.type == .card }) var cards: [SVVaultItem]` | SwiftData |
| Campo revelado | `@State var revealedFieldId: UUID?` + Timer 5s | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakInfoRow` | Cada campo com mascaramento |
| `ZodiakNotice` | Aviso de campo visível e cópia |
| `ZodiakButton` | "Copiar" ao lado do campo revelado |
| `ZodiakEmptyState` | Nenhum cartão |
| `ZodiakModal` | Confirmação de exclusão |
| `ZodiakWarningButton` | "Confirmar exclusão" |

---

## Definition of Done

- [ ] Strings: `sv.cards.title`, `sv.cards.empty_title`, `sv.cards.field_number`, `sv.cards.field_cvv`, `sv.cards.field_expiry`, `sv.cards.field_name`, `sv.cards.action_copy`, `sv.cards.copied_notice`, `sv.cards.reveal_notice`, `sv.cards.delete_confirm_title`
- [ ] Lógica de mascaramento/reveal e timeout documentada
- [ ] Implementação pode começar sem ambiguidades
