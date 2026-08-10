# Personalizar Avatar

> **Épico**: PocketBank Kids
> **US-ID**: US-34.05
> **Tela nº**: 5 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela para a criança escolher seu avatar emoji e definir seu nome no app. O avatar selecionado aparece na tela principal e no ranking familiar.

---

## História de usuário

Como **criança**, quero **personalizar meu avatar e nome**, para que **o app pareça meu e eu me identifique com ele**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Selecionar avatar (happy path)
**Dado** que acesso a tela de avatar
**Quando** toco em um emoji no grid
**Então** o emoji é selecionado com `ZodiakCheckbox` marcado
**E** o `ZodiakAvatar` XL de prévia é atualizado em tempo real

### Cenário 2 — Salvar avatar e nome
**Dado** que selecionei um avatar e preenchi o nome
**Quando** toco em "Salvar"
**Então** `@AppStorage("pk.avatar")` e `@AppStorage("pk.name")` são atualizados
**E** navego de volta para a tela principal

### Cenário 3 — Estado inicial sem avatar
**Dado** que acesso o app pela primeira vez
**Quando** a tela de avatar é exibida
**Então** o `ZodiakAvatar` de prévia exibe placeholder (emoji padrão 🐷)
**E** o campo nome está vazio

### Cenário 4 — Validação de nome
**Dado** que toco em "Salvar" com o campo nome vazio
**Então** exibo `ZodiakAlert` "Por favor, insira um nome" e não salvo

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada emoji no grid tem label de acessibilidade legível (ex: "Porquinho rosa")
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `PKPiggyBankScreen` (tap no avatar)
- **Saída**: ← back após salvar

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Avatar | `@AppStorage("pk.avatar")` | UserDefaults |
| Nome | `@AppStorage("pk.name")` | UserDefaults |

### Grid de avatares
Emojis propostos (12): 🐷 🐻 🦊 🐸 🐱 🐭 🦁 🐼 🐨 🐧 🦋 🐝

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakAvatar` | Prévia XL do avatar selecionado |
| `ZodiakCheckbox` | Marcação da seleção no grid |
| `ZodiakLabelledField` | Campo de nome |
| `ZodiakButton` | "Salvar" |
| `ZodiakAlert` | Erro de validação |
| `ZodiakEyebrow` | "Escolha seu avatar" |

---

## Definition of Done

- [ ] Strings: `pk.avatar.title`, `pk.avatar.eyebrow`, `pk.avatar.field_name`, `pk.avatar.action_save`, `pk.avatar.error_empty_name`
- [ ] Lista completa de 12 emojis + labels de acessibilidade
- [ ] Implementação pode começar sem ambiguidades
