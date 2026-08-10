# Configurações de Segurança

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.08
> **Tela nº**: 8 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Configurações globais de segurança do app: notificações de compra, PIN mock e logout. Não aplica a um cartão específico, mas à conta como um todo.

---

## História de usuário

Como **correntista**, quero **configurar minhas preferências de segurança**, para que **eu receba alertas importantes e tenha controle adicional sobre o acesso ao app**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Ativar notificações de compra
**Dado** que estou nas Configurações de Segurança
**Quando** aciono o `ZodiakSwitch` "Notificações de compra"
**Então** `@AppStorage("cm.notifications.purchase") = true`

### Cenário 2 — Alterar PIN do app
**Dado** que toco em "Alterar PIN"
**Então** exibo `ZodiakFormContainer` com campo PIN atual + novo PIN + confirmação
**Quando** todos os campos são preenchidos e confirmados corretamente
**Então** exibo `ZodiakNotice` de sucesso "PIN alterado com sucesso"

### Cenário 3 — Logout
**Dado** que toco em "Sair da conta"
**Então** exibo `ZodiakModal` de confirmação
**Quando** confirmo
**Então** `@AppStorage("cm.isAuthenticated") = false`
**E** retorno para `CMLoginScreen` via `popToRoot`

### Cenário 4 — Notificações de limite próximo
**Dado** que aciono "Alerta de limite"
**Então** exibo `ZodiakDropdown` com percentuais: 70%, 80%, 90%, 100%
**E** persisto em `@AppStorage("cm.notifications.limit_threshold")`

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada `ZodiakSwitch` anuncia estado atual e label
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `CMCardListScreen` (ícone de configuração na toolbar)
- **Saída**: ← back para CardList · popToRoot para Login (logout)
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Notificações de compra | `@AppStorage("cm.notifications.purchase")` | UserDefaults |
| Threshold de limite | `@AppStorage("cm.notifications.limit_threshold")` | UserDefaults |
| Auth state | `@AppStorage("cm.isAuthenticated")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakSwitch` | Toggles de notificações |
| `ZodiakDropdown` | Threshold de alerta de limite |
| `ZodiakFormContainer` | Formulário de alteração de PIN |
| `ZodiakPasswordField` | PIN atual / novo PIN / confirmação |
| `ZodiakNotice` | Sucesso ao alterar PIN |
| `ZodiakModal` | Confirmação de logout |
| `ZodiakWarningButton` | "Sair da conta" (destrutivo) |
| `ZodiakEyebrow` | Seções: Notificações / PIN / Conta |
| `ZodiakDivider` | Separação de seções |

---

## Definition of Done

- [ ] Strings: `cm.security.section_notifications`, `cm.security.toggle_purchase`, `cm.security.toggle_limit`, `cm.security.dropdown_threshold`, `cm.security.action_change_pin`, `cm.security.pin_success`, `cm.security.action_logout`, `cm.security.logout_confirm_title`
- [ ] Implementação pode começar sem ambiguidades
