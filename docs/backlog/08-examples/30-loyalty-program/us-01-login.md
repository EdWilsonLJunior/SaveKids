# Login / Autenticação

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Ponto de entrada do mini-app de fidelidade. Autenticação mock com CPF (11 dígitos) e senha (mínimo 4 caracteres). O estado de autenticação é persistido via `@AppStorage`.

---

## História de usuário

Como **cliente do programa fidelidade**, quero **me autenticar com CPF e senha**, para que **eu possa acessar meu saldo de pontos e as promoções disponíveis**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que preenchi CPF com 11 dígitos e senha com mínimo 4 caracteres
**Quando** toco em "Entrar"
**Então** persisto `@AppStorage("lp.isAuthenticated") = true`
**E** navego para `LPHomeScreen`

### Cenário 2 — Estados de carregamento
**Dado** que toquei em "Entrar" com dados válidos
**Quando** a validação mock (800ms) está em andamento
**Então** o botão exibe estado `loading` e os campos ficam desabilitados

### Cenário 3 — CPF inválido
**Dado** que preenchi CPF com menos de 11 dígitos ou com letras
**Quando** toco em "Entrar"
**Então** `ZodiakNotice` inline exibe "CPF inválido — informe 11 dígitos"

### Cenário 4 — Senha muito curta
**Dado** que a senha tem menos de 4 caracteres
**Quando** toco em "Entrar"
**Então** `ZodiakNotice` inline exibe "Senha deve ter ao menos 4 caracteres"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** campo CPF anuncia "CPF, campo de texto numérico"
**E** campo senha anuncia "Senha, campo de texto protegido"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: raiz do `NavigationStack`
- **Saída**: → `LPHomeScreen` (push)
- **Parâmetros recebidos**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Estado de auth | `@AppStorage("lp.isAuthenticated")` | UserDefaults |
| CPF | `@State` local | — |
| Senha | `@State` local | — |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakLoginForm` | Container do formulário |
| `ZodiakPhoneInput` | Campo de CPF com máscara 000.000.000-00 |
| `ZodiakPasswordField` | Campo de senha com toggle |
| `ZodiakButton` | "Entrar" com estado loading |
| `ZodiakNotice` | Erros inline por campo |
| `ZodiakAlert` | Erro genérico de autenticação |

### Estados da tela
- `idle`, `loading`, `error(field)`, `error(generic)`

### Validações
- CPF: 11 dígitos numéricos (máscara aplicada, validação no ViewModel)
- Senha: mínimo 4 caracteres

---

## Boas práticas — iOS

- `ZodiakPhoneInput` aplica máscara de CPF automaticamente se configurado para `.cpf`
- CPF e senha nunca saem do ViewModel

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.02 — Home](us-02-home.md) — destino após login

---

## Gaps e dúvidas

- `ZodiakPhoneInput` suporta máscara de CPF (000.000.000-00) ou apenas telefone? Verificar API.

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.login.title`, `lp.login.field_cpf`, `lp.login.field_password`, `lp.login.action_enter`, `lp.login.error_cpf`, `lp.login.error_password`
- [ ] Implementação pode começar sem ambiguidades
