# Documentos

> **Épico**: SafeVault
> **US-ID**: US-33.03
> **Tela nº**: 3 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de documentos armazenados (CPF, RG, CNH, Passaporte) organizados por tipo via `ZodiakTabs`. Dados mascarados por padrão com reveal via long-press, igual ao padrão de Cartões.

---

## História de usuário

Como **usuário**, quero **consultar meus documentos armazenados de forma segura**, para que **eu tenha acesso rápido aos números quando precisar, sem carregar documentos físicos**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Documentos por tipo (happy path)
**Dado** que tenho documentos de tipos variados
**Quando** acesso a tela Documentos
**Então** exibo `ZodiakTabs` com: CPF, RG, CNH, Todos
**E** cada documento exibe campos mascarados por padrão

### Cenário 2 — Revelar campo
**Dado** que faço long-press em um campo
**Então** o valor é revelado por 5 segundos e mascara automaticamente

### Cenário 3 — Sem documentos na aba
**Dado** que não há documentos do tipo selecionado
**Então** exibo `ZodiakEmptyState` por aba com botão "+ Adicionar CPF" (ou tipo correspondente)

### Cenário 4 — Copiar campo
**Dado** que o campo está revelado
**Quando** toco em "Copiar"
**Então** o valor é copiado e `ZodiakNotice` confirma

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakTabs` anuncia aba selecionada e total de documentos
**E** campos mascarados anunciam instrução de long-press
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SVHomeScreen`
- **Saída**: → `SVAddItemScreen` (FAB +) · ← back
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Documentos | `@Query(filter: #Predicate { $0.type == .document }) var docs: [SVVaultItem]` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakTabs` | CPF / RG / CNH / Todos |
| `ZodiakInfoRow` | Campos mascarados |
| `ZodiakNotice` | Reveal notice e cópia |
| `ZodiakEmptyState` | Por aba vazia |
| `ZodiakButton` | "Copiar" e FAB "+" |

---

## Definition of Done

- [ ] Strings: `sv.documents.title`, `sv.documents.tab_cpf`, `sv.documents.tab_rg`, `sv.documents.tab_cnh`, `sv.documents.tab_all`, `sv.documents.empty_title`
- [ ] Tipos de documentos suportados definidos com seus campos
- [ ] Implementação pode começar sem ambiguidades
