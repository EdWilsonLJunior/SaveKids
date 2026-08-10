# PasswordField

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Campo de senha — variação de `ZodiakTextField` que mascara o conteúdo e oferece toggle "mostrar/ocultar".

## História de usuário
Como **usuário**, quero **digitar minha senha com opção de revelar** para **conferir o que digitei sem expô-la a terceiros**.

## Critérios de aceite

### Cenário 1 — Mask default
**Dado** campo recém-aberto
**Então** caracteres mostrados como `•`; trailing icon = "olho".

### Cenário 2 — Toggle reveal
**Quando** toco no olho
**Então** caracteres revelados; ícone muda para "olho cortado"; toggle reversível.

### Cenário 3 — Estados de validação
**Dado** `error: "Mínimo 8 caracteres"`
**Então** borda vermelha, ícone alerta inline, anúncio acessível.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** label = "Senha, campo seguro"; toggle = "Mostrar senha" / "Ocultar senha".

### Cenário 5 — AutoFill
**Dado** senha salva (iCloud Keychain / Credential Manager Android)
**Então** sugestão aparece; submissão habilita salvar nova senha.

## Spec técnica

### APIs públicas
- `ZodiakPasswordField(value: Binding<String>, label: String = "Senha", helper: String? = none, error: String? = none, isNew: Bool = false)`.

### Implementação
- Usa `ZodiakTextFieldImpl` com `isSecure: true` + trailing custom (toggle).
- `isNew: true` configura `textContentType(.newPassword)` (iOS) / `ContentType.NewPassword` (Android) para autofill sugerir senha nova.

### Tokens
- Herda de [text-field](text-field.md).

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakPasswordField(value: Binding<String>, label: String = "Senha", helper: String? = none, error: String? = none, isNew: Bool = false)`.

- `SecureField(_, text:)` é base; alternar com `TextField` quando revealed (Apple suporta este pattern).
- `.textContentType(.password | .newPassword)`.
- HIG: [Text fields — Secure](https://developer.apple.com/design/human-interface-guidelines/text-fields).

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakPasswordField(value: String, onValueChange: (String) -> Unit, label: String = "Senha", helper: String? = null, errorText: String? = null, isNew: Boolean = false, modifier: Modifier = Modifier)`.

- `OutlinedTextField(visualTransformation = PasswordVisualTransformation())`.
- Toggle: `IconButton { Icon(Icons.Filled.Visibility | VisibilityOff) }` no trailing.
- `KeyboardOptions(keyboardType = KeyboardType.Password, autoCorrect = false)`.
- `Modifier.semantics { contentType = ContentType.Password }` (Credential Manager).

## Acessibilidade
- Toggle é botão acessível independente.
- Caractere por caractere NÃO é falado (segurança do SO trata).
- Erros anunciados.

## Referências
- [iOS `Atoms/TextField/ZodiakPasswordField.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/TextField/ZodiakPasswordField.swift)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Text%20input.md)

## Gaps & dúvidas para o time de Design
- [ ] Indicador de força de senha — variante ou organism separado?

## DoD
- [ ] Toggle reveal.
- [ ] AutoFill `password` + `newPassword`.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
