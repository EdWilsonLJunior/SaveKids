# LoginForm

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Formulário de login padrão Zodiak. Combina logo + título + campos email/senha + botão login + "esqueci senha" + login social opcional.

## História de usuário
Como **usuário**, quero **entrar na minha conta** com **fluxo padrão e seguro**.

## Critérios de aceite

### Cenário 1 — Campos
**Dado** email + senha
**Então** validação inline (formato email, senha mínimo); botão habilita apenas com valid.

### Cenário 2 — Estados
**Dado** loading durante submit
**Então** botão mostra spinner; campos desabilitados.

### Cenário 3 — Erro
**Dado** credentials inválidas
**Então** alert/notice com mensagem clara, foco no email.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** fluxo navegável; AutoFill (Keychain / Credential Manager) integrado.

### Cenário 5 — Login social
**Dado** `socialProviders: [.apple, .google]`
**Então** botões padronizados (HIG/Material) abaixo do formulário.

## Spec técnica

### APIs públicas
- `ZodiakLoginForm(email: Binding<String>, password: Binding<String>, isLoading: Bool, error: String? = none, onSubmit: Action, onForgotPassword: Action? = none, socialProviders: [ZodiakSocialProvider] = [])`.

### Tokens
- Padding: `spacing.s24`. Gap: `spacing.s16`.

## Boas práticas — iOS
- `Sign in with Apple` via `AuthenticationServices` framework (obrigatório se há login social).
- HIG: [Sign in with Apple](https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple).

## Boas práticas — Android
- Credential Manager API (`androidx.credentials`) para Google + Passkeys.
- Botões social seguem branding guidelines.

## Acessibilidade
- Foco inicial no email.
- Erro associado ao campo.
- AutoFill suportado em ambos OS.

## Referências
- [iOS `Organisms/LoginForm/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/LoginForm/)

## Gaps & dúvidas para o time de Design
- [ ] Posicionamento social (acima/abaixo)?
- [ ] Passkeys suportado oficialmente?

## DoD
- [ ] AutoFill + social.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
