# Senhas

> **Épico**: SafeVault
> **US-ID**: US-33.04
> **Tela nº**: 4 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Gerenciador de senhas simplificado. Cada item armazena serviço (nome), login e senha. Inclui gerador de senha forte com parâmetros configuráveis (comprimento, caracteres especiais). Senha mascarada por padrão com reveal via toggle.

---

## História de usuário

Como **usuário**, quero **armazenar e gerar senhas fortes no cofre**, para que **eu acesse meus serviços com segurança sem memorizar senhas complexas**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de senhas (happy path)
**Dado** que tenho senhas armazenadas
**Quando** acesso a tela Senhas
**Então** exibo lista com nome do serviço, login e senha mascarada
**E** cada item tem botões "Copiar login" e "Copiar senha"

### Cenário 2 — Gerador de senha
**Dado** que toco em "Gerar senha"
**Então** exibo `ZodiakModal` com:
  - `ZodiakSliderCounter` para comprimento (8–32)
  - `ZodiakSwitch` incluir símbolos
  - `ZodiakSwitch` incluir números
  - Prévia da senha gerada
  - Botão "Usar esta senha"

### Cenário 3 — Revelar senha
**Dado** que toco no toggle de reveal ao lado da senha
**Então** a senha é exibida em texto plano
**Quando** toco novamente
**Então** é mascarada

### Cenário 4 — Estado vazio
**Dado** que não há senhas armazenadas
**Então** exibo `ZodiakEmptyState` com botão "Adicionar senha"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** campo de senha mascarado anuncia "Senha oculta. Toque para revelar."
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SVHomeScreen`
- **Saída**: → `SVAddItemScreen` · ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Senhas | `@Query(filter: #Predicate { $0.type == .password }) var passwords: [SVVaultItem]` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakPasswordField` | Campo de senha com toggle reveal |
| `ZodiakModal` | Gerador de senha |
| `ZodiakSliderCounter` | Comprimento da senha |
| `ZodiakSwitch` | Incluir símbolos / números |
| `ZodiakInfoRow` | Serviço, login e senha |
| `ZodiakButton` | "Copiar" e "Gerar senha" |
| `ZodiakEmptyState` | Nenhuma senha |

---

## Definition of Done

- [ ] Strings: `sv.passwords.title`, `sv.passwords.action_generate`, `sv.passwords.generator_title`, `sv.passwords.field_length`, `sv.passwords.toggle_symbols`, `sv.passwords.toggle_numbers`, `sv.passwords.action_use`, `sv.passwords.action_copy_login`, `sv.passwords.action_copy_password`, `sv.passwords.empty_title`
- [ ] Algoritmo de geração de senha documentado (charset por configuração)
- [ ] Implementação pode começar sem ambiguidades
