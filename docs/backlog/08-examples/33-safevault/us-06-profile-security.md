# Perfil e Segurança

> **Épico**: SafeVault
> **US-ID**: US-33.06
> **Tela nº**: 6 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Gerenciamento do PIN e das configurações de biometria. Permite alterar o PIN atual e habilitar/desabilitar Face ID ou Touch ID.

---

## História de usuário

Como **usuário**, quero **alterar meu PIN e configurar biometria**, para que **o cofre mantenha o nível de segurança adequado ao meu uso**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Alterar PIN (happy path)
**Dado** que preenchi PIN atual (correto), novo PIN e confirmação do novo PIN
**Quando** toco "Salvar"
**Então** `@AppStorage("sv.pin")` é atualizado com o novo hash
**E** exibo `ZodiakNotice` "PIN alterado com sucesso"

### Cenário 2 — PIN atual incorreto
**Dado** que preenchi PIN atual incorreto
**Quando** toco "Salvar"
**Então** `ZodiakNotice` exibe "PIN atual incorreto"

### Cenário 3 — Novos PINs não coincidem
**Dado** que novo PIN e confirmação diferem
**Então** `ZodiakNotice` exibe "Os PINs não coincidem"

### Cenário 4 — Ativar biometria
**Dado** que biometria está desativada
**Quando** aciono o `ZodiakSwitch` "Usar Face ID"
**Então** `LAContext.evaluatePolicy` confirma disponibilidade
**E** `@AppStorage("sv.biometrics") = true` se bem-sucedido

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakPin` anuncia cada dígito conforme é preenchido
**E** `ZodiakSwitch` anuncia estado atual da biometria
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SVSecuritySettingsScreen`
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| PIN | `@AppStorage("sv.pin")` | UserDefaults |
| Biometria habilitada | `@AppStorage("sv.biometrics")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakPin` | PIN atual / novo PIN / confirmação |
| `ZodiakSwitch` | "Usar Face ID / Touch ID" |
| `ZodiakNotice` | Erros e sucesso |
| `ZodiakButton` | "Salvar" |
| `ZodiakEyebrow` | "Alterar PIN" / "Biometria" |
| `ZodiakDivider` | Separação de seções |

---

## Definition of Done

- [ ] Strings: `sv.profile.section_pin`, `sv.profile.pin_current`, `sv.profile.pin_new`, `sv.profile.pin_confirm`, `sv.profile.action_save`, `sv.profile.error_pin_wrong`, `sv.profile.error_pin_mismatch`, `sv.profile.success`, `sv.profile.section_biometrics`, `sv.profile.toggle_biometrics`
- [ ] Implementação pode começar sem ambiguidades
