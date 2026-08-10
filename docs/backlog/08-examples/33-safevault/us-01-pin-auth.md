# Autenticação PIN / Biometria

> **Épico**: SafeVault
> **US-ID**: US-33.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Portão de entrada do SafeVault. Solicita biometria (Face ID / Touch ID) automaticamente ao abrir. Se a biometria falhar ou não estiver disponível, exibe `ZodiakPin` para entrada do PIN de 6 dígitos. Ao ir para background, o app é bloqueado automaticamente via `ScenePhase`.

---

## História de usuário

Como **usuário**, quero **desbloquear o SafeVault com biometria ou PIN**, para que **acesse meus dados sensíveis com segurança e conveniência**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Biometria (happy path)
**Dado** que biometria está habilitada em `@AppStorage("sv.biometrics")`
**Quando** a tela de autenticação aparece
**Então** `LAContext.evaluatePolicy` é chamado automaticamente
**Quando** biometria é aprovada
**Então** `SVAuthViewModel.isAuthenticated = true` e o conteúdo do cofre é exibido

### Cenário 2 — Fallback para PIN
**Dado** que biometria falhou ou foi cancelada
**Quando** o fallback é acionado
**Então** exibo `ZodiakPin` de 6 dígitos
**Quando** o PIN digitado confere com `@AppStorage("sv.pin")`
**Então** `isAuthenticated = true`

### Cenário 3 — PIN errado
**Dado** que o usuário digitou o PIN incorreto
**Quando** os 6 dígitos são preenchidos
**Então** o `ZodiakPin` exibe animação de erro (shake) e limpa os campos
**E** após 5 tentativas erradas, exibo `ZodiakAlert` "Cofre bloqueado por 60 segundos"

### Cenário 4 — Auto-lock ao voltar do background
**Dado** que estou autenticado e o app vai para `.background`
**Então** `SVAuthViewModel.lock()` é chamado via `onChange(of: scenePhase)`
**E** a tela de autenticação é exibida novamente

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakPin` anuncia "Código PIN, dígito X de 6"
**E** o botão de biometria anuncia "Usar Face ID" ou "Usar Touch ID"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: apresentada sempre que `isAuthenticated == false`
- **Saída**: liberação do conteúdo principal (não navega — condicional por estado)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| PIN | `@AppStorage("sv.pin")` (hash mock) | UserDefaults |
| Biometria habilitada | `@AppStorage("sv.biometrics")` | UserDefaults |
| Estado de auth | `@Published var isAuthenticated: Bool` no `SVAuthViewModel` | em memória |
| Tentativas erradas | `@State var wrongAttempts: Int` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakPin` | Entrada de 6 dígitos |
| `ZodiakNotice` | Hint "PIN incorreto, tente novamente" |
| `ZodiakAlert` | Bloqueio após 5 tentativas |
| `ZodiakButton` | "Usar biometria" (reaparece após cancelamento) |
| `ZodiakText` | Rótulo "SafeVault" e instrução |

### Estados da tela
- `awaiting` — aguardando biometria
- `pinEntry` — mostrando `ZodiakPin`
- `error(attempts)` — PIN errado
- `locked(until: Date)` — bloqueado temporariamente

---

## Boas práticas — iOS

- `LAContext` instanciado no ViewModel, nunca na View
- `ScenePhase` observado via `.onChange(of: scenePhase)` no nível mais alto do app (`ZodiakiOSApp` ou `SVRootView`)
- Não usar `@AppStorage` para armazenar PIN em texto plano — usar hash simples (SHA-256 mock)

---

## Definition of Done

- [ ] Strings: `sv.auth.title`, `sv.auth.subtitle`, `sv.auth.action_biometrics`, `sv.auth.pin_hint`, `sv.auth.error_pin`, `sv.auth.locked_title`, `sv.auth.locked_message`
- [ ] Lógica de bloqueio (5 tentativas, 60s cooldown) documentada
- [ ] Implementação pode começar sem ambiguidades
