# Login

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Ponto de entrada do Gerenciador de Cartões. Autenticação mock com agência (4 dígitos), conta (7 dígitos) e senha (4–8 caracteres). Estado de autenticação persistido via `@AppStorage("cm.isAuthenticated")`.

---

## História de usuário

Como **correntista**, quero **me autenticar no gerenciador de cartões com minhas credenciais bancárias**, para que **eu acesse meus cartões com segurança**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que preenchi agência (4 dígitos), conta (7 dígitos) e senha (4–8 caracteres)
**Quando** toco em "Entrar"
**Então** persisto `@AppStorage("cm.isAuthenticated") = true`
**E** navego para `CMCardListScreen`

### Cenário 2 — Carregamento
**Dado** que toquei "Entrar"
**Quando** a validação mock (700ms) está em andamento
**Então** o botão exibe estado `loading`
**E** todos os campos ficam desabilitados

### Cenário 3 — Campo de agência inválido
**Dado** que preenchi agência com menos de 4 dígitos
**Quando** toco "Entrar"
**Então** `ZodiakNotice` exibe "Agência deve ter 4 dígitos"

### Cenário 4 — Campo de conta inválido
**Dado** que preenchi conta com menos de 7 dígitos
**Quando** toco "Entrar"
**Então** `ZodiakNotice` exibe "Conta deve ter 7 dígitos"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** campo agência anuncia "Agência, 4 dígitos, campo de texto numérico"
**E** campo conta anuncia "Conta, 7 dígitos, campo de texto numérico"
**E** campo senha anuncia "Senha, entre 4 e 8 caracteres, campo de texto protegido"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: raiz do `NavigationStack`
- **Saída**: → `CMCardListScreen`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Auth state | `@AppStorage("cm.isAuthenticated")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakLoginForm` | Container do formulário |
| `ZodiakLabelledField` | Agência e conta |
| `ZodiakPasswordField` | Senha |
| `ZodiakButton` | "Entrar" |
| `ZodiakNotice` | Erros de validação |
| `ZodiakAlert` | Erro genérico |

---

## Definition of Done

- [ ] Strings: `cm.login.title`, `cm.login.field_agency`, `cm.login.field_account`, `cm.login.field_password`, `cm.login.action_enter`, `cm.login.error_agency`, `cm.login.error_account`, `cm.login.error_password`
- [ ] Implementação pode começar sem ambiguidades
