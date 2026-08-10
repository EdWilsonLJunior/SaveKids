# TextField

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Campo de texto base (single-line / multi-line) com suporte a label flutuante, helper text, error text, leading/trailing icons, clear button. É o building block dos demais inputs (`ZodiakPasswordField`, `ZodiakSearchField`, `ZodiakPhoneInput`, `ZodiakCombobox`).

## História de usuário
Como **usuário**, quero **digitar texto em um campo com feedback visual claro** para **entender o estado (vazio, focado, erro) sem precisar reler instruções**.

## Critérios de aceite

### Cenário 1 — Estados
**Dado** `default / focused / disabled / error / readonly`
**Então** estados visuais corretos (borda, label, helper).

### Cenário 2 — Label flutuante
**Dado** campo focado ou com valor
**Então** label move para o topo e diminui (animação 200ms ease-in-out, respeitando Reduce Motion).

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "<label>, campo de texto, <valor ou vazio>, <helper>"; em erro, anuncia "<label>, inválido, <error message>".

### Cenário 5 — Teclado
**Dado** `keyboardType: .email`
**Então** teclado correto aparece; `submitLabel` configurável.

### Cenário 6 — Limites & validação
**Dado** `maxLength: 10`
**Então** não aceita mais caracteres; (opcional) contador `7/10` no helper.

## Spec técnica

### APIs públicas
- `ZodiakTextField(value: Binding<String>, label: String, helper: String? = none, error: String? = none, leading: ZodiakIcon? = none, trailing: AnyView? = none, state: ZodiakFieldState = ZodiakFieldState.normal, keyboardType: UIKeyboardType = .default, autocapitalization: TextInputAutocapitalization = .sentences, isSecure: Bool = false, maxLength: Int? = none)`.

### Primitivo interno
`ZodiakTextFieldImpl` consumido por `ZodiakPasswordField`/`ZodiakSearchField`/`ZodiakPhoneInput` (ver [ARCHITECTURE.md](../ARCHITECTURE.md)).

### Tokens
- Tipografia: `typography.bodyLarge` (input), `labelMedium` (label flutuante), `labelSmall` (helper).
- Cor: borda `borderDefault → actionPrimary` (focus) → `statusError` (error).
- Padding interno: `spacing.s16` horizontal, `spacing.s12` vertical.
- Altura mínima: `Zodiak.sizing.fieldHeight`.
- Raio: `radii.sm`.

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakTextField(value: Binding<String>, label: String, helper: String? = none, error: String? = none, leading: ZodiakIcon? = none, trailing: AnyView? = none, state: ZodiakFieldState = .normal, keyboardType: UIKeyboardType = .default, autocapitalization: TextInputAutocapitalization = .sentences, isSecure: Bool = false, maxLength: Int? = none)`.

- SwiftUI: `TextField(_, text:, axis:)` (iOS 16+ multiline).
- HIG: [Text fields](https://developer.apple.com/design/human-interface-guidelines/text-fields).
- `.textContentType(...)` (`.emailAddress`, `.oneTimeCode`, etc.) habilita autofill.
- `.submitLabel(.next | .done | .go)`.
- `.focused($focus, equals: .field)` para controle programático.

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakTextField(value: String, onValueChange: (String) -> Unit, label: String, helper: String? = null, errorText: String? = null, leadingIcon: ZodiakIcon? = null, trailingIcon: @Composable (() -> Unit)? = null, keyboardOptions: KeyboardOptions = KeyboardOptions.Default, visualTransformation: VisualTransformation = VisualTransformation.None, maxLength: Int? = null, modifier: Modifier = Modifier)`.

- Material 3: `OutlinedTextField` e `TextField` (`androidx.compose.material3`).
- Zodiak usa `OutlinedTextField` como base com `colors = OutlinedTextFieldDefaults.colors(...)` mapeando tokens Zodiak.
- `KeyboardOptions(keyboardType, imeAction, autoCorrect, capitalization)`.
- `KeyboardActions(onNext = { focusManager.moveFocus(...) })`.
- AutoFill: `Modifier.semantics { contentType = ContentType.EmailAddress }` (Material 3 Expressive).

## Acessibilidade
- Label sempre visível (não placeholder apenas).
- Mensagem de erro anunciada pelo leitor de tela junto ao valor do campo.
- Helper text associado.
- Hit-target ≥ `Zodiak.hitTarget.minimum`.
- Suporte FontScale 2.0 sem overflow.

## Referências
- [iOS `Atoms/TextField/ZodiakTextField.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/TextField/ZodiakTextField.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Text%20input.md)
- [Supernova: Guidelines](../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20Text%20input.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Text%20input.md)

## Gaps & dúvidas para o time de Design
- [ ] Variante **filled** (sem borda) existe oficialmente além da outlined?
- [ ] Contador de caracteres é parte do padrão?
- [ ] Multiline TextArea — específica ou mesma API?

## DoD
- [ ] Primitivo + API pública.
- [ ] AutoFill testado (email, senha).
- [ ] Snapshot 5 estados × 2 temas × 2 tamanhos.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Input } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `labelText` | `string` | — | Rótulo do campo |
| `placeholder` | `string` | — | Texto placeholder |
| `size` | `'medium' \| 'large'` | `'medium'` | Tamanho do campo |
| `state` | `'default' \| 'focus' \| 'error' \| 'success' \| 'disabled'` | `'default'` | Estado de validação |
| `variant` | `'default' \| 'messageFieldL' \| 'messageFieldXL'` | `'default'` | Variante (textarea para messageField*) |
| `helperText` | `string` | — | Texto auxiliar ou de erro |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança |

### Acessibilidade
- O componente associa automaticamente `<label>` ao `<input>` via `id` gerado.
- Forneça `aria-describedby` para mensagens de erro externas ao componente.

### Storybook
- `AllOptions`: estados × variantes × tamanhos
- `Playground`: controles interativos com validação simulada
