# Login / Autenticação

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Ponto de entrada do mini-app. O usuário precisa se autenticar antes de acessar qualquer funcionalidade. A autenticação é simulada (mock): qualquer combinação de agência com 4 dígitos + conta com 7 dígitos + senha com 4–8 caracteres é considerada válida. O estado de autenticação é persistido via `@AppStorage` para que o app não exija login novamente na mesma sessão.

---

## História de usuário

Como **correntista**, quero **me autenticar informando agência e senha**, para que **eu possa acessar o sistema de reserva de saque com segurança**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela de Login
**E** preenchi agência com 4 dígitos, conta com 7 dígitos e senha com mínimo 4 caracteres
**Quando** toco no botão "Entrar"
**Então** o app persiste `@AppStorage("wp.isAuthenticated") = true`
**E** navega via `NavigationStack` para a tela Dashboard

### Cenário 2 — Estados de carregamento
**Dado** que toquei em "Entrar" com dados válidos
**Quando** a validação mock está em andamento (simulado com `Task.sleep` de 800ms)
**Então** o botão exibe estado `loading` (`ZodiakButton` com indicador)
**E** os campos ficam desabilitados (`isEnabled = false`)
**E** nenhuma navegação ocorre antes da conclusão

### Cenário 3 — Estado de erro (credenciais inválidas)
**Dado** que preenchi campos com formato incorreto (ex.: agência < 4 dígitos, senha < 4 chars)
**Quando** toco em "Entrar"
**Então** exibe `ZodiakAlert` com título "Credenciais inválidas" e mensagem de orientação
**E** os campos são limpos
**E** o foco retorna ao campo agência

### Cenário 4 — Campo obrigatório vazio
**Dado** que ao menos um campo obrigatório está vazio
**Quando** toco em "Entrar"
**Então** exibe `ZodiakNotice` inline abaixo do campo vazio com mensagem de erro
**E** o botão "Entrar" permanece habilitado (erro é apresentado, não bloqueado antecipadamente)

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada campo possui `accessibilityLabel` descritivo ("Agência", "Conta", "Senha")
**E** o botão "Entrar" anuncia estado ("Entrar, botão" / "Carregando, botão desabilitado")
**E** em dark mode, nenhuma cor ou espaçamento é hardcoded — todos via tokens Zodiak
**E** hit-target de todos os controles ≥ `Zodiak.hitTarget.minimum`

---

## Spec de tela

### Navegação
- **Entrada**: raiz do `NavigationStack` do mini-app (sem back button)
- **Saída**: → `WPDashboardScreen` (push, após autenticação bem-sucedida)
- **Parâmetros recebidos**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Estado de autenticação | `@AppStorage("wp.isAuthenticated")` | UserDefaults |
| Agência / Conta | `@State` local (não persistido) | — |
| Senha | `@State` local (não persistido) | — |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakLoginForm` | Container do formulário de login |
| `ZodiakLabelledField` | Campos agência e conta |
| `ZodiakPasswordField` | Campo de senha com toggle de visibilidade |
| `ZodiakButton` | Botão "Entrar" com estado loading |
| `ZodiakAlert` | Modal de erro de autenticação |
| `ZodiakNotice` | Erro inline por campo |

### Estados da tela
- `idle` — formulário vazio, aguardando input
- `loading` — autenticação em andamento (mock delay)
- `error` — credenciais inválidas (exibe `ZodiakAlert`)
- `fieldError` — campo com formato incorreto (exibe `ZodiakNotice` inline)

### Validações
- Agência: exatamente 4 dígitos numéricos
- Conta: exatamente 7 dígitos numéricos
- Senha: 4–8 caracteres alfanuméricos
- Todas as validações ocorrem no `WPAuthViewModel` — a Screen não contém lógica

---

## Boas práticas — iOS

- `WPAuthViewModel` expõe `@Published var uiState: WPAuthUiState` (enum: idle / loading / error)
- A Screen observa `uiState` via `.onChange` para navegar ou exibir erros
- Senha nunca é armazenada — apenas validada e descartada
- Usar `ZodiakPasswordField` que já implementa toggle de visibilidade conforme DS
- `@FocusState` para gerenciar foco entre campos (agência → conta → senha → botão)

---

## Referências

- [finalBacklog.md — Projeto 1: Provisionamento de Saque](../../raw_pdf/finalBacklog.md)
- [US-29.02 — Dashboard](us-02-dashboard.md) — destino após login
- [ZodiakLoginForm](../../../02-atoms/button-regular.md) — componente de referência

---

## Gaps e dúvidas

- Definir se a tela de login deve ter logo/branding específico do "banco fictício" ou usar `ZodiakLogoView`.
- Confirmar se o mock de delay (800ms) é suficiente ou deve ser configurável via `WPConstants`.

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados e confirmados como existentes no `Shared/DesignSystem/`
- [ ] Strings identificadas: `wp.login.title`, `wp.login.field_agency`, `wp.login.field_account`, `wp.login.field_password`, `wp.login.action_enter`, `wp.login.error_invalid`, `wp.login.error_field_required`
- [ ] Dados mock / API definidos (nenhuma API nesta tela)
- [ ] Implementação pode começar sem ambiguidades
