# Chaves Pix

> **Épico**: SafeVault
> **US-ID**: US-33.05
> **Tela nº**: 5 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de chaves Pix armazenadas (CPF, e-mail, telefone, chave aleatória). Cada chave exibe seu tipo via `ZodiakStatusChip` e permite copiar para o clipboard.

---

## História de usuário

Como **usuário**, quero **armazenar e copiar minhas chaves Pix**, para que **eu compartilhe chaves de recebimento rapidamente sem precisar digitá-las**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de chaves (happy path)
**Dado** que tenho chaves Pix armazenadas
**Quando** acesso a tela Chaves Pix
**Então** exibo lista com tipo via `ZodiakStatusChip`, rótulo da chave (parcialmente mascarado) e botão "Copiar"

### Cenário 2 — Revelar chave completa
**Dado** que vejo uma chave mascarada (ex: CPF `***.321.456-**`)
**Quando** faço long-press
**Então** a chave completa é exibida por 5 segundos

### Cenário 3 — Copiar chave
**Dado** que toco em "Copiar"
**Então** a chave completa é copiada para o clipboard
**E** `ZodiakNotice` exibe "Chave Pix copiada"

### Cenário 4 — Estado vazio
**Dado** que não há chaves armazenadas
**Então** exibo `ZodiakEmptyState` com ícone `"qrcode"`, título "Nenhuma chave Pix" e botão "Adicionar chave"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada chave anuncia tipo e instrução de long-press
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SVHomeScreen`
- **Saída**: → `SVAddItemScreen` · ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Chaves Pix | `@Query(filter: #Predicate { $0.type == .pixKey }) var keys: [SVVaultItem]` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStatusChip` | Tipo: CPF / E-mail / Telefone / Aleatória |
| `ZodiakInfoRow` | Chave mascarada |
| `ZodiakButton` | "Copiar" |
| `ZodiakNotice` | Confirmação de cópia e reveal |
| `ZodiakEmptyState` | Nenhuma chave |

---

## Definition of Done

- [ ] Strings: `sv.pix.title`, `sv.pix.type_cpf`, `sv.pix.type_email`, `sv.pix.type_phone`, `sv.pix.type_random`, `sv.pix.action_copy`, `sv.pix.copied_notice`, `sv.pix.empty_title`, `sv.pix.empty_action`
- [ ] Regra de mascaramento por tipo definida (CPF: `***.XXX.XXX-**`, e-mail: `u***@dominio.com`)
- [ ] Implementação pode começar sem ambiguidades
